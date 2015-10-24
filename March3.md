# Introduction #

Follows is the summary of the work that the Adelaide team has been doing, following Steven's handover of the cache schematics on Thursday night.


## Rhys ##
Rhys has been responsible for the decoder block, and writing a test bench for the whole cache.

### Decoder64 Block testbench ###
  * Generating a self-asserting test bench ([DecoderBench.java](http://hmc-mips.googlecode.com/svn/trunk/testing/adelaide/DecoderBench.java))
  * Make a trial layout to see that each cell fits in the available space.
  * look at optimisation with respect to delay

### Top level cache testbench ###
  * Will do whole cache test bench last
  * Try to test each mode of operation and transitions between
  * Will not hook up to the other devices, such as memory, yet; just plugging in appropriate signals at appropriate times.

## Rob ##
Rob has been working on the SRAM array.

### SRAM Layout ###
> Issue with fanout for inverter stage. Problem may be solved in three ways:
  1. Increase the size of the inverter, or
  1. Employ a small buffer design.
    * scaling factor of `u`
    * number of stages `N`
    * rough idea of what the capacitance seen by the inverter at its input
    * capacitance of the load it will be driving. Or,
  1. Simply break the inverter signal to have 1 inverter driving 4 lines at most. This is ok but then the stage that feeds the original inverter will still have its own fanout issue to deal with in driving the 13 or so replacement inverters. 13 or so may not be a problem.


### Write driver ###
  * The `ph1`, `rwb`, `din` and the `and3` can be replaced nicely by a single inverter on the `ph1` and a `nor3`. This eliminates an inverter and also the `nor3` is smaller than the `and3`. This is the least of our worries in this section. But its a start :)

  * Currently working on a layout of the `writedriver` to try to make it as compact as possible. Doing it purely with standard cells. The extra transistors need to be laid out to get an idea of how much area they will take up and also the possibilities for simplifying the ordering of cells for routing the connecting wires.

  * The biggest problem is that the write driver is much larger (wider) than the pair of SRAM cells it is meant to be driving. it is not possible to just make an array and have them lined up nicely. An observation that I made was that a write driver is as wide as 4 SRAM cells.
  * To solve this, a possible solution may be to two write drivers sitting one under the other: ie:
```
[sram][sram][sram][sram]
 y0y1 y2y3   y0y1  y2y3
-------------------------
|                       |
|      writedriver      |
|                       |
------------------------

-------------------------
|                       |
|      writedriver      |
|                       |
-------------------------
```
The top write driver will service the first two SRAMs, while the bottom will service the next two. The bottom write driver will be laid out such that the bitlines line up nicely with the left-most SRAMs and the bottom will line up nicely with the right-most SRAMs. Therefore, we may need two copies of the `writedriver`. Drawback is the extra extra space requirements, so looking into other possible solutions.

It sounds a little far out but thats what has been planned at this stage.

### Testing SRAM array ###
As per discussion with Stephen Brawner earlier today, the Mudders have suggested just assuming the array works as it is a difficult unit to test. However, if we have time will come up with a dumb and simple way of testing in IRSIM just to get some outputs.

## Joel ##
Joel has been designated the 'tools man' of the team.

  * Team is currently testing their modules using IRSIM in Electric
  * Looking at using verilog testing of modules
  * Ran into issues with unavailability of verilog libraries for ModelSim on CATS computers, still pushing ahead with it though.

  * Looked at the `cachecontroller` modules, working on writing test benches for them.

  * Getting all of the teams work into SVN on the google code server.
    * Currently all files are located in [trunk/testing/adelaide](http://hmc-mips.googlecode.com/svn/trunk/testing/adelaide/).
    * Having issues with accessing svn on the windows boxes - does the mudd team have any tips for getting Tortoise SVN to work with google code? Possibly get cygwin installed on CATS comptuers?

## Mel ##
Mel has been designing test benches to check the functions of the multiplexers (`mux2_1x_32`, `mux2_4`, `mux2_c_1x`, `mux2_dp_1x`, `mux2_zip`), `adrtagdatalogic`, `byteenlog`, and `dataout`.

The IRSIM test scripts are located in subversion, under [testing/adelaide](http://hmc-mips.googlecode.com/svn/trunk/testing/adelaide/).

### Notes ###
  * To run minor `test_adrtagdatalogic.cmd`, minor modification is required to the adrtagdatalogic block; some wires in the block have been given names in order to verify behavior. A modified `Cache.jelib` that reflects this change is in subversion.

  * There are 2 separate read and write files to test the `dataout` block

  * Most of the blocks function as expected. However, some issues are
    * The comparator in `adrtagdatalogic` is giving output `x` (floating - illegal value) for matching inputs
    * For the AND gate in `adrtagdatalogic`, the bypass (output) is `0` when inputs `adr[29]` and `adr[27]` are both `1`.



