# Tell where various toolchain utilities exist.
CC = ~/yoda_warrior/bin/mips-cygwin-elf-gcc-4.1.1 
AS = ~/yoda_warrior/bin/mips-cygwin-elf-as.exe 
LD = ~/yoda_warrior/bin/mips-cygwin-elf-ld.exe
DUMP = ~/yoda_warrior/bin/mips-cygwin-elf-objdump.exe

# Where the source directories are
BLD = ../build
SRC = ./
INCLUDEFILES = boot.mk test_leds.mk test_lcd.mk lightsOut.mk dhrystone.mk test_buttons.mk test_simple.mk test_buttons2.mk

# These variables control the build process.
CFLAGS = -Wall -msoft-float -march=r3000 -O0
LDFLAGS = -Tdata 0x80016A80 
DEBUG = -nodebug
BOOTLOAD = true
#BOOTLOAD = false
MEM_SPECS = toolchain_memory_specs.txt
RESET_LOC = 0xbfc00000
BOOT_LOC = 0xbfc00100
PROG_LOC = 0x9fc00200
#PROG_LOC = 0xbfc00000
#PROG_LOC = 0xbfc00200

# Build all of the main programs in the src folder
all: lightsOut.v dhrystone.v test_simple.v test_leds.v test_lcd.v test_buttons.v test_led_asm.v test_led_asm.asm

# This line prevents make from automatically deleting these files as temporary
.PRECIOUS: %.dat %.dump %.o %.s %.asm

include $(INCLUDEFILES)

%.asm: %.c
	$(CC) $(CFLAGS) -S $< -o $@

%.o: %.asm
	python checkInstructions.py $<
	$(AS) -o $@ $<

%.out: %.o
	$(LD) $(LDFLAGS) -Ttext=$(PROG_LOC) -o $@ $<

%.dump: %.out
	$(DUMP) -d --disassemble-zeroes $< > $@


# This magic grep command strips out the instruction hex from the objdump 
# output.

%.dat: %.dump
	cat $< | grep --only-matching "^ *[0-9a-fA-F]\+:[^0-9a-fA-F]*[0-9a-fA-F ]\+" | grep --only-matching ":[^0-9a-fA-F]*[0-9a-fA-F]\+" | tr -d " " | grep --only-matching "[0-9a-fA-F]\{8\}" > $@



# If we want to generate a verilog file using the bootloader, we have different
# options than if we want to generate it without.

%.v: %.dat boot_loader.dat boot_start.dat
ifeq ($(BOOTLOAD),true)
	python generateVerilog.py $(DEBUG) -params $(MEM_SPECS) -program $< -output $@
	cp $@ ROM.v
else
	python generateVerilog.py $(DEBUG) -noboot -params $(MEM_SPECS) -program $< -output $@
	cp $@ ROM.v
endif
	@echo ""
	@echo "   Verilog file generated successfully!"
	@echo "   It is a good idea to inspect $*.dump before continuing further to ensure that the program's main routine is the first symbol (address 0x9fc01000)."

%.rom: %.dat boot_loader.dat boot_start.dat
ifeq ($(BOOTLOAD), true)
	python generateROM.py $(DEBUG) -params $(MEM_SPECS) -program $< -output $@
else
	python generateROM.py $(DEBUG) -noboot -params $(MEM_SPECS) -program $< -output $@
endif



clean: 
	rm -f *.o *.out *.dump *.coe *.dat
	rm -f muddCLib/*.o

# Assuming that clean- is the prefix for any cleaning rule defined in the 
# included makefiles, this rule will use it. 
clean-all: $(patsubst %.mk, clean-%, $(INCLUDEFILES))
	rm -f *.rom *.v 
	make clean

