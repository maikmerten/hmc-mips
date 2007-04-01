/*
 *  lightsOut.c
 *
 *  Created by Matt McKnett on 4/1/07
 *  VLSI Spring 2007
 *
 *  This demo program is a "lights out" game playable on the 
 *  hmc-mips system.
 */

#include "lightsOut.h"
#include "muddCLib/muddCLib.h"

int main() 
{
	/* Initialize variables */
	int i;
	int buttonPressed;

	while(1)  /* The main program loop */
	{

	/* Initialize variables, array, and LCD. */
	for(i = 0; i < NUM_LIGHTS; ++i) 
	{
		/* For now, we won't randomize the lights, we'll just make them
		   all on initially. */
		lights[i] = LIGHT_ON;
	}
	lightsOut = 0;
	lightPosition = 0;
	buttonPressed = 0;

	/* Randomize the array. */

	/* printLED("LightsOut!"); */

	while(!lightsOut)
	{
		/* Read input from the buttons and update the game state. */
		update(readInput());
		lightsOut = areLightsOut();
		printLights();
	}

	while(!buttonPressed)
	{
		/* printLED("You win!"); */
		/* printLED("Play again?"); */
		buttonPressed = (int)readInput();
	}
	

	} /* END of the main program loop. */

	return 0;
}

char *lastPressed = 0;
char lastVal = 0;

char* readInput() 
{
	char leftVal;
	char rightVal;
	char upVal;

	leftVal = ReadSwitch(BUTTON_LEFT);
	rightVal = ReadSwitch(BUTTON_RIGHT);
	upVal = ReadSwitch(BUTTON_UP);

	/* Ignore input if more than one button is pressed. */
	if( (leftVal == BUTTON_PRESSED && rightVal == BUTTON_PRESSED)
		|| (leftVal == BUTTON_PRESSED && upVal == BUTTON_PRESSED)
		|| (rightVal == BUTTON_PRESSED && upVal == BUTTON_PRESSED) )
	{
		return (char*)0;
	}

	/* Check to see if any button was just pressed. */
	if( leftVal == BUTTON_PRESSED
        && !(lastPressed == BUTTON_LEFT && lastVal == BUTTON_PRESSED) )
	{
		lastPressed = BUTTON_LEFT;
		lastVal = BUTTON_PRESSED;
		return BUTTON_LEFT;
	}
	else if(rightVal == BUTTON_PRESSED
		&& !(lastPressed == BUTTON_RIGHT && lastVal == BUTTON_PRESSED) )
	{
		lastPressed = BUTTON_RIGHT;
		lastVal = BUTTON_PRESSED;
		return BUTTON_RIGHT;
	}
	else if(upVal == BUTTON_PRESSED
		&& !(lastPressed == BUTTON_UP && lastVal == BUTTON_PRESSED) )
	{
		lastPressed = BUTTON_UP;
		lastVal = BUTTON_PRESSED;
		return BUTTON_UP;
	}

	/* If no button was just pressed, check to see if all buttons are
	   released, and if they are then show the last value as having
	   been released.  */
	if( leftVal == BUTTON_RELEASED
		&& rightVal == BUTTON_RELEASED
		&& upVal == BUTTON_RELEASED    )
	{
		lastVal = BUTTON_RELEASED;
	}

	return (char*)0;
}

void update(char* input) 
{
	/* If the button was the right or left button, we want to move the
	   carat in the appropriate direction. */
	if(input == BUTTON_LEFT)
	{
		if(lightPosition != 0)
			lightPosition -= 1;
	}
	else if(input == BUTTON_RIGHT)
	{
		if(lightPosition != (NUM_LIGHTS - 1) )
			lightPosition += 1;
	}
	/* If the button was the up button, we want to flip the values 
	   in the square pointed to by the carat, and also its neighbors. */
	else if(input == BUTTON_UP)
	{
		/* Consider the corners first, and if we aren't at a corner,
		   then just flip the one pointed at and its neighbors. */
		if(lightPosition == 0)
		{
			lights[0] = (~lights[0]) & 0x1;
			lights[1] = (~lights[0]) & 0x1;
		}
		else if(lightPosition == NUM_LIGHTS - 1)
		{
			lights[NUM_LIGHTS - 1] = (~lights[NUM_LIGHTS - 1]) & 0x1;
			lights[NUM_LIGHTS - 2] = (~lights[NUM_LIGHTS - 2]) & 0x1;
		}
		else
		{
			lights[lightPosition - 1] = (~lights[lightPosition - 1]) & 0x1;
			lights[lightPosition] = (~lights[lightPosition]) & 0x1;
			lights[lightPosition + 1] = (lights[lightPosition + 1]) & 0x1;
		}
	}
}

int areLightsOut() 
{
	int i;
	for(i = 0; i < NUM_LIGHTS; ++i)
	{
		if(lights[i] != 0)
			return 0;
	}

	/* We didn't find any lights that were on. */
	return 1;
}

void printLights()
{

}
