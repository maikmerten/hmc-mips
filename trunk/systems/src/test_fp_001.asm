	.file	1 "test_fp_001.c"
	.section .mdebug.abi32
	.previous
 #APP
	li $sp,0xf0
	.globl	__addsf3
 #NO_APP
	.section	.sdata,"aw",@progbits
	.align	2
$LC0:
	.word	1078523331
	.align	2
$LC1:
	.word	1073741824
	.align	2
$LC2:
	.word	1065353216
	.text
	.align	2
	.globl	test_fp_1
	.ent	test_fp_1
test_fp_1:
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	lw	$2,%gp_rel($LC0)($28)
	nop
	sw	$2,24($fp)
	lw	$2,%gp_rel($LC1)($28)
	nop
	sw	$2,20($fp)
	lw	$2,%gp_rel($LC2)($28)
	nop
	sw	$2,16($fp)
	lw	$4,24($fp)
	lw	$5,20($fp)
	jal	__addsf3
	nop

	sw	$2,16($fp)
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	test_fp_1
	.size	test_fp_1, .-test_fp_1
	.ident	"GCC: (GNU) 4.1.1"
