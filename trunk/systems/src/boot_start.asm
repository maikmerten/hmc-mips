	.file	1 "boot_start.c"
	.section .mdebug.abi32
	.previous
 #APP
	lui $t0, 0xbfc0
	ori $t0, $t0, 0xbeef
	jr  $t0
 #NO_APP
	.text
	.align	2
	.globl	dummyfunc
	.ent	dummyfunc
dummyfunc:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-8
	sw	$fp,0($sp)
	move	$fp,$sp
	move	$sp,$fp
	lw	$fp,0($sp)
	addiu	$sp,$sp,8
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	dummyfunc
	.size	dummyfunc, .-dummyfunc
	.ident	"GCC: (GNU) 4.1.1"
