#include "muddCLib/muddCLib.h"

int main() 
{
	char str1[16] = {'H', 'e', 'l', 'l', 'o', ',', ' ', 'W', 'o', 'r', 'l', 'd', '!'};
	char str2[16] = {' ', ' ', ' ', 'H', 'M', 'C', ' ', 'V', 'L', 'S', 'I', ' ', '0', '7'};
	int i;

	initLCD();

	while(1)
	{
		// Move test
		move(L_secondRow);
		dispChar('*');

		delay1000clock(100);

		sendInst(L_clear);
		move(0x08);
		dispChar('*');

		delay1000clock(100);

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

		delay1000clock(1000);

		sendInst(L_clear);
	}

	/* for some reason, dispMessage doesn't work. */
	//dispMessage(str1, str2);
	
	/* Turn off the cursor. */
	//sendInst(L_disp);

	//while(1); // Loop forever

	return 0;
}
