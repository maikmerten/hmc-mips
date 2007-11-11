"""
generateVerilog.py

Created 2/27/07 by Matt McKnett
HMC Spring 2007 CMOS VLSI, MIPS project

This script is designed to accept three dat files (each file composed of
MIPS instructions in hex, one instruction per line) and convert them to a
verilog file that can be synthesized for the chip.

It would definitely be nice to generalize the execution of this function
so that code isn't copied and pasted, but since it works, I won't touch it.
"""

import sys

#
# The function that takes the three files and puts them together into output
#
def verilogBootAndProgram(params):

    # Get pertinent values out of the parameters
    try:
        # We bit-shift the addresses by 2 because the memory controller treats
        # memory as word-addressable, and masks to provide byte-addressing.
        reset_name = params['reset_name']
        reset_loc = int(params['reset_loc'], 16) >> 2
        except_name = params['except_name']
        except_loc = int(params['except_loc'], 16) >> 2
        program_name = params['program_name']
        program_loc = int(params['program_loc'], 16) >> 2
        mem_size = int(params['mem_size'], 16) >> 2
        output_name = params['output_name']
        debug = params['debug']
        boot = params['use_boot_loader']
        verilog_template = params['verilog_template']
    except KeyError:
        print "generateVerilog: A needed parameter was not defined!"    

    # Initialize the current location and the output file.
    current_loc = reset_loc

    # We will construct our output in a string.
    outputString = ""
    caseStmtTemplate = "{1'b0, 16'h(address)}: instr <= 32'h(data);"

    if boot:
        #First open the bootstrapper start file and output the lines.
        reset_file = open(reset_name, 'rU')
        for line in reset_file:
            line_data = line.replace("\n","")
            caseStmt = caseStmtTemplate
            caseStmt = caseStmt.replace("(address)", "%x" % current_loc)
            caseStmt = caseStmt.replace("(data)", line_data)
            outputString += caseStmt
            
            outputString += "\n"
            current_loc += 1
        reset_file.close()

        # Make sure the reset code didn't overrun the exception code.
        offset = except_loc - current_loc
        if offset < 0:
            print "  Verilog Generation:  boot code exceeded available " \
                    "memory region.  Read %d lines from %s." % (current_loc, reset_name)
            sys.exit(1)

        # We don't need to write any 0's in between memory blocks.
        current_loc = except_loc

        #print "  Diagnostic: current_loc = %d, and boot_loc = %d (should match)" % (current_loc, except_loc)

        # Next open the boot_loader and output its lines.
        except_file = open(except_name, 'rU')
        for line in except_file:
            line_data = line.replace("\n","")
            caseStmt = caseStmtTemplate
            caseStmt = caseStmt.replace("(address)", "%x" % current_loc)
            caseStmt = caseStmt.replace("(data)", line_data)
            outputString += caseStmt
            
            outputString += "\n"
            current_loc += 1
        except_file.close()

        # Make sure the boot_loader didn't overrun the program code.
        offset = program_loc - current_loc
        if offset < 0:
            print "  Verilog Generation:  exception code exceeded available memory region."\
                      "  Read %d lines from %s" % (current_loc - except_loc, except_name)

        # Again, no 0's needed between memory blocks.
        current_loc = program_loc

        #print "  Diagnostic: current_loc = %d, and prog_loc = %d (should match)" % (current_loc, program_loc)

    # Last, write the program out to the memory.  
    program_file = open(program_name, 'rU')
    for line in program_file:
        line_data = line.replace("\n","")
        caseStmt = caseStmtTemplate
        caseStmt = caseStmt.replace("(address)", "%x" % current_loc)
        caseStmt = caseStmt.replace("(data)", line_data)
        outputString += caseStmt
        
        outputString += "\n"
        current_loc += 1
    program_file.close()

    # Make sure the program didn't overrun the memory (leave room for a final word of 0's)
    offset = mem_size - current_loc
    if offset < 0:
        print "  Verilog Generation:  The program exceeded available memory region." \
                  "  Read %d lines from %s" % (current_loc - program_loc, program_file)

    # Now that we have constructed the replacement string, we will replace the token
    # in the template file with that string.
    verilog_file = open(verilog_template, 'rU')
    verilog_output = verilog_file.read()
    verilog_file.close()

    verilog_output = verilog_output.replace("(case_statements)", outputString)
    verilog_output = verilog_output.replace("(source_filename)", program_name)

    output_file = open(output_name, 'wb')
    output_file.write(verilog_output)
    output_file.close()

    print "  Verilog Generation: output %d words to file %s" % (current_loc / 4, output_name)
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

if "-noboot" in args:
    params['use_boot_loader'] = False
else:
    params['use_boot_loader'] = True

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
    
verilogBootAndProgram(params)
sys.exit(0)
