# Harvey Mudd College VLSI MIPS Project
# Carl Nygaard
# Spring, 2007
#
# Test 006
#
# Created: 1/5/07
#
#   Exceptions test.

main:   addi  $3, $0, -1        # $3 = 0xffffffff
        mtc0  $3, $12           # set SR to all the ones we can
        nop                     # Let the assignment go through the pipeline
        nop
        nop
        mfc0  $4, $12           # copy SR to $4
b8:     sw    $0, 0($4)         # should write 0 to address (something)
end:    beq   $0, $0, end       # loop forever
        nop
