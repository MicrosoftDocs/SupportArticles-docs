---
title: Use list STL functions in Visual C++
description: Describes how to use the [list::remove, list::remove_if] STL function(s) in Visual C++. There are some differences in the implementation of the Standard C++ Library components in Visual C++ version 4.2 versus later revisions.
ms.date: 04/27/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.reviewer: rodneyr, anbrad
ms.topic: how-to
---
# Use the list::remove, list::remove_if STL functions in Visual C++

This article provides information that how to use the `list::remove`, `list::remove_if` STL functions in Visual C++.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 168047

## Summary

The sample code below illustrates how to use the `list::remove`, `list::remove_if` STL function(s) in Visual C++.

> [!NOTE]
> There are some differences in the implementation of the Standard C++ Library components in Visual C++ version 4.2 versus later revisions. The relevant sections of code below compile conditionally based upon the value of `_MSC_VER`.

## Required header

```cpp
<list>
<string>
<iostream>
```

## Prototype

```cpp
void remove(const T& x);
void remove_if(binder2nd< not_equal_to<T> > pr);
```

> [!NOTE]
> The class/parameter names in the prototype may not match the version in the header file. Some have been modified to improve readability.

## Description

This example shows how to use `list::remove` and `list::remove_if`. It also shows how to use `list::remove_if` with your own function.

## Sample code

```cpp
//////////////////////////////////////////////////////////////////////
// Compile options needed: -GX
// remove.cpp : This example shows how to use list::remove and
// list::remove_if. It also shows how to use
// list::remove_if with your own function.
// Functions:
// list::remove
// list::remove_if
// Copyright (c) 1996 Microsoft Corporation. All rights reserved.
//////////////////////////////////////////////////////////////////////

#pragma warning(disable:4786) // disable spurious C4786 warnings

#include <list>
#include <string>
#include <iostream>
using namespace std;

#if _MSC_VER > 1020 // if later than revision 4.2
    using namespace std; // std c++ libs are implemented in std
#endif

typedef list<string, allocator<string> > LISTSTR;

// Used to customize list::remove_if()
class is_four_chars
    : public not_equal_to<string>
{
    bool operator()(const string& rhs, const string&) const
    { return rhs.size() == 4; }
};

void main()
{
    LISTSTR test;
    LISTSTR::iterator i;

    test.push_back("good");
    test.push_back("bad");
    test.push_back("ugly");

    // good bad ugly
    for (i = test.begin(); i != test.end(); ++i)
        cout << *i << " ";
    cout << endl;

    test.remove("bad");

    // good ugly
    for (i = test.begin(); i != test.end(); ++i)
        cout << *i << " ";
    cout << endl;

    // remove any not equal to "good"
    test.remove_if(binder2nd<not_equal_to<string> >
        (not_equal_to<string>(), "good"));

    // good
    for (i = test.begin(); i != test.end(); ++i)
        cout << *i << " ";
    cout << endl;

    // Remove any strings that are four characters long
    test.remove_if(binder2nd<not_equal_to<string> >
        (is_four_chars(), "useless parameter"));

    if (test.empty())
        cout << "Empty list\n";
}
```

### Program output

```console
good bad ugly
good ugly
good
Empty list
```

## References

For more information about `list::remove` and `list::remove_if`, visit the following web sites:

- [list::remove (STL/CLR)](/previous-versions/bb386133(v=vs.140))
- [list::remove_if (STL/CLR)](/previous-versions/bb398083(v=vs.140))
