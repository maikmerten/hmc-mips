# dhrystone.mk
#
# The makefile responsible for making dhrystone.

DHRYFILES = dhry.h timers_b.c $(SRC)/muddCLib/muddCLib.h boot_start.dat boot_loader.dat

dhrystone.asm: dhrystone.c $(DHRYFILES)
	$(CC) $(CFLAGS) -O2 -S $< -o $@ 

dhryFuncs.asm: dhryFuncs.c $(DHRYFILES)
	$(CC) $(CFLAGS) -O2 -S $< -o $@ 


dhrystone.o: dhrystone.asm
	python $(SRC)/checkInstructions.py $<
	$(AS) -EL -o $@ $<

dhryFuncs.o: dhryFuncs.asm
	python $(SRC)/checkInstructions.py $<
	$(AS) -EL -o $@ $<

dhrystone.out: dhrystone.o dhryFuncs.o $(SRC)/muddCLib/muddCLib.o
	$(LD) $(LDFLAGS) -Ttext=$(PROG_LOC) -o $@ $^

