	.file	1 "test_017.c"
	.section .mdebug.abi32
	.previous
 #APP
	swapon: addi  $9, $0, 1
	sll $9,$9,17
	mtc0  $9, $12
	nop
	nop
	nop
	addi $10, $0, 256
	addi $11, $0, 0x400
	loop1:
	sb $0,0($11)
	addi $11,$11,4
	addi $10,$10,-1
	bnez $10,loop1
	swapoff: addi  $9, $0, 0
	mtc0  $9, $12
	nop
	nop
	nop
	addi $10, $0, 256
	addi $11, $0, 0x400
	loop2:
	sb $0,0($11)
	addi $11,$11,4
	addi $10,$10,-1
	bnez $10,loop2
	li $sp,0x300
	addi $8, $0, 116
	jr $8
 #NO_APP
	.text
	.align	2
	.globl	test
	.ent	test
test:
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	li	$2,768			# 0x300
	sw	$2,20($fp)
	sw	$0,24($fp)
	j	$L2
	nop

$L3:
	lw	$3,20($fp)
	lw	$2,24($fp)
	nop
	sw	$2,0($3)
	lw	$2,20($fp)
	nop
	addiu	$2,$2,4
	sw	$2,20($fp)
	lw	$2,24($fp)
	nop
	addiu	$2,$2,1
	sw	$2,24($fp)
$L2:
	lw	$2,24($fp)
	nop
	slt	$2,$2,15
	bne	$2,$0,$L3
	nop

	li	$2,768			# 0x300
	sw	$2,20($fp)
	sw	$0,24($fp)
	j	$L5
	nop

$L6:
	lw	$2,20($fp)
	nop
	lw	$2,0($2)
	nop
	sw	$2,16($fp)
	lw	$2,20($fp)
	nop
	addiu	$2,$2,4
	sw	$2,20($fp)
	lw	$2,24($fp)
	nop
	addiu	$2,$2,1
	sw	$2,24($fp)
$L5:
	lw	$2,24($fp)
	nop
	slt	$2,$2,15
	bne	$2,$0,$L6
	nop

	sw	$0,28($fp)
	jal	test2
	nop

	move	$3,$2
	lw	$2,24($fp)
	nop
	addu	$3,$3,$2
	lw	$2,28($fp)
	nop
	sw	$3,0($2)
$L8:
	j	$L8
	nop

	.set	macro
	.set	reorder
	.end	test
	.size	test, .-test
	.align	2
	.globl	test2
	.ent	test2
test2:
	.frame	$fp,24,$31		# vars= 16, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-24
	sw	$fp,16($sp)
	move	$fp,$sp
	li	$2,-559087616			# 0xffffffffdead0000
	sw	$2,8($fp)
	li	$2,48864			# 0xbee0
	sw	$2,4($fp)
	lw	$3,8($fp)
	lw	$2,4($fp)
	nop
	addu	$2,$3,$2
	sw	$2,0($fp)
	lw	$2,0($fp)
	move	$sp,$fp
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	test2
	.size	test2, .-test2
	.ident	"GCC: (GNU) 4.1.1"
