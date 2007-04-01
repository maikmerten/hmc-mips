/*
 *  muddCLib.c
 *
 *  Created by Matt McKnett, 3/31/07
 *  VLSI Spring 2007
 * 
 *  Supplies code for the functions defined in muddCLib.h
 */

#include <"muddCLib.h">

void setLED(char value) {
	*((char*)LEDS) = value;		/* Turn the LED specified on. */
}

char ReadSwitch(void* switchOrButton) {
	return *((char*)switchOrButton);	
	/* The button value is either BUTTON_PRESSED or BUTTON_RELEASED. */
}

