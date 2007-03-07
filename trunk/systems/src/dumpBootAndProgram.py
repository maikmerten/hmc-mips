"""
dumpBootAndProgram.py

Created 2/27/07 by Matt McKnett
HMC Spring 2007 CMOS VLSI, MIPS project

This script is designed to accept three dump files (each file composed of
MIPS instructions in hex, one instruction per line) and space them properly.
"""

# These addresses are locations in memory that the processor will actually
# look for the first instruction, the boot loader, and the first program.
reset_loc = 0x00000000
boot_loc =  0x00000e00
prog_loc =  0x00001000

def dumpBootAndProgram(boot_start, boot_load, program, output):
    current_loc = reset_loc
    output_file = open(output, 'wb')

    #First open the bootstrapper start file and output the lines.
    boots_file = open(boot_start, 'rU')
    for line in boots_file:
        output_file.write(line)
        current_loc += 4
    boots_file.close()
    
    offset = boot_loc - current_loc
    if offset < 0:
        print "Boot and Program Dump:  initial boot code exceeded available " \
                "memory region.  Read %d lines from %s." % (current_loc, boot_start)
        sys.exit(1)

    # Write 0's as a buffer between memory locations.
    while offset > 0 :
        output_file.write("00000000")
        current_loc += 4
        offset -= 4

    print "  Diagnostic: current_loc = %d, and boot_loc = %d" % (current_loc, boot_loc)
    
    
    bootl_file = open(boot_load, 'rU')
    bootl_file.close()
    progr_file = open(program, 'rU')
    progr_file.close()
    
    
