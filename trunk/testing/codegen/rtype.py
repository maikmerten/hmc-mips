# rtype.py
# contains functions to run the desired operation
# 26mar2007, Thomas W. Barr
# tbarr at cs dot hmc dot edu
# inputs to instructions: (m, act): m: input machine, act: perform instruction

from operands import *

class addu(Instruction):
    name = 'addu'
    operandTypes = (treg, sreg, sreg)
    actFunction = lambda self, m, (d,s,t): \
            m.setReg(d.reg, (m.regs[s.reg] + m.regs[t.reg]))
            
class subu(Instruction):
    name = 'subu'
    operandTypes = (treg, sreg, sreg)
    actFunction = lambda self, m, (d,s,t): \
            m.setReg(d.reg, (m.regs[s.reg] - m.regs[t.reg]))

class addiu(Instruction):
    name = 'addiu'
    operandTypes = (treg, sreg, simm16)
    actFunction = lambda self, m, (d,s,j): \
            m.setReg(d.reg, (m.regs[s.reg] + j.imm))
            
class subiu(Instruction):
    name = 'subiu'
    operandTypes = (treg, sreg, simm16)
    actFunction = lambda self, m, (d,s,j): \
            m.setReg(d.reg, (m.regs[s.reg] - j.imm))
            
# debug goes here
m = MIPSComputer()
print m.regs
i = subiu()
print i(m)
print m.regs
