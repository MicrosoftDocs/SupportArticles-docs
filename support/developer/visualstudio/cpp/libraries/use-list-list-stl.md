---
title: "Use the list::list function in Visual C++"
description: "Describes how to use the list::list STL functions in Visual C++. This article also provides a code sample to show how to do this task."
ms.date: 04/24/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.topic: how-to
---
# Use the list::list STL function in Visual C++

This article illustrates how to use the `list::list` STL function in Visual C++.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 158091

## Required header

```cpp
<list>
```

## Prototype

```cpp
explicit list(const A& al = A());
explicit list(size_type n, const T& v = T(), const A& al = A());
list(const list& x);
list(const_iterator first, const_iterator last, const A& al = A());
```

> [!NOTE]
> The class/parameter names in the prototype may not match the version in the header file. Some have been modified to improve readability.

## Description

The first constructor specifies an empty initial controlled sequence. The second constructor specifies a repetition of `n` elements of value `x`. The third constructor specifies a copy of the sequence controlled by `x`. The last constructor specifies the sequence (`first`, `last`). All constructors store the allocator object `al`, or for the copy constructor, `x.get_allocator()`, in allocator and initialize the controlled sequence.

## Sample code

```cpp
//////////////////////////////////////////////////////////////////////
// Compile options needed: -GX
// list.cpp : demonstrates the different constructors for list<T>
// Functions:
//    list::list
// Copyright (c) 1996 Microsoft Corporation. All rights reserved.
//////////////////////////////////////////////////////////////////////

#include <list>
#include <string>
#include <iostream>

#if _MSC_VER > 1020   // if VC++ version is > 4.2
   using namespace std;  // std c++ libs implemented in std
   #endif

typedef list<string, allocator<string> > LISTSTR;

// Try each of the four constructors
void main()
{
    LISTSTR::iterator i;
    LISTSTR test;                   // default constructor
    test.insert(test.end(), "one");
    test.insert(test.end(), "two");
    LISTSTR test2(test);            // construct from another list
    LISTSTR test3(3, "three");      // add several <T>'s
    LISTSTR test4(++test3.begin(),  // add part of another list
             test3.end());
    // Print them all out
    // one two
    for (i =  test.begin(); i != test.end(); ++i)
        cout << *i << " ";
    cout << endl;
    // one two
    for (i =  test2.begin(); i != test2.end(); ++i)
        cout << *i << " ";
    cout << endl;
    // three three three
    for (i =  test3.begin(); i != test3.end(); ++i)
        cout << *i << " ";
    cout << endl;
    // three three
    for (i =  test4.begin(); i != test4.end(); ++i)
        cout << *i << " ";
    cout << endl;
}
```

Program output is:

```console
one two
one two
three three three
three three
```
