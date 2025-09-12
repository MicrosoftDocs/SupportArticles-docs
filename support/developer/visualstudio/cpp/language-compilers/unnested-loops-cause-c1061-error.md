---
title: Unnested loops cause C1061 compiler error
description: Describes a problem that occurs when you include more than 250 unnested loops in a function. You may receive a compiler error in Visual C++.
ms.date: 04/24/2020
ms.custom: sap:Language or Compilers\C++
ms.reviewer: ScotBren
---
# Too many unnested loops incorrectly causes a C1061 compiler error in Visual C++

This article helps you resolve the C1061 compiler error that occurs when you compile the source code that includes more than 250 unnested loops in a function as a C++ source file.

_Original product version:_ &nbsp; Visual Studio Premium 2012, Visual Studio 2010  
_Original KB number:_ &nbsp; 315481

## Symptoms

If a function contains more than approximately 250 unnested loops, you receive the following error message, which should not appear in this scenario:

> fatal error C1061: compiler limit : blocks nested too deeply

The problem occurs only when you compile the source code as a C++ source file. The source code compiles without errors when you compile it as a C source file.

## Workaround

Surround each for loop with braces to create an enclosing scope:

```cpp
{
    for (i=0; i<5; i++)
    {
        a += a*i;
    }
}
```

## Steps to reproduce the behavior

The following sample code demonstrates the error:

```cpp
/* Compile options needed: /TP /c
*/
#include <stdio.h>

// The code blocks in this function have only two nesting levels.
// C1061 should not occur.
void func1()
{
    int a;
    int i = 0;
    int count = 0;

    count++;
    a = count;
    for (i=0; i<5; i++)
    {
        a += a*i;
    }
    printf("a=%d\n", a);

    // Copy and paste the following code 250 times.
    /*
    for (i=0; i<5; i++)
    {
        a += a*i;
    }
    printf("a=%d\n", a);
    */

    count++;
    a = count;
    for (i=0; i<5; i++)
    {
        a += a*i;
    }
    printf("a=%d\n", a);
}

void main()
{
    func1();
}
```

## More information

The C++ compiler must keep track of all for-loops in the same scope in order to issue warning C4258 when **/Zc:forScope** is enabled:

```cpp
int i;
void foo()
{
    for (int i = 0; i < 10; ++i)
    {
        if (i == 5) break;
    }
    if (i == 5)... // C4258: this 'i' comes from an outer scope, not the for-loop
}
```

With **/Zc:ForScope** disabled, that `i` on the commented line would come from the for-loop instead. Users must be informed of this difference in behavior.

Unfortunately, scopes are non-trivial data structures, so the compiler has a limit on the number of scopes it can keep track of at the same time, which leads to the bug described here.

The workaround solves this problem by isolating each for-loop so that it is no longer in the same scope as other for-loops, thereby removing the compiler's need to keep track of all of their scopes at the same time. Another way of looking at the workaround is that it avoids the possibility of encountering warning C4258 outside an extra enclosing scope:

```cpp
int i;
void foo()
{
    {
        for (int i = 0; i < 10; ++i)
        {
            if (i == 5) break;
        }
    }
    if (i == 5)...
    // this 'i' comes from the outer scope regardless of whether /Zc:forScope is enabled
}
```
