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

// Uncomment this line if you want to try making the right button toggle LED3.
// #define TRY_TOGGLE 1

int main()
{
	// Initially, all LEDs off.
	char ledVal = 0x0;
	setLED(ledVal);

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
			lastVal = BUTTON_PRESSED;
		}
		else
		{
			ledVal = ledVal & ~0x1;  // binary 1110
			if(lastPressed == BUTTON_LEFT)
				lastVal = BUTTON_RELEASED;
		}

		// Top button press causes the LED1 to light up
		// when pressed.
		if(readSwitch(BUTTON_UP) == BUTTON_PRESSED)
		{
			ledVal = ledVal | 0x2;  // binary 0010
			lastPressed = BUTTON_UP;
			lastVal = BUTTON_PRESSED;
		}
		else
		{
			ledVal = ledVal & ~0x2;  // binary 1101
			if(lastPressed == BUTTON_UP)
				lastVal = BUTTON_RELEASED;
		}

		// Bottom button press causes the LED2 to light up
		// when pressed.
		if(readSwitch(BUTTON_DOWN) == BUTTON_PRESSED)
		{
			ledVal = ledVal | 0x4;  // binary 0100
			lastPressed = BUTTON_DOWN;
			lastVal = BUTTON_PRESSED;
		}
		else
		{
			ledVal = ledVal & ~0x4;  // binary 1011
			if(lastPressed == BUTTON_DOWN)
				lastVal = BUTTON_RELEASED;
		}

#ifndef TRY_TOGGLE
		// Right button press turns on LED3 for as long as it is held.
		if(readSwitch(BUTTON_RIGHT) == BUTTON_PRESSED)
		{
			ledVal = ledVal | 0x8;  // binary 1000
			lastPressed = BUTTON_RIGHT;
			lastVal = BUTTON_PRESSED;
		}
		else
		{
			ledVal = ledVal & ~0x8;  // binary 0111
			if(lastPressed == BUTTON_RIGHT)
				lastVal = BUTTON_RELEASED;
		}
#else
		// Right button press toggles LED3
		if(readSwitch(BUTTON_RIGHT) == BUTTON_PRESSED)
		{
			if(lastPressed != BUTTON_RIGHT || lastVal == BUTTON_RELEASED)
			{
				// If LED3 is not off
				if(ledVal & 0x8)
					ledVal = ledVal | 0x8;	// Turn LED3 on
				else
					ledVal = ledVal & ~0x8;	// Turn LED3 off

				lastPressed = BUTTON_RIGHT;
				lastVal = BUTTON_PRESSED;
			}
		}
		else
		{
			if(lastPressed == BUTTON_RIGHT)
				lastVal = BUTTON_RELEASED;
		}
#endif
			
		// After figuring out what buttons were pressed, show the LEDs.
		setLED(ledVal);
	}

	return 0;
}
