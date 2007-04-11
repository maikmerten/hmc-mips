# dhrystone.mk
#
# The makefile responsible for making dhrystone.


dhrystone.asm: dhry21a.c dhry21b.c dhry.h timers_b.c \
$(SRC)/muddCLib/muddCLib.h boot_start.dat boot_loader.dat
	$(CC) $(CFLAGS) -O2 -S dhry21a.c dhry21b.c -o $@

dhrystone.o: dhrystone.asm
	python $(SRC)/checkInstructions.py $<
	$(AS) -EL -o $@ $<

dhrystone.out: dhrystone.o $(SRC)/muddCLib/muddCLib.o
	$(LD) $(LDFLAGS) -Ttext=$(PROG_LOC) -o $@ dhrystone.o $(SRC)/muddCLib/muddCLib.o

