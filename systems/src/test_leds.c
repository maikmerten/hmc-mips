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
