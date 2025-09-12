---
title: Precision and accuracy in floating-point calculations
description: Describes the rules that should be followed for floating-point calculations.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: stuk
appliesto: 
  - Access
search.appverid: MET150
ms.date: 05/26/2025
---
# Precision and accuracy in floating-point calculations

_Original KB number:_ &nbsp; 125056

## Summary

There are many situations in which precision, rounding, and accuracy in floating-point calculations can work to generate results that are surprising to the programmer. They should follow the four general rules:

1. In a calculation involving both single and double precision, the result won't usually be any more accurate than single precision. If double precision is required, be certain all terms in the calculation, including constants, are specified in double precision.

2. Never assume that a simple numeric value is accurately represented in the computer. Most floating-point values can't be precisely represented as a finite binary value. For example, `.1` is `.0001100110011...` in binary (it repeats forever), so it can't be represented with complete accuracy on a computer using binary arithmetic, which includes all PCs.

3. Never assume that the result is accurate to the last decimal place. There are always small differences between the "true" answer and what can be calculated with the finite precision of any floating point processing unit.

4. Never compare two floating-point values to see if they're equal or not- equal. This is a corollary to rule 3. There are almost always going to be small differences between numbers that "should" be equal. Instead, always check to see if the numbers are nearly equal. In other words, check to see if the difference between them is small or insignificant.

## More Information

In general, the rules described above apply to all languages, including C, C++, and assembler. The samples below demonstrate some of the rules using FORTRAN PowerStation. All of the samples were compiled using FORTRAN PowerStation 32 without any options, except for the last one, which is written in C.

### Sample 1

The first sample demonstrates two things:

- That FORTRAN constants are single precision by default (C constants are double precision by default).
- Calculations that contain any single precision terms aren't much more accurate than calculations in which all terms are single precision.

After being initialized with 1.1 (a single precision constant), y is as inaccurate as a single precision variable.

```console
x = 1.100000000000000  y = 1.100000023841858
```

The result of multiplying a single precision value by an accurate double precision value is nearly as bad as multiplying two single precision values. Both calculations have thousands of times as much error as multiplying two double precision values.

```console
true = 1.320000000000000 (multiplying 2 double precision values)
y    = 1.320000052452087 (multiplying a double and a single)
z    = 1.320000081062318 (multiplying 2 single precision values)
```

#### Sample code

```c
C Compile options: none

       real*8 x,y,z
       x = 1.1D0
       y = 1.1
       print *, 'x =',x, 'y =', y
       y = 1.2 * x
       z = 1.2 * 1.1
       print *, x, y, z
       end
```

### Sample 2

Sample 2 uses the quadratic equation. It demonstrates that even double precision calculations aren't perfect, and that the result of a calculation should be tested before it's depended on if small errors can have drastic results. The input to the square root function in sample 2 is only slightly negative, but it's still invalid. If the double precision calculations didn't have slight errors, the result would be:

```console
Root =   -1.1500000000
```

Instead, it generates the following error:

> run-time error M6201: MATH
> - sqrt: DOMAIN error

#### Sample code

```c
C Compile options: none

       real*8 a,b,c,x,y
       a=1.0D0
       b=2.3D0
       c=1.322D0
       x = b**2
       y = 4*a*c
       print *,x,y,x-y
       print "(' Root =',F16.10)",(-b+dsqrt(x-y))/(2*a)
       end
```

### Sample 3

Sample 3 demonstrates that due to optimizations that occur even if optimization is not turned on, values may temporarily retain a higher precision than expected, and that it's unwise to test two floating- point values for equality.

In this example, two values are both equal and not equal. At the first IF, the value of Z is still on the coprocessor's stack and has the same precision as Y. Therefore X doesn't equal Y and the first message is printed out. At the time of the second IF, Z had to be loaded from memory and therefore had the same precision and value as X, and the second message also is printed.

#### Sample code

```c
C Compile options: none

       real*8 y
       y=27.1024D0
       x=27.1024
       z=y
       if (x.ne.z) then
         print *,'X does not equal Z'
       end if
       if (x.eq.z) then
         print *,'X equals Z'
       end if
       end
```

### Sample 4

The first part of sample code 4 calculates the smallest possible difference between two numbers close to 1.0. It does this by adding a single bit to the binary representation of 1.0.

```console
x   = 1.00000000000000000  (one bit more than 1.0)
y   = 1.00000000000000000  (exactly 1.0)
x-y =  .00000000000000022  (smallest possible difference)
```

Some versions of FORTRAN round the numbers when displaying them so that the inherent numerical imprecision isn't so obvious. This is why x and y look the same when displayed.

The second part of sample code 4 calculates the smallest possible difference between two numbers close to 10.0. Again, it does this by adding a single bit to the binary representation of 10.0. Notice that the difference between numbers near 10 is larger than the difference near 1. This demonstrates the general principle that the larger the absolute value of a number, the less precisely it can be stored in a given number of bits.

```console
x   = 10.00000000000000000  (one bit more than 10.0)
y   = 10.00000000000000000  (exactly 10.0)
x-y =   .00000000000000178
```

The binary representation of these numbers is also displayed to show that they do differ by only 1 bit.

```console
x = 4024000000000001 Hex
y = 4024000000000000 Hex
```

The last part of sample code 4 shows that simple non-repeating decimal values often can be represented in binary only by a repeating fraction. In this case x=1.05, which requires a repeating factor CCCCCCCC....(Hex) in the mantissa. In FORTRAN, the last digit "C" is rounded up to "D" in order to maintain the highest possible accuracy:

```console
x = 3FF0CCCCCCCCCCCD (Hex representation of 1.05D0)
```

Even after rounding, the result is not perfectly accurate. There is some error after the least significant digit, which we can see by removing the first digit.

```console
x-1 = .05000000000000004
```

#### Sample code

```c
C Compile options: none

       IMPLICIT real*8 (A-Z)
       integer*4 i(2)
       real*8 x,y
       equivalence (i(1),x)

       x=1.
       y=x
       i(1)=i(1)+1
       print "(1x,'x  =',F20.17,'  y=',f20.17)", x,y
       print "(1x,'x-y=',F20.17)", x-y
       print *

       x=10.
       y=x
       i(1)=i(1)+1
       print "(1x,'x  =',F20.17,'  y=',f20.17)", x,y
       print "(1x,'x-y=',F20.17)", x-y
       print *
       print "(1x,'x  =',Z16,' Hex  y=',Z16,' Hex')", x,y
       print *

       x=1.05D0
       print "(1x,'x  =',F20.17)", x
       print "(1x,'x  =',Z16,' Hex')", x
       x=x-1
       print "(1x,'x-1=',F20.17)", x
       print *
       end
```

### Sample 5

In C, floating constants are doubles by default. Use an "f" to indicate a float value, as in "89.95f".

```c
/* Compile options needed: none
*/ 

#include <stdio.h>

void main()
   {
      float floatvar;
      double doublevar;

/* Print double constant. */ 
      printf("89.95 = %f\n", 89.95);      // 89.95 = 89.950000

/* Printf float constant */ 
      printf("89.95 = %f\n", 89.95F);     // 89.95 = 89.949997

/*** Use double constant. ***/ 
      floatvar = 89.95;
      doublevar = 89.95;

printf("89.95 = %f\n", floatvar);   // 89.95 = 89.949997
      printf("89.95 = %lf\n", doublevar); // 89.95 = 89.950000

/*** Use float constant. ***/ 
      floatvar = 89.95f;
      doublevar = 89.95f;

printf("89.95 = %f\n", floatvar);   // 89.95 = 89.949997
      printf("89.95 = %lf\n", doublevar); // 89.95 = 89.949997
   }
```
