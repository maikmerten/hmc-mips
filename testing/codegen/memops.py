# memops.py
# generates memory operations
# 30mar2007, Thomas W. Barr
# tbarr at cs dot hmc dot edu

from operands import *
from codegenClasses import *
import random


# NOTE: this breaks our length agnosticism. it only works with 32bit addresses
# since I don't know how mips64 actually WORKS, I can't be nice to our
# fearless SGI users.

def loadReg(reg, address32, machine, act=True):
    outIns = ""
    address_h = (address32 & 0xffff0000) >> 16
    address_l = address32 & 0xffff
    
    #load upper, then lower
    address_h_str = hex(address_h).strip('L')
    outIns += "lui $%s, %s\n" % (str(reg.reg), address_h_str)
    outIns += "addiu $%s, $%s, %d\n" % (str(reg.reg), 
                str(reg.reg), address_l)
                
    # set the register contents to the full 32bit value
    if act:
        machine.regs[reg.reg] = address32
        
    return outIns

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
        
        outIns += loadReg(addressReg, regVector, machine, act)
        
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

#these don't work because I'm not really being careful about sign extensions
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
    s = sw()
    print s(m)
    l = lw()
    print l(m)
    print m.regs
    print m.mem