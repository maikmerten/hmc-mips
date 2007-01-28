# Harvey Mudd College VLSI MIPS Project
# Thomas W. Barr, Carl Nygaard
# Spring, 2007
#
# Test 010
#
# Created: 1/20/07
#
#   Decode stage exception tests.

# Start code 0x1FC00000
main:   addi $3, $0, 0
        nop         # run syscall
        break 0		        # run the break call
        nop               # modified in source code to be a malformed opcode
        nop		            # add floating point test later.

        sw    $3, 0($0)         # should write 4 to address 0
end:    beq   $0, $0, end       # loop forever
        nop


# Start exception code 0x1FC00100
except: nop
        mfc0  $7, $14           # get the exception address
        addi $3, $3, 1          # increment the exception counter
        nop                     # MUST HAVE NOPS HERE - Move from cp0 takes a 
        nop                     # while, and has no hazard detection
        nop
        addi  $7, $7, 4         # Point to one past the errant instruction
        jr    $7                # Resume
        nop                     # BSD
        
