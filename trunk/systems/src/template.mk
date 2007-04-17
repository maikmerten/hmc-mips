# template.mk
#
# The makefile responsible for making my program

# Just replace 'myProgram' with the name of your program's c file.  So, if you
# have 'helloWorld.c', make this be 'helloWorld'.
MYPROGRAM=myProgram

# This might be nothing, so delete 'myProgram.h' if you don't have a header file
MYPROGRAMHEADER=myProgram.h

MYPROGFILES = $(MYPROGRAMHEADER) $(SRC)/muddCLib/muddCLib.h boot_start.dat boot_loader.dat

$(MYPROGRAM).asm: $(MYROGRAM).c $(MYPROGFILES)
	$(CC) $(CFLAGS) -O2 -S $< -o $@

$(MYPROGRAM).o: $(MYPROGRAM).asm
	python $(SRC)/checkInstructions.py $<
	$(AS) -o $@ $<

$(MYPROGRAM).out: $(MYPROGRAM).o $(SRC)/muddCLib/muddCLib.o
	$(LD) $(LDFLAGS) -Ttext=$(PROG_LOC) -o $@ $^

clean-$(MYPROGRAM):
	rm -f $(MYPROGRAM).asm

