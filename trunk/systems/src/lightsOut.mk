# lightsOut.mk
#
# Defines the dependencies for lightsOut

lightsOut.asm: lightsOut.c lightsOut.h muddCLib/muddCLib.h muddCLib/mtRand.h
	$(CC) $(CFLAGS) -S lightsOut.c -o lightsOut.asm

lightsOut.out: lightsOut.o muddCLib/muddCLib.o muddCLib/mtRand.o
	$(LD) -EL -Ttext=$(PROG_LOC) -o lightsOut.out lightsOut.o muddCLib/muddCLib.o

