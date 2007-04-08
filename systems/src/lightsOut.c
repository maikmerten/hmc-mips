/*
 *  lightsOut.c
 *
 *  Created by Matt McKnett on 4/1/07
 *  VLSI Spring 2007
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

/*char lightsOutMsg[LCD_WIDTH];
char hmcMipsMsg[LCD_WIDTH];
char youWinMsg[LCD_WIDTH];
char playAgainMsg[LCD_WIDTH];
char gameOverMsg[LCD_WIDTH];
char blankMsg[LCD_WIDTH];*/

int main() 
{
	/* Initialize variables */
	int i;
	char* buttonPressed;
	int numberExtracted;
	int done;

	/* Construct all of the strings used in the game. */
	char lightsOutMsg[LCD_WIDTH] = {' ', ' ', ' ', 'L', 'i', 'g', 'h', 't', 's', 'O', 'u', 't', '!'};
	char hmcMipsMsg[LCD_WIDTH] = {'H', 'M', 'C', '-', 'M', 'I', 'P', 'S', ' ', 'V', 'L', 'S', 'I', ' ', '0', '7'};
	char youWinMsg[LCD_WIDTH] = {'Y', 'o', 'u', ' ', 'w', 'i', 'n', '!'};
	char playAgainMsg[LCD_WIDTH] = {'P', 'l', 'a', 'y', ' ', 'a', 'g', 'a', 'i', 'n', '?'};
	char gameOverMsg[LCD_WIDTH] = {' ', ' ', ' ', 'G', 'a', 'm', 'e', ' ', 'O', 'v', 'e', 'r'};
	char blankMsg[LCD_WIDTH] = {'\0'};

#ifdef DEBUG_SIMULATOR
	printf("LightsOut!\n");
	int numberSeed = 2;
#else
	/* Initialize the LCD display. */
	initLCD();
	sendInst(L_disp);
	dispMessage(lightsOutMsg, hmcMipsMsg);

	/* Wait for a button press. */
	while(readInput() == NOSWITCH);

	int numberSeed = getCycleCount();
#endif

	/* Initialize done to be 0. */
	done = 0;
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
	buttonPressed = 0;

	while(!lightsOut)
	{
		printLights();
		/* Read input from the buttons and update the game state. */
		update(readInput());
		lightsOut = areLightsOut();
	}

	/* Any button press continues except down, which ends. */
	while(buttonPressed == NOSWITCH)
	{
#ifdef DEBUG_SIMULATOR
		printLights();
		printf("You win!\nPlay again?\n");
#else
		dispMessage(youWinMsg, playAgainMsg);
#endif
		buttonPressed = readInput();
		if(buttonPressed == BUTTON_DOWN)
		{
			done = 1;
		}
	}

	} /* END of the main program loop. */

#ifndef DEBUG_SIMULATOR
	dispMessage(gameOverMsg, blankMsg);
	while(1);	/* Loop forever instead of letting the program
				   counter run up. */
#endif

	return 0;
} /* END of the main function. */

char *lastPressed = 0;
char lastVal = 0;

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

	/* Ignore input if more than one button is pressed. */
	if( (leftVal == BUTTON_PRESSED && rightVal == BUTTON_PRESSED)
		|| (leftVal == BUTTON_PRESSED && upVal == BUTTON_PRESSED)
		|| (rightVal == BUTTON_PRESSED && upVal == BUTTON_PRESSED)
		|| (downVal == BUTTON_PRESSED && leftVal == BUTTON_PRESSED)
		|| (downVal == BUTTON_PRESSED && rightVal == BUTTON_PRESSED)
		|| (downVal == BUTTON_PRESSED && upVal == BUTTON_PRESSED)    )
	{
		return NOSWITCH;
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
	else if(downVal == BUTTON_PRESSED
		&& !(lastPressed == BUTTON_DOWN && lastVal == BUTTON_PRESSED) )
	{
		lastPressed = BUTTON_DOWN;
		lastVal = BUTTON_PRESSED;
		return BUTTON_DOWN;
	}

	/* If no button was just pressed, check to see if all buttons are
	   released, and if they are then show the last value as having
	   been released.  */
	if( leftVal == BUTTON_RELEASED
		&& rightVal == BUTTON_RELEASED
		&& upVal == BUTTON_RELEASED
		&& downVal == BUTTON_RELEASED  )
	{
		lastVal = BUTTON_RELEASED;
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
	char str1[LCD_WIDTH];	/* The upper LCD bar */
	char str2[LCD_WIDTH];	/* The lower LCD bar */
	int i;

	for(i = 0; i < NUM_LIGHTS; ++i)
	{
		if(lights[i] == LIGHT_ON)
			str1[i] = '_';
		else
			str2[i] = '*';
	}

	for(i = 0; i < NUM_LIGHTS; ++i)
	{
		if(i == lightPosition)
			str2[i] = '^';
		else
			str2[i] = ' ';
	}

	dispMessage(str1, str2);
#endif
}
