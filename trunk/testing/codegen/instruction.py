# instruction.py
# generates an individual instruction (r-type, memop)
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
            (xori,    1),
            (sw,      0),
            (lw,      0),
            (sb,      0),
            (sb,      0)
            ]

# make weight table. if a weight is too big, this gets kinda slow
instructions = []            
for (op, weight) in weights:
    instructions += weight * [op]

def makeInstruction(machine, act=True, bds=False):
    if bds:
        done = False
        while not done:
            ins = random.choice(instructions)()
            done = ins.bdsSafe
    else:        
        ins = random.choice(instructions)()
    return ins(machine, act)

#debug
if __name__ == '__main__':
    m = MIPSComputer()
    print m.regs
    print makeInstruction(m, bds=True)
    print m.regs