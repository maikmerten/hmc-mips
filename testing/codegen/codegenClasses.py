# codegenClasses.py
# random directed code generator for MIPS
# 26mar2007, Thomas W. Barr
# tbarr at cs dot hmc dot edu

# unidirectional code tester (code never branches backwards)

import random

LENGTH = 32 #word length of machine, tested for mips32, should work for mips64
DEBUG = True

class MIPSError(Exception):
    pass

class MIPSComputer:
    regs = {} # stores unsigned values
    mem = {} # memory not yet implemented
    
    def __init__(self):
        for reg in range(32):
            if DEBUG:
                self.regs[reg] = random.randint(0,5)
            else:
                self.regs[reg] = 0
        self.regs[0] = 0
            
    def setReg(self, reg, value):
        # this code should take any unsigned value and wrap (as the CPU would
        # do) to the max value of any register, and should convert signed
        # values to their 2's complement value. any overflow trapping
        # must happen in the instruction definition. Since C doesn't generate
        # the unprefixed forms of the instructions, we don't worry much
        # about that.
        
        # can't write to $0
        if reg==0:
            raise (MIPSError, '$0 read only')
            
        # wrap around to bounds
        value = value % 2**LENGTH
        
        # make sure we're in bounds for signed
        if not (-(2**LENGTH)/2 <= value):
            raise (ValueError, "number out of range for machine word length")
            
        if value >= 0:
            # we don't need to manipulate the number at all
            self.regs[reg] = value
        else: 
            # now we actually need to find the two's complement value
            # flip the bits, add one.
            twoComp = abs((value ^ (2**LENGTH-1)) + 1)
            self.regs[reg] = twoComp


class Operand:
    # may do something someday, just for subclassing for now
    pass

class Instruction:
    operandTypes = ()
    operands = ()
    actFunction = None
    name = 'nop'

    def __call__(self, m, act=True):
        self.operands = [op() for op in self.operandTypes]
        if act:
            self.actFunction(m, self.operands)
        return self.name + " " + ", ".join([str(op) for op in self.operands])
    
def unsigned(signedInt, length=LENGTH):
    # make sure we're in bounds for either signed or unsigned
    if not (-(2**length)/2 <= signedInt <= (2**length - 1)):
        raise (ValueError, "number out of range for given length")

    if signedInt >= 0:
        # we don't need to manipulate the number at all, aside from
        # stripping off the 0x, the 'L' if it's there and zero pad the number
        return signedInt

    # now we actually need to find the two's complement value
    # flip the bits, add one.
    twoComp = abs((signedInt ^ (2**length-1)) + 1)
    return twoComp

def signed(unsignedInt, length=LENGTH):
    if unsignedInt < (2**(length-1)):
        return unsignedInt
    else:
        # subtract one, flip bits
        return -((unsignedInt - 1) ^ (2**length-1))