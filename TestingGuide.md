# Before you start #

Get SVN setup as described by DevelopmentEnvironmentGuide. Make sure your machine is set up with Xilinx and Modelsim.

# Running Test #

  1. Open Modelsim
  1. Change to the root directory of the svn tree (the folder with src/ and testing/)
  1. Type do debug.fdo
  1. If there are no errors, type `run 500us`
  1. Something like the following should be printed:
```
# Simulation           0 succeeded (start time          0)
# Writing value          7 to address 00000050
# Simulation           1 succeeded (start time        100)
# Simulation           2 succeeded (start time        200)
# Simulation           3 succeeded (start time        300)
# Simulation           4 succeeded (start time        400)
# Simulation           5 succeeded (start time        500)
# Simulation           6 succeeded (start time        600)
# Writing value ffffffff to address 00000010
# Writing value 00000000 to address 00000011
# Writing value 55005500 to address 00000012
# Writing value 550000ff to address 00000014
# Simulation           7 succeeded (start time        700)
# Writing value 1234abcd to address 00000018
# Writing value 0000001f to address 00000018
# Simulation           8 succeeded (start time        800)
# Writing value         12 to address 0000000c
# Simulation           9 FAILED    (start time        900)
# Test complete --           9 out of          10 passed
```

# Compiling Tests #

You must have GCC cross compiled for MIPS.  Currently this is only known to be available for Linux machines.

As noted by [this](http://tams-www.informatik.uni-hamburg.de/applets/hades/webdemos/mips.html) website:

"If you are running Linux, you also try to download the following [gcc-mips.tgz](http://tams-www.informatik.uni-hamburg.de/applets/hades/archive/gcc-2.7.2.3-mips.tgz) archive in tar.gz format; it includes gcc 2.7.2.3 and corresponding binutils ready for Linux/x86 (Pentium,Athlon) hosts. Note that the tools expect to be installed into a directory called /opt/mips. This path is configured into the tools; you will have to build the tools yourself and supply the corresponding -prefix option to change the base directory."

Once you have done this, you should be able to `cd testing/` and type `make`.

# Viewing More Internal Objects #

**Note these instructions are not necessary if you use the debug.fdo script**

By default Modelsim will optimize and not make it possible to view most internal components of the simulation (in a waveform view for example).

You can bypass this (while also making the simulation slower) by doing the following:

The vopt (opimization) command can control the visibility of components.  The +acc flag determines which components are visible.  Type `vopt -help` to see the various components that +acc controls.  In the following example "rn" refers to registers and nets.

To make these things visible, once Modelsim is open, type this into the console:

```
vopt +acc=rn testbench -o testbench_debug
```

Switch to optimized mode with

```
vsim testbench_debug
```

You may now view various components of the system in the Workspace by dragging the corresponding objects to the waveform window.

Finally run as usual.

```
run 100000ns
```