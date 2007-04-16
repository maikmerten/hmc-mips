# memops.py
# generates memory operations
# 30mar2007, Thomas W. Barr
# tbarr at cs dot hmc dot edu

from operands import *
from codegenClasses import *
import random

CACHED = True

class Memop:
    name = 'nop'
    mask = (2**LENGTH) - 1
    isLoad = True
    bdsSafe = False
    
    # sw $1 42($1)
    def __init__(self):
        self.ops = (sreg(), sreg())
        
    def __call__(self, machine, act=True):
        outIns = ""
        # determine where we'll be jumping to
        loc = memloc().location
        addressReg = treg()
        offset = random.randint(0,32)
        regVector = loc - offset
        if act:
            if CACHED:
                machine.regs[addressReg.reg] = (regVector + 0x80100000) 
            else:
                machine.regs[addressReg.reg] = regVector
        
        if CACHED:
            outIns += "lui $%s, 0x8010\n" % str(addressReg.reg)
        
        outIns += "addiu $%s, $%s, %d\n" % (str(addressReg.reg), 
                str(addressReg.reg), regVector)
        
        if self.isLoad:
            dataReg = treg()
            data = (machine.mem[loc] & self.mask)
            if act:
                machine.setReg(dataReg.reg, data)
        else:
            dataReg = sreg()
            if act:
                machine.mem[loc] = (machine.regs[dataReg.reg] & self.mask)
            
        # print the instruction
        outIns += "%s %s, %d(%s)" % \
                (self.name, str(dataReg), offset, str(addressReg))
        return outIns
                
class sw(Memop):
    name = 'sw'
    isLoad = False
    
class lw(Memop):
    name = 'lw'
    isLoad = True

class sb(Memop):
    name = 'sb'
    isLoad = False
    mask = 0xFF

class lb(Memop):
    name = 'lb'
    isLoad = True
    mask = 0xFF


#debug
if __name__ == '__main__':
    DEBUG = True
    m = MIPSComputer()
    print m.regs
    print m.mem
    s = sb()
    print s(m)
    l = lb()
    print l(m)
    print m.regs
    print m.mem