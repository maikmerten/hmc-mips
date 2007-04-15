/*
 *************************************************************************
 *
 *                   "DHRYSTONE" Benchmark Program
 *                   -----------------------------
 *  This is a modified version of the Dhrystone benchmark modified
 *  specifically for the Harvey Mudd College HMC-MIPS project, CMOS VLSI
 *  Design, Spring 2007.  
 *  Major modifications began Apr 10, 2007 by Matt McKnett
 *  
 *  Changes from the original are marked with a "CHANGED" comment in code.
 *
 *  $Author: whiterook2004 $,  $Date: 2007-04-12 18:46:58 -0700 (Thu, 12 Apr 2007) $ -- $Revision: 547 $
 * 
 *
 *  Version:    C, Version 2.1
 *
 *  File:       dhry_1.c (part 2 of 3)
 *
 *  Date:       May 25, 1988
 *
 *  Author:     Reinhold P. Weicker
 *
 *************************************************************************
 */

/* CHANGE:
	These includes were originally used, but cannot happen with Yoda_warrior */
/*#include <stdio.h>
#include <stdlib.h>
#include <string.h> */
#include "dhry.h"
#include "muddCLib/muddCLib.h"

/* Global Variables: */

Rec_Type		Rec_Glob,
				Next_Rec_Glob;
Rec_Pointer     Ptr_Glob,
                Next_Ptr_Glob;
int             Int_Glob;
Boolean         Bool_Glob;
char            Ch_1_Glob,
                Ch_2_Glob;
int             Arr_1_Glob [50];
int             Arr_2_Glob [50] [50];

/* CHANGE:  No longer need this string.
	char Reg_Define[] = "Register option selected."; */

/* CHANGE:
	You go away because you declare the function wrong!!
Enumeration     Func_1 ();
  //forward declaration necessary since Enumeration may not simply be int
  
*/

/* CHANGE:
	I don't know where it's supposed to get ROPT, but I don't
	see it anywhere, so it's going away.
#ifndef ROPT
#define REG
        // REG becomes defined as empty
        // i.e. no register variables 
#else
#define REG register
#endif
*/
#define REG		// Make REG empty.

/* CHANGE:
	We'll be measuring our timing by hand!

// variables for time measurement:

#define Too_Small_Time 2
                // Measurements should last at least 2 seconds

double          Begin_Time,
                End_Time,
                User_Time;

double          Microseconds,
                Dhrystones_Per_Second,
                Vax_Mips;

*/

/* end of variables for time measurement */


int main ()
/*****/

  /* main program, corresponds to procedures        */
  /* Main and Proc_0 in the Ada version             */
{  
	/* CHANGE:
	We no longer use the code itself for timing.
	double   dtime(); */

  /* CHANGE:
     We need a strcpy function in MuddCLib.  Since we don't pull
	 string literal data out of object files, we have to put them 
	 on the stack.  */
  /* "DHRYSTONE PROGRAM, SOME STRING" */
  char some_string[32] = {'D', 'H', 'R', 'Y', 'S', 'T', 'O', 'N', 'E', ' ', 
	  'P', 'R', 'O', 'G', 'R', 'A', 'M', ',', ' ', 'S', 'O', 'M', 'E', ' ', 
	  'S', 'T', 'R', 'I', 'N', 'G', '\0'};

  /* "DHRYSTONE PROGRAM, 1'ST STRING" */
  char first_string[32] = {'D', 'H', 'R', 'Y', 'S', 'T', 'O', 'N', 'E', ' ',
	  'P', 'R', 'O', 'G', 'R', 'A', 'M', ',', ' ', '1', '\'', 'S', 'T', ' ', 
	  'S', 'T', 'R', 'I', 'N', 'G', '\0'};

  /* Before we count down, we need to define the strings that will
     be used in the tests. "DHRYSTONE PROGRAM, 2'ND STRING" */
  char second_string[32] = {'D', 'H', 'R', 'Y', 'S', 'T', 'O', 'N', 'E', ' ',
	  'P', 'R', 'O', 'G', 'R', 'A', 'M', ',', ' ', '2', '\'', 'N', 'D', ' ', 
	  'S', 'T', 'R', 'I', 'N', 'G', '\0'};
  /* "DHRYSTONE PROGRAM, 3'RD STRING" */
  char third_string[32] = {'D', 'H', 'R', 'Y', 'S', 'T', 'O', 'N', 'E', ' ',
	  'P', 'R', 'O', 'G', 'R', 'A', 'M', ',', ' ', '3', '\'', 'R', 'D', ' ', 
	  'S', 'T', 'R', 'I', 'N', 'G', '\0'};

        One_Fifty       Int_1_Loc;
  REG   One_Fifty       Int_2_Loc;
        One_Fifty       Int_3_Loc;
  REG   char            Ch_Index;
        Enumeration     Enum_Loc;
        Str_30          Str_1_Loc;
        Str_30          Str_2_Loc;
  REG   int             Run_Index;
  REG   int             Number_Of_Runs = 100000;
		int				i;
		int				testsSucceeded;
  /* We'll hard-code 100,000 runs in for now and see how that does. */

  /* Initializations */

/* CHANGE:  We're never using sde!!
#if !#system(sde)
        FILE            *Ap;

  if ((Ap = fopen("dhry.res","a+")) == NULL)
    {
       printf("Can not open dhry.res\n\n");
       exit(1);
    }
#endif
*/

  /* CHANGE: We don't have a malloc function. 
  Next_Ptr_Glob = (Rec_Pointer) malloc (sizeof (Rec_Type));
  Ptr_Glob = (Rec_Pointer) malloc (sizeof (Rec_Type));     */
  Next_Ptr_Glob = &Next_Rec_Glob;
  Ptr_Glob = &Rec_Glob;

  Ptr_Glob->Ptr_Comp                    = Next_Ptr_Glob;
  Ptr_Glob->Discr                       = Ident_1;
  Ptr_Glob->variant.Enum_Comp     = Ident_3;
  Ptr_Glob->variant.Int_Comp      = 40;

  strcpy (Ptr_Glob->variant.Str_Comp, some_string);
  strcpy (Str_1_Loc, first_string);

  Arr_2_Glob [8][7] = 10;
        /* Was missing in published program. Without this statement,    */
        /* Arr_2_Glob [8][7] would have an undefined value.             */
        /* Warning: With 16-Bit processors and Number_Of_Runs > 32000,  */
        /* overflow may occur for this array element.                   */


  /* CHANGE:
	No printing necessary!
  printf ("\n");
  printf ("Dhrystone Benchmark, Version 2.1 (Language: C)\n");
  printf ("\n");*/

/*  
  if (Reg)
  {
    printf ("Program compiled with 'register' attribute\n");
    printf ("\n");
  }
  else
  {
    printf ("Program compiled without 'register' attribute\n");
    printf ("\n");
  }
*/

/* CHANGE:  We'll never run this on sde and we set the number of runs
			at the beginning of main, so we don't need to read it!
#if #system(sde)
  // Call a non-inlineable function to prevent loop unrolling
  //   from knowing the number of loops.
  Number_Of_Runs = number_of_runs ();
#else
  printf ("Please give the number of runs through the benchmark: ");
  {
    int n;
    scanf ("%d", &n);
    Number_Of_Runs = n;
  }
  printf ("\n");
#endif */

  /* CHANGE:
		Instead of printing that execution starts here, we'll
		flash some LEDs.
  printf ("Execution starts, %d runs through Dhrystone\n",Number_Of_Runs);
  */

  /* The LEDs count down one at a time, then flash to indicate the
	 beginning of tests. */
  setLED(0x8);
  delay1000clock(200);
  setLED(0x4);
  delay1000clock(200);
  setLED(0x2);
  delay1000clock(200);
  setLED(0x1);
  delay1000clock(200);
  setLED(0xF);
  delay1000clock(50);
  setLED(0x0);

  /***************/
  /* Start timer */
  /***************/
 
  /* CHANGE:
	  No more internal timing.
  Begin_Time = dtime();
  */
  
  for (Run_Index = 1; Run_Index <= Number_Of_Runs; ++Run_Index)
  {

    Proc_5();
    Proc_4();
      /* Ch_1_Glob == 'A', Ch_2_Glob == 'B', Bool_Glob == true */
    Int_1_Loc = 2;
    Int_2_Loc = 3;
    strcpy (Str_2_Loc, second_string);
    Enum_Loc = Ident_2;
    Bool_Glob = ! Func_2 (Str_1_Loc, Str_2_Loc);
      /* Bool_Glob == 1 */
    while (Int_1_Loc < Int_2_Loc)  /* loop body executed once */
    {
      Int_3_Loc = 5 * Int_1_Loc - Int_2_Loc;
        /* Int_3_Loc == 7 */
      Proc_7 (Int_1_Loc, Int_2_Loc, &Int_3_Loc);
        /* Int_3_Loc == 7 */
      Int_1_Loc += 1;
    } /* while */
      /* Int_1_Loc == 3, Int_2_Loc == 3, Int_3_Loc == 7 */
    Proc_8 (Arr_1_Glob, Arr_2_Glob, Int_1_Loc, Int_3_Loc);
      /* Int_Glob == 5 */
    Proc_1 (Ptr_Glob);
    for (Ch_Index = 'A'; Ch_Index <= Ch_2_Glob; ++Ch_Index)
                             /* loop body executed twice */
    {
      if (Enum_Loc == Func_1 (Ch_Index, 'C'))
          /* then, not executed */
        {
        Proc_6 (Ident_1, &Enum_Loc);
        strcpy (Str_2_Loc, third_string);
        Int_2_Loc = Run_Index;
        Int_Glob = Run_Index;
        }
    }
      /* Int_1_Loc == 3, Int_2_Loc == 3, Int_3_Loc == 7 */
    Int_2_Loc = Int_2_Loc * Int_1_Loc;
    Int_1_Loc = Int_2_Loc / Int_3_Loc;
    Int_2_Loc = 7 * (Int_2_Loc - Int_3_Loc) - Int_1_Loc;
      /* Int_1_Loc == 1, Int_2_Loc == 13, Int_3_Loc == 7 */
    Proc_2 (&Int_1_Loc);
      /* Int_1_Loc == 5 */

  } /* loop "for Run_Index" */

  /**************/
  /* Stop timer */
  /**************/

  /* Flash the LEDs to indicate the end of the tests. */
  for(i = 0; i < 10; ++i)
  {
	  setLED(0xF);
	  delay1000clock(100);
	  setLED(0x0);
	  delay1000clock(100);
  }

  /* Check all of the results, and display pass or fail on the LEDs. */
  /* Assume tests succeeded and challenge. */
  testsSucceeded = (Int_Glob == 5) && 
		(Bool_Glob == 1) &&
		(Ch_1_Glob == 'A') && 
		(Ch_2_Glob == 'B') &&
		(Arr_1_Glob[8] == 7) && 
		(Arr_2_Glob[8][7] == Number_Of_Runs + 10) &&
		((int)Ptr_Glob->Ptr_Comp == (int)Next_Ptr_Glob->Ptr_Comp) &&
		(Ptr_Glob->Discr == 0) && 
		(Ptr_Glob->variant.Enum_Comp == 2) &&
		(Ptr_Glob->variant.Int_Comp == 17) && 
		!strcmp(Ptr_Glob->variant.Str_Comp, some_string) &&		// strcmp returns 0 if they're the same!
		(Next_Ptr_Glob->Discr == 0) &&
		(Next_Ptr_Glob->variant.Enum_Comp == 1) &&
		(Next_Ptr_Glob->variant.Int_Comp == 18) &&
		!strcmp(Next_Ptr_Glob->variant.Str_Comp, some_string) &&
		(Int_1_Loc == 5) &&
		(Int_2_Loc == 13) &&
		(Int_3_Loc == 7) &&
		(Enum_Loc == 1) &&
		!strcmp(Str_1_Loc, first_string) &&
		!strcmp(Str_2_Loc, second_string);

  if(testsSucceeded)
  {
	/* LEDs show fireworks */
	  while(1)
	  {
		  setLED(0x2);
		  delay1000clock(100);
		  setLED(0x5);
		  delay1000clock(100);
		  setLED(0x8);
		  delay1000clock(100);
		  setLED(0x0);
		  delay1000clock(500);
		  setLED(0x4);
		  delay1000clock(100);
		  setLED(0xA);
		  delay1000clock(100);
		  setLED(0x1);
		  delay1000clock(100);
		  setLED(0x0);
		  delay1000clock(700);
	  }
  }
  else
  {
	/* LEDs flash quickly */
	  while(1)
	  {
		  setLED(0xF);
		  delay1000clock(50);
		  setLED(0x0);
		  delay1000clock(50);
	  }
  }


  /* CHANGE:
	  We don't print any of the data, but we'll validate it and flash
	  the LEDs accordingly.
	
  End_Time = dtime();

  printf ("Execution ends\n");
  printf ("\n");
  printf ("Final values of the variables used in the benchmark:\n");
  printf ("\n");
  printf ("Int_Glob:            %d\n", Int_Glob);
  printf ("        should be:   %d\n", 5);
  printf ("Bool_Glob:           %d\n", Bool_Glob);
  printf ("        should be:   %d\n", 1);
  printf ("Ch_1_Glob:           %c\n", Ch_1_Glob);
  printf ("        should be:   %c\n", 'A');
  printf ("Ch_2_Glob:           %c\n", Ch_2_Glob);
  printf ("        should be:   %c\n", 'B');
  printf ("Arr_1_Glob[8]:       %d\n", Arr_1_Glob[8]);
  printf ("        should be:   %d\n", 7);
  printf ("Arr_2_Glob[8][7]:    %d\n", Arr_2_Glob[8][7]);
  printf ("        should be:   Number_Of_Runs + 10\n");
  printf ("Ptr_Glob->\n");
  printf ("  Ptr_Comp:          %d\n", (int) Ptr_Glob->Ptr_Comp);
  printf ("        should be:   (implementation-dependent)\n");
  printf ("  Discr:             %d\n", Ptr_Glob->Discr);
  printf ("        should be:   %d\n", 0);
  printf ("  Enum_Comp:         %d\n", Ptr_Glob->variant.Enum_Comp);
  printf ("        should be:   %d\n", 2);
  printf ("  Int_Comp:          %d\n", Ptr_Glob->variant.Int_Comp);
  printf ("        should be:   %d\n", 17);
  printf ("  Str_Comp:          %s\n", Ptr_Glob->variant.Str_Comp);
  printf ("        should be:   DHRYSTONE PROGRAM, SOME STRING\n");
  printf ("Next_Ptr_Glob->\n");
  printf ("  Ptr_Comp:          %d\n", (int) Next_Ptr_Glob->Ptr_Comp);
  printf ("        should be:   (implementation-dependent), same as above\n");
  printf ("  Discr:             %d\n", Next_Ptr_Glob->Discr);
  printf ("        should be:   %d\n", 0);
  printf ("  Enum_Comp:         %d\n", Next_Ptr_Glob->variant.Enum_Comp);
  printf ("        should be:   %d\n", 1);
  printf ("  Int_Comp:          %d\n", Next_Ptr_Glob->variant.Int_Comp);
  printf ("        should be:   %d\n", 18);
  printf ("  Str_Comp:          %s\n", Next_Ptr_Glob->variant.Str_Comp);
  printf ("        should be:   DHRYSTONE PROGRAM, SOME STRING\n");
  printf ("Int_1_Loc:           %d\n", Int_1_Loc);
  printf ("        should be:   %d\n", 5);
  printf ("Int_2_Loc:           %d\n", Int_2_Loc);
  printf ("        should be:   %d\n", 13);
  printf ("Int_3_Loc:           %d\n", Int_3_Loc);
  printf ("        should be:   %d\n", 7);
  printf ("Enum_Loc:            %d\n", Enum_Loc);
  printf ("        should be:   %d\n", 1);
  printf ("Str_1_Loc:           %s\n", Str_1_Loc);
  printf ("        should be:   DHRYSTONE PROGRAM, 1'ST STRING\n");
  printf ("Str_2_Loc:           %s\n", Str_2_Loc);
  printf ("        should be:   DHRYSTONE PROGRAM, 2'ND STRING\n");
  printf ("\n");

  User_Time = End_Time - Begin_Time;

  if (User_Time < Too_Small_Time)
  {
    printf ("Measured time too small to obtain meaningful results\n");
    printf ("Please increase number of runs\n");
    printf ("\n");
  }
  else
  {
    Microseconds = User_Time * Mic_secs_Per_Second 
                        / (double) Number_Of_Runs;
    Dhrystones_Per_Second = (double) Number_Of_Runs / User_Time;
    Vax_Mips = Dhrystones_Per_Second / 1757.0;

	*/

  /* CHANGE:
  All of these data will be recorded by a human datataker and a stopwatch.
#ifdef ROPT
    printf ("Register option selected?  YES\n");
#else
    printf ("Register option selected?  NO\n");
    // XXX bug in dhrystone - writes beyond end of Reg_Define XXX 
    // strcpy(Reg_Define, "Register option not selected.");
#endif
    printf ("Microseconds for one run through Dhrystone: ");
    printf ("%7.1lf \n", Microseconds);
    printf ("Dhrystones per Second:                      ");
    printf ("%10.1lf \n", Dhrystones_Per_Second);
    printf ("VAX MIPS rating = %10.3lf \n",Vax_Mips);
    printf ("\n");
  
#if !#system(sde)
  fprintf(Ap,"\n");
  fprintf(Ap,"Dhrystone Benchmark, Version 2.1 (Language: C)\n");
#ifdef ROPT
  fprintf(Ap,"%s\n",Reg_Define);
#else
  fprintf (Ap,"Register option not selected.\n");
#endif
  fprintf(Ap,"Microseconds for one loop: %7.1lf\n",Microseconds);
  fprintf(Ap,"Dhrystones per second: %10.1lf\n",Dhrystones_Per_Second);
  fprintf(Ap,"VAX MIPS rating: %10.3lf\n",Vax_Mips);
  fclose(Ap);
#endif  
  }
  */

  return (0);

} /* End of main() */





