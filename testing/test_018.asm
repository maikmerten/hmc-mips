# Harvey Mudd College VLSI MIPS Project
# Matt Totino
# Spring, 2007
#
# Test 017
#
# Created: 2/9/07
#
#   Test exceptions for bad fetch addresses (ie bad PC jumps)
#   *not run yet

.set noreorder

# Start code 0x1FC00000
main:   addi  $6, $0, 0		# start overflow count at 0
	nop			# for pcspim pre-testing: lui   $3, 0x0040		
        addi  $3, $3, 3 	# $3 = 3 (or 0x0027 for pcspim purposes)
        jr    $3		# jump PC to 0x3 (not valid)
	nop      
	nop	             
        addi  $3, $3, 1 	# $3 = 1
        jr    $3		# jump PC to 0x1 (not valid)	
	nop
	nop
	nop
        addi  $3, $3, 2 	# $3 = 2
        jr    $3		# jump PC to 0x2 (not valid)		
	nop	
	nop
	nop	
                    
        sw    $6, 0($6)         # should write #exceptions (3) to address 0x3       
end:    beq   $0, $0, end       # loop forever
        nop

nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop
nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop
nop;nop;nop;nop;nop;nop

# Start exception code at 0x1FC00100 (0x100 compiled) at the earliest
except: mfc0  $4, $13           # get the cause register
        mfc0  $7, $14           # get the exception address
        andi  $4, 0xff          # mask out the exception code
        srl   $4, $4, 2         # align the exception code
        addi  $5, $0, 12        # $5 = 12

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
        rfe                     # BDS
