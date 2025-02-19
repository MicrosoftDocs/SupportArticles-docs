---
title: "Use the set::find function in Visual C++"
description: "Describes how to use the set::find STL function in Visual C++. This article includes a sample code."
ms.date: 04/27/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.topic: how-to
---
# Use the set::find STL function in Visual C++

This article illustrates how to use the `set::find` Standard Template Library (STL) function in Visual C++.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 158576

## Required header

```cpp
<set>
```

## Prototype

```cpp
template<class _K, class _Pr, class _A>
class set
{
    public:
    // Function 1:

    const_iterator find(const _K& _Kv) const;
}
```

> [!NOTE]
> The class/parameter names in the prototype may not match the version in the header file. Some have been modified to improve readability.

## Description of the set::find function

The `find` function is used to locate an element in a controlled sequence. It returns an iterator to the first element in the controlled sequence whose sort key matches its parameter. If no such element exists, the returned iterator equals `end()`.

## Sample code

> [!NOTE]
> In Visual C++ .NET and in Visual C++, **/EHsc** is set by default and is equivalent to **/GX**.

```cpp
//////////////////////////////////////////////////////////////////////
// Compile options needed: -GX
// SetFind.cpp:
//      Illustrates how to use the find function to get an iterator
//      that points to the first element in the controlled sequence
//      that has a particular sort key.
// Functions:
//    find         Returns an iterator that points to the first element
//                 in the controlled sequence that has the same sort key
//                 as the value passed to the find function. If no such
//                 element exists, the iterator equals end().
// Copyright (c) 1996 Microsoft Corporation. All rights reserved.
//////////////////////////////////////////////////////////////////////

#pragma warning(disable:4786)
#include <set>
#include <iostream>
#if _MSC_VER > 1020   // if VC++ version is > 4.2
   using namespace std;  // std c++ libs implemented in std
#endif
typedef set<int,less<int>,allocator<int> > SET_INT;

void truefalse(int x)
{
  cout << (x?"True":"False") << endl;
}
void main()
{
  SET_INT s1;
  cout << "s1.insert(5)" << endl;
  s1.insert(5);
  cout << "s1.insert(8)" << endl;
  s1.insert(8);
  cout << "s1.insert(12)" << endl;
  s1.insert(12);

  SET_INT::iterator it;
  cout << "it=find(8)" << endl;
  it=s1.find(8);
  cout << "it!=s1.end() returned ";
  truefalse(it!=s1.end());  //  True

  cout << "it=find(6)" << endl;
  it=s1.find(6);
  cout << "it!=s1.end() returned ";
  truefalse(it!=s1.end());  // False
}
```

### Program output

```console
s1.insert(5)
s1.insert(8)
s1.insert(12)
it=find(8)
it!=s1.end() returned True
it=find(6)
it!=s1.end() returned False
```
