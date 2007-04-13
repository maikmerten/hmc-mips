/* test_lcd.c
 *
 * Created by Matt McKnett, HMC-MIPS Project, VLSI Spring 2007
 * $Author$,  $Date$ -- $Revision$
 * 
 * The purpose of this test is to test the function of the LCD screen
 * that is built into the PCB board.  It does the following:
 *	- Initializes the LCD screen and initiates an infinite loop
 *  - Causes the LEDs to blink before each iteration through the loop
 *  - Flashes two stars on the LCD, and then prints
 *	  "Hello, World!
 *	      HMC VLSI 07"
 *	  on the LCD.
 *  - Leaves the message on the screen for a short time, then clears
 *	  the screen and loops again.
 *
 * Systems tested:
 *	- memory I/O -- LCD
 */

#include "muddCLib/muddCLib.h"

int main() 
{
	char str1[16] = {'H', 'e', 'l', 'l', 'o', ',', ' ', 'W', 'o', 'r', 'l', 'd', '!'};
	char str2[16] = {' ', ' ', ' ', 'H', 'M', 'C', ' ', 'V', 'L', 'S', 'I', ' ', '0', '7'};
	int i;

	initLCD();

	while(1)
	{
		// Make some LEDs blink so we know we're getting
		// some response from the board.
		setLED(0x1);
		delay1000clock(300);
		setLED(0x2);
		delay1000clock(300);
		setLED(0x4);
		delay1000clock(300);
		setLED(0x8);
		delay1000clock(300);
		setLED(0x9);

		// Move test
		move(L_secondRow);
		dispChar('*');

		delay1000clock(200);  // Flash a * for a short bit

		setLED(0x00);

		sendInst(L_clear);
		move(0x08);
		dispChar('*');

		delay1000clock(200);

		setLED(0x00);

		// Print "Hello, Word!"
		//       "   HMC VLSI 07"

		sendInst(L_clear);
		move(0x00);

		for(i = 0; i < LCD_WIDTH; ++i)
		{
			if(str1[i] == '\0')
				break;
			dispChar(str1[i]);
		}

		move(L_secondRow);

		for(i = 0; i < LCD_WIDTH; ++i)
		{
			if(str2[i] == '\0')
				break;
			dispChar(str2[i]);
		}

		delay1000clock(3000);

		sendInst(L_clear);
	}

	/* for some reason, dispMessage doesn't work. */
	//dispMessage(str1, str2);
	
	/* Turn off the cursor. */
	//sendInst(L_disp);

	//while(1); // Loop forever

	return 0;
}
