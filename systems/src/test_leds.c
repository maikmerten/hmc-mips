/* test_leds.c
 *
 * Created by Matt McKnett, HMC-MIPS Project, VLSI Spring 2007
 * $Author$,  $Date$ -- $Revision$
 * 
 * The purpose of this test is to constantly read the dip switches
 * on the Xilinx board and make the LEDs reflect the value shown
 * by the switches.  It also tests the system's ability to use
 * global data by storing the values of the dip switches in memory.
 *
 * Systems tested:
 *	- memory I/O -- dip switches
 *	- memory I/O -- LEDs
 *	- memory -- global pointer/global data
 */

#include "muddCLib/muddCLib.h"

char dip_switch[4];

int main() {

	while(1)
	{

	dip_switch[0] = 0x1;
	dip_switch[1] = 0x2;
	dip_switch[2] = 0x4;
	dip_switch[3] = 0x8;

	if(readSwitch(SWITCH0) == SWITCH_ON)
		dip_switch[0] = 0;
	if(readSwitch(SWITCH1) == SWITCH_ON)
		dip_switch[1] = 0;
	if(readSwitch(SWITCH2) == SWITCH_ON)
		dip_switch[2] = 0;
	if(readSwitch(SWITCH3) == SWITCH_ON)
		dip_switch[3] = 0;
	setLED((char)(dip_switch[0] + dip_switch[1] + dip_switch[2] + dip_switch[3]));

	}
	return 0;
}
