#include "muddCLib/muddCLib.h"

int main() 
{
	char str1[16] = {'H', 'e', 'l', 'l', 'o', ',', ' ', 'W', 'o', 'r', 'l', 'd', '!'};
	//int i;
	char str2[16] = {'\0'};

	initLCD();

	//move(0x00);
	//dispChar('F');

	/*for(i = 0; i < 13; ++i)
	{
		move((char)i);
		dispChar(str1[i]);
	}*/

	dispMessage(str1, str2);
	
	/* Turn off the cursor. */
	sendInst(L_disp | L_blink);

	while(1); // Loop forever

	return 0;
}
