"""
checkInstructions.py

Created by Matt McKnett
on 2/26/07

This should be able to parse an assembly output file and find MIPS instructions
that are not supported by our processor, causing python to return a bad value
if it found bad instructions.
"""

import sys

# The list of invalid instructions for our MIPS processor.
# This includes the patented instructions and the floating point intructions
# most likely to be used when other FP instructions are used.
#
# This list could be made more comprehensive.
instructs = ["lwl", "swl", "lwr", "swr", "lwc1", "swc1", "mtc1", "mfc1"]

"""
Define the checkInst method to check instructions for words in instructs
"""
def checkInst(filename):
    # Open the file to be read and initialize the line counter.
    myFile = open(filename)
    line_num = 0
    found_bad = 0

    # Look through each line in the file for the instructions.
    for line in myFile:
        line_num += 1
        # Look for each of the bad instructions in the line
        for op in instructs:
            # If we find it, tell the user.
            try:
                if line.split()[0] == op:
                    print " Illegal MIPS assembly instruction %s " % op \
                          + "found on line %d:" % line_num
                    print line.replace("\n","")
                    found_bad += 1
            except IndexError:
                continue    # I don't know a better way to say "do nothing"

    # Close the file.
    myFile.close()

    print " Found %d bad instructions in %s" % (found_bad, filename)

    if found_bad:
        return 1
    else:
        return 0
    
"""
Read the command line arguments as files and run checkInst on each.
"""
def readCmdLine():
    args = sys.argv[1:]
    if len(args) == 0:
        raise SystemExit("checkInstructions requires at least one file name \
                         as input.")
    return args

# Read from the command line and initialize counters
args = readCmdLine()
fileCount = 0
badFileCount = 0

# Go through each argument and read the file.
for filename in args:
    fileCount += 1
    print "%d: Checking %s for bad instructions" % (fileCount, filename)
    badFileCount += checkInst(filename)

print "Instruction Check: %d file(s) of %d passed instruction check."\
       % (fileCount - badFileCount, fileCount)

if badFileCount == 0:
    sys.exit(0)
else:
    sys.exit(1)
