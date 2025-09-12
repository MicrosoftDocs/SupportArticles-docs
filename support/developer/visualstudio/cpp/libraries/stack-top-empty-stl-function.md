---
title: "Use stack::top and stack::empty STL functions"
description: "Introduces how to use the stack::top and stack::empty STL functions in Visual C++."
ms.date: 04/27/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.reviewer: derekj
ms.topic: how-to
---
# Use stack::top and stack::empty STL functions in Visual C++

This article illustrates how to use the `stack::top` and `stack::empty` STL functions in Visual C++. The information in this article applies only to unmanaged Visual C++ code.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 158040

## Required header

- `<stack>`

## Prototype

```cpp
template <class _TYPE, class _C, class _A> // Function 1
value_type &stack::top();

template <class _TYPE, class _C, class _A> // Function 2
const value_type &stack::top() const;

template <class _TYPE, class _C, class _A> // Function 3
bool stack::empty() const;
```

> [!NOTE]
> The class or parameter names in the prototype may not match the version in the header file. Some have been modified to improve readability.

## Description of stack::top and stack::empty functions

The `top` function returns the topmost element of the stack. You should ensure that there are one or more elements on the stack before calling the `top` function. The first version of the `top` function returns a reference to the element of the top of the stack, allowing you to modify the value. The second function returns a constant reference, ensuring that you don't accidentally modify the stack.

The `empty` function returns **true** if there are no elements in the stack. If there are one or more elements, the function will return **false**. You should use the `empty` function to verify that there are elements left on the stack before calling the `top` function.

## Sample code

```cpp
//////////////////////////////////////////////////////////////////////
// Compile options needed: /GX
// StackTop&Empty.cpp : Illustrates how to use the top function to
// retrieve the last element of the controlled
// sequence. It also illustrates how to use the
// empty function to loop though the stack.
// Functions:
// top : returns the top element of the stack.
// empty : returns true if the stack has 0 elements.
// Copyright (c) 1996 Microsoft Corporation. All rights reserved.
//////////////////////////////////////////////////////////////////////

#pragma warning(disable : 4786)

#include <stack>
#include <iostream>

#if _MSC_VER > 1020  // if VC++ version is > 4.2
    using namespace std; // std c++ libs implemented in std
#endif

typedef stack<int, deque<int>> STACK_INT;
void main()
{
    STACK_INT stack1;
    cout << "stack1.empty() returned " <<
        (stack1.empty() ? "true" : "false") << endl; // Function 3
    cout << "stack1.push(2)" << endl;
    stack1.push(2);

    if (!stack1.empty()) // Function 3
        cout << "stack1.top() returned " << stack1.top() << endl; // Function 1
    cout << "stack1.push(5)" << endl;
    stack1.push(5);

    if (!stack1.empty()) // Function 3
        cout << "stack1.top() returned " << stack1.top() << endl; // Function 1
    cout << "stack1.push(11)" << endl;
    stack1.push(11);

    if (!stack1.empty()) // Function 3
        cout << "stack1.top() returned " << stack1.top() << endl; // Function 1

    // Modify the top item. Set it to 6.
    if (!stack1.empty())
    { // Function 3
        cout << "stack1.top()=6;" << endl;
        stack1.top() = 6; // Function 1
    }

    // Repeat until stack is empty
    while (!stack1.empty())            // Function 3
    {
        const int &t = stack1.top(); // Function 2
        cout << "stack1.top() returned " << t << endl;
        cout << "stack1.pop()" << endl;
        stack1.pop();
    }
}
```
