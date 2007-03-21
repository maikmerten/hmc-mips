# Multdiv test generator, v3
# Carl Nygaard, Thomas W. Barr
# 3/8/07
#
# Autogenerates a set of random tests for multiply/divide
# format: {multdivb, signedop, x, y, prodhexpected, prodlexpected}
# {multdivb, signedop}: 0 - unsigned division
#                       1 - signed division
#                       2 - unsigned mult.
#                       3 - signed div

import random, math, sys

numvectors = 1000
DEBUG = False
RANDOMNESS = 6 # how often a directed number is taken

signedDirections = [0, 1, -1, -0x80000000, 0x7fffffff]
unsignedDirections = [0, 1, 0x80000000, 0x7fffffff, 0xffffffff]

def zeropad(inNumString, length=32):
    #length is length in bits
    return ('0'*(length/4 - len(inNumString)) + inNumString).lower()

def genNum(signed = False):
    # pick random number
    if signed:
      if not (random.randint(0,RANDOMNESS)):
        newx = random.choice(signedDirections)
      else:
        newx = random.randint(-0x80000000, 0x7fffffff)
        
    else:
      if not (random.randint(0,RANDOMNESS)):
        newx = random.choice(unsignedDirections)
      else:
        newx = random.randint(0x00000000, 0xffffffff)
    return newx
      
def reprInt(signedInt, length=32):
    # convert an input integer to the n bit hex string representing the 
    # desired number in 2's complement notation. This code is also used to
    # get the hex representation of an unsigned number.
    
    # make sure we're in bounds for either signed or unsigned
    if not (-(2**length)/2 <= signedInt <= (2**length - 1)):
        raise (ValueError, "number out of range for given length")

    if signedInt >= 0:
        # we don't need to manipulate the number at all, aside from
        # stripping off the 0x, the 'L' if it's there and zero pad the number
        return zeropad(hex(signedInt)[2:].strip('L'), length)
    
    # now we actually need to find the two's complement value
    # flip the bits, add one.
    twoComp = abs((signedInt ^ (2**length-1)) + 1)
    return reprInt(twoComp, length)

def genVector(type):
    # {multdivb, signedop}: 0 - unsigned division
    #                       1 - signed division
    #                       2 - unsigned mult.
    #                       3 - signed div
    signed = (1 & type)
    (x, y) = (genNum(signed), genNum(signed))
    if DEBUG:
        print "signed: " + str(signed)
    
    if (2 & type):
        result = x * y
        
        result64str = reprInt(result, length=64)
        resulth = result64str[:8]
        resultl = result64str[8:]
    else:
        # we need to make y smaller than x, otherwise we'll always just round
        # down to zero. we do want the value to be negative, though
        
        # since the CPU calculates quotients and remainders by calculating
        # from magnitudes, then propogating, we'll do that too, I suppose.
        
        while (y==0):
          y = genNum(signed)
        
        y = int(math.sqrt(abs(y))) * (abs(y) / y)
        
        (xa, ya) = (abs(x), abs(y))
        
        if (x==0):
          xs = 1
          ys = y/ya
        else:
          (xs, ys) = (x/xa, y/ya)
        
        quotient = long(xa / ya) #cast to long to ensure we're not a float
                             # not really necessary under py2.5, will be
                             # for py3.0
        
        
        quotient = quotient * (ys * xs)
        
        remainder = (xa % ya) * xs
        
        if not x == quotient * y + remainder:
          sys.stderr.write('x=qy+z violated\n')
        
        resulth = reprInt(remainder)
        resultl = reprInt(quotient)
    
    if DEBUG:
        print "x: " + str(x)
        print "y: " + str(y)
    
    print str(type) + "_" +\
          reprInt(x) + "_" +\
          reprInt(y) + "_" +\
          resulth + "_" +\
          resultl
    if DEBUG: print

# main script.
sys.stderr.write('writing %d vectors...\n' % numvectors)
for x in range(numvectors):
    genVector(random.randint(0,3))
    