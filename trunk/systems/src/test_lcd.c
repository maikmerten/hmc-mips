#include "muddCLib/muddCLib.h"

int main() 
{
	initLCD();

	dispMessage("Hello, world!", " HMC-MIPS 07");

	while(1); // Loop forever

	return 0;
}