# Harvey Mudd College VLSI MIPS Project
# Carl Nygaard
# Spring, 2007
#
# Test 012
#
# Created: 1/27/07
#
#   Multiply/Divide test

main:   addi  $2, $0, 50        # $2 = 50
        addi  $3, $0, 70        # $3 = 70
        mult  $2, $3            # LO = 50 * 70 = 3500
        mflo  $4                # $4 = LO = 3500
        sw    $4, 0($0)         # should write 3500 to address
end:    beq   $0, $0, end       # loop forever
        nop
