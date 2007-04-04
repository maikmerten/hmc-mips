/*
 *  muddCLib.c
 *
 *  Created by Matt McKnett, 3/31/07
 *  VLSI Spring 2007
 * 
 *  Supplies code for the functions defined in muddCLib.h
 */

#include "muddCLib.h"

void setLED(char value) 
{
	*LEDS = value;		/* Turn the LED specified on. */
}

char readSwitch(char *switchOrButton) 
{
	return *switchOrButton;
	/* The button value is either BUTTON_PRESSED or BUTTON_RELEASED. */
}

/*****************************
 *  CYCLE COUNTER METHODS
 *****************************/

int getCycleCount() 
{
	return CYCLE_CNT;
}

void delay1KTCYx(int n)
{
	int cycle_count = CYCLE_STEP * n;
	while(cycle_count) --cycle_count;
}

/*****************************
 *  LCD MANIPULATION METHODS
 *****************************/

/*
* Initializes the LCD
*/
void initLCD(void)
{

	// No Delay 40000 clock cycles (20 ms)
	// delay1KTCYx(40);
	// Clear data bus.
	LCD_DATA = 0x00;
	// Set the LCD into 8-bit mode
	sendInst(L_8bit);
	// Turn off the LCD
	sendInst(L_off);
	// Clear the LCD
	sendInst(L_clear);
	// Set entry mode
	sendInst(L_entrymode);
	// Turn on the LCD
	sendInst(L_on);
}

/*
* Displays the given character on the LCD
*/
void dispChar(char character)
{
	LCD_DATA = LCD_RS_MASK | (LCD_DATA_MASK & character);
	// pulseE();
	// Delay 1000 clock cycles (50 us)
	//delay1KTCYx(1);
}

/*
* Displays a message on the LCD
*/
void dispMessage(char* line1, char* line2)
{
	char* curchar = line1;
	int count = 0;
	// Clear the LCD
	sendInst(L_clear);

	// Display first row (display addresses 0x00 - 0x0F)
	move(0x00);
	while ((*curchar != 0 ) && (count < 16))
	{
		dispChar(*curchar);
		++curchar;
		++count;
	}
	// Display second row (display addresses 0x40 - 0x4F)
	curchar = line2;
	count = 0;
	move(0x40);
	while ((*curchar != 0 ) && (count < 16))
	{
		dispChar(*curchar);
		++curchar;
		++count;
	}
	// Move cursor back to first position
	move(0x00);
}

/*
* Moves the cursor to the given position (see LCD datasheet for position numbers)
*/
void move(unsigned char position)
{
	// Check if the given position is within the bounds of the display
	// (position must be >= 0x00 because of its type.)
	if ( (position <= (unsigned char)0x0F) ||
		 ((position >= (unsigned char)0x40) && (position <= (unsigned char)0x4F))   )
	{
		// Need to set high bit so LCD knows you want to move cursor position
		sendInst(0x80 | position);
	}
}

/*
* Pulse the enable bit to tell the LCD a new instruction is available
*/
/*void pulseE(void)
{
	LCD_DATA = LCD_E_MASK;
	// Delay 2000 clock cycles (100 us)
	delay1KTCYx(2);
	LCD_DATA = (~LCD_E_MASK);
}*/

/*
* Sends an instruction over the LCD data address
*/
void sendInst(unsigned char instruction)
{
	LCD_DATA = (LCD_DATA_MASK & instruction);
	// Delay 1000 clock cycles (50 us)
	//delay1KTCYx(1);
}

/*
* Makes sure the current location is valid; if not, wraps the cursor appropriately
*/
unsigned char checkLoc(unsigned char location)
{
	// Valid location
	if ( (location < 0x10) ||
		 ((location >= 0x40) && (location < 0x50)))
	{
		return location;
	}
	// Past end of second line, wrap to first line
	else if ((location >= 0x50) && (location < 0x60))
	{
		location = location % 0x50;
	}
	// Past beginning of first line, wrap to second line
	else if (location >= 0xF0)
	{
		location = location % 0xE0;
	}
	// If off end of first line, wrap to second
	else if ((location >= 0x10) && (location < 0x20))
	{
		location = location + 0x30;
	}
	// If off beginning of second line, wrap to first
	else if ((location >= 0x30) && (location < 0x40))
	{
		location = location % 0x30;
	}
	// If all else fails, go to beginning of first line
	else
		location = 0;
	return location;
}
