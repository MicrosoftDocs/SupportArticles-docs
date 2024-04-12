---
title: Use member functions of the STL queue class
description: Provides a Visual C++ code example that demonstrates how to use the STL queue class.
ms.date: 04/27/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.topic: how-to
---
# Use the member functions of the STL queue class in Visual C++

The sample code below illustrates how to use the `queue::push`, `queue::pop`, `queue::empty`, `queue::back`, `queue::front`, and `queue::size` STL functions in Visual C++. The information in this article applies to unmanaged Visual C++ code only.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 157622

## Summary

The `queue` adapter holds objects of the type defined by the type of container supported by the `queue`. The two containers supported are the `list` and the `deque`. Objects are inserted by `push()` and removed by `pop()`. `front()` returns the oldest item in the `queue` (also known as FIFO), and `back()` returns the latest item inserted in the `queue`.

## Required header

- `<queue>`

## Prototypes

```cpp
queue::push();
queue::pop();
queue::empty();
queue::back();
queue::front();
queue::size();
```

> [!NOTE]
> The class or parameter names in the prototypes may not match the version in the header file. Some have been modified to improve readability.

## Sample code

The sample shows queue implementation using `list` and `deque` containers.

```cpp
//////////////////////////////////////////////////////////////////////
// Compile options needed: none
// <filename> : queue.cpp
// Functions:
// queue::push(), queue::pop(), queue::empty(), queue::back(),
// queue::front(),queue::size()
// Copyright (c) 1996 Microsoft Corporation. All rights reserved.
//////////////////////////////////////////////////////////////////////

/* Compile options needed: /GX */
#include <list>
#include <iostream>
#include <queue>
#include <deque>
using namespace std;

#if _MSC_VER > 1020  // if VC++ version is > 4.2
    using namespace std; // std c++ libs implemented in std
#endif

// Using queue with list
typedef list<int, allocator<int>> INTLIST;
typedef queue<int, INTLIST> INTQUEUE;

// Using queue with deque
typedef deque<char *, allocator<char *>> CHARDEQUE;
typedef queue<char *, CHARDEQUE> CHARQUEUE;
void main(void)
{
    int size_q;
    INTQUEUE q;
    CHARQUEUE p;

    // Insert items in the queue(uses list)
    q.push(42);
    q.push(100);
    q.push(49);
    q.push(201);

    // Output the item inserted last using back()
    cout << q.back() << endl;

    // Output the size of queue
    size_q = q.size();
    cout << "size of q is:" << size_q << endl;

    // Output items in queue using front()
    // and use pop() to get to next item until
    // queue is empty
    while (!q.empty())
    {
        cout << q.front() << endl;
        q.pop();
    }

    // Insert items in the queue(uses deque)
    p.push("cat");
    p.push("ape");
    p.push("dog");
    p.push("mouse");
    p.push("horse");

    // Output the item inserted last using back()
    cout << p.back() << endl;

    // Output the size of queue
    size_q = p.size();
    cout << "size of p is:" << size_q << endl;

    // Output items in queue using front()
    // and use pop() to get to next item until
    // queue is empty
    while (!p.empty())
    {
        cout << p.front() << endl;
        p.pop();
    }
}
```

## Program output

```console
201
size of q is:4
42
100
49
201
horse
size of p is:5
cat
ape
dog
mouse
horse
```

## References

For the same information about member functions of the STL `queue` class, see [queue](/previous-versions/z8dd0cek%28v%3dvs.140%29).
