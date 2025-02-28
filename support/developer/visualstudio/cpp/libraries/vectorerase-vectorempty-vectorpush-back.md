---
title: Use vector STL functions in Visual C++
description: Describes how to use the vector::erase, vector::empty, and vector::push_back STL functions in Visual C++. This article also provides a code sample to show how to perform this task.
ms.date: 04/22/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.topic: how-to
---
# Use the vector::erase, vector::empty, and vector::push_back STL functions in Visual C++

This article illustrates how to use the `vector::erase` function, the `vector::empty` function, and the `vector::push_back` Standard Template Library (STL) functions in Visual C++. The information applies only to unmanaged Visual C++ code.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 158612

## Required header

```cpp
<vector>
```

## Prototypes

```cpp
template<class _TYPE, class _A>
void vector::push_back(const _TYPE& X);

template<class _TYPE, class _A>
iterator vector::erase(iterator Iterator);

template<class _TYPE, class _A>
iterator vector::erase(iterator First, iterator Last);

template<class _TYPE, class _A>
bool vector::empty() const;
```

> [!NOTE]
> The class/parameter names in the prototype may not match the version in the header file. Some have been modified to improve readability.

## Description

The sample declares an empty vector of integers. It adds 10 integers to the vector, then displays the contents of the vector. It deletes the sixth element by using erase, and then displays the contents of the vector again. It deletes the rest of the elements using a different form of erase, then displays the vector (now empty) again. The `ShowVector` routine uses the empty function to determine whether to generate the contents of the vector.

## Sample code

In Visual C++ .NET and in Visual C++, **/EHsc** is set by default and is equivalent to **/GX**.

> [!NOTE]
> In Visual C++, you must change the code from
 `const ARRAY_SIZE = 10;` to
 `const int ARRAY_SIZE = 10;` if you want to run the sample code.

```cpp
//////////////////////////////////////////////////////////////////////
// Compile options needed: /GX
// Empty.cpp -- Illustrates the vector::empty and vector::erase
// functions.
// Also demonstrates the vector::push_back function.
// Functions:
// vector::empty - Returns true if vector has no elements.
// vector::erase - Deletes elements from a vector (single & range).
// vector::begin - Returns an iterator to start traversal of the
// vector.
// vector::end - Returns an iterator for the last element of the
// vector.
// vector::push_back - Appends (inserts) an element to the end of a
// vector, allocating memory for it if necessary.
// vector::iterator - Traverses the vector.
// of Microsoft Corporation
// Copyright (c) 1996 Microsoft Corporation. All rights reserved.
//////////////////////////////////////////////////////////////////////
// The debugger can't handle symbols more than 255 characters long.
// STL often creates symbols longer than that.
// When symbols are longer than 255 characters, the warning is disabled.
#pragma warning(disable:4786)

#include <iostream>
#include <vector>

#if _MSC_VER > 1020 // if VC++ version is > 4.2
    using namespace std; // std c++ libs implemented in std
#endif

typedef vector<int, allocator<int> > INTVECTOR;

const ARRAY_SIZE = 10;

void ShowVector(INTVECTOR &theVector);

void main()
{
     // Dynamically allocated vector begins with 0 elements.
     INTVECTOR theVector;

     // Intialize the vector to contain the numbers 0-9.
     for (int cEachItem = 0; cEachItem < ARRAY_SIZE; cEachItem++)
         theVector.push_back(cEachItem);

     // Output the contents of the dynamic vector of integers.
     ShowVector(theVector);

     // Using void iterator erase(iterator Iterator) to
     // delete the 6th element (Index starts with 0).
     theVector.erase(theVector.begin() + 5);

     // Output the contents of the dynamic vector of integers.
     ShowVector(theVector);

     // Using iterator erase(iterator First, iterator Last) to
     // delete a range of elements all at once.
     theVector.erase(theVector.begin(), theVector.end());

     // Show what's left (actually, nothing).
     ShowVector(theVector);
}

// Output the contents of the dynamic vector or display a
// message if the vector is empty.
void ShowVector(INTVECTOR &theVector)
{
     // First see if there's anything in the vector. Quit if so.
     if (theVector.empty())
     {
         cout << endl << "theVector is empty." << endl;
         return;
     }

     // Iterator is used to loop through the vector.
     INTVECTOR::iterator theIterator;

     // Output contents of theVector.
     cout << endl << "theVector [ " ;
     for (theIterator = theVector.begin(); theIterator != theVector.end();
     theIterator++)
     {
         cout << *theIterator;
         if (theIterator != theVector.end()-1) cout << ", ";
         // cosmetics for the output
     }
     cout << " ]" << endl ;
}
```

Program output:

```console
theVector [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
theVector [ 0, 1, 2, 3, 4, 6, 7, 8, 9 ]
theVector is empty.
```

## References

[vector::empty, vector::erase, and vector::push_back](/previous-versions/b6ezyw32(v=vs.140))
