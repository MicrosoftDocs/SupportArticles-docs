---
title: Use priority_queue STL functions
description: This article describes how to use the priority_queue::push, priority_queue::pop, priority_queue::empty, priority_queue::top, and priority_queue::size STL functions in Visual C++.
ms.date: 04/24/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.topic: how-to
---
# Use priority_queue::(push, pop, empty, top) STL functions in Visual C++

This article helps you resolve the problem where how to use the `priority_queue::push`, `priority_queue::pop`, `priority_queue::empty`, `priority_queue::top`, and `priority_queue::size` STL functions in Visual C++.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 157623

## Summary

The sample code below illustrates how to use the `priority_queue::push`, `priority_queue::pop`, `priority_queue::empty`, `priority_queue::top`, and `priority_queue::size` STL functions in Visual C++.

The `priority_queue` adapter holds objects of the type defined by the type of container supported by the `priority_queue`. The two containers supported are the `vector` and the `deque`. Objects are inserted by `push()` and removed by `pop()`. `top()` returns the top item in the `priority_queue`.

Since adapters do not support iteration, a `priority_queue` has no associated iterator.

`Priority_queue` allows you to maintain a sorted collection of items determined by an associated comparator function, such as less, greater, etc. The top item therefore becomes the candidate of choice, lowest or highest based on the function chosen.

## Required header

```cpp
<queue>
```

## Prototype

```cpp
priority_queue::push();
priority_queue::pop();
priority_queue::empty();
priority_queue::top();
priority_queue::size();
```

> [!NOTE]
> The class/parameter names in the prototype may not match the version in the header file. Sme have been modified to improve readability.

## Sample code

The sample shows `priority_queue`implementation using `deque` and `vector` containers.

```cpp
//////////////////////////////////////////////////////////////////////
// Compile options needed: /GX
// <filename> : priority_queue.cpp
// Functions:
// priority_queue::push(), priority_queue::pop(),
// priority_queue::empty(), priority_queue::top(), queue::size()
// of Microsoft Product Support Services,
// Copyright (c) 1996 Microsoft Corporation. All rights reserved.
//////////////////////////////////////////////////////////////////////

#include <iostream>
#include <queue>
#include <deque>
#include <vector>
#include <functional>
using namespace std;

#if _MSC_VER > 1020 // if VC++ version is > 4.2
    using namespace std; // std c++ libs implemented in std
#endif

// Using priority_queue with deque
// Use of function greater sorts the items in ascending order
typedef deque<int, allocator<int> > INTDQU;
typedef priority_queue<int,INTDQU, greater<int> > INTPRQUE;

// Using priority_queue with vector
// Use of function less sorts the items in descending order
typedef vector<char, allocator<char> > CHVECTOR;
typedef priority_queue<char,CHVECTOR,less<char> > CHPRQUE;

void main(void)
{
    int size_q;
    INTPRQUE q;
    CHPRQUE p;

    // Insert items in the priority_queue(uses deque)
    q.push(42);
    q.push(100);
    q.push(49);
    q.push(201);

    // Output the item at the top using top()
    cout << q.top() << endl;
    // Output the size of priority_queue
    size_q = q.size();
    cout << "size of q is:" << size_q << endl;
    // Output items in priority_queue using top()
    // and use pop() to get to next item until
    // priority_queue is empty
    while (!q.empty())
    {
        cout << q.top() << endl;
        q.pop();
    }

    // Insert items in the priority_queue(uses vector)
    p.push('c');
    p.push('a');
    p.push('d');
    p.push('m');
    p.push('h');

    // Output the item at the top using top()
    cout << p.top() << endl;

    // Output the size of priority_queue
    size_q = p.size();
    cout << "size of p is:" << size_q << endl;

    // Output items in `priority_queue`using top()
    // and use pop() to get to next item until
    // `priority_queue`is empty
    while (!p.empty())
    {
        cout << p.top() << endl;
        p.pop();
    }
}
```

Program output:

```console
4
size of q is:4
42
49
100
201
m
size of p is:5
m
h
d
c
a
```
