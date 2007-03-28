# operands.py
# operands for code generator
# 26mar2007, Thomas W. Barr
# tbarr at cs dot hmc dot edu

from codegenClasses import *
import random

class sreg(Operand):
    reg = None
    
    def __str__(self):
        return "$" + str(self.reg)
    
    def __init__(self):
        # generates a random source register
        self.reg = random.randint(0, 31)
        
class treg(sreg):
    def __init__(self):
        # generates a random target register (not including $0)
        self.reg = random.randint(1, 31)
    
class simm16(Operand):
    """
    Signed 16 bit number.
    """
    imm = None
    
    def __str__(self):
        return str(self.imm).strip('L')
    
    def __init__(self):
        self.imm = random.randint(-(2**15), (2**15)-1)
