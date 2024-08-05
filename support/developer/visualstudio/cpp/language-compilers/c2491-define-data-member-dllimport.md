---
title: C2491 error when defining data as dllimport
description: Describes that you receive a Compiler C2491 error message when you try to define data members as dllimport functions.
ms.date: 04/20/2020
ms.custom: sap:Language or Compilers\C++
---
# Compiler C2491 error when you try to define data members as dllimport functions

This article helps you resolve the compiler C2491 error that occurs when you try to define data members as `dllimport` functions.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 815647

## Symptom

You cannot apply the `__declspec(dllimport)` keyword to implement a function. For example, when you try to define data members (including static data members and functions) as `dllimport` functions, you receive the following compiler C2491 error message:

> 'identifier' : definition of dllimport function not allowed

## Cause and resolution

You can only apply the `__declspec(dllimport)` keyword to declarations. You cannot apply the `__declspec(dllimport)` keyword to implement functions. The purpose of this keyword is to declare the implementation of a function by a DLL. Similarly, if you apply the `__declspec(dllimport)` keyword to a data member, you receive the initial data from a DLL. Therefore, you can't assign a value in your code initially.

You receive the compiler C2491 error when you try to compile the following code:

```cpp
// function definition
void __declspec(dllimport) funcB() 
{
    // error C2491: 'funcB' : definition of dllimport function not allowed
}
```

This behavior occurs because you defined the function implementation as `dllimport`. To avoid this compiler error, don't define the function, but instead declare the function as follows:

```cpp
// function declaration
void __declspec(dllimport) funcB(); // ok
int main()
{
}
```

Similarly, you receive the compiler C2491 error when you try to compile the following code:

```cpp
//defining data member
extern __declspec(dllimport) int code = 1;
// error C2491: 'code' : definition of dllimport data not allowed
```

You receive this error message because you defined the data member as `dllimport`. To avoid this compiler error, don't define the data member, but instead declare the data member as follows:

```cpp
// declaring data member
extern __declspec(dllimport) int code; // ok
```
