# codegen.py
# code generator for MIPS32 CPU
# 26mar2007, Thomas W. Barr
# tbarr at cs dot hmc dot edu

# unidirectional code tester (code never branches backwards)

from branch import *
from memops import *
from instruction import *
from codegenClasses import *
from rtype import *
import random
import sys

DESIRED_INSTRUCTION_COUNT = 10000

print "# randomly generated test\n"
print ".set noreorder"
print ".set noat"

print "main:"

# start by creating a machine
machine = MIPSComputer()

# for the simulation, we need to reset everything we touch
# reset the memory space we're looking at
for addr in mempool:
    if CACHED:
        print "lui $1, 0x8002"
    print "addi $1, $1, %d" % addr
    print "addi $2, $0, 42"
    print "sw $2, 0($1)"
    machine.mem[addr] = 42

# reset all regs to zero
for x in range(31):
    print "addi $%d, $0, 0" % (x+1)

# populate some registers
for x in range(32):
    addi_ins = addiu()
    print addi_ins(machine)

# dump the contents of the registers
for (regname, value) in machine.regs.iteritems():
    print "# $%s = %s" % (regname, value)

instructionsLeft = DESIRED_INSTRUCTION_COUNT

while instructionsLeft > 0:
    if random.randint(0,5):
        insout = makeInstruction(machine)
        instructionsLeft -= len(insout.split('\n'))
        print insout
    else:
        insout = makeBlock(machine)
        instructionsLeft -= len(insout.split('\n'))
        print insout
        
print "# done.\n"

# xor all the regs together
for x in range(30):
    x += 1
    print "xor $%s, $%s, $%s" % (x+1, x+1, x)
    machine.regs[x+1] = machine.regs[x+1] ^ machine.regs[x]

# dump the contents of the registers
for (regname, value) in machine.regs.iteritems():
    print "# $%s = %s" % (regname, hex(value))

print "# final value (in $31) is: %s" % machine.regs[31]
# test bench should agree with what we've calculated here.
print "sw $31, 4($0)"

print '# memstate: %s' % machine.mem

# loop forever
print "done: beq $0, $0, done\n"