---
title: Declare an array of pointers to functions in C++
description: Describes how to build an array that contains function addresses and call those functions in Visual C++.
ms.date: 04/22/2020
ms.reviewer: markm
ms.topic: how-to
ms.custom: sap:Language or Compilers\C++
---
# Declare an array of pointers to functions in Visual C++

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 30580

This article introduces how to declare an array of pointers to functions in Visual C++. The information in this article applies only to unmanaged Visual C++ code.

The sample code below demonstrates building an array that contains function addresses and calling those functions.

```cpp
/*
 * Compile options needed: none
 */

#include <stdio.h>

void test1();
void test2();            /*  Prototypes */
void test3();

/* array with three functions */
void (*functptr[])() = { test1, test2, test3 } ;

void main()
{
   (*functptr[0])();    /*  Call first function  */
   (*functptr[1])();    /*  Call second function */
   (*functptr[2])();    /*  Call third function  */
}

void test1()
{
   printf("hello 0\n");
}

void test2()
{
   printf("hello 1\n");
}

void test3()
{
   printf("hello 2\n");
}
```
