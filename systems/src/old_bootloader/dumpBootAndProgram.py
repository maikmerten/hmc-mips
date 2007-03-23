"""
dumpBootAndProgram.py

Created 2/27/07 by Matt McKnett
HMC Spring 2007 CMOS VLSI, MIPS project

This script is designed to accept three dat files (each file composed of
MIPS instructions in hex, one instruction per line) and convert them to a
vector file simulatable in Modelsim.
"""

import sys

#
# The function that takes the three files and puts them together into output
#
def dumpBootAndProgram(boot_start, boot_load, program, output):
    current_loc = reset_loc
    output_file = open(output, 'wb')

    #First open the bootstrapper start file and output the lines.
    boots_file = open(boot_start, 'rU')
    for line in boots_file:
        output_file.write(line)
        current_loc += 4
    boots_file.close()

    # Make sure the boot_starter didn't overrun the boot_loader code.
    offset = boot_loc - current_loc
    if offset < 0:
        print "Boot and Program Dump:  initial boot code exceeded available " \
                "memory region.  Read %d lines from %s." % (current_loc, boot_start)
        sys.exit(1)

    # Write 0's as a buffer between boot_starter and boot_loader.
    while current_loc < boot_loc :
        output_file.write("00000000\n")
        current_loc += 4

    print "  Diagnostic: current_loc = %d, and boot_loc = %d (should match)" % (current_loc, boot_loc)

    # Next open the bootloader and output its lines.
    bootl_file = open(boot_load, 'rU')
    for line in bootl_file:
        output_file.write(line)
        current_loc += 4
    bootl_file.close()

    # Make sure the boot_loader didn't overrun the program code.
    offset = prog_loc - current_loc
    if offset < 0:
        print "Boot and Program Dump:  boot loader exceeded available memory region."\
                  "  Read %d lines from %s" % (current_loc - boot_loc, boot_load)
    
    # Write 0's as a buffer between the boot_loader and the program
    while current_loc < prog_loc :
        output_file.write("00000000\n")
        current_loc += 4

    print "  Diagnostic: current_loc = %d, and prog_loc = %d (should match)" % (current_loc, prog_loc)

    # Last, write the program out to the memory.  
    progr_file = open(program, 'rU')
    for line in progr_file:
        output_file.write(line)
        # If we were to allow the whole mem_size, we would want to add a
        # condition here to see if we need a ';' instead of a ','
        current_loc += 4
    progr_file.close()

    # Make sure the program didn't overrun the memory (leave room for a final word of 0's)
    offset = mem_size - 4 - current_loc
    if offset < 0:
        print "Boot and Program Dump:  The program exceeded available memory region." \
                  "  Read %d lines from %s" % (current_loc - prog_loc, progr_file)

    # Write 0's as a buffer between the program and the end of memory
    while current_loc < mem_size :
        # If we were to allow the whole mem_size, we would want to add a
        # condition here to see if we need a ';' instead of a ','
        output_file.write("00000000\n")
        current_loc += 4
        
    output_file.close()

    print "Boot and Program Dump: output %d words to file %s" % (current_loc / 4, output)


# Here is our main functionality

# parse the arguments
args = sys.argv[1:]

if "--help" in args or len(args) < 4:
    print "Usage:  python dumpBootAndProgram.py -boot_start [bootstrap dat file] -boot_load \
            [bootloader dat file] -program [program dat file] -output [output filename] \
            \n\nOptions:\n-reset_loc [address of beginning of reset instructions in output file]\n \
            -boot_loc [address of beginning of bootloader in output file]\n \
            -prog_loc [address of beginning of program in output file]\n \
            -mem_size [size of file to output in words]\n"
    sys.exit(0)
    
if "-debug" in args:
    DEBUG = 1
else:
    DEBUG = 0

# Default values
# These addresses are locations in memory that the processor will actually
# look for the first instruction, the boot loader, and the first program.
if(not DEBUG):
    reset_loc = 0x00000000
    boot_loc =  0x00000e00
    prog_loc =  0x00001000
    mem_size =  69632
else:
    reset_loc = 0x00000000
    boot_loc =  0x00000020
    prog_loc =  0x00000120
    mem_size =  2**8

# Continue parsing
try:
    i = args.index("-boot_start")
    boot_start = args[i+1]
except IndexError:
    print "Found a bad parameter in the arguments."
    sys.exit(1)
except ValueError:
    print "-boot_start argument is required"
    sys.exit(1)
    
try:
    i = args.index("-boot_load")
    boot_load = args[i+1]
except IndexError:
    print "Found a bad parameter in the arguments."
    sys.exit(1)
except ValueError:
    print "-boot_load argument is required"
    sys.exit(1)

try:
    i = args.index("-program")
    program = args[i+1]
except IndexError:
    print "Found a bad parameter in the arguments."
    sys.exit(1)
except ValueError:
    print "-program argument is required"
    sys.exit(1)

try:
    i = args.index("-output")
    output = args[i+1]
except IndexError:
    print "Found a bad parameter in the arguments."
    sys.exit(1)
except ValueError:
    print "-output argument is required"
    sys.exit(1)

try:
    if "-reset_loc" in args:
        i = args.index("-reset_loc")
        reset_loc = args[i+1]
    if "-boot_loc" in args:
        i = args.index("-boot_loc")
        boot_loc = args[i+1]
    if "-prog_loc" in args:
        i = args.index("-prog_loc")
        prog_loc = args[i+1]
    if "-mem_size" in args:
        i = args.index("-mem_size")
        mem_size = args[i+1]
except IndexError:
    print "Found a bad optional parameter in the arguments."
    sys.exit(1)
    # This would be a good place for an options explanation!

dumpBootAndProgram(boot_start, boot_load, program, output)
sys.exit(0)
