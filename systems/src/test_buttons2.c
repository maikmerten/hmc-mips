/* test_buttons.c
 *
 * Created by Matt McKnett, HMC-MIPS Project, VLSI Spring 2007
 * $Author: whiterook2004 $,  $Date: 2007-04-15 23:55:16 -0700 (Sun, 15 Apr 2007) $ -- $Revision: 584 $
 * 
 * The purpose of this test is to read the buttons on the board
 * and indicate by LEDs whether they are being read properly.
 * It also tests a small version of the code used by lightsOut
 * to read a single button press.
 *
 * - The left button causes LED0 to be turned on when pressed, and 
 *	off when released.
 * - The right button causes LED1 to toggle on and off.
 *
 * Some recommended additions to this program:
 * - The top button causes LED2 and LED3 to blink.
 * - The bottom button causes LED2 and LED3 to blink faster.
 * 
 * Pressing the left, right, and top or bottom buttons together
 * will cause all of their functionalities to happen at once;
 * however, pressing buttons top and bottom together causes
 * only the bottom's functionality.
 * 
 * Note: We don't use BUTTON_ENTER because it is used for
 *		 reset in our implementation.
 *
 * Systems tested:
 *	- memory I/O -- buttons
 *	- memory I/O -- LEDs
 */

#include "muddCLib/muddCLib.h"

// Uncomment this line if you want to try making the right button toggle LED3.
//#define TRY_TOGGLE 1

int main()
{
	int i = 0;
	int counter = 0;

	/* Read each button and light up LEDs accordingly. */
	while(1)
	{

		setLED(0x0);	
		for(i = 0; i < 1000000000; ++i)
		{
			counter++;	
		}
		setLED(0x9);
		for(i = 0; i < 1000000000; ++i)
		{
			counter++;	
		}
	}

	if(counter > 0)
		i = 1;
	else
		i = 2;
	return 0;
}
