# Instruction Log #

[Click here](http://docs.google.com/View?docid=df39snmn_12g57j46) to see the current status of the various instructions.

# Carl Nygaard's Log for developing the hmc mips processor #

## 1/16/2007 and beyond ##

At this point, the semester began and development transfered to the entire microarchitecture team: Carl Nygaard, Matt Totino, Nate Pinckney, & Thomas Barr.

## 1/8/2007 ##

I have a working but somewhat primitive exception unit that is able to trap arithmetic overflows.  It also handles the branch delay slot issue.

A new question I've just realized is when the exception should happen.  Should the exception unit be expected to recognize an exception within the same clock cycle it happens, or should an extra cycle be allowed.  I believe the former is easier, although slower, because it allows the exception unit to look at the processor in its current state, rather than having to look back at the previous clock cycle.

There was a possible unhandled hazard I noticed in creating test\_009.  In the following code snippet, the modified value is not reaching the jump.

```
        addi  $7, $7, 4
        jr    $7
```

## 1/7/2007 ##

Exceptions -- I'm starting exceptions.  There aer many different possible exceptions.  For now I'm planning on getting the basic functionality in place, then worry about supporting all the necessary exceptions later.

I need to worry about the branch delay bit in the cause register.  It says whether the errant instruction was in a branch delay slot. (We can just look at the previous instruction's branch and jump bits.  This also requires setting EPC to PC - 4.)

## 1/6/2007 ##

Today I implemented all the various load and store operations.  This went fairly smoothly.   I am truly grateful for the regression testing system; it has made this whole process so much easier and faster than it would have been without it.

The interface for the cache is still not complete, but the processor now supports delaying until each cache acknowledges the data is available.

The features that remain to be completed are:

  1. Multiplication/Division
  1. Coprocessor 0 actually having any use
  1. Exceptions
  1. Caching
  1. Proper startup behavior, such as reset vectors, status vectors, etc

Among these, exceptions should probably take priority because it will be good to know early on in the project how exceptions fit in.

## 1/5/2007 ##

I started work on coprocessor zero.  It is now possible to read and write to cop0 registers using the appropriate instructions.  I also did a basic status register.  Beyond that, the coprocessor does nothing.  Of course it will need to perform exceptions next.

However, it is time to get basic caching and all the load and store ops working.  Prof Harris and I decided to keep things simple for now and have the cache development work be completed later on in the semester.  For now I am focusing on getting all the instructions functional.

## 1/4/2007 ##

I began to look at the cache and load/store operations, but I think i'm going to switch things around and work on CoP0 and exceptions first, since there are several exceptions that can happen with memory.

In the mean time, I have a few questions about the cache.  I've been doing some reading and there are a few quirky things about the [R2000](https://code.google.com/p/hmc-mips/source/detail?r=2000) cache system.  I'm wondering whether we should try/have to to implement all the same "features."

First, the D-cache in [R3000](https://code.google.com/p/hmc-mips/source/detail?r=3000) can be "isolated" meaning that loads and stores do not touch the memory at all.

Similarly, the I-cache and D-cache in [R3000](https://code.google.com/p/hmc-mips/source/detail?r=3000) can be swapped, apparently so that cache initializing operations can be performed on both caches.  I am trying to think of a simpler way of making it possible to initialize the I-cache.

Probably worst of all, cache entry invalidation in [R2000](https://code.google.com/p/hmc-mips/source/detail?r=2000) is achieved by performing partial-word write (like a byte write).

Since we're doing a write-through cache, I guess I'll also implement a FIFO for writes.  (SMR says this is usually large enough for four writes.)

## 1/3/2007 ##

I worked more on branching, making a fairly rigorous test.  I changed the branching so that the controller made all the control decisions and the datapath simply provides comparison values and enacts mux operations.  Likewise with the shifter module.

## 1/2/2007 ##

I spent today adding support for all the jump and branch commands, as well as the branch delay slot.  I believe that supporting the branch delay slot is as simple as removing the clear feature of the register between the Fetch and Decode stages.

The hard part was supporting all the different kinds of branches.  There are 2 R-type commands with jumps, opcode 1 has four branches, as well as six other instructions with their own opcodes.  I also have to support linking, which means I have to add to the main datapath.

## 1/1/2007 ##

I believe I misinterpretted the sltiu command.  I originally added an enable slot to the immediate sign extender so that the immediate can be turned off for these unsigned instructions.  I can't find any reference to this issue in See MIPS Run, but [this website](http://www.mrc.uidaho.edu/mrc/people/jff/digital/MIPSir.html) says that all immediate values are first sign extended and then treated as signed or unsigned.  I believe only a certain set of intrsuctions have their immediates sign extended.  Page 223 of See MIPS Run for example shows "signed" and "unsigned."  PCSPIM seems to behave in a way consistent with those instructions being zero-extended.

## 12/31/2006 ##

I implemented some of the immediate instructions.  I am becoming better at debugging, so my speed of development should start to pick up more and more.

## 12/30/2006 ##

Now that I'm starting to get into the nitty-gritty of implementation, I'm going to try to document my work.

I am starting off with basics, in particular the immediate instructions.  I just read in See MIPS Run (page 178) that I misinterpreted the meaning of the "u" in some instructions like addu and subu.  I assumed it meant "unsigned," but in fact some of the time it means something like "no overflow test."  See MIPS Run says it is very unliked that the non-suffixed versions (e.g. "add") will ever be generated by a compiler.  Therefore I plan to remove these instructions from the instruction set (or just make them replicas of "addu" etc).