# lightsOut.mk
#
# Defines the dependencies for lightsOut


lightsOut.asm: lightsOut.c lightsOut.h muddCLib/muddCLib.h muddCLib/mtRand.h
	$(CC) $(CFLAGS) -S lightsOut.c -o lightsOut.asm

lightsOut.o: lightsOut.asm
	python checkInstructions.py $<
	$(AS) -EL -o $@ $<

lightsOut.out: lightsOut.o muddCLib/muddCLib.o muddCLib/mtRand.o
	$(LD) $(LDFLAGS) -Ttext=$(PROG_LOC) -o lightsOut.out lightsOut.o muddCLib/muddCLib.o muddCLib/mtRand.o

lightsOut.exe: lightsOut.c lightsOut.h muddCLib/muddCLib.h muddCLib/mtRand.h
	gcc -o lightsOut lightsOut.c muddCLib/muddCLib.c muddCLib/mtRand.c
	
