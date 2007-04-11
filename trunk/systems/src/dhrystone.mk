# dhrystone.mk
#
# The makefile responsible for making dhrystone.

DHRYFILES = dhry.h timers_b.c $(SRC)/muddCLib/muddCLib.h boot_start.dat boot_loader.dat

dhry21a.asm: dhry21a.c $(DHRYFILES)
	$(CC) $(CFLAGS) -O2 -S dhry21a.c -o $@

dhry21b.asm: dhry21b.c $(DHRYFILES)
	$(CC) $(CFLAGS) -O2 -S dhry21b.c -o $@ 

dhrystone.o: dhry21a.asm dhry21b.asm
	python $(SRC)/checkInstructions.py $^ 
	$(AS) -EL -o $@ $<

dhrystone.out: dhrystone.o $(SRC)/muddCLib/muddCLib.o
	$(LD) $(LDFLAGS) -Ttext=$(PROG_LOC) -o $@ $^

