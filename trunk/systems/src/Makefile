# Tell where various toolchain utilities exist.
CC = ~/yoda_warrior/bin/mips-cygwin-elf-gcc-4.1.1 
AS = ~/yoda_warrior/bin/mips-cygwin-elf-as.exe 
LD = ~/yoda_warrior/bin/mips-cygwin-elf-ld.exe
DUMP = ~/yoda_warrior/bin/mips-cygwin-elf-objdump.exe

# Where the source directories are
BLD = ../build
SRC = ./
INCLUDEFILES = boot.mk test_leds.mk test_lcd.mk lightsOut.mk dhrystone.mk test_buttons.mk

# These variables control the build process.
CFLAGS = -Wall -msoft-float -march=r3000 -EL
LDFLAGS = -Tdata 0x80016A80 -EL
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

include $(INCLUDEFILES)

%.asm: %.c
	$(CC) $(CFLAGS) -S $< -o $@

%.o: %.asm
	python checkInstructions.py $<
	$(AS) -EL -o $@ $<

%.out: %.o
	$(LD) $(LDFLAGS) -Ttext=$(PROG_LOC) -o $@ $<

%.dump: %.out
	$(DUMP) -d --disassemble-zeroes $< > $@

%.rom: %.dat boot_loader.dat boot_start.dat
ifeq ($(BOOTLOAD), true)
	python generateROM.py $(DEBUG) -params $(MEM_SPECS) -program $< -output $@
else
	python generateROM.py $(DEBUG) -noboot -params $(MEM_SPECS) -program $< -output $@
endif


# This magic grep command strips out the instruction hex from the objdump 
# output.

%.dat: %.dump
	cat $< | grep --only-matching "^ *[0-9a-fA-F]\+:[^0-9a-fA-F]*[0-9a-fA-F ]\+" | grep --only-matching ":[^0-9a-fA-F]*[0-9a-fA-F]\+" | tr -d " " | grep --only-matching "[0-9a-fA-F]\{8\}" > $@


# If we want to generate a verilog file using the bootloader, we have different
# options than if we want to generate it without.

%.v: %.dat boot_loader.dat boot_start.dat
ifeq ($(BOOTLOAD),true)
	python generateVerilog.py $(DEBUG) -params $(MEM_SPECS) -program $< -output $@
else
	python generateVerilog.py $(DEBUG) -noboot -params $(MEM_SPECS) -program $< -output $@
endif



clean:
	rm -f *.o *.out *.dump *.coe *.dat
	rm -f muddCLib/*.o

clean-all: 
	rm -f *.rom *.v 
	make clean

