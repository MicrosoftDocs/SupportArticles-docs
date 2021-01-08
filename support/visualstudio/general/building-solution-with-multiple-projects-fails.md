---
title: The referenced project doesn't exist
description: This article describes the Visual Studio 2010 build failure when building a solution with multiple projects and there exists dependency relationships among them, and provides a workaround.
ms.date: 04/22/2020
ms.prod-support-area-path: Language or compilers
ms.reviewer: danmose
---
# Visual Studio 2010 build fails with an error: The referenced project doesn't exist

This article helps you resolve the Microsoft Visual Studio 2010 build failure when you build a solution with multiple projects and there exists dependency relationships among those projects.

_Original product version:_ &nbsp; Visual Studio Professional 2010, Visual Studio Premium 2010, Visual Studio Ultimate 2010  
_Original KB number:_ &nbsp; 2516078

## Symptoms

In Visual Studio 2010, when you try to build a solution with multiple projects and there exists dependency relationships among those projects, in specific conditions a build fails with the following error message:

> "C:\WINDOWS\Microsoft.NET\Framework\v4.0.30319\Microsoft.Common.targets (1200, 9): warning: The referenced project 'Relative path to the referenced project from the current directory' does not exist."

A build fails with the error message above when the following conditions are met:

1. You have a solution with multiple projects and there exists dependency relationships among those projects.
2. The sum of the following two path length is exactly added up to 259 characters (= `MAX_PATH - 1`)
    - The path of a referencing project's directory.
    - The relative path to a referenced project from the current directory (= a referencing project's directory).

    > [!NOTE]
    > `MAX_PATH` is the maximum path length defined by Windows API and is set to be 260 characters.

## Cause

This issue occurs because of a bug in the `Path.GetFullPath` in .NET Framework library.

This is a known issue in Visual Studio 2010.

For more information about the `Path.GetFullPath` method, see
[Path.GetFullPath Method](/dotnet/api/system.io.path.getfullpath#System_IO_Path_GetFullPath_System_String_).

## Workaround

To work around this issue, you can change path length and make sure that the sum of the following two path length isn't added up to 259 characters.

- The path of a referencing project's directory.
- The relative path to a referenced project from the current directory (= a referencing project's directory).
