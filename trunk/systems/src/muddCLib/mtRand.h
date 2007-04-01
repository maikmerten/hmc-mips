/*
 * mtRand.h
 * Created by Matt McKnett on 4/1/07
 * 
 * An implementation of the Mersenne Twist algorithm, copied from
 * pseudocode found at Wikipedia:
 * http://en.wikipedia.org/wiki/Mersenne_twister
 *
 */

#ifndef MTRAND_INCLUDED
#define MTRAND_INCLUDED 1

#define NUM_STATES 624

int MT[NUM_STATES];

/* Function for initializing the algorithm */
void initializeGenerator(int seed);

/* Generate NUM_STATES untempered numbers. */
void generateNumbers();

/* Extract a tempered pseudorandom number based on ith value. */
int extractNumber(int i);

#endif /* MTRAND_INCLUDED */
