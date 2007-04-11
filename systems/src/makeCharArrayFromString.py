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

for param in sys.stdin:
    paramLength = len(param)
    outputString = str(strToList(param))
    outputString = outputString.replace('[','{').replace(']','}')
    outputString = "char str%d[%d] = " % (strCnt, paramLength) + outputString
    print outputString
    strCnt += 1
