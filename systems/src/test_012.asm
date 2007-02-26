	.file	1 "test_012.c"
	.section .mdebug.abi32
	.previous
 #APP
	li $sp,0x200
 #NO_APP
	.text
	.align	2
	.globl	test_012
	.ent	test_012
test_012:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-16
	sw	$fp,8($sp)
	move	$fp,$sp
	li	$2,12			# 0xc
	sw	$2,4($fp)
	li	$2,1			# 0x1
	sw	$2,0($fp)
	j	$L2
	nop

$L3:
	lw	$3,0($fp)
	lw	$2,4($fp)
	nop
	mult	$3,$2
	mflo	$2
	sw	$2,0($fp)
	lw	$2,4($fp)
	nop
	addiu	$2,$2,-1
	sw	$2,4($fp)
$L2:
	lw	$2,4($fp)
	nop
	bne	$2,$0,$L3
	nop

	move	$sp,$fp
	lw	$fp,8($sp)
	addiu	$sp,$sp,16
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	test_012
	.size	test_012, .-test_012
	.ident	"GCC: (GNU) 4.1.1"
