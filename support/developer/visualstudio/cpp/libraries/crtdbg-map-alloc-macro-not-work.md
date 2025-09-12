---
title: _CRTDBG_MAP_ALLOC macro doesn't work
description: This article explains that allocation is reported as occurring in the Crtdbg.h file on line 512 when an object is allocated by using the new operator and is dumped by using the debugging routines in the C Run-Time Library.
ms.date: 04/22/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.reviewer: kayda
---
# The _CRTDBG_MAP_ALLOC macro doesn't work as expected

This article helps you resolve the problem that allocation is reported as occurring in the *Crtdbg.h* file when an object is allocated by the `new` operator and is dumped by the debugging routines in the C Run-Time Library.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 140858

## Symptoms

When an object is allocated through use of the `new` operator and dumped through use of the debugging routines in the C Run-Time Library, the allocation is reported as occurring in the *Crtdbg.h* file line 512.

## Cause

This is caused by the definition of the overloaded operator `new` in the *Crtdbg.h* file:

```cpp
#ifdef _CRTDBG_MAP_ALLOC
inline void* __cdecl operator new(unsigned int s)
    { return ::operator new(s, _NORMAL_BLOCK, __FILE__, __LINE__); }
#endif /* _CRTDBG_MAP_ALLOC */
```

Here `__FILE__`and `__LINE__` are macros defined by the compiler that report the current file name and line number. Macros are filled out by the preprocessor. Then the compiler replaces your call to `new` with this function. Therefore, the macros have already been filled out before they are inlined. Hence they will report the header file information.

## Resolution

Defining the `_CRTDBG_MAP_ALLOC` symbol causes all instances of `new` in your code to be mapped properly to the debug version of `new` so as to record source file and line number information.

While it is true that this will map calls to the debug version of `new`, it will not store the proper source file or line number information. There are two ways to mark the correct file name and line number:

- Call the debug version of the `new` operator directly.
- Create macros that replace the operator `new` in debug mode as in the following sample code.

## Sample Code

```cpp
/* MyDbgNew.h
/* Defines global operator new to allocate from
/* client blocks*/
#ifdef _DEBUG
    #define MYDEBUG_NEW new( _NORMAL_BLOCK, __FILE__, __LINE__)
    // Replace _NORMAL_BLOCK with _CLIENT_BLOCK if you want the
    //allocations to be of _CLIENT_BLOCK type
#else
    #define MYDEBUG_NEW
#endif // _DEBUG
/* MyApp.cpp
/* Compile options needed: /Zi /D_DEBUG /MLd
/* or use a
/* Default Workspace for a Console Application to
/* build a Debug version*/
#include "crtdbg.h"
#include "mydbgnew.h"

#ifdef _DEBUG
    #define new MYDEBUG_NEW
#endif

void main( )
{
    char *p1;
    p1 = new char[40];
    _CrtMemDumpAllObjectsSince( NULL );
}
```
