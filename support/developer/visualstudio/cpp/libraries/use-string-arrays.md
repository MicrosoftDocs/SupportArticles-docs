---
title: Use string arrays in Visual C++
description: Describes a code sample that shows how to create and use string arrays in Visual C++.
ms.date: 04/22/2020
ms.custom: sap:Language or Compilers\C++
ms.reviewer: V-JEFFBO
ms.topic: how-to
---
# Create and use string arrays in Visual C++

This article provides a code sample to show how to create and use string arrays in Visual C++.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 310809

## Summary

This article shows you how to use managed C++ to create and use string arrays in Visual C++ .NET and in Visual C++. Although the example uses a two-dimensional string array, the information can also be applied to a one-dimensional string array or a multidimensional string array.

## Initializing an array

Initialize a new instance of a two-dimensional `__gc` array that includes elements of a pointer to the `String` class:

```cpp
Int32 nRows, nColumns;
nRows = 10;
nColumns = 10;
String* myStringArray [,]= new String* [nRows,nColumns];
```

Next, fill the string array:

```cpp
String* myString = "This is a test";
myStringArray[x,y] = myString;
```

The variables *x* and *y* are placeholders for valid `Int32` values or variables that specify the subscripted values of the array. The `__gc` array is zero-based.

## Complete sample code

```cpp
#using <mscorlib.dll>
#include <tchar.h>

using namespace System;

int _tmain(void)
{
    Int32 nRows, nColumns;
    nRows = 10;
    nColumns = 10;
    String* myString = "This is a test";

    String* myStringArray[,]= new String* [nRows,nColumns];
    myStringArray[0,0] = myString;

    Console::WriteLine(myStringArray[0,0]);
    return 0;
}
```

You must add a common language runtime support compiler option in Visual Studio to successful compile the previous code sample. To add the common language runtime support compiler option in Visual Studio, follow these steps:

1. Click **Project**, and then click **\<ProjectName> Properties**.

    > [!NOTE]
    > **\<ProjectName>** is a placeholder for the name of the project.
2. Expand **Configuration Properties**, and then click **General**.
3. Click to select **Common Language Runtime Support, Old Syntax (/clr:oldSyntax)** at the right of **Common Language Runtime support** under **Project Defaults** in the right pane, click **Apply**, and then click **OK**.

For more information about the common language runtime support compiler option, see [/clr (Common Language Runtime Compilation)](/cpp/build/reference/clr-common-language-runtime-compilation).
