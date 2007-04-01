/*
 * mtRand.c
 * Created by Matt McKnett on 4/1/07
 * 
 * An implementation of the Mersenne Twist algorithm, copied from
 * pseudocode found at Wikipedia:
 * http://en.wikipedia.org/wiki/Mersenne_twister
 *
 */

#include "mtRand.h"

void initializeGenerator(int seed)
{
	int i;
	MT[0] = seed;

	for(i = 1; i < NUM_STATES; ++i)
	{
		MT[i] = 0xFFFFFFFF & ((0x10dcd * MT[i-1]) + 1);
	}
}

void generateNumbers()
{
	int i;
	int y;

	for(i = 0; i < NUM_STATES - 1; ++i)
	{
		y = ((0x80000000 & MT[i]) >> 31) + (0x7FFFFFFF & MT[i+1]);
		if(y % 2 == 0)
		{
			MT[i] = MT[(i + 397) % NUM_STATES] ^ (y >> 1);
		}
		else
		{
			MT[i] = MT[(i + 397) % NUM_STATES] ^ (y >> 1) ^ (2567483615);
		}
	}

	y = ((0x80000000 & MT[NUM_STATES - 1]) >> 31) + (0x7FFFFFFF & MT[0]);
	if(y % 2 == 0)
	{
		MT[NUM_STATES - 1] = MT[396] ^ (y >> 1);
	}
	else
	{
		MT[NUM_STATES - 1] = MT[396] ^ (y >> 1) ^ (2567483615);
	}
}

int extractNumber(int i)
{
	int y;

	y = MT[i];
	y = y ^ (y >> 11);
	y = y ^ ((y << 7) & (2636928640));
	y = y ^ ((y << 15) & (4022730752));
	y = y ^ (y >> 18);
	return y;
}
