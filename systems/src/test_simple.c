/* test_simple.c
 *
 * Created by Matt McKnett, HMC-MIPS Project, VLSI Spring 2007
 * $Author$,  $Date$ -- $Revision$
 * 
 * This test just counts up on the LEDs.  Its purpose is to give the testers something to run
 * while they are determining what clock frequency is best for the chip.
 *
 * Systems tested:
 *	- memory I/O -- LEDs
 */

#include "muddCLib/muddCLib.h"

//asm("lui $sp, 0x8004;");

int main() {
	char count = 1;
	int i;
	
	while(1) {
	  //setLED(count++);
	  *LEDS = count++;
	  i = 16000;
	  while(i--);
	  //delay1000clock(20);
        }
	return 0;
}
