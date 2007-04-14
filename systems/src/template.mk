# template.mk
#
# The makefile responsible for making my program

MYPROGFILES = myProgram.h $(SRC)/muddCLib/muddCLib.h boot_start.dat boot_loader.dat

myProgram.asm: myProgram.c $(MYPROGFILES)
	$(CC) $(CFLAGS) -O2 -S $< -o $@

myProgram.o: myProgram.asm
	python $(SRC)/checkInstructions.py $<
	$(AS) -EL -o $@ $<

myProgram.out: myProgram.o $(SRC)/muddCLib/muddCLib.o
	$(LD) $(LDFLAGS) -Ttext=$(PROG_LOC) -o $@ $^

