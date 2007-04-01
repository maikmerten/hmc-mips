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
#define LEDS ((char*)0xA0044000)

/* Button addresses encoded for function use */
#define BUTTON_UP ((char*)0xA0044018)
#define BUTTON_DOWN ((char*)0xA004401C)
#define BUTTON_LEFT ((char*)0xA0044020)
#define BUTTON_RIGHT ((char*)0xA0044024)
#define BUTTON_MID ((char*)0xA0044014)

/* if a button is pressed, then a value of 0 is returned by
   the memory system.  */
#define BUTTON_PRESSED ((char)0x00)
#define BUTTON_RELEASED ((char)0xFF)

/* Switch addresses encoded for function use */
#define SWITCH0 ((char*)0xA0044004)
#define SWITCH1 ((char*)0xA0044008)
#define SWITCH2 ((char*)0xA004400C)
#define SWITCH3 ((char*)0xA0044010)

/* If a switch is up (on) then a value of 0 is returned. */
#define SWITCH_ON ((char)0x00)
#define SWITCH_OFF ((char)0xFF)

/* Heap start location */
#define HEAP_START ((void*)0x80016A80

/* Sets the LED lights in the binary pattern supplied in value */
void setLED(char value);

/* Reads the button or switch at the address specified
   Use the BUTTON_X or SWITCH# constants!
 */
char ReadSwitch(char* switchOrButton);

/*
 *  LCD MANIPULATION METHODS
 */



#endif // MUDDCLIB_INCLUDED
