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

boot:	lui $t0, 0xBFC0		# Our main bootloader is located at 0xBFC00E00
	ori $t0, $t0, 0x0E00
	jr  $t0
	nop

#boot:	b __reset		# For now, we will try getting the linker
#				# to use the boot_loader tag __reset
