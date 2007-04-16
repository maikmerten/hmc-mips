# rtype.py
# contains functions to run the desired operation
# 26mar2007, Thomas W. Barr
# tbarr at cs dot hmc dot edu
# inputs to instructions: (m, act): m: input machine, act: perform instruction

from operands import *

class Rtype(Instruction):
    operandTypes = ()
    operands = ()
    actFunction = None
    name = 'nop'
    bdsSafe = True

    def __call__(self, m, act=True):
        self.operands = [op() for op in self.operandTypes]
        if act:
            self.actFunction(m, self.operands)
        return self.name + " " + ", ".join([str(op) for op in self.operands])

class addu(Rtype):
    name = 'addu'
    operandTypes = (treg, sreg, sreg)
    actFunction = lambda self, m, (d,s,t): \
            m.setReg(d.reg, (m.regs[s.reg] + m.regs[t.reg]))
            
class subu(Rtype):
    name = 'subu'
    operandTypes = (treg, sreg, sreg)
    actFunction = lambda self, m, (d,s,t): \
            m.setReg(d.reg, (m.regs[s.reg] - m.regs[t.reg]))

class addiu(Rtype):
    name = 'addiu'
    operandTypes = (treg, sreg, simm16)
    actFunction = lambda self, m, (d,s,j): \
            m.setReg(d.reg, (m.regs[s.reg] + j.imm))

            
class and_ins(Rtype):
    name = 'and'
    operandTypes = (treg, sreg, sreg)
    actFunction = lambda self, m, (d,s,t): \
            m.setReg(d.reg, (m.regs[s.reg] & m.regs[t.reg]))

class or_ins(Rtype):
    name = 'or'
    operandTypes = (treg, sreg, sreg)
    actFunction = lambda self, m, (d,s,t): \
            m.setReg(d.reg, (m.regs[s.reg] | m.regs[t.reg]))
            
class xor_ins(Rtype):
    name = 'xor'
    operandTypes = (treg, sreg, sreg)
    actFunction = lambda self, m, (d,s,t): \
            m.setReg(d.reg, (m.regs[s.reg] ^ m.regs[t.reg]))
            
# nor not yet implemented

class andi(Rtype):
    name = 'andi'
    operandTypes = (treg, sreg, uimm16)
    actFunction = lambda self, m, (d,s,j): \
            m.setReg(d.reg, (m.regs[s.reg] & j.imm))
            
class ori(Rtype):
    name = 'ori'
    operandTypes = (treg, sreg, uimm16)
    actFunction = lambda self, m, (d,s,j): \
            m.setReg(d.reg, (m.regs[s.reg] | j.imm))
            
class xori(Rtype):
    name = 'xori'
    operandTypes = (treg, sreg, uimm16)
    actFunction = lambda self, m, (d,s,j): \
            m.setReg(d.reg, (m.regs[s.reg] ^ j.imm))
            
class lui(Rtype):
    name = 'lui'
    operandTypes = (treg, uimm16)
    actFunction = lambda self, m, (d,j): \
            m.setReg(d.reg, (j.imm << 16))

#debug
if __name__ == '__main__':
    m = MIPSComputer()
    print m.regs
    ins = lui()
    print ins(m)
    print m.regs