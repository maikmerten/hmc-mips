# Harvey Mudd College VLSI MIPS Project
# Carl Nygaard
# Spring, 2007
#
# Test 005
#
# Created: 1/2/07
#
#   Rigorous branching and branch delay slot test. Covers all branch and jump
#   commands.

.set noreorder

main:   addi  $3, $0, 0x14      # $3 = 0x14
        addi  $2, $0, 0         # $2 = 0
        jalr  $7, $3            # Link address (0x10) into $7, jump $3 = 0x14
                                # (this is r3dest)
        addi  $2, $2, 1         # Branch delay slot, so $2++ = 1
        addi  $2, $2, 0x10      # Should not be taken
r3dest: #jal   j1                # jump to j1 (0x8 << 2) and put 0x1c in $31
        # Hardcode the instruction, the assembler wants to make it PIC
        .word   0x0c000008
        addi  $2, $2, 1         # Branch delay slot, so $2++ = 2
        addi  $2, $2, 0x20      # Should not be taken
j1:     bltz  $7, b1            # Should not be taken
        addi  $2, $2, 1         # Branch delay slot, so $2++ = 3
        addi  $2, $2, 1         # $2++ = 4
b1:     bgtz  $7, b2            # Should be taken
        addi  $2, $2, 1         # Branch delay slot, so $2++ = 5
        addi  $2, $2, 0x40      # Should not be taken
b2:     addu  $3, $0, $0        # $3 = 0
        bgez  $3, b3            # Should be taken
        add   $3, $31, $7       # $3 = 0x10 + 0x1c = 0x2c
        addi  $2, $2, 0x80      # Should not be taken
b3:     lui   $4, 0x8000       # $3 = 0x80000000
        bltzal $4, b4           # $31 = address X, with branch taken
        addu  $5, $0, $31       # Delay slot within link, $5 = $31 = X
        addi  $2, $2, 0x100     # Should not happen
b4:     bgezal $4, b5           # No branch taken but link still happens, 
                                # so $31 = address X + 12
        addi  $2, $2, 1         # Should be added (BDS)
        addiu $31, $31, -12     # Make $31 the same as register 5's address
b5:     bne   $5, $31, end      # if the modified addresses are different, fail
        addi  $2, $2, 1         # Should be added (BDS)
        bgezal $0, b7           # Branch and link
        addi  $2, $2, 1         # Should be added (BDS)
b6:     blez  $4, b8            # Should be taken
        addi  $2, $2, 1         # Should be added (BDS)
b7:     jr    $31               # Jump to b6
        nop                     # BDS
b8:     sw    $2, 0($3)         # should write 9 to address 0x2c
end:    beq   $0, $0, end       # loop forever
        nop
