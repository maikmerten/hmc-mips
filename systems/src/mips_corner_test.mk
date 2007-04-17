# mips_corner_test.mk
#
# The makefile responsible for making mips_corner_test

# Just replace 'myProgram' with the name of your program's c file.  So, if you
# have 'helloWorld.c', make this be 'helloWorld'.
MYPROGRAM=mips_corner_test

# This might be nothing, so delete 'myProgram.h' if you don't have a header file
MYPROGRAMHEADER=

MYPROGFILES = $(MYPROGRAMHEADER) $(SRC)/muddCLib/muddCLib.h boot_start.dat boot_loader.dat

mips_corner_test.asm: mips_corner_test.c $(MYPROGFILES)
	$(CC) $(CFLAGS) -O2 -S $< -o $@

mips_corner_test.o: mips_corner_test.asm
	python $(SRC)/checkInstructions.py $<
	$(AS) -o $@ $<

mips_corner_test.out: mips_corner_test.o $(SRC)/muddCLib/muddCLib.o
	$(LD) $(LDFLAGS) -Ttext=$(PROG_LOC) -o $@ $^

clean-mips_corner_test:
	rm -f mips_corner_test.asm

