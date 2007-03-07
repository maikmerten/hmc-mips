CC = /home/Matt/yoda_warrior/bin/mips-cygwin-elf-gcc.exe 
AS = /home/Matt/yoda_warrior/bin/mips-cygwin-elf-as.exe 
LD = /home/Matt/yoda_warrior/bin/mips-cygwin-elf-ld.exe
DUMP = /home/Matt/yoda_warrior/bin/mips-cygwin-elf-objdump.exe 
BLD = ../build 
SRC = ./ 
CFLAGS = -Wall -msoft-float -march=r3000 -EL 

all: test_012.dat test_012.asm test_016.dat test_fp_001.dat test_fp_001.asm test_017.dat test_026.dat test_026.asm yoda_test_001.dat yoda_test_001.asm

# All c-compiled programs must have their first instruction changed so that it
# sets the stack pointer

# This line prevents make from automatically deleting these files as temporary
.PRECIOUS: %.dat %.dump %.o %.s %.asm

%.coe: %.dat boot_loader.dat boot_start.dat
	python dumpBootAndProgram.py -boot_start boot_start.dat -boot_load boot_loader.dat -program $< -output $@

# This magic grep command strips out the instruction hex from the objdump 
# output.
%.dat: %.dump
	cat $< | grep --only-matching "^ *[0-9a-fA-F]\+:[^0-9a-fA-F]*[0-9a-fA-F ]\+" | grep --only-matching ":[^0-9a-fA-F]*[0-9a-fA-F]\+" | tr -d " " | grep --only-matching "[0-9a-fA-F]\{8\}" > $@

%.dump: %.out
	$(DUMP) -d --disassemble-zeroes $< > $@

%.out: %.o
	$(LD) -EL -Ttext=0x9fc00000 -o $@ $<

boot_start.out: boot_start.o boot_loader.o
	$(LD) -EL -Ttext=0xbfc00000 -o $@ $<

boot_loader.out: boot_loader.o
	$(LD) -EL -Ttext=0xbfc00E00 -o $@ $<

# ".set noreorder" in the assembly code prevents the removal of unneeded nops 
# and swapping branches
%.o: %.asm
	python checkInstructions.py $<
	$(AS) -EL -o $@ $<

%.asm: %.c
	$(CC) $(CFLAGS) -S -c $< -o $@

clean:
	rm *.o *.dump *.coe
