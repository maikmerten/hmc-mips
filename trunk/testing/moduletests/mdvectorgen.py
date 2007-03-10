# Multdiv test generator
# Carl Nygaard
# 3/8/07
#
# Autogenerates a set of random tests for multiply/divide


import random

numvectors = 100

for i in xrange(numvectors):
  # There are actually more than two cases (see multdiv.tv, the type of test is
  # determined by the first character, e.g. "0_...", "2_..." etc)
  doMult= (random.random() > 0.5)
  # pick random numbers.  This ought to be conditional on whether we desided
  # (randomly) to support negative numbers
  x = random.randint(-0x80000000, 0xefffffff)
  y = random.randint(-0x80000000, 0xefffffff)
  outputstring = ""

  if doMult:
    outputstring += "1_"
    result = x * y
    if result < 0:
      # This doesn't necessarily do what it is trying to do, convert two 32 bits
      # of 2's complement.
      hex((1) ^ 0xfffffffffffffff + 1 - 0x1000000000000000)
    resultstr = hex(x * y)[2:].zfill(16)
    outputstring += resultstr[:8] + "_" + resultstr[8:16]
  else:
    outputstring += "0_"
    quotient = x / y
    remainder = x % y
