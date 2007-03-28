CC = ~/yoda_warrior/bin/mips-cygwin-elf-gcc-4.1.1 
AS = ~/yoda_warrior/bin/mips-cygwin-elf-as.exe 
LD = ~/yoda_warrior/bin/mips-cygwin-elf-ld.exe
DUMP = ~/yoda_warrior/bin/mips-cygwin-elf-objdump.exe 
BLD = ../build 
DEBUG = -nodebug
SRC = ./ 
CFLAGS = -Wall -msoft-float -march=r3000 -EL 
RESET_LOC = 0xbfc00000
BOOT_LOC = 0xbfc00100
PROG_LOC = 0x9fc01000

all: test_012.dat test_012.asm test_016.dat test_fp_001.dat test_fp_001.asm test_017.dat test_026.dat test_026.asm yoda_test_001.dat yoda_test_001.asm

# All c-compiled programs must have their first instruction changed so that it
# sets the stack pointer

# This line prevents make from automatically deleting these files as temporary
.PRECIOUS: %.dat %.dump %.o %.s %.asm

%.rom: %.dat boot_loader.dat boot_start.dat
	python dumpBootAndProgram.py $(DEBUG) -params toolchain_memory_specs.txt -program $< -output $@

%.v: %.dat
	python verilogLiteBootAndProgram.py $(DEBUG) -params toolchain_memory_specs.txt -program $< -output $@

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
	$(CC) $(CFLAGS) -S -c $< -o $@

clean:
	rm *.o *.out *.dump *.coe 

clean-all: 
	rm *.o *.out *.dump *.coe *.rom *.dat *.v
