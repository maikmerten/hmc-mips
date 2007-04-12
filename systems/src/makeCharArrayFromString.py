#  makeCharArrayFromString.py
#  
#  Created by Matt McKnett
#  4/10/07 for VLSI Spring '07
#
#  Turns a string literal into an array of chars for C programs.
#

import sys

def strToList(stringin):
    charList = []
    for c in stringin:
        charList.append(c)
    return charList

strCnt = 0

print "Don't forget to add null terminators to strings! \
    An extra char is included in the array for this purpose.\n\n"

for param in sys.stdin:
    # Don't interpret newlines.
    outputString = param.replace("\n","").replace("\r","")
    # Make the length include null terminators we don't use, and don't forget
    # that we must declare one greater than the length.
    strLength = len(outputString) + 2

    # Turn the string into a string list.
    outputList = strToList(outputString)

    # Add the null terminator to the list.  Python likes to print \\0 and I
    # can't make it stop.
    #outputList.append("\x5C" + "0")
    
    outputString = str(outputList)
    
    # Change [ to {, ] to }
    outputString = outputString.replace('[','{').replace(']','}')
    outputString = "char str%d[%d] = " % (strCnt, strLength) + outputString
    outputString += ";"
    print outputString
    strCnt += 1
