# boot_loader.asm
# Created 2/27/07 by Matt McKnett
# Harvey Mudd College, CMOS VLSI Design Spring '07, MIPS project
#
# This is the segment of the boot loader that will do the actual heavy lifting.
# It goes at the memory location pointed to by boot_start

# Don't le the assembler reorder or fill branch delay slots.
.text
.set noreorder


# The instruction to jump to on reset.
__reset:

# Step 1: Set the Status Register to something that makes sense
# Bits to set:
#   29 (CU1) = 0 since we don't have an FPU
#   22 (BEV) = 0 for now, even though we haven't initialized the cache yet
#		(according to See MIPS run p. 76, this is desirable)
#   20 (PE) = 0 a cache parity error has not occurred.
#   18 (PZ) = 0 disabling parity, which shouldn't be used w/ on-chip cache.
#   17 (SwC) = 1 start with the I-cache
#   16 (IsC) = 1 isolate the I-cache so that we can invalidate the cache.
#   8-15 (IM) = 1 for each, enabling all interrupts.
#   5 (KUo) = 1 so that we don't rfe into a bad user mode
#   4 (IEo) = 0 for similar reasons
#   3 (KUp) = 1
#   2 (IEp) = 0
#   1 (KUc) = 1 because we must always run our CPU in kernel mode.
#   0 (IEc) = 0 for now, disable interrupts.

# Instructions for setting SR on See MIPS Run p. 105
	mfc0	$t0, SR
set_sr1:
	nop
	nop
	lui	$t1, 0x0002		# set the specified bits
	or	$t0, $t0, $t1
	ori	$t0, $t0, 0xFFEA		 
	lui	$t1, 0xDFAB		# clear the specified bits
	ori     $t1, $t1, 0xFFEA
	and	$t0, $t0, $t1
set_sr2:
	mtc0	$t0, SR
	nop
	nop	


# Step 2: Invalidate the cache
# With the I-cache in isolation, we can find out the size of the cache, and
# then write that many invalid bits.
	lui	$t1, 0x0004	# $t1 is initially 256K.
	li	$t2, 0x0400	# $t2 is the smallest cache size (0.5K) 
	lui	$t3, 0x8000	# $t3 = kseg0 = 0x8000 0000
size_i:
	add	$t0, $t3, $t1	# $t0 = kseg0 + current size
	sw	$t0, $t1	# After we're done looping, leaves the cache
				# size in mem address 0x8000 0000
	srl	$t1, $t1, 1	# divide the size we're looking for by two
	bne	$t1, $t2, size_i
				# Move on if we've finished all cache sizes
				# loop otherwise.
read_size_i:
	lw	$t1, $t3	# Loads the value of kseg0 into $t1
				# Our cache size is now in $t1
				# Conveniently, $t2 holds the value we want to
				# start writing at
inval_i_loop:
	sb	$0, 0($t2)	# Invalidate the word at address $t2
	addi	$t2, $t2, 4	# Move to next word address
	addi	$t1, $t1, -4	# Use cache size to count down loop iterations
	bnez	$t1, inval_i_loop
				# Keep writing bytes until we run out of space.

# Now that we have invalidated the I-cache, we move on to the D-cache
swap_i_for_d:
	mfc0	$t0, SR
	nop
	nop
	lui	$t1, 0xFFFD
	ori	$t1, $t1, 0xFFFF
	and	$t0, $t0, $t1		# clear the SwC bit
	mtc0	$t0, SR
	nop
	nop

# Having swapped the caches, we can repeat the same operation on the D-cache
# that we did on the I-cache.
	lui	$t1, 0x0004	# $t1 is initially 256K.
	li	$t2, 0x0400	# $t2 is the smallest cache size (0.5K) 
	lui	$t3, 0x8000	# $t3 = kseg0 = 0x8000 0000
size_d:
	add	$t0, $t3, $t1	# $t0 = kseg0 + current size
	sw	$t0, $t1	# After we're done looping, leaves the cache
				# size in mem address 0x8000 0000
	srl	$t1, $t1, 1	# divide the size we're looking for by two
	bne	$t1, $t2, size_d
				# Move on if we've finished all cache sizes
				# loop otherwise.
read_size_d:
	lw	$t1, $t3	# Loads the value of kseg0 into $t1
				# Our cache size is now in $t1
	addi	$t2, $0, 0	# Conveniently, $t2 holds the value we want to
				# start writing at
inval_d_loop:
	sb	$0, 0($t2)	# Invalidate the word at address $t2
	addi	$t2, $t2, 4	# Move to next word address
	addi	$t1, $t2, -4	# Use cache size to count down loop iterations
	bnez	$t1, inval_d_loop
				# Keep writing bytes until we run out of space.

# Step 3: Initialize $sp and reset SR to proper values. 
	lui	$sp, 0x001
	ori	$sp, $sp, 0x31FC  # The highest the stack goes is 0x00131FF.

# Set register bits:
#   22 (BEV) = 0 now that we have initialized the cache.
#   16 (IsC) = 0 to disable isolation
#   0  (IEc) = 1 now that we are done with the cache we can re-enable interrupts
	
	mfc0	$t0, SR
	nop
	nop
	ori	$t0, $t0, 0x1	# set IEc
	lui	$t1, 0xFFBE	
	ori	$t1, $t1, 0xFFFF
	and	$t0, $t0, $t1   # clear BEV and IsC.
	mtc0	$t0, SR
	nop
	nop


# Step 4: Jump to a cached-mode address
	lui	$t0, 0x9FC0
	ori	$t0, $t0, 0x1000
	jr	$t0		# Instructions should start at 0x9FC01000 
