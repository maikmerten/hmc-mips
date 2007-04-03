# branch.py
# generates branching blocks
# 27mar2007, Thomas W. Barr
# tbarr at cs dot hmc dot edu

from instruction import *
from operands import *
from codegenClasses import *
import random

# *** WEIGHTS TABLE AFTER CLASS DEFINITIONS ***

class Block:
    name = 'nop'
    comp_func = None
    
    # for two op branches, two source regs and a label
    def __init__(self):
        self.ops = (sreg(), sreg())
        
    def __call__(self, machine):
        assemblerOps = ", ".join([str(x) for x in self.ops])
        outBlock = "\n" + self.name + " " + assemblerOps + ", " + "block" + \
            str(machine.blockCounter) + '\n'
        
        # decide if the branch will even be taken, these always use signed
        # numbers
        signedVals = [signed(machine.regs[s.reg]) for s in self.ops]
        taken = self.comp_func(*signedVals)
        
        # how far to jump?
        vector = random.randint(0,5)
        
        if vector:
            #if we jumped at all, we'll need a BDS op
            outBlock += makeInstruction(machine, bds=True) + "\n"
            # for the rest, if we're following the branch, don't act
            for x in xrange(vector-1):
                outBlock += (makeInstruction(machine, act=(not taken)) + '\n')
        
        outBlock += "block" + str(machine.blockCounter) + ":\n"
        machine.blockCounter += 1
        return outBlock

class beq(Block):
    name = 'beq'
    comp_func = lambda self, s, t: s==t

class bne(Block):
    name = 'bne'
    comp_func = lambda self, s, t: not s==t

class ZeroBlock(Block):
    def __init__(self):
        self.ops = (sreg(), )
        
class bgtz(ZeroBlock):
    name = 'bgtz'
    comp_func = lambda self, s: s > 0
    
class blez(ZeroBlock):
    name = 'blez'
    comp_func = lambda self, s: s <= 0
    
class bltz(ZeroBlock):
    name = 'bltz'
    comp_func = lambda self, s: s < 0
    
class bgez(ZeroBlock):
    name = 'bgez'
    comp_func = lambda self, s: s >= 0

weights =  [(beq,  5),
            (bne,  5),
            (bgtz, 2),
            (blez, 2),
            (bltz, 2),
            (bgez, 2)]

# make weight table. if a weight is too big, this gets kinda slow
instructions = []            
for (op, weight) in weights:
    instructions += weight * [op]

def makeBlock(machine):
    block = random.choice(instructions)()
    return block(machine)

#debug
if __name__ == '__main__':
    m = MIPSComputer()
    print m.regs
    print makeBlock(m)
    print makeBlock(m)
    print m.regs
