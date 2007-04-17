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
        self.operands = [op(m=m) for op in self.operandTypes]
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

class sll(Rtype):
    """
    Shift left logical
    """
    name = 'sll'
    operandTypes = (treg, sreg, shammt)
    actFunction = lambda self, m, (d,s,shft): \
            m.setReg(d.reg, (m.regs[s.reg] << shft.imm))

class sllv(Rtype):
    """
    Shift left logical, variable
    """
    name = 'sllv'
    operandTypes = (treg, sreg, sreg)
    actFunction = lambda self, m, (d,t,s): \
            m.setReg(d.reg, (m.regs[t.reg] << (m.regs[s.reg] % 32)))

class srl(Rtype):
    """
    Shift right logical
    """
    name = 'srl'
    operandTypes = (treg, sreg, shammt)
    actFunction = lambda self, m, (d,s,shft): \
            m.setReg(d.reg, (m.regs[s.reg] >> shft.imm))

class srlv(Rtype):
    """
    Shift right logical, variable
    """
    name = 'srlv'
    operandTypes = (treg, sreg, sreg)
    actFunction = lambda self, m, (d,t,s): \
            m.setReg(d.reg, (m.regs[t.reg] >> (m.regs[s.reg] % 32)))

class sra(Rtype):
    """
    Shift right arithmetic
    """
    name = 'sra'
    operandTypes = (treg, sreg, shammt)
    actFunction = lambda self, m, (d,s,shft): \
            m.setReg(d.reg, (signed(m.regs[s.reg]) >> shft.imm))

class srav(Rtype):
    """
    Shift right arithmetic, variable
    """
    name = 'srav'
    operandTypes = (treg, sreg, sreg)
    actFunction = lambda self, m, (d,t,s): \
            m.setReg(d.reg, (signed(m.regs[t.reg]) >> (m.regs[s.reg] % 32)))

#debug
if __name__ == '__main__':
    m = MIPSComputer()
    print m.regs
    ins = sra()
    print ins(m)
    print m.regs