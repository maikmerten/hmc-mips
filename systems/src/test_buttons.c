/* test_buttons.c
 *
 * Created by Matt McKnett, HMC-MIPS Project, VLSI Spring 2007
 * $Author$,  $Date$ -- $Revision$
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

int main()
{
	// Initially, LED1 is on, all others off.
	char ledVal = 0x2;

	// These variables let us make a button press only happen
	// when the button is first read as pressed.
	char *lastPressed = NOSWITCH;
	char lastVal = BUTTON_RELEASED;

	/* Read each button and light up LEDs accordingly. */
	while(1)
	{
		// Left button press causes the LED0 to light up
		// when pressed.
		if(readSwitch(BUTTON_LEFT) == BUTTON_PRESSED)
		{
			ledVal = ledVal | 0x1;  // binary 0001
			lastPressed = BUTTON_LEFT;
			// We don't care about lastVal for BUTTON_LEFT.
		}
		else
		{
			ledVal = ledVal & ~0x1;  // binary 1110
		}

		// Right button press toggles LED1
		if(readSwitch(BUTTON_RIGHT) == BUTTON_PRESSED &&
			(lastPressed != BUTTON_RIGHT ||	lastVal == BUTTON_RELEASED))
		{
			// If LED1 is not off
			if(ledVal & 0x2)
				ledVal = ledVal | 0x2;	// Turn LED1 on
			else
				ledVal = ledVal & ~0x2;	// Turn LED1 off
		}
			

		setLED(ledVal);
	}

	return 0;
}
