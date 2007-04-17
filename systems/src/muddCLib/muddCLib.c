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

void delay1000clock(int n)
{
	delay1clock(1000 * n);
}

void delay1clock(int cycle_count)
{
	//while(cycle_count > 0) --cycle_count;
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

	// Delay 4000 clock cycles
	delay1000clock(4);
	// Set the LCD into 8-bit mode
	sendInst(L_8bit);
	// Turn off the LCD
	sendInst(L_off);
	// Clear the LCD
	sendInst(L_clear);
	// Set entry mode - removed this command to see if it fixes the init code.
    sendInst(L_normEntry);
	// Turn on the LCD
	sendInst(L_on);
}

/*
* Displays the given character on the LCD
*/
void dispChar(char character)
{
	LCD_DATA = LCD_RS_MASK | (LCD_DATA_MASK & character);
	delay1clock(200);
}

/*
* Displays a message on the LCD
*/
void dispMessage(char* line1, char* line2)
{
	int i = 0;

	// Clear the LCD.
	sendInst(L_clear);

	// Display first row (display addresses 0x00 - 0x14)
	for(i = 0; i < LCD_WIDTH; ++i)
	{
		if(line1[i] == '\0')
			break;
		dispChar(line1[i]);
	}

	// Display second row (display addresses 0x40 - 0x54)
	move(0x40);
	for(i = 0; i < LCD_WIDTH; ++i)
	{
		if(line2[i] == '\0')
			break;
		dispChar(line2[i]);
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
		sendInst(L_moveMask | position);
	}
}

/*
* Pulse the enable bit to tell the LCD a new instruction is available
*/
/*void pulseE(void)
{
	LCD_DATA = LCD_E_MASK;
	// Delay 2000 clock cycles (100 us)
	delay1000clock(2);
	LCD_DATA = (~LCD_E_MASK);
}*/

/*
* Sends an instruction over the LCD data address
*/
void sendInst(unsigned char instruction)
{
	LCD_DATA = (LCD_DATA_MASK & instruction);
	if(instruction == L_clear || instruction == L_moveHome)
	{
		setLED(0x1);			// Make an LED turn on if we get a clear.
		delay1000clock(5);		// We need at least 1.53 ms delay for a clear.
	}
	else
	{
		delay1clock(200);		// All of the other instructions take
								// less than 50us.
	}
}

/*
* Makes sure the current location is valid; if not, wraps the cursor appropriately
*/
unsigned char checkLoc(unsigned char location)
{
	// Valid location
	if ( (location < 0x14) ||
		 ((location >= 0x40) && (location < 0x54)))
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
	else if ((location >= 0x14) && (location < 0x20))
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

/*****************************
 *  LIBRARY EMULATION METHODS
 *****************************/

char* strcpy(char *dest, char *src)
{
	char current = *src;

	while(current != '\0')
	{
		*dest = current;
		++dest;
		++src;
		current = *src;
	}

	/* At the end of the copy, put a null terminator at 
	   the end of string 1. */
	*dest = '\0';
	return dest;
}

/*
 *  This was essentially taken from:
 *  http://src.opensolaris.org/source/xref/onnv/onnv-gate/usr/src/lib/libc/sparcv9/gen/strcmp.s
 *  on the OpenSolaris website.
 */
int strcmp(register const char *str1, register const char *str2)
{
	if (str1 == str2)
		return 0;

	while(*str1 == *str2++)
		if(*str1++ == '\0')
			return 0;

	return(*str1 - str2[-1]);
}

/*
 * This was taken from:
 * http://src.opensolaris.org/source/xref/onnv/onnv-gate/usr/src/common/util/memset.c
 * on the OpenSolaris website.
 *
 * Thank God for OpenSolaris!
 */
void *memset(void *buffer, int ch, size_t count)
{
	if (count != 0) {
		unsigned char *cbuff = buffer;
		do {
			*cbuff++ = (unsigned char)ch;
		} while (--count != 0);
	}

	return (buffer);
}
