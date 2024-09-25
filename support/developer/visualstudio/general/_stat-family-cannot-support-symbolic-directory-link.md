---
title: _stat-family can't support Symbolic Directory Link
description: This article provides resolutions for the problem where function calls of _stat-family do not support Symbolic Directory Links for C Runtime Library functions from Visual Studio 2013, 2012, or 2010.
ms.date: 07/15/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.reviewer: kurta
---
# Function calls of "_stat-family" do not support Symbolic Directory Links for C Runtime Library functions from Visual Studio 2013, 2012, or 2010

This article helps you resolve the problem where function calls of `_stat-family` do not support Symbolic Directory Links for C Runtime Library functions from Visual Studio 2013, 2012, or 2010.

_Original product version:_ &nbsp; Visual Studio 2013, Visual Studio 2012, Visual Studio 2010  
_Original KB number:_ &nbsp; 4531963

## Symptoms

You create a Symbolic Directory Link to a local directory or a remote file share. This creates the link `C:\link` that points to the `C:\temp` folder, as follows:

```console
mklink /d C:\link C:\temp
```

If your application is built by using Microsoft Visual Studio 2013, 2012, or 2010, unpredictable or false results occur when you use C Runtime Library (CRT) function calls of `_stat-family`.

## Resolution

To resolve this problem, migrate your C or C++ project to a latest version of Microsoft Visual Studio. This is because C Runtime function calls of `_stat-family` of the Universal C Runtime are used by Visual Studio 2019, 2017, and 2015. These versions support Symbolic Directory Links.

## Workaround

To work around this problem, create a link as follows:

```console
mklink C:\abc C\temp

mkdir C:\abc\link
```  

If you use a `_stat-family` function call that has a `C:\abc\link` path, the result is always correct.

## More information

For more information about the C Runtime Library stat-functions, see [C Runtime Library (stat-functions)](/cpp/c-runtime-library/reference/stat-functions?view=vs-2019&preserve-view=true).

## Applies to

- Visual Studio Ultimate 2013
- Visual Studio Professional 2013
- Visual Studio Premium 2013
- Visual Studio Ultimate 2012
- Visual Studio Professional 2012
- Visual Studio Premium 2012
- Visual Studio Ultimate 2010
- Visual Studio Professional 2010
- Visual C++ 2010 Express  
