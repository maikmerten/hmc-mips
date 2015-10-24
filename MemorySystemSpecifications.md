# Introduction #

This specifies the memory subsystem, including the data and instruction cache, write buffer, external memory interface, and the memory system controller.

# Specifications #

## Overview ##

The memory and cache system is composed of the following modules:

  * Two identical 512 byte caches: one for data and one for instructions.
  * A write buffer to reduce number of stalls when writing to main memory.
  * A memsys controller which multiplexes data between the above modules, processor, and external memory.

A block diagram of this is shown below:

![http://hmc-mips.googlecode.com/svn/trunk/images/mem.gif](http://hmc-mips.googlecode.com/svn/trunk/images/mem.gif)

## Memory Interface Conventions ##

All of the primary memory and cache system modules follow a common interface convention for control signals and address/data buses.  The interface convention includes:

  * adr: word address
  * data: bi-direction data
  * byteen: byte mask for writing data less than a word in length
  * rwb: read/write bar, 0 = write, 1 = read
  * en: enable read/write
  * done: asserted when memory operation is complete

Most of the modules include the interface convention twice, one for requests from "lower" modules to the module and one for requests from the module to a "higher" module.  "Lower" and "higher" modules refer to the position of the module within the memory hierarchy shown below.  For example, from the write buffer's perspective, the "lower" module is the caches and the "higher" module is external memory.

![http://hmc-mips.googlecode.com/svn/trunk/images/memhier.gif](http://hmc-mips.googlecode.com/svn/trunk/images/memhier.gif)

We'll call the "lower" module requesting a memory operation the master and the current module executing the operation the slave.  When the slave's input pins (adr, data, rwb, etc..) from the master are valid, the master asserts en.  En must be asserted for the entire duration of the operation. The slave will execute the operation until completion, where it will drive necessary pins to the master and assert done. There will always be at least a one cycle latency between the master asserting en and the slave asserting done, except between the MIPS processor/cache interface (for reading) and the external memory interface.

All of the interfaces for primary modules are detailed below and are from the slave's point of view.


## Memsys ##

The MIPS memory system (memsys) module is the entire memory/cache system and interfaces the processor, caches, write buffer, and external memory. Additionally, it handles operations such as cache swapping. Memsys also includes the memsys controller (memsyscontroller) containing logic to control many multiplexers and tri-state buffers, to prioritize and arbitrate external memory operations. Memsys's interface is:

```
input ph1, ph2, reset,
input [31:2] pcF,
output [31:0] instrF,
input reF,
output instrackF,
                       
input [29:0] adrM, 
input [31:0] writedataM,
input [3:0] byteenM,
output [31:0] readdataM,
input memwriteM, reM,
output dataackM,
                       
input swc,
                       
output [26:0] memadr,
inout [31:0] memdata,
output [3:0] membyteen,
output memrwb,
output memen,
input memdone
```

Note that an uncached address read or write operation will cause a cache miss (and hence processor stall) whenever en is asserted.  Hence, it is necessary for the processor to control the data and instruction cache en inputs, so no cycles will be wasted on unneeded memory stalls (e.g. if the current instruction does not use memory).

Since the external memory only has one data and address bus, the memsys is responsible for multiplexing read/writes to the external memory from the two caches and write buffer. The cache controller will wait until the current memory operation is complete and start new operations with the following priority (top indicates highest priority):

  1. Write buffer write
  1. Data cache read
  1. Instruction cache read

The data cache (or instruction cache if swapped) is connected directly to the write buffer if it requests a memory write. When a module is using the external memory, the memory and module are multiplexed together directly, so once the memory asserts done the component's memdone will be HIGH. After one cycle, memsys disconnects the module and the memory, and connects a LOW to the memdone input of the module.

## Data and Instruction Caches ##

Both caches are identical, one for instructions and one for data. Each cache will be 512 bytes in size and synchronous. Cache features include:

  * _Write-through_: When a data write is requested from the processor, it is written immediately to memory (or write buffer) as well as the cached. The cache never holds a newer copy of data than main memory (or write buffer).
  * _Write buffer_: To improve performance, so the CPU does not stall for the entire external memory write time, a FIFO (first-in, first-out) write buffer is used. Once the write buffer is full, the CPU stalls until a space is available in the write buffer.
  * _Direct-mapped_: The lower seven bits of the memory address are used as the tag in the cache memory.
  * _Physically addressed_: The address the cache uses in the tag data is based upon the physical address of the data in external RAM.
  * _Bypassing_:  The cache can be bypassed via the upper bits (explained in the memory map section) so that certain data (e.g. memory mapped I/O) is never cached.
  * _Swapping_:  The caches can be swapped.  This is mainly useful for cache invalidation during boot loading of the processor.


Since each cache is 512 bytes and a word is 4 bytes, each cache can hold 128 words. A tag must be associated with each word, representing the lower bits of the address. 128 = 2^7, so each tag is 7 bits long. The tag data must hold the upper bits of the address, and all addresses should word aligned, hence 32 - 7 - 2 = 23 bits of tag data. Additionally, a valid bit must be associated with each tag. The total width of each cache slot is then 23 + 1 + 32 = 56 bits.  The total size of the cache's memory is then 128\*56 = 7168 bits or 896 bytes per cache.

The cache slots (containing the tag data, data, and valid bit) are stored in the cacheram module, and the controls are generated from a cachecontroller module.  The cache interface is:

```
input ph1, ph2, reset,
input [29:0] adr,
inout [31:0] data,
input [3:0] byteen,
input rwb, en,
output done,
             
output [26:0] memadr, 
inout  [31:0] memdata,
output [3:0] membyteen,
output memrwb,
output memen,
input memdone
```

The cache is synchronous with the processor completes a cache hit within one clock cycle. So, the cache will respond exactly as the HMC ENGR85 (Digital Electronics and Computer Engineering) MIPS processor's instruction and data memory did for cached memory locations that are valid. In this case, a done signal will be asserted within the same clock signal as the request. When the cache misses, the done signal is not asserted until the memory fetch or write is complete. During the time done is not asserted, the hazard unit causes the cpu to stall.

When a word write is requested to an address that is cachable, but not currently in the cache, data is written to both the cache and to the write buffer. When a half-word or byte address write is requested, it is sent directly to the write buffer and invalidates its cache line. Hence, a store other than word length will never write to the cache: just invalidate. This is to retain compatibility with [R2000](https://code.google.com/p/hmc-mips/source/detail?r=2000) MIPS processors and to allow invalidation of cache lines.  Note that the caches do not support cache isolation because a read-modify-write cycle was not implemented (read-modify-write cycles appear to only have been implemented on [R3000](https://code.google.com/p/hmc-mips/source/detail?r=3000)'s and above).  If a cache is given an uncached address (to bypass the cache), it will not read/write from/to the cache line (or invalidate it) but otherwise completes the operation as above.


## Write Buffer ##
The write buffer is a FIFO (first-in first-out) buffer four entries deep, as suggested as an optimal depth by See MIPS Run. The write buffer (module writebuffer) contains the module wbram, which represents the buffer's memory.  Dual-port SRAM is needed for wbram because the write buffer must be able to send data to the external memory while reading data from the cache to write, and so two independent bit-line buses are needed with corresponding word-line buses.  Data cannot be read from external memory until after the write buffer is empty, so a cache read miss directly after a memory write will stall the CPU until all writes are complete.  This prevents the processor from reading outdated data.  In addition to storing the address and data for a write, the write buffer must also store the byteen byte mask to support storing data smaller than a word.

The interface is:

```
input ph1, ph2, reset,
input [26:0] adr,
input [31:0] data,
input [3:0] byteen,
input en,
output done,
                   
output [26:0] memadr,
output [31:0] memdata,
output [3:0] membyteen,
output memen,
input memdone
```


## External Memory ##

The memory system expects a single external memory interface. The exact timings of the main memory are very flexible. The main memory should expect an en (enable) input when the cache system requests a read/write. Once the main memory has performed the operation, and driven any necessary output ports with the correct value, it asserts done.

The interface from the main memory's view is:

```
input ph1, ph2,
input [31:0] adr,
inout [31:0] data,
input [3:0] byteen,
input rwb, en,
output done)
```

If the memory does not have these specifications, then a memory controller will need to be implemented to interface the cache system with the RAM. On the test implementation used for simulation, a reset pin was added to reset the state machine used to generate memory cycle latency. done can be asserted within the same cycle, so the memory should not drive done HIGH until the memory operation is complete. Note that there are only 27 address bits from memsys, so 3 MSB's (because of physical mapping) and 2 LSB's (because it is word addressed) of the external memory's address are driven LOW.


# Memory Map #

For simplicity, data and program memory are mapped the same.  Note that the program memory and data memory share identical physical addresses.  No mechanism is in place to protect program memory from accidental overwriting.

  * kseg0 (cached program/data memory): 0x8000 0000 - 0x9FFF FFFF
  * kseg1 (uncached program/data memory):  0xA000 0000 - 0xBFFF FFFF

In practice, the cache only checks if the 1st and 3rd most significant bit of the address is high to bypass the cache, otherwise the data is cached.  The address is physically mapped by removing the top three bits.

# Programming Guidelines #

## Startup Procedures ##
The processor starts from 0xBFC0 0000 (508MB physically mapped;kseg1/uncached).  Since the cache will be full of garbage when the CPU starts, the cache must be initialized before use.  Entries in both I- and D-cache must be invalidated, by writing half-word or byte values to unused memory locations for all cache lines.  After invalidation, the I- and D-cache can be used.  This can be accomplished using the algorithm outlined below:

  1. Start in an uncached memory region
  1. Set swc high in the status register to swap the cache (instruction cache is now the data cache)
  1. For each cache line, invalidate by writing a byte or half-word value
  1. Set swc low to swap instruction and data cache to normal arrangement
  1. Repeat step 3
  1. Jump to a cached instruction address

The following code will do this:

```
  // swap
  asm("swapon: addi  $9, $0, 1;
      sll $9,$9,17
      mtc0  $9, $12;
      nop;
      nop;
      nop");
  
  // Invalidate entire instruction cache
  asm("addi $10, $0, 256;
       addi $11, $0, 0x400;
       loop1:
       sb $0,0($11);
       addi $11,$11,4;
       addi $10,$10,-1;
       bnez $10,loop1");

  // unswap
  asm("swapoff: addi  $9, $0, 0;
      mtc0  $9, $12;
      nop;
      nop;
      nop");

  // Invalidate entire data cache
  asm("addi $10, $0, 256;
       addi $11, $0, 0x400;
       loop2:
       sb $0,0($11);
       addi $11,$11,4;
       addi $10,$10,-1;
       bnez $10,loop2");

```

After invalidating the cache, the bootloader should jump to a cached instruction address.  Such as
```
asm("addi $8, $0, 116
     jr $8");
```
to jump to address 0x74 (this is outside of the range of the memory map listed above, but recall that in practice the cache only checks if the addressed should be bypassed).  _jr_ must be used so that the upper bits of the PC change (unlike _jmp_).  Also, the stack pointer should be initialized:
```
asm("li $sp,0x300");
```
which initializes to 0x300.
