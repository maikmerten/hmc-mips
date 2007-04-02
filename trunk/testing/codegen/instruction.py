# instruction.py
# generates an individual instruction (r-type, memop)
# MEMOPs NOT GENERATED HERE ANYMORE
# 27mar2007, Thomas W. Barr
# tbarr at cs dot hmc dot edu

import random
from rtype import *
from memops import *

weights =  [(addu,    1),
            (subu,    1),
            (addiu,   1),
            (and_ins, 1),
            (or_ins,  1),
            (xor_ins, 1),
            (andi,    1),
            (ori,     1),
            (xori,    1)]

# make weight table. if a weight is too big, this gets kinda slow
instructions = []            
for (op, weight) in weights:
    instructions += weight * [op]

def makeInstruction(machine, act=True):
    ins = random.choice(instructions)()
    return ins(machine, act)

#debug
if __name__ == '__main__':
    m = MIPSComputer()
    print m.regs
    print makeInstruction(m)
    print m.regs