/* $Id: matmult.c,v 1.2 2005/04/04 11:34:58 csg Exp $ */

/* matmult.c */
/* was mm.c! */
#include "test_benchmark.h"
#include "test.h"

/*----------------------------------------------------------------------*
 * To make this program compile under our assumed embedded environment,
 * we had to make several changes:
 * - Declare all functions in ANSI style, not K&R.
 *   this includes adding return types in all cases!
 * - Declare function prototypes
 * - Disable all output
 * - Disable all UNIX-style includes
 *
 * This is a program that was developed from mm.c to matmult.c by
 * Thomas Lundqvist at Chalmers.
 *----------------------------------------------------------------------*/
#define UPPSALAWCET 1


/* ***UPPSALA WCET***:
   disable stupid UNIX includes */
#ifndef UPPSALAWCET
#include <sys/types.h>
#include <sys/times.h>
#endif

/*
 * MATRIX MULTIPLICATION BENCHMARK PROGRAM:
 * This program multiplies 2 square matrices resulting in a 3rd
 * matrix. It tests a compiler's speed in handling multidimensional
 * arrays and simple arithmetic.
 */

#define UPPERLIMIT 10

typedef int matrix [UPPERLIMIT][UPPERLIMIT];

int Seed;
matrix ArrayA, ArrayB, ResultArray;

#ifdef UPPSALAWCET
/* Our picky compiler wants prototypes! */
void Multiply(matrix A, matrix B, matrix Res);
void InitSeed(void);
void Test(matrix A, matrix B, matrix Res);
void Initialize(matrix Array, int num);
int RandomInteger(void);
#endif
void mm_init()
{
   InitSeed();
/* ***UPPSALA WCET***:
   no printing please! */
#ifndef UPPSALAWCET
   printf("\n   *** MATRIX MULTIPLICATION BENCHMARK TEST ***\n\n");
   printf("RESULTS OF THE TEST:\n");
#endif
   Test(ArrayA, ArrayB, ResultArray);
}


void InitSeed(void)
/*
 * Initializes the seed used in the random number generator.
 */
{
  /* ***UPPSALA WCET***:
     changed Thomas Ls code to something simpler.
   Seed = KNOWN_VALUE - 1; */
  Seed = 0;
}

const int mm_res[UPPERLIMIT][UPPERLIMIT] = {{285, 375, 465, 555, 645, 735, 825, 915, 1005, 1095}, {330, 440, 550, 660, 770, 880, 990, 1100, 1210, 1320}, {375, 505, 635, 765, 895, 1025, 1155, 1285, 1415, 1545}, {420, 570, 720, 870, 1020, 1170, 1320, 1470, 1620, 1770}, {465, 635, 805, 975, 1145, 1315, 1485, 1655, 1825, 1995}, {510, 700, 890, 1080, 1270, 1460, 1650, 1840, 2030, 2220}, {555, 765, 975, 1185, 1395, 1605, 1815, 2025, 2235, 2445}, {600, 830, 1060, 1290, 1520, 1750, 1980, 2210, 2440, 2670}, {645, 895, 1145, 1395, 1645, 1895, 2145, 2395, 2645, 2895}, {690, 960, 1230, 1500, 1770, 2040, 2310, 2580, 2850, 3120}};

void Test(matrix A, matrix B, matrix Res)
/*
 * Runs a multiplication test on an array.  Calculates and prints the
 * time it takes to multiply the matrices.
 */
{
#ifndef UPPSALAWCET
   long StartTime, StopTime;
   float TotalTime;
#endif

   Initialize(A, 1);
   Initialize(B, 2);

   /* ***UPPSALA WCET***: don't print or time */
#ifndef UPPSALAWCET
   StartTime = ttime ();
#endif

   Multiply(A, B, Res);

   for (int i=0; i<UPPERLIMIT; i++) {
      for (int j=0; j<UPPERLIMIT; j++) {
         if (Res[i][j] != mm_res[i][j]) {
            Incorrect_Result();
         }
      }
   }

   /* ***UPPSALA WCET***: don't print or time */
#ifndef UPPSALAWCET
   StopTime = ttime();
   TotalTime = (StopTime - StartTime) / 1000.0;
   printf("    - Size of array is %d\n", UPPERLIMIT);
   printf("    - Total multiplication time is %3.3f seconds\n\n", TotalTime);
#endif
}


void Initialize(matrix Array, int num)
/*
 * Intializes the given array with random integers.
 */
{
   int OuterIndex, InnerIndex;

   for (OuterIndex = 0; OuterIndex < UPPERLIMIT; OuterIndex++)
      for (InnerIndex = 0; InnerIndex < UPPERLIMIT; InnerIndex++)
         Array[OuterIndex][InnerIndex] = OuterIndex + InnerIndex * (num);
}


int RandomInteger(void)
/*
 * Generates random integers between 0 and 8095
 */
{
   Seed = ((Seed * 133) + 81) % 8095;
   return (Seed);
}


#ifndef UPPSALAWCET
int ttime()
/*
 * This function returns in milliseconds the amount of compiler time
 * used prior to it being called.
 */
{
   struct tms buffer;
   int utime;

   /*   times(&buffer);   times not implemented */
   utime = (buffer.tms_utime / 60.0) * 1000.0;
   return (utime);
}
#endif

void Multiply(matrix A, matrix B, matrix Res)
/*
 * Multiplies arrays A and B and stores the result in ResultArray.
 */
{
   register int Outer, Inner, Index;

   for (Outer = 0; Outer < UPPERLIMIT; Outer++)
      for (Inner = 0; Inner < UPPERLIMIT; Inner++)
      {
         Res [Outer][Inner] = 0;
         for (Index = 0; Index < UPPERLIMIT; Index++)
            Res[Outer][Inner]  +=
               A[Outer][Index] * B[Index][Inner];
       }
}
