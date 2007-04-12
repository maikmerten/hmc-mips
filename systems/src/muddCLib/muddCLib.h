/*
 *  muddCLib.h
 *
 *  Created by Matt McKnett, 3/31/07
 *  VLSI Spring 2007
 * 
 *  These functions will provide support for reading and writing to the
 *  hardware on the hmc-mips PCB and Verilog board based on the Memory I/O
 *  specifications defined by the Systems Cluster.
 *
 */


#ifndef MUDDCLIB_INCLUDED
#define MUDDCLIB_INCLUDED 1


/* LED addresses encoded for easy use of functions. */
#define LEDS ((char*)0xA0044000)

/* Button addresses encoded for function use */
#define BUTTON_ENTER ((char*)0xA0044014)
#define BUTTON_UP ((char*)0xA0044018)
#define BUTTON_DOWN ((char*)0xA004401C)
#define BUTTON_LEFT ((char*)0xA0044020)
#define BUTTON_RIGHT ((char*)0xA0044024)

/* if a button is pressed, then a value of 0 is returned by
   the memory system.  */
#define BUTTON_PRESSED ((char)0x01)
#define BUTTON_RELEASED ((char)0x00)

/* Switch addresses encoded for function use */
#define SWITCH0 ((char*)0xA0044004)
#define SWITCH1 ((char*)0xA0044008)
#define SWITCH2 ((char*)0xA004400C)
#define SWITCH3 ((char*)0xA0044010)

#define NOSWITCH ((char*)0)

/* If a switch is up (on) then a value of 0 is returned. */
#define SWITCH_ON ((char)0x01)
#define SWITCH_OFF ((char)0x00)

/* Heap start location */
#define HEAP_START ((void*)0x80026A80)

/* Sets the LED lights in the binary pattern supplied in value */
void setLED(char value);

/* Reads the button or switch at the address specified
   Use the BUTTON_X or SWITCH# constants!
 */
char readSwitch(char* switchOrButton);


/*  =============================================
 *	TIME FUNCTIONS
 *
 *  These functions use the timing unit that we
 *  built into the memory controller.
 */

/* The location of the cycle counter.  It counts every thousand 
   cycles.
   Note that this macro defines it as dereferenced.  This
   makes it easy to set and get CYCLE_CNT.  */
#define CYCLE_CNT (*(int*)0xA004402C)

/* Gets the cycle count from the memory contoller's clock.
 * The cycle count is returned in thousands of cycles.
 */
int getCycleCount();

/* Delay for 1000*n clock cycles. */
void delay1000clock(int n);

/* Delay for cycle_count clock cycles. */
void delay1clock(int cycle_count);


/*  =============================================
 *  LCD MANIPULATION METHODS
 *	
 *	These methods were mostly taken from Bart Oegema's and
 *	Bill Hewitt's final E155 project, "PS/2 Keyboard and LCD
 *  Controller With Multiple Buffers," dated Dec. 9, 2005.
 */

/* In hardware, we only have one address to write to.
   Bits 0-7 are data, bit 8 is RS.  */
#define LCD_RS_MASK 0x100
#define LCD_DATA_MASK 0x0FF

#define LCD_DATA (*(int*)0xA0044028)

#define LCD_WIDTH 16

#define L_init 0x30		// Standard LCD initialization code
#define L_8bit 0x38		// Code indicating 8-bit operating mode
#define L_clear 0x01	// Code to clear the LCD

#define L_off 0x08		// Turns off the LCD
#define L_on 0x0F
#define L_disp 0x0C		// Include this in a bitwise OR to turn on the LCD.
#define L_curs 0x0A		// Include this in a bitwise OR to turn on the cursor.
#define L_blink 0x09	// Include this in a bitwise OR to make the cursor blink.

#define L_single 0x04 // Write a single character & deactivate cursor mode
#define L_normEntry 0x06 // Normal mode: move to the right as char's entered.

#define L_moveRight 0x14 // move cursor to right.
#define L_moveLeft 0x10 // move cursor to left.
#define L_shiftLeft 0x18 // Shifts the display to the left
#define L_shiftRight 0x1C // Shifts the display to the right

#define L_moveHome 0x02	  // Places the cursor back at 0x00 without changing data.
#define L_moveMask 0x80	  // Bitwise OR this with an int to set the cursor position.
#define L_secondRow 0x40  // The start of the second row.

/* Initialize the LCD. */
void initLCD(void);

/* Display the given character at the current location. */
void dispChar(char character);

/* Display the two strings passed on the first and second lines. */
void dispMessage(char* line1, char* line2);

/* Move the carat to the given position. */
void move(unsigned char position);

/* Pulse the enable bit on the LCD.  Hardware no longer needs this.*/
/* void pulseE(void); */

/* Send the specified instruction to the LCD. */
void sendInst(unsigned char instruction);

/* Check to see if the location specified is valid. */
unsigned char checkLoc(unsigned char location);


/*  =============================================
 *  LIBRARY EMULATION METHODS
 *	
 *	These methods are used in place of standard library
 *  functions that we cannot use because of the limitations
 *  of yoda_warrior.
 */

/* type definitions needed for standard library functions */
typedef unsigned int size_t;

/* The string copy function puts the data in str2 into str1.
   It assumes that there is enough space in str1 to copy all of str2! */
char* strcpy(char *dest, char *src);

/* Returns positive if str1 is lexically greater than str2, 0 if they
   are equal, and negative if str1 is lexcially less than str2.	   */
int strcmp(register const char *str1, register const char *str2);

void *memset(void *buffer, int ch, size_t count);

#endif // MUDDCLIB_INCLUDED
