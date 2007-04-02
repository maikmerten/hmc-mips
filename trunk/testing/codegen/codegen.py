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

DESIRED_INSTRUCTION_COUNT = 500


print "# randomly generated test\n"
print "main:"
# start by creating a machine and populating some registers
machine = MIPSComputer()
for x in range(10):
    addi_ins = addiu()
    print addi_ins(machine)
    
# dump the contents of the registers
for (regname, value) in machine.regs.iteritems():
    print "# $%s = %s" % (regname, hex(value))

instructionsLeft = DESIRED_INSTRUCTION_COUNT

while instructionsLeft > 0:
    # fudge numbers to direct tester.
    # if not time==2.45am: code.clean()
    direction = random.randint(0,5)
    if 0 <= direction <=2:
        print makeInstruction(machine)
        instructionsLeft -= 1
    elif 3<= direction <=4:
        print makeMemop(machine)
        instructionsLeft -= 2
    else:
        print makeBlock(machine)
        instructionsLeft -= 3
        
print "# done.\n"

# xor all the regs together
for x in range(31):
    print "xor $%s, $%s, $%s" % (x+1, x+1, x)
    machine.regs[x+1] = machine.regs[x+1] ^ machine.regs[x]

# dump the contents of the registers
for (regname, value) in machine.regs.iteritems():
    print "# $%s = %s" % (regname, hex(value))

print "# final value (in $31) is: %s" % hex(machine.regs[31])
# test bench should agree with what we've calculated here.
print "sw $31 0($0)"

# loop forever
print "done: beq $0 $0 done\n"