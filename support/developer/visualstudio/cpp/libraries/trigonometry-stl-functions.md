---
title: Trigonometry STL functions in Visual C++
description: This article illustrates how to use the acos, asin, atan, atan2, cos, cosh, sin, sinh, tan, and tanh STL functions in Visual C++.
ms.date: 04/27/2020
ms.custom: sap:C and C++ Libraries
ms.topic: how-to
---
# Use trigonometry STL functions in Visual C++

The sample code below illustrates how to use the STL `acos`, `asin`, `atan`, `atan2`, `cos`, `cosh`, `sin`, `sinh`, `tan`, `tanh` functions in Visual C++. The information in this article applies to unmanaged Visual C++ code only.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 157950

## Required header

- `<valarray>`
- `<cmath>`

## Prototype

```cpp
// acos
template <class T>
inline valarray<T> acos(const valarray<T> &x);

// asin
template <class T>
inline valarray<T> asin(const valarray<T> &x);

// atan
template <class T>
inline valarray<T> atan(const valarray<T> &x);

// atan2
template <class T>
inline valarray<T> atan2(const valarray<T> &x, const valarray<T> &y);

template <class T>
inline valarray<T> atan2(const valarray<T> x, const T &y);

template <class T>
inline valarray<T> atan2(const T &x, const valarray<T> &y);

// cos
template <class T>
inline valarray<T> cos(const valarray<T> &x);

// cosh
template <class T>
inline valarray<T> cosh(const valarray<T> &x);

// sin
template <class T>
inline valarray<T> sin(const valarray<T> &x);

// sinh
template <class T>
inline valarray<T> sinh(const valarray<T> &x);

// tan
template <class T>
inline valarray<T> tan(const valarray<T> &x);

// tanh
template <class T>
inline valarray<T> tanh(const valarray<T> &x);
```

> [!NOTE]
> The class or parameter names in the prototype may not match the version in the header file. Some have been modified to improve readability.

## Sample code

This article illustrates the use of STL trigonometry functions through the following sample code.

```cpp
//////////////////////////////////////////////////////////////////////
// Compile options needed: /GX
// main.cpp : Illustrates the use of STL trigonometry functions.
// Functions:
// acos, asin, atan, atan2, cos, cosh, sin, sinh, tan, tanh
// Copyright (c) 1996 Microsoft Corporation. All rights reserved.
//////////////////////////////////////////////////////////////////////

#include <iostream> // for i/o functions
#include <valarray> // for valarray
#include <cmath>    // for trigonometry functions

#if _MSC_VER > 1020  // if VC++ version is > 4.2
using namespace std; // std c++ libs implemented in std
#endif

#define ARRAY_SIZE 3 // array size
void main()
{
    // Initialize val_array to values -1, 0 and 1.
    valarray<double> val_array(ARRAY_SIZE);
    for (int i = 0; i < ARRAY_SIZE; i++)
        val_array[i] = i - 1;

    // Display the size of val_array.
    cout << "Size of val_array = " << val_array.size() << endl;

    // Display the values of val_array before calling any trigonometry
    // functions.
    cout << "The values in val_array:" << endl;
    for (i = 0; i < ARRAY_SIZE; i++)
        cout << val_array[i] << " ";
    cout << endl << endl;

    // Initialize rev_valarray that is the reverse of val_array.
    valarray<double> rev_valarray(ARRAY_SIZE);
    for (i = 0; i < ARRAY_SIZE; i++)
        rev_valarray[i] = val_array[ARRAY_SIZE - i - 1];

    // Display the size of rev_valarray.
    cout << "Size of rev_valarray = " << rev_valarray.size() << endl;

    // Display the values of rev_valarray.
    cout << "The values in rev_valarray:" << endl;
    for (i = 0; i < ARRAY_SIZE; i++)
        cout << rev_valarray[i] << " ";
    cout << endl << endl;

    // rvalue_array to hold the return value from calling the trigonometry
    // functions.
    valarray<double> rvalue_array;

    // acos() - display the result of rvalue_array
    rvalue_array = acos(val_array);
    cout << "The result after calling acos():" << endl;
    for (i = 0; i < ARRAY_SIZE; i++)
        cout << rvalue_array[i] << " ";
    cout << endl << endl;

    // asin() - display the result of rvalue_array
    rvalue_array = asin(val_array);
    cout << "The result after calling asin():" << endl;
    for (i = 0; i < ARRAY_SIZE; i++)
        cout << rvalue_array[i] << " ";
    cout << endl << endl;

    // atan() - display the result of rvalue_array
    rvalue_array = atan(val_array);
    cout << "The result after calling atan():" << endl;
    for (i = 0; i < ARRAY_SIZE; i++)
        cout << rvalue_array[i] << " ";
    cout << endl << endl;

    // atan2() - display the result of rvalue_array

    // This template function returns an object of class valarray<T>,
    // each of whose elements at I is the arctangent of x[I] / y[I].
    rvalue_array = atan2(val_array, rev_valarray);
    cout << "The result after calling atan2(val_array, rev_valarray):"
         << endl;
    for (i = 0; i < ARRAY_SIZE; i++)
        cout << rvalue_array[i] << " ";
    cout << endl << endl;

    // This template function stores in element I the arctangent of
    // x[I] / y.
    rvalue_array = atan2(val_array, 3.1416);
    cout << "The result after calling atan2(val_array, 3.1416):" << endl;
    for (i = 0; i < ARRAY_SIZE; i++)
        cout << rvalue_array[i] << " ";
    cout << endl << endl;

    // This template function stores in element I the arctangent of
    // x / y[I].
    rvalue_array = atan2(3.1416, val_array);
    cout << "The result after calling atan2(3.1416, val_array):" << endl;
    for (i = 0; i < ARRAY_SIZE; i++)
        cout << rvalue_array[i] << " ";
    cout << endl << endl;

    // cos() - display the result of rvalue_array
    rvalue_array = cos(val_array);
    cout << "The result after calling cos():" << endl;
    for (i = 0; i < ARRAY_SIZE; i++)
        cout << rvalue_array[i] << " ";
    cout << endl << endl;

    // cosh() - display the result of rvalue_array
    rvalue_array = cosh(val_array);
    cout << "The result after calling cosh():" << endl;
    for (i = 0; i < ARRAY_SIZE; i++)
        cout << rvalue_array[i] << " ";
    cout << endl << endl;

    // sin() - display the result of val_array
    rvalue_array = sin(val_array);
    cout << "The result after calling sin():" << endl;
    for (i = 0; i < ARRAY_SIZE; i++)
        cout << rvalue_array[i] << " ";
    cout << endl << endl;

    // sinh() - display the result of val_array
    rvalue_array = sinh(val_array);
    cout << "The result after calling sinh():" << endl;
    for (i = 0; i < ARRAY_SIZE; i++)
        cout << rvalue_array[i] << " ";
    cout << endl << endl;

    // tan() - display the result of val_array
    rvalue_array = tan(val_array);
    cout << "The result after calling tan():" << endl;
    for (i = 0; i < ARRAY_SIZE; i++)
        cout << rvalue_array[i] << " ";
    cout << endl << endl;

    // tanh() - display the result of val_array
    rvalue_array = tanh(val_array);
    cout << "The result after calling tanh():" << endl;
    for (i = 0; i < ARRAY_SIZE; i++)
        cout << rvalue_array[i] << " ";
    cout << endl << endl;
}
```

## Program output

```console
Size of val_array = 3
The values in val_array:
-1 0 1

Size of rev_valarray = 3
The values in rev_valarray:
1 0 -1

The result after calling acos():
3.14159 1.5708 0

The result after calling asin():
-1.5708 0 1.5708

The result after calling atan():
-0.785398 0 0.785398

The result after calling atan2(val_array, rev_valarray):
-0.785398 0 2.35619

The result after calling atan2(val_array, 3.1416):
-0.308168 0 0.308168

The result after calling atan2(3.1416, val_array):
1.87896 1.5708 1.26263

The result after calling cos():
0.540302 1 0.540302

The result after calling cosh():
1.54308 1 1.54308

The result after calling sin():
-0.841471 0 0.841471

The result after calling sinh():
-1.1752 0 1.1752

The result after calling tan():
-1.55741 0 1.55741

The result after calling tanh():
-0.761594 0 0.761594
```
