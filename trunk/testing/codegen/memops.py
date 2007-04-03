# memops.py
# generates memory operations
# 30mar2007, Thomas W. Barr
# tbarr at cs dot hmc dot edu

from operands import *
from codegenClasses import *
import random

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
            machine.regs[addressReg.reg] = regVector
        
        outIns += "addiu $%s, $0, %d\n" % (str(addressReg.reg), regVector)
        
        if self.isLoad:
            dataReg = treg()
            data = (machine.mem[loc] & self.mask)
            if act:
                print "#BEFORE\n# memSpace: %s\n# regs: %s" % (machine.mem, machine.regs)
                machine.setReg(dataReg.reg, data)
                print "#AFTER\n# memSpace: %s\n# regs: %s" % (machine.mem, machine.regs)
        else:
            dataReg = sreg()
            if act:
                machine.mem[loc] = (machine.regs[dataReg.reg] & self.mask)
            
        # print the instruction
        outIns += "%s %s, %d(%s)\nnop\nnop" % \
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