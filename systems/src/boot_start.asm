# Harvey Mudd College VLSI MIPS Project
# Matt McKnett
# Spring, 2007
# 
# Bootloader bootstrap code
#
# This code is step 1 in the bootloading process.  It is designed to jump
# to the main boot code that is stored in ROM.  This keeps the bootloader code
# from running into exception entry points and gives us a simple test of CPU
# function (according to See MIPS Run page 110). 

# We don't want the assembler to reorder or fill branch delay slots.
.set noreorder
.text

reset:
	j	load
	nop

load:
	# Boot-loading code must be placed in exception-handling.  We'll use the
	# breakpoint features to cause an exception to get there.  The exception
	# handler appears to start at 0xBFC00100 on our chip, which is contrary to
	# See MIPS Run.
	break	0x0

	# Once the cache setup is done, jump to the first instruction (in the
	# uncached region).  This ought to be at 0x9FC00200
	#lui	$8, 0x9FC0
	lui	$8, 0xBFC0
	ori	$8, $8, 0x0200
	lui	$sp, 0x8004 # Set $sp
	ori	$sp, 0x4000
	jalr	$8
	nop
final:
	j	final
	nop

# Originally, we were going to jump to a location to prove that the processor is
# configured enough to handle it, but it is probably best to simply jump to the 
# next instruction (which will be the loader) as above.
#boot:	lui $8, 0xBFC0		# Our main bootloader is located at 0xBFC00E00
#	ori $8, $8, 0x0E00
#	jr  $8
#	nop

#	b	reset		# For now, we will try getting the linker
#				# to use the boot_loader tag __reset
