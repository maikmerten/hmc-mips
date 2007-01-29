# Harvey Mudd College VLSI MIPS Project
# Matt Totino
# Spring, 2007
#
# Test 014
#
# Created: 1/28/07
#
#   Tests overflow limits

# Start code 0x1FC00000
main:   addi  $6, $0, 0		# start overflow count at 0
	lui   $2, 0x8000        # $2 = 0x80000000 = (largest negative number)
        addi  $3, $0, -1        # $3 = -1
        add   $2, $2, $3        # $2 = $2 + $3 = 0 (cause overflow exception)
                                # (jump to exception code)
	lui   $2, 0x8000        # $2 = 0x80000000 = (largest negative number)
	addi  $2, $2, -1	# $2 = $2 + -1 = 0 (cause overflow exception)
                                # (jump to exception code)
	lui   $2, 0x8000        # $2 = 0x80000000 = (largest negative number)
	addi  $3, $0, 1		# $3 = 1
	sub   $2, $2, $3	# $2 = $2 - $3 = 0 (cause overflow exception)
                                # (jump to exception code)
	addi  $2, $0, -1	# $2 = -1 = 0xffffffff
	addi  $2, $2, 1		# $2 = -1 + 1 = 0 (shouldn't cause exception)
	lui   $2, 0x7fff	# big positive in $2
	addi  $2, $2, 0x7fff	# ...
	addi  $2, $2, 0x7fff	# ...
	addi  $2, $2, 1		# get biggest pos into $2
	addi  $2, $2, 1		# cause overflow!
                                # (jump to exception code)
        sw    $6, 0($7)         # should write #overflows (4) to address 0x12
end:    beq   $0, $0, end       # loop forever
        nop


# Start exception code 0x1FC00100
except: mfc0  $4, $13           # get the cause register
        mfc0  $7, $14           # get the exception address
        andi  $4, 0xff          # mask out the exception code
        srl   $4, $4, 2         # align the exception code
        addi  $5, $0, 12        # $5 = 12
        bne   $4, $5, end       # fail if the exception code is not 12 (stored in $4)
        
	addi  $7, $7, 4         # Point to one past the errant instruction
                                # (to avoid an infinite exception loop)
	addi  $6, $6, 1		# add 1 to overflow count
        nop
        nop # something is weird here, so adding nops
        nop
        nop
        nop
        nop
        jr    $7                # Resume
        nop                     # BDS
