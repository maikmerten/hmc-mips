#include "muddCLib/muddCLib.h"

int main() {
	char switch0;
	char switch1;
	char switch2;
	char switch3;

	while(1)
	{

	switch0 = 0x1;
	switch1 = 0x10;
	switch2 = 0x100;
	switch3 = 0x1000;

	if(ReadSwitch(SWITCH0) == SWITCH_ON)
		switch0 = 0;
	if(ReadSwitch(SWITCH1) == SWITCH_ON)
		switch1 = 0;
	if(ReadSwitch(SWITCH2) == SWITCH_ON)
		switch2 = 0;
	if(ReadSwitch(SWITCH3) == SWITCH_ON)
		switch3 = 0;
	setLED((char)0x09);

	}
	return 0;
}
