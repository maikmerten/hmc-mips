# Tell where various toolchain utilities exist.
CC = ~/yoda_warrior/bin/mips-cygwin-elf-gcc-4.1.1 
AS = ~/yoda_warrior/bin/mips-cygwin-elf-as.exe 
LD = ~/yoda_warrior/bin/mips-cygwin-elf-ld.exe
DUMP = ~/yoda_warrior/bin/mips-cygwin-elf-objdump.exe

# Where the source directories are
BLD = ../build
SRC = ./

# These variables control the build process.
CFLAGS = -Wall -msoft-float -march=r3000 -EL 
DEBUG = -nodebug
BOOTLOAD = true
MEM_SPECS = toolchain_memory_specs.txt
RESET_LOC = 0xbfc00000
BOOT_LOC = 0xbfc00100
PROG_LOC = 0x9fc01000

# Build all of the main programs in the src folder
all: test_012.dat test_012.asm test_016.dat test_fp_001.dat test_fp_001.asm test_017.dat test_026.dat test_026.asm yoda_test_001.dat yoda_test_001.asm

# This line prevents make from automatically deleting these files as temporary
.PRECIOUS: %.dat %.dump %.o %.s %.asm

%.rom: %.dat boot_loader.dat boot_start.dat
	python dumpBootAndProgram.py $(DEBUG) -params $(MEM_SPECS) -program $< -output $@

%.v: %.dat boot_loader.dat boot_start.dat
ifeq ($(BOOTLOAD),true)
	python generateVerilog.py $(DEBUG) -params $(MEM_SPECS) -program $< -output $@
else
	python generateVerilogNoBoot.py $(DEBUG) -params $(MEM_SPECS) -program $< -output $@
endif

# This magic grep command strips out the instruction hex from the objdump 
# output.
%.dat: %.dump
	cat $< | grep --only-matching "^ *[0-9a-fA-F]\+:[^0-9a-fA-F]*[0-9a-fA-F ]\+" | grep --only-matching ":[^0-9a-fA-F]*[0-9a-fA-F]\+" | tr -d " " | grep --only-matching "[0-9a-fA-F]\{8\}" > $@

%.dump: %.out
	$(DUMP) -d --disassemble-zeroes $< > $@

%.out: %.o
	$(LD) -EL -Ttext=$(PROG_LOC) -o $@ $<

boot_start.out: boot_start.o boot_loader.o
	$(LD) -EL -Ttext=$(RESET_LOC) -o $@ $<

boot_loader.out: boot_loader.o
	$(LD) -EL -Ttext=$(BOOT_LOC) -o $@ $<

# ".set noreorder" in the assembly code prevents the removal of unneeded nops 
# and swapping branches
%.o: %.asm
	python checkInstructions.py $<
	$(AS) -EL -o $@ $<

%.asm: %.c
	$(CC) $(CFLAGS) -S $< -o $@

test_leds.asm: test_leds.c muddCLib/muddCLib.h boot_start.dat boot_loader.dat
	$(CC) $(CFLAGS) -S test_leds.c -o test_leds.asm

test_leds.out: test_leds.o muddCLib/muddCLib.o
	$(LD) -EL -Ttext=$(PROG_LOC) -o test_leds.out test_leds.o muddCLib/muddCLib.o

lightsOut.asm: lightsOut.c lightsOut.h muddCLib/muddCLib.h muddCLib/mtRand.h
	$(CC) $(CFLAGS) -S lightsOut.c -o lightsOut.asm

lightsOut.out: lightsOut.o muddCLib/muddCLib.o muddCLib/mtRand.o
	$(LD) -EL -Ttext=$(PROG_LOC) -o lightsOut.out lightsOut.o muddCLib/muddCLib.o

clean:
	rm *.o *.out *.dump *.coe 

clean-all: 
	rm *.o *.out *.dump *.coe *.rom *.dat *.v
