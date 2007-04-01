#include "muddCLib/muddCLib.h"

int main() {
	char switch0;
	char switch1;
	char switch2;
	char switch3;

	while(1)
	{

	switch0 = 0x1;
	switch1 = 0x2;
	switch2 = 0x4;
	switch3 = 0x8;

	if(ReadSwitch(SWITCH0) == SWITCH_ON)
		switch0 = 0;
	if(ReadSwitch(SWITCH1) == SWITCH_ON)
		switch1 = 0;
	if(ReadSwitch(SWITCH2) == SWITCH_ON)
		switch2 = 0;
	if(ReadSwitch(SWITCH3) == SWITCH_ON)
		switch3 = 0;
	setLED((char)(switch0 + switch1 + switch2 + switch3));

	}
	return 0;
}
