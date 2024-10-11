---
title: Use map STL functions in Visual C++
description: This article provides a sample code to show how to use the map::end, map::find, map::insert, map::iterator, and map::value_type STL functions in Visual C++.
ms.date: 04/24/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.topic: how-to
---
# Use the map::end, map::find, map::insert, map::iterator, and map::value_type STL functions in Visual C++

This article illustrates how to use the `map::end`, `map::find`, `map::insert`, `map::iterator`, and `map::value_type` Standard Template Library (STL) symbols in Visual C++.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 157159

## Required header

```cpp
<map>
```

## Prototypes

```cpp
iterator map::end();

// Key is the data type of template argument #1 for map
iterator map::find(const Key& key);
pair<iterator, bool> map::insert(const value_type& x);
```

> [!NOTE]
> The class/parameter names in the prototypes may not match the version in the header file. Some have been modified to improve readability.

## Description

The `end()` function returns an iterator that points one past the end of a sequence.

Find returns an iterator that chooses the first element whose sort key equals `key`. If no such element exists, the iterator equals `end()`.

If the key doesn't already exist, `insert` will add it to the sequence and return `pair<iterator, true>`. If the key already exists, `insert` doesn't add it to the sequence and returns `pair <iterator, false>`.

The following sample creates a map of ints to strings. In this case, the mapping is from digits to their string equivalents (1 -> One, 2 -> Two, and so on.).

The program reads a number from the user, finds the word equivalent for each digit (using the map), and prints the number back as a series of words. For example, if the user enters *25463*, the program responds with: **Two Five Four Six Three**.

## Sample code

```cpp
//////////////////////////////////////////////////////////////////////
// Compile options needed: None
// <filename> : main.cpp
// Functions:
// end
// find
// insert
// of Microsoft Product Support Services,
// Copyright (c) 1996 Microsoft Corporation. All rights reserved.
//////////////////////////////////////////////////////////////////////
// disable warning C4018: '<' : signed/unsigned mismatch
// okay to ignore

#pragma warning(disable: 4018)

#pragma warning(disable:4786)
#include <iostream>
#include <string>
#include <map>
using namespace std;

typedef map<int, string, less<int>, allocator<string> > INT2STRING;
void main()
{
    // 1. Create a map of ints to strings
    INT2STRING theMap;
    INT2STRING::iterator theIterator;
    string theString = "";
    int index;
    // Fill it with the digits 0 - 9, each mapped to its string counterpart
    // Note: value_type is a pair for maps...
    theMap.insert(INT2STRING::value_type(0,"Zero"));
    theMap.insert(INT2STRING::value_type(1,"One"));
    theMap.insert(INT2STRING::value_type(2,"Two"));
    theMap.insert(INT2STRING::value_type(3,"Three"));
    theMap.insert(INT2STRING::value_type(4,"Four"));
    theMap.insert(INT2STRING::value_type(5,"Five"));
    theMap.insert(INT2STRING::value_type(6,"Six"));
    theMap.insert(INT2STRING::value_type(7,"Seven"));
    theMap.insert(INT2STRING::value_type(8,"Eight"));
    theMap.insert(INT2STRING::value_type(9,"Nine"));
    // Read a Number from the user and print it back as words
    for( ; ; )
    {
       cout << "Enter \"q\" to quit, or enter a Number: ";
       cin >> theString;
       if(theString == "q")
           break;
       // extract each digit from the string, find its corresponding
       // entry in the map (the word equivalent) and print it
       for(index = 0; index < theString.length(); index++){
           theIterator = theMap.find(theString[index] - '0');
           if(theIterator != theMap.end()) // is 0 - 9
               cout << (*theIterator).second << " ";
           else // some character other than 0 - 9
               cout << "[err] ";
       }
       cout << endl;
    }
}
```

Program output:

```console
Enter "q" to quit, or enter a Number: 22
Two Two
Enter "q" to quit, or enter a Number: 33
Three Three
Enter "q" to quit, or enter a Number: 456
Four Five Six
Enter "q" to quit, or enter a Number: q
```

## References

For the same information about `map::end`, `map::find`, and `map::insert`, visit [map::insert, map::find, and map::end](/previous-versions/visualstudio/visual-studio-2010/wwcahb6y(v%3dvs.100)).
