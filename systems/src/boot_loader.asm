# boot_loader.asm
# Created 2/27/07 by Matt McKnett
# Harvey Mudd College, CMOS VLSI Design Spring '07, MIPS project
#
# This is the segment of the boot loader that will do the actual heavy lifting.
# It must be implemented as exception code so that interrupts will be disabled
# while it is running.
#
# This boot loader is in no way general purpose!!  It is specific to the
# idiosynchrosies of the Harvey Mudd MIPS implementation from Spring 2007.
# It has been written to conform to the special situations and unimplemented
# features of that chip and that chip only.


# Don't le the assembler reorder or fill branch delay slots.
	.set noreorder


# Step 1: Set the Status Register to something that makes sense
# Bits to set:
#   29 (CU1) *not implemented* 
#   22 (BEV) = 0 for now, even though we haven't initialized the cache yet
#		(according to See MIPS run p. 76, this is desirable)
#   20 (PE) *not implemented*
#   18 (PZ) *not implemented*
#   17 (SwC) = 1 start with the I-cache
#   16 (IsC) *Cache isolation has not been implemented, but the bit is settable
#	     in the status register.*
#   8-15 (IM) = 1 for each, enabling all interrupts.
#   5 (KUo) = 1 so that we don't rfe into a bad user mode
#   4 (IEo) = 0 for similar reasons
#   3 (KUp) = 1
#   2 (IEp) = 0
#   1 (KUc) = 1 because we must always run our CPU in kernel mode.
##   0 (IEc) *can only be set on interrupt*
#
#  SR words:  OR with 0x0002FF2A, AND with 0xFF4FFFEB

hello there, I am some text

# Instructions for setting SR (register $12 in cp0) on See MIPS Run p. 105

	.text

	nop

	.globl	reset
	.ent	reset

reset:
	mfc0	$8, $12
set_sr1:
	nop
	nop
	lui	$9, 0x0002		# set the specified bits
	or	$8, $8, $9
	ori	$8, $8, 0xFF2A		 
	lui	$9, 0xFF4F		# clear the specified bits
	ori     $9, $9, 0xFFEB
	and	$8, $8, $9
set_sr2:
	mtc0	$8, $12
	nop
	nop	


# Step 2: Invalidate the cache
# With the I-cache in isolation, we can find out the size of the cache, and
# then write that many invalid bits.

	# Now that we know the cache ignores the isolate bit, we must
	# write bytes to 0x8000 8000 so that we do not clobber what is in
	# the ROM region and so that we don't write into the device I/O.
	# This means we only support up to 32K cache sizes.  (Our cache is
	# 512 MB).  Just for the sake of a more generalizable bootloader, 
	# I include code for discovering the cache size. 
	li	$9, 0x8000	# $9 is initially 32K (2^15).
	li	$10, 0x0400	# $10 is the smallest cache size (0.5K) (2^9)
	lui	$11, 0x8000	# $11 = kseg0 = 0x8000 0000
size_i:
	add	$8, $11, $9	# $8 = kseg0 + current size
	sw	$8, 0($9)	# After we're done looping, leaves the cache
				# size in mem address 0x8000 0000
	srl	$9, $9, 1	# divide the size we're looking for by two
	bne	$9, $10, size_i
				# Move on if we've finished all cache sizes
				# loop otherwise.
	nop
read_size_i:
	lw	$9, 0($11)	# Loads the value of kseg0 into $9
				# Our cache size is now in $9
				# Conveniently, $10 holds the value we want to
				# start writing at
inval_i_loop:
	sb	$0, 0($10)	# Invalidate the word at address $10
	addi	$10, $10, 4	# Move to next word address
	addi	$9, $9, -4	# Use cache size to count down loop iterations
	bnez	$9, inval_i_loop
				# Keep writing bytes until we run out of space.

# Now that we have invalidated the I-cache, we move on to the D-cache
swap_i_for_d:
	mfc0	$8, $12
	nop
	nop
	lui	$9, 0xFFFD
	ori	$9, $9, 0xFFFF
	and	$8, $8, $9		# clear the SwC bit
	mtc0	$8, $12
	nop
	nop

# Having swapped the caches, we can repeat the same operation on the D-cache
# that we did on the I-cache.
	lui	$9, 0x0004	# $9 is initially 256K.
	li	$10, 0x0400	# $10 is the smallest cache size (0.5K) 
	lui	$11, 0x8000	# $11 = kseg0 = 0x8000 0000
size_d:
	add	$8, $11, $9	# $8 = kseg0 + current size
	sw	$8, 0($9)	# After we're done looping, leaves the cache
				# size in mem address 0x8000 0000
	srl	$9, $9, 1	# divide the size we're looking for by two
	bne	$9, $10, size_d
				# Move on if we've finished all cache sizes
				# loop otherwise.
	nop
read_size_d:
	lw	$9, 0($11)	# Loads the value of kseg0 into $9
				# Our cache size is now in $9
	addi	$10, $0, 0	# Conveniently, $10 holds the value we want to
				# start writing at
inval_d_loop:
	sb	$0, 0($10)	# Invalidate the word at address $10
	addi	$10, $10, 4	# Move to next word address
	addi	$9, $10, -4	# Use cache size to count down loop iterations
	bnez	$9, inval_d_loop
				# Keep writing bytes until we run out of space.

# Step 3: Initialize $sp and reset $12 to proper values. 
	lui	$29, 0x001
	ori	$29, $29, 0x31FC  # The highest the stack goes is 0x00131FF.

# Set register bits:
#   22 (BEV) = 0 now that we have initialized the cache.
#   16 (IsC) = 0 to disable isolation
##  0  (IEc) = 1 now that we are done with the cache we can re-enable interrupts
	
	mfc0	$8, $12
	nop
	nop
	ori	$8, $8, 0x1	# set IEc
	lui	$9, 0xFFBE	
	ori	$9, $9, 0xFFFF
	and	$8, $8, $9   # clear BEV and IsC.
	mtc0	$8, $12
	nop
	nop


# Step 4: Jump to a cached-mode address
	lui	$8, 0x9FC0
	ori	$8, $8, 0x1000
	jr	$8		# Instructions should start at 0x9FC01000 
	
