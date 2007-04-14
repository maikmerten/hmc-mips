"""
dumpBootAndProgram.py

Created 2/27/07 by Matt McKnett
HMC Spring 2007 CMOS VLSI, MIPS project

This script is designed to accept three dat files (each file composed of
MIPS instructions in hex, one instruction per line) and convert them to a
vector file simulatable in Modelsim.

In debug mode, line numbers are included.
"""

import sys

#
# The function that takes the three files and puts them together into output
#
def dumpBootAndProgram(params):

    # Get pertinent values out of the parameters
    try:
        print params
        reset_name = params['reset_name']
        reset_loc = int(params['reset_loc'], 16)
        except_name = params['except_name']
        except_loc = int(params['except_loc'], 16)
        program_name = params['program_name']
        program_loc = int(params['program_loc'], 16)
        mem_size = int(params['mem_size'], 16)
        output_name = params['output_name']
        debug = params['debug']
    except KeyError:
        print "generateDat: A needed parameter was not defined!"    

    # Initialize the current location and the output file.
    current_loc = reset_loc
    output_file = open(output_name, 'wb')

    #First open the bootstrapper start file and output the lines.
    reset_file = open(reset_name, 'rU')
    for line in reset_file:
        if debug:
            output_file.write("%X: " % current_loc)
        output_file.write(line)
        current_loc += 4
    reset_file.close()

    # Make sure the reset code didn't overrun the exception code.
    offset = except_loc - current_loc
    if offset < 0:
        print "  Dat Generation:  initial boot code exceeded available " \
                "memory region.  Read %d lines from %s." % (current_loc, reset_name)
        sys.exit(1)

    # Write 0's as a buffer between reset and exception.
    while current_loc < except_loc :
        if debug:
            output_file.write("%X: " % current_loc)
        output_file.write("00000000\n")
        current_loc += 4

    #print "  Diagnostic: current_loc = %d, and boot_loc = %d (should match)" % (current_loc, except_loc)

    # Next open the boot_loader and output its lines.
    except_file = open(except_name, 'rU')
    for line in except_file:
        if debug:
            output_file.write("%X: " % current_loc)
        output_file.write(line)
        current_loc += 4
    except_file.close()

    # Make sure the boot_loader didn't overrun the program code.
    offset = program_loc - current_loc
    if offset < 0:
        print "  Dat Generation:  boot loader exceeded available memory region."\
                  "  Read %d lines from %s" % (current_loc - except_loc, except_name)
    
    # Write 0's as a buffer between the boot_loader and the program
    while current_loc < program_loc :
        if debug:
            output_file.write("%X: " % current_loc)
        output_file.write("00000000\n")
        current_loc += 4

    #print "  Diagnostic: current_loc = %d, and prog_loc = %d (should match)" % (current_loc, program_loc)

    # Last, write the program out to the memory.  
    program_file = open(program_name, 'rU')
    for line in program_file:
        if debug:
            output_file.write("%X: " % current_loc)
        output_file.write(line)
        current_loc += 4
    program_file.close()

    # Make sure the program didn't overrun the memory (leave room for a final word of 0's)
    offset = mem_size - current_loc
    if offset < 0:
        print "  Dat Generation:  The program exceeded available memory region." \
                  "  Read %d lines from %s" % (current_loc - program_loc, program_file)

    # Write 0's as a buffer between the program and the end of memory
    while current_loc < mem_size :
        if debug:
            output_file.write("%X: " % current_loc)
        output_file.write("00000000\n")
        current_loc += 4
        
    output_file.close()

    print "  Dat Generation: output %d words to file %s" % (current_loc / 4, output_name)
# End of dumpBootAndProgram()



# Here is our main functionality

# parse the arguments
args = sys.argv[1:]

if "--help" in args or not("-params" in args and "-output" in args):
    print "Usage:  python dumpBootAndProgram.py -params (file with parameters) \
            -program (program filename) -output (output filename) [-debug]"
    sys.exit(0)
    
if "-debug" in args:
    params = {'debug': True}
else:
    params = {'debug': False}

# Continue parsing
try:
    i = args.index("-params")
    params_filename = args[i+1]
except IndexError:
    print "No parameter file was specified."
    sys.exit(1)
except ValueError:
    print "-params requires a parameter file name."
    sys.exit(1)

try:
    i = args.index("-output")
    params['output_name'] = args[i+1]
except IndexError:
    print "No output file was specified."
    sys.exit(1)
except ValueError:
    print "-output requires a file name."
    sys.exit(1)

try:
    i = args.index("-program")
    params['program_name'] = args[i+1]
except IndexError:
    print "No program file was specified."
    sys.exit(1)
except ValueError:
    print "-program requires a file name."
    sys.exit(1)

# Parse the parameter file.
params_file = open(params_filename, 'rU')
lineNum = 0
for line in params_file:
    lineNum += 1
    # Try to read the parameters from the file.
    try:
        paramsNameVal = line.replace("\n","").split(':')
        params[paramsNameVal[0]] = paramsNameVal[1]
    except IndexError:
        print "The parameter defined in %s on line %d is invalid." % (params_filename, lineNum)
params_file.close()
    
dumpBootAndProgram(params)
sys.exit(0)
