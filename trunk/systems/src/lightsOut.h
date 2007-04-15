/*
 * lightsOut.h
 * 
 * Created by Matt McKnett on 4/1/07
 * VLSI Spring 2007
 *
 * $Author$,  $Date$ -- $Revision$
 * 
 * This is a demo program for the hmc-mips project.  It is a
 * "lights out" game playable on the LCD display onboard the
 * PCB board.
 */

#ifndef LIGHTSOUT_INCLUDED
#define LIGHTSOUT_INCLUDED 1

#include "muddCLib/muddCLib.h"

/* Comment this line to use the LCD instead of LEDs */
//#define USE_LEDS 1

#ifdef USE_LEDS
	#define NUM_LIGHTS 4
	int lastOn;
#else
	#define NUM_LIGHTS LCD_WIDTH
#endif

#define LIGHT_OFF 1
#define LIGHT_ON 0

#define PRINT_LIGHT_ON 0x20
#define PRINT_LIGHT_OFF 0xFF
#define PRINT_CARAT	'^'

int lights[NUM_LIGHTS];
int lightsOut;
int lightPosition;

/* readInput shall return the button that was pressed, or 0 if no
   button is being pressed. */
char* readInput();

/* update shall shift the lightPosition carat if it receives a 
   left or right button, or else it shall flip the corresponding
   lights if it sees an up button. */
void update(char* input);

/* areLightsOut returns true if all of the lights are out. */
int areLightsOut();

/* print the lights and carat out in an understandable way. */
void printLights();

#endif /* LIGHTSOUT_INCLUDED. */
