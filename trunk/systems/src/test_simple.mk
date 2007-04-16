# test_simple.mk
#
# The makefile responsible for making my program

MYPROGFILES = $(SRC)/muddCLib/muddCLib.h boot_start.dat boot_loader.dat

test_simple.asm: test_simple.c $(MYPROGFILES)
	$(CC) $(CFLAGS) -O2 -S $< -o $@

test_simple.o: test_simple.asm
	python $(SRC)/checkInstructions.py $<
	$(AS) -EL -o $@ $<

test_simple.out: test_simple.o $(SRC)/muddCLib/muddCLib.o
	$(LD) $(LDFLAGS) -Ttext=$(PROG_LOC) -o $@ $^

