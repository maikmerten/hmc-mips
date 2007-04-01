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
#define LED1 (0x80008000)
#define LED2 (0x80008004)
#define LED3 (0x80008008)
#define LED4 (0x8000800C)

/* Button addresses encoded for function use */
#define BUTTON_UP (0x80008010)
#define BUTTON_DOWN (0x80008014)
#define BUTTON_LEFT (0x80008018)
#define BUTTON_RIGHT (0x8000801C)
#define BUTTON_MID (0x80008020)

/* if a button is pressed, then a value of 0 is returned by
   the memory system.  */
#define BUTTON_PRESSED 0
#define BUTTON_RELEASED 1

/* Switch addresses encoded for function use */
#define SWITCH1 (0x80008024)
#define SWITCH2 (0x80008028)
#define SWITCH3 (0x8000802C)
#define SWITCH4 (0x80008030)

/* If a switch is up (on) then a value of 0 is returned. */
#define SWITCH_ON 0
#define SWITCH_OFF 1


/* Turns on the LED at the address supplied */
void LEDoff(void* led);

/* Turns off the LED at the address supplied */
void LEDon(void* led);

/* Reads the button or switch at the address specified
   Use the BUTTON_X or SWITCH# constants!
 */
bool ReadSwitch(void* button);

/*
 *  LCD MANIPULATION METHODS
 */



#endif // MUDDCLIB_INCLUDED
