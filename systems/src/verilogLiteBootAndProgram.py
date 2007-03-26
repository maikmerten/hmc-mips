"""
verilogLiteBootAndProgram.py

Created 2/27/07 by Matt McKnett
HMC Spring 2007 CMOS VLSI, MIPS project

This script is designed to accept a dat file (composed of
MIPS instructions in hex, one instruction per line) and convert them to a
verilog file that can be synthesized for a Xilinx chip.

This version does not use the boot loader.
"""

import sys
import string

#
# The function that takes the three files and puts them together into output
#
def verilogLiteBootAndProgram(params):

    # Get pertinent values out of the parameters
    try:
        print params
        program_name = params['program_name']
        program_loc = int(params['program_loc'], 16)
        mem_size = int(params['mem_size'], 16)
        output_name = params['output_name']
        debug = params['debug']
        template_name = params['verilog_template']
    except KeyError:
        print "verilogBootAndProgram: A needed parameter was not defined!"    

    # Initialize the current location and the output file.
    current_loc = 0

    # We will construct our output in a string.
    outputString = ""
    caseStmtTemplate = "{1'b0, 16'h(address)}: instr <= 32'h(data);"

    
    # Last, write the program out to the memory.  
    program_file = open(program_name, 'rU')
    for line in program_file:
        line_data = line.replace("\n","")
        caseStmt = caseStmtTemplate
        caseStmt = caseStmt.replace("(address)", "%x" % current_loc)
        caseStmt = caseStmt.replace("(data)", line_data)
        outputString += caseStmt
                                                 
        if debug:
            outputString += " //Line %X" % current_loc
        outputString += "\n"
        current_loc += 1
    program_file.close()

    # Make sure the program didn't overrun the memory (leave room for a final word of 0's)
    offset = mem_size - current_loc
    if offset < 0:
        print "Boot and Program Verilog:  The program exceeded available memory region." \
                  "  Read %d lines from %s" % (current_loc - program_loc, program_file)

    # Write 0's as a buffer between the program and the end of memory
    while current_loc < mem_size :
        line_data = line.replace("\n","")
        caseStmt = caseStmtTemplate
        caseStmt = caseStmt.replace("(address)", "%x" % current_loc)
        caseStmt = caseStmt.replace("(data)", "00000000")
        outputString += caseStmt
        if debug:
            outputString += " //Line %X" % current_loc
        outputString += "\n"
        current_loc += 1

    # Now that we have constructed the replacement string, we will replace the token
    # in the template file with that string.
    verilog_file = open(template_name, 'rU')
    verilog_output = verilog_file.read()
    verilog_file.close()
    
    verilog_output = verilog_output.replace("(case_statements)", outputString)

    output_file = open(output_name, 'wb')
    output_file.write(verilog_output)
    output_file.close()

    print "Boot and Program Verilog: output %d words to file %s" % (current_loc / 4, output_name)
# End of verilogBootAndProgram()



# Here is our main functionality

# parse the arguments
args = sys.argv[1:]

if "--help" in args or not("-params" in args and "-output" in args):
    print "Usage:  python verilogBootAndProgram.py -params (file with parameters) \
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
    
verilogLiteBootAndProgram(params)
sys.exit(0)
