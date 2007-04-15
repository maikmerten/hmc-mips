/*
 *  lightsOut.c
 *
 *  Created by Matt McKnett on 4/1/07
 *  VLSI Spring 2007
 *
 * $Author$,  $Date$ -- $Revision$
 *
 *  This demo program is a "lights out" game playable on the 
 *  hmc-mips system.
 */

//#define DEBUG_SIMULATOR 1

#ifdef DEBUG_SIMULATOR
#include <stdio.h>
#endif

#include "lightsOut.h"
#include "muddCLib/muddCLib.h"
#include "muddCLib/mtRand.h"

char *lastPressed;

int main() 
{
	/* Declare variables */
	int i;
	char* buttonPressed;
	int numberExtracted;
	int done = 0;

	/* Initialize variables */
	lastPressed = NOSWITCH;

#ifndef USE_LEDS
	/* Construct all of the strings used in the game. */
	char lightsOutMsg[LCD_WIDTH] = {' ', ' ', ' ', ' ', ' ', 'L', 'i', 'g', 'h', 't', 's', 'O', 'u', 't', '!'};
	char hmcMipsMsg[LCD_WIDTH] = {'H', 'M', 'C', '-', 'M', 'I', 'P', 'S', ' ', 'V', 'L', 'S', 'I', ' ', '0', '7'};
	char youWinMsg[LCD_WIDTH] = {'Y', 'o', 'u', ' ', 'w', 'i', 'n', '!'};
	char playAgainMsg[LCD_WIDTH] = {'P', 'l', 'a', 'y', ' ', 'a', 'g', 'a', 'i', 'n', '?'};
	char gameOverMsg[LCD_WIDTH] = {' ', ' ', ' ', 'G', 'a', 'm', 'e', ' ', 'O', 'v', 'e', 'r'};
	char blankMsg[LCD_WIDTH] = {'\0'};
#endif

#ifdef DEBUG_SIMULATOR
	printf("LightsOut!\n");
	int numberSeed = 2;
#else
  #ifdef USE_LEDS
	lastOn = 0;
  #else // USE_LEDS not defined
	/* Initialize the LCD display. */
	initLCD();
	sendInst(L_disp);
	dispMessage(lightsOutMsg, hmcMipsMsg);
  #endif //USE_LEDS



	/* Wait for a button press. */
	while(readInput() == NOSWITCH);

	int numberSeed = getCycleCount();
#endif

	while(!done)  /* The main program loop */
	{

	/* Initialize the random number generator.
	   Seed it with the cycle count.			*/
	initializeGenerator(numberSeed);
	generateNumbers();
	numberExtracted = extractNumber(NUM_LIGHTS);
	
	/* Initialize variables, array, and LCD. */
	for(i = 0; i < NUM_LIGHTS; ++i) 
	{
		/* We'll place the lights randomly. */
		lights[i] = numberExtracted & 0x1;
		numberExtracted = numberExtracted >> 1;
	}
	lightsOut = 0;
	lightPosition = 0;

	printLights();
	buttonPressed = NOSWITCH;

	while(!lightsOut)
	{
		/* Read input from the buttons and update the game state. */
		buttonPressed = readInput();
		update(buttonPressed);
		lightsOut = areLightsOut();
		if(buttonPressed != NOSWITCH)
		{
			printLights();
		}
	}

	/* The lights are out, the game is over */
#ifdef USE_LEDS
	lastOn = 0;
#else
	dispMessage(youWinMsg, playAgainMsg);
#endif

	/* Any button press continues except down, which ends. */
	while(buttonPressed == NOSWITCH)
	{
#ifdef DEBUG_SIMULATOR
		printLights();
		printf("You win!\nPlay again?\n");
#else
  #ifdef USE_LEDS
		/* Finite-state fireworks animation */
		switch(lastOn)
		{
			case 0: setLED(0x2);
			break;
			case 1: setLED(0x5);
			break;
			case 2: setLED(0x8);
			break;
			case 10: setLED(0x4);
			break;
			case 11: setLED(0xA);
			break;
			case 12: setLED(0x1);
			break;
		default: setLED(0x0);
		}

		++lastOn;
  #endif
#endif
		buttonPressed = readInput();
		if(buttonPressed == BUTTON_DOWN)
		{
			done = 1;
		}
	}

	} /* END of the main program loop. */

#ifndef DEBUG_SIMULATOR
  #ifndef USE_LEDS
	dispMessage(gameOverMsg, blankMsg);
  #endif
	while(1);	/* Loop forever instead of letting the program
				   counter run up. */
#endif

	return 0;
} /* END of the main function. */



/* This will find out if a button was just pressed and return the
   pointer to its address. */
char* readInput()
{
#ifdef DEBUG_SIMULATOR /* Are we simulating? */

	char c;
	scanf(" %c", &c);

	if(c == 'a')
		return BUTTON_LEFT;
	if(c == 'd')
		return BUTTON_RIGHT;
	if(c == 'w')
		return BUTTON_UP;
	if(c == 's')
		return BUTTON_DOWN;

	return NOSWITCH;

#else /* This would mean we aren't simulating. */

	char leftVal;
	char rightVal;
	char upVal;
	char downVal;

	leftVal = readSwitch(BUTTON_LEFT);
	rightVal = readSwitch(BUTTON_RIGHT);
	upVal = readSwitch(BUTTON_UP);
	downVal = readSwitch(BUTTON_DOWN);

	/* Check to see if any button was just pressed. */
	if(lastPressed == NOSWITCH)
	{
		if(leftVal == BUTTON_PRESSED)
		{
			lastPressed = BUTTON_LEFT;
			return BUTTON_LEFT;
		}
		else if(rightVal == BUTTON_PRESSED)
		{
			lastPressed = BUTTON_RIGHT;
			return BUTTON_RIGHT;
		}
		else if(upVal == BUTTON_PRESSED)
		{
			lastPressed = BUTTON_UP;
			return BUTTON_UP;
		}
		else if(downVal == BUTTON_PRESSED)
		{
			lastPressed = BUTTON_LEFT;
			return BUTTON_DOWN;
		}
	}

	/* If no button was just pressed, check to see if all buttons are
	   released, and if they are then show the last value as having
	   been released.  */
	if( leftVal == BUTTON_RELEASED
		&& rightVal == BUTTON_RELEASED
		&& upVal == BUTTON_RELEASED
		&& downVal == BUTTON_RELEASED  )
	{
		lastPressed = NOSWITCH;
	}

	return NOSWITCH;

#endif /* We determined whether we want the simulator version of readInput
		  or the real version. */
}

/* Update the array and the carat according to the button that
   was pressed.  */
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
			lights[1] = (~lights[1]) & 0x1;
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
			lights[lightPosition + 1] = (~lights[lightPosition + 1]) & 0x1;
		}
	}
}

/* Return 1 if the lights are out, 0 otherwise */
int areLightsOut() 
{
	int i;
	for(i = 0; i < NUM_LIGHTS; ++i)
	{
		if(lights[i] == LIGHT_ON)
			return 0;
	}

	/* We didn't find any lights that were on. */
	return 1;
}


/* Display the lights in some form the user can interact with. */
void printLights()
{
#ifdef DEBUG_SIMULATOR
	int i;

	printf("--\n");

	for(i = 0; i < NUM_LIGHTS; ++i)
	{
		if(lights[i] == LIGHT_ON)
			printf("_");
		else
			printf("*");
	}
	printf("\n");
	for(i = 0; i < NUM_LIGHTS; ++i)
	{
		if(i == lightPosition)
			printf("^");
		else
			printf(" ");
	}
	printf("\n\n");

#else
  #ifdef USE_LEDS
	/* If we're using LEDs, we need to make the cursor blink. */
	char output = 0x00;
	int i;

	// Look at each "light" and give the proper LED bit its value.
	for(i = 0; i < NUM_LIGHTS;  ++i)
	{
		output = output | (lights[i] << i);
	}

	// Here's where the cursor blinks
	if(lastOn >= 10 && lastOn < 12)
		output = output & ~(1 << lightPosition);  // Turn off cursor position.
	else if(lastOn >= 12 && lastOn < 15)
		output = output | (1 << lightPosition);   // Turn on cursor position.

	// Print the output on the LEDs.
	setLED(output);

	lastOn++;
	if(lastOn == 15)
		lastOn = 0;		// Reset the finite state machine if we're at a certain point.

  #else
	char str1[LCD_WIDTH];	/* The upper LCD bar */
	char str2[LCD_WIDTH];	/* The lower LCD bar */
	int i;

	for(i = 0; i < NUM_LIGHTS; ++i)
	{
		if(lights[i] == LIGHT_ON)
			str1[i] = PRINT_LIGHT_ON;
		else
			str1[i] = PRINT_LIGHT_OFF;
	}

	for(i = 0; i < NUM_LIGHTS; ++i)
	{
		if(i == lightPosition)
			str2[i] = PRINT_CARAT;
		else
			str2[i] = ' ';
	}

	dispMessage(str1, str2);
  #endif
#endif
}
