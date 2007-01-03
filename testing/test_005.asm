# Harvey Mudd College VLSI MIPS Project
# Spring, 2007
#
# Test 005
#
# Created: 1/2/07
#
#   Branching and branch delay slot tests.

main:   addi  $3, $0, 0x14      # $3 = 0x14
        addi  $2, $0, 0         # $2 = 0
        jalr  $7, $3            # Link address (0x10) into $7, jump $3 = 0x14
                                # (this is r3dest)
        addi  $2, $2, 1         # Branch delay slot, so $2++ = 1
        addi  $2, $2, 100       # Should not be taken
r3dest: sw    $2, 0($7)         # should write 0x1 to address 0x10
end:    beq   $0, $0, end       # loop forever
        nop
