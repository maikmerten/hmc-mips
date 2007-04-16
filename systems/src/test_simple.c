/* test_simple.c
 *
 * Created by Matt McKnett, HMC-MIPS Project, VLSI Spring 2007
 * $Author: whiterook2004 $,  $Date: 2007-04-12 17:39:50 -0700 (Thu, 12 Apr 2007) $ -- $Revision: 542 $
 * 
 * This test just counts up on the LEDs.  Its purpose is to give the testers something to run
 * while they are determining what clock frequency is best for the chip.
 *
 * Systems tested:
 *	- memory I/O -- LEDs
 */

#include "muddCLib/muddCLib.h"

int main() {
	char count = 0;

	while(1)
	{
		setLED(count);
		delay1000clock(50);
		++count;
	}

	return 0;
}