## Overview ##

To compare our implementation of the MIPS CPU with existing implementations, we must run the same regression tests on both our simulated hardware with some other simulation, or real hardware. There are several options to do this:

  * GXemul - Known to boot Linux, IRIX. Emulates the [r2000](https://code.google.com/p/hmc-mips/source/detail?r=2000)/3000 hardware in the form of the DECstation 2100.
  * qemu - General purpose emulator, known to book Linux.
  * Silicon Graphics Indy [r4400](https://code.google.com/p/hmc-mips/source/detail?r=4400) (twb's webserver) - 64bit arch probably too different from the r2k implementation we've written.
  * DECstation 2100 (twb's doorstop) - Might be ideal, if I can get access to it. Currently in my high-school's engineering lab.

## Progress ##
My initial attempts will involve gxemul, and it's simple developer mode. This emulates the CPU, and a pair of IO devices. It seems like this will be the easiest system to write code for, and it shouldn't be terribly difficult to get ModelSim to behave like the IO devices gxemul emulates. Therefore, the same binaries should run on both, confirming our design.