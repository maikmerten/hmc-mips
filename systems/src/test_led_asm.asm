# test_led_asm.asm
# 
# Created by Matt McKnett on 4/19/2007
#
# This file is designed for debugging the dual FPGA.
# It turns on LED0 and LED3, and turns off LED1 and LED2.
#

.set noreorder

main:
	lui	$8, 0xA004		# Load the LED address 0xA0044000
	ori	$8, $8, 0x4000
	addi	$9, $0, 0x9		# Print 1001 on the LEDs
	sw	$9, 0($8)
loop:
	j	loop
	nop