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

//asm("lui $sp, 0x8004;");

// Uncomment this line if you want to try making the right button toggle LED3.
//#define TRY_TOGGLE 1

int main()
{
	// Initially, all LEDs off.
	char ledVal = 0x0;
	setLED(0x0);

	// Do a little wiggle
	wiggleLED();

	// Main loop
	while(1) {
	  setLED(ledVal);
          if(readSwitch(BUTTON_LEFT) == BUTTON_PRESSED)
		ledVal |= 0x1;
	  else
		ledVal &= ~0x1;

          if(readSwitch(BUTTON_RIGHT) == BUTTON_PRESSED)
		ledVal |= 0x2;
	  else
		ledVal &= ~0x2;

          if(readSwitch(BUTTON_UP) == BUTTON_PRESSED)
		ledVal |= 0x4;
	  else
		ledVal &= ~0x4;

          if(readSwitch(BUTTON_DOWN) == BUTTON_PRESSED)
		ledVal |= 0x8;
	  else
		ledVal &= ~0x8;
	}

	return 0;
}
