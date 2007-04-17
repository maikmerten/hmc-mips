# operands.py
# operands for code generator
# 26mar2007, Thomas W. Barr
# tbarr at cs dot hmc dot edu

from codegenClasses import *
import random

mempool = [x*4 + 0x80011000 for x in range(10)]

class sreg(Operand):
    reg = None
    
    def __str__(self):
        return "$" + str(self.reg)
    
    def __init__(self, reg=None, m=None):
        # generates a random source register
        if reg == None:
            self.reg = random.randint(0, 31)
        else:
            self.reg = reg
        
class treg(sreg):
    def __init__(self, reg=None, m=None):
        # generates a random target register (not including $0)
        if reg == None:
            self.reg = random.randint(1, 31)
        else:
            self.reg = reg

class nzreg(treg):
    def __init__(self, m):
        foundValue = 0
        
        # or the registers together to prevent an infinite loop
        if reduce(lambda x,y: x | y, m.regs.values()) == 0:
            raise MIPSError, "no non-zero register found"
            
        while foundValue == 0:
            self.reg = random.randint(1, 31)
            foundValue = m.regs[self.reg]
        
class simm16(Operand):
    """
    Signed 16 bit number.
    """
    imm = None
    
    def __str__(self):
        return str(self.imm).strip('L')
    
    def __init__(self, m=None):
        self.imm = random.randint(-(2**15), (2**15)-1)

class uimm16(Operand):
    """
    Unsigned 16 bit number.
    """
    imm = None
    
    def __str__(self):
        return str(self.imm).strip('L')
    
    def __init__(self, m=None):
        self.imm = random.randint(0, (2**16)-1)

class shammt(uimm16):
    """
    Number from 0-31
    """
    def __init__(self, m=None):
        self.imm = random.randint(0,31)

class memloc:
    """
    Not really an operand. Returns memory location.
    Location: location in byte offset.
    """
    # since this is where we define all our directed stuff, we might
    # as well make memory locations here.
    
    location = None
    
    def __init__(self, m=None):
        self.location = random.choice(mempool)