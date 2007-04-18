# multdiv.py
# generates test vectors for mult, div, mfhi, mflo
# 16apr2007, Thomas W. Barr
# tbarr at cs dot hmc dot edu

from rtype import *
        
def MIPSdiv(x, y):
    (xa, ya) = (abs(x), abs(y))
        
    if (x==0):
      xs = 1
      ys = y/ya
    else:
      (xs, ys) = (x/xa, y/ya)
    
    quotient = long(xa / ya) #cast to long to ensure we're not a float
                         # not really necessary under py2.5, will be
                         # for py3.0
    
    
    q = quotient * (ys * xs)
    
    r = (xa % ya) * xs
    return (r, q)
    
def unsignedHiLo(sint64):
    uint64 = unsigned(sint64, length=64)
    uint_h = 0xffffffff00000000 & uint64
    uint_l = 0x00000000ffffffff & uint64
    
    return (uint_h, uint_l)

def doMultu(self, m, (s,t)):
    (m.hi, m.lo) = unsignedHiLo(m.regs[s.reg] * m.regs[t.reg])
class multu(Rtype):
    name = 'multu'
    operandTypes = (sreg, sreg)
    actFunction = doMultu

def doMult(self, m, (s,t)):
    (m.hi, m.lo) = unsignedHiLo(signed(m.regs[s.reg]) * signed(m.regs[t.reg]))
class mult(Rtype):
    name = 'addu'
    operandTypes = (sreg, sreg)
    actFunction = doMult

# this might throw div by zero Python exceptions since we're blindly dividing.
# wish it luck.
def doDiv(self, m, (s,t)):
    (m.hi, m.lo) = MIPSdiv(signed(m.regs[s.reg]), signed(m.regs[t.reg]))
class div(Rtype):
    name = 'div $0,'
    operandTypes = (sreg, nzreg)
    actFunction = doDiv

def doDivu(self, m, (s,t)):
    (m.hi, m.lo) = MIPSdiv(m.regs[s.reg], m.regs[t.reg])
class divu(Rtype):
    name = 'divu $0,'
    operandTypes = (sreg, nzreg)
    actFunction = doDivu

class mfhi(Rtype):
    name = 'mfhi'
    operandTypes = (treg, )
    actFunction = lambda self, m, (d,): \
            m.setReg(d.reg, m.hi)

class mflo(Rtype):
    name = 'mflo'
    operandTypes = (treg, )
    actFunction = lambda self, m, (d,): \
            m.setReg(d.reg, m.lo)

#debug
if __name__ == '__main__':
    m = MIPSComputer()
    print m.regs
    ins = div()
    print ins(m)
    ins = mfhi()
    print ins(m)
    ins = mflo()
    print ins(m)
    print m.regs
    print (m.hi, m.lo)