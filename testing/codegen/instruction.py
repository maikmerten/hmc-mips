# instruction.py
# generates an individual instruction (r-type, memop)
# 27mar2007, Thomas W. Barr
# tbarr at cs dot hmc dot edu

import random
from rtype import *
from memops import *
from multdiv import *

weights =  [(addu,    2),
            (subu,    2),
            (addiu,   2),
            (and_ins, 2),
            (or_ins,  2),
            (xor_ins, 2),
            (andi,    2),
            (ori,     2),
            (xori,    2),
            (lui,     5),
            (mult,    1),
            (multu,   1),
            (div,     1),
            (divu,    1),
            (mfhi,    1),
            (mflo,    1),
            (sll,     1),
            (sllv,    1),
            (sra,     1),
            (srav,    1),
            (srl,     1),
            (srlv,    1),
            (sw,      5),
            (lw,      5),
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