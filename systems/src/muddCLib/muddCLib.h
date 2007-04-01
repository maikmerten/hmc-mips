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


/* LED addresses encoded for easy use of functions */
#define LEDS ((void*)0xA0044000)

/* Button addresses encoded for function use */
#define BUTTON_UP ((void*)0x80008010)
#define BUTTON_DOWN ((void*)0x80008014)
#define BUTTON_LEFT ((void*)0x80008018)
#define BUTTON_RIGHT ((void*)0x8000801C)
#define BUTTON_MID ((void*)0x80008020)

/* if a button is pressed, then a value of 0 is returned by
   the memory system.  */
#define BUTTON_PRESSED ((char)0x00)
#define BUTTON_RELEASED ((char)0xFF)

/* Switch addresses encoded for function use */
#define SWITCH1 ((void*)0x80008024)
#define SWITCH2 ((void*)0x80008028)
#define SWITCH3 ((void*)0x8000802C)
#define SWITCH4 ((void*)0x80008030)

/* If a switch is up (on) then a value of 0 is returned. */
#define SWITCH_ON ((char)0x00)
#define SWITCH_OFF ((char)0xFF)


/* Sets the LED lights in the binary pattern supplied in value */
void setLED(char value);

/* Reads the button or switch at the address specified
   Use the BUTTON_X or SWITCH# constants!
 */
char ReadSwitch(void* switchOrButton);

/*
 *  LCD MANIPULATION METHODS
 */



#endif // MUDDCLIB_INCLUDED