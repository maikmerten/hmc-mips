/* mips_corner_test.c
 * 
 * Bart Oegema	boegema@hmc.edu
 * 4/16/2007
 *
 * Written as part of the HMC/Adelaide MIPS processor implementation project.
 *
 * Combines the corner cases defined by the µArch team into a single C
 * test file, outputting status to the LCD display. Intended to aid in
 * debugging of any problems that arise in the hardware implementation
 * of the MIPS processor after fabrication.
 *
 * Test cases adopted from earlier implementations. Memory reallocated according
 * to defined memory map.
 */

#include "muddCLib/muddCLib.h"

#define NUM_TESTS 1
#define TEST0_ADDRESS ((int*)0x20000)	// I don't know if this address works.  Also, line 58 uses a magic 
										// number version of this.
#define TEST0_RESULT 21

void test0();

int main()
{
	int test_num = 0;
	char passStr[LCD_WIDTH] = {'T', 'e', 's', 't', ' ', ' ', '0', ':', ' ', 'P', 'a', 's', 's', '\0'};
	char nothing[LCD_WIDTH] = {'\0'};
	char failStr[LCD_WIDTH] = {'T', 'e', 's', 't', ' ', ' ', '0', ':', ' ', 'F', 'a', 'i', 'l', '\0'};
	char halted[LCD_WIDTH] = {'H', 'a', 'l', 't', 'e', 'd', '.', '\0'};
	int strDigHi = 5;
	int strDigLo = 6;

	initLCD();

	while(test_num < NUM_TESTS)
	{

		switch(test_num)
		{
			/* Test 000
			 * Commands tested:
			 *   addi, add, beq, sw
			 *
			 * Expected Behavior:
			 *   Fibonnacci Sequence.
			 */  
			case 0:
			{
				test0();
				
				if (*TEST0_ADDRESS == TEST0_RESULT) // suffix 'u' makes an unsigned long
				{
					passStr[strDigHi] = ' ';
					passStr[strDigLo] = '0';
					dispMessage(passStr, nothing);
				}
				else
				{
					failStr[strDigHi] = ' ';
					failStr[strDigLo] = '0';
					dispMessage(failStr, halted);
					return 0;
				}
			} // case 0
		

		} // test_num switch statement


		++test_num;   // Go through each test.

	}	// end of program while loop

	return 0;
}

void test0()
{
	asm volatile (
		".set noreorder\n\t"
		"main0:   addi $2, $0, 0\n\t"		// initialize $2 = 0
				"addi $3, $0, 1\n\t"		// initialize $3 = 1
				"addi $5, $0, 21\n\t"		// initialize $5 = 21 (stopping point)
		"loop0:   add  $4, $2, $3\n\t"		// $4 <= $2 + $3
				"add  $2, $3, $0\n\t"		// $2 <= $3
				"add  $3, $4, $0\n\t"		// $3 <= $4
				"beq  $4, $5, write0\n\t"	// when sum is 21, jump to write
				"nop\n\t"
				"beq  $0, $0, loop0\n\t"		// loop (beq is easier to assemble than jump)
				"nop\n\t"
		"write0:  sw   $4, 0x20000($2)\n\t"		// should write 21 @ 7 + 13 = 20 = 0x14
		"end0:    beq  $0, $0, end0\n\t"		// loop forever
				"nop" );
}
