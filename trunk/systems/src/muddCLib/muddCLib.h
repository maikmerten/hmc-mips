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

/* If a switch is up (on) then a value of 0 is returned. */
#define SWITCH_ON ((char)0x01)
#define SWITCH_OFF ((char)0x00)

/* Heap start location */
#define HEAP_START ((void*)0x80016A80

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
#define KCYCLE_CNT (*(char*)0xA0044028)
/* Each increment on the cycle counter is 1000 cycles. */
#define CYCLE_STEP 1000

/* Gets the cycle count from the memory contoller's clock.
 * The cycle count is returned in thousands of cycles.
 */
int getKCycleCount();

/* Delay for CYCLE_STEP*n clock cycles. */
void delay1KTCYx(int n);


/*  =============================================
 *  LCD MANIPULATION METHODS
 *	
 *	These methods were mostly taken from Bart Oegema's and
 *	Bill Hewitt's final E155 project, "PS/2 Keyboard and LCD
 *  Controller With Multiple Buffers," dated Dec. 9, 2005.
 */

#define LCD_RS (*(char*)0xA004402C) // Reset bit on the LCD
#define LCD_E (*(char*)0xA0044030) // Enable bit on the LCD
#define LCD_DATA (*(char*)0xA0044034) // The data register on the LCD

#define LCD_WIDTH 16

#define L_init 0x30		// Standard LCD initialization code
#define L_8bit 0x38		// Code indicating 8-bit operating mode
#define L_off 0x08		// Code to turn off LCD screen
#define L_on 0x0F		// Code to turn on LCD screen
#define L_clear 0x01	// Code to clear the LCD
#define L_entrymode 0x03 // Sets cursor increments when writing to DRAM
#define L_shiftleft 0x18 // Code that shifts the display to the left
#define L_shiftright 0x1C // Code that shifts the display to the right

/* Initialize the LCD. */
void initLCD(void);

/* Display the given character at the current location. */
void dispChar(char character);

/* Display the two strings passed on the first and second lines. */
void dispMessage(char* line1, char* line2);

/* Move the carat to the given position. */
void move(unsigned char position);

/* Pulse the enable bit on the LCD. */
void pulseE(void);

/* Send the specified instruction to the LCD. */
void sendInst(unsigned char instruction);

/* Check to see if the location specified is valid. */
unsigned char checkLoc(unsigned char location);


#endif // MUDDCLIB_INCLUDED
