---
title: Error when building application in VS
description: Describes the Could not transform licenses file into a binary resource error when you build your application in Visual Studio 2017, and provides a workaround.
ms.date: 04/23/2020
ms.prod-support-area-path:
ms.reviewer: hihayak
---
# Could not transform licenses file into a binary resource when you build your application in Visual Studio 2017

This article provides information about resolving the **Could not transform licenses file into a binary resource** error when you build your application in Visual Studio 2017.

_Original product version:_ &nbsp; Visual Studio Professional 2017, Visual Studio Enterprise 2017, Visual Studio Express 2017 for Windows Desktop, Visual Studio Community 2017  
_Original KB number:_ &nbsp; 4022463

## Symptoms

When you build your application in Microsoft Visual Studio 2017, you receive the following error message:

> Licenses.licx: Could not transform licenses file into a binary resource. Could not load file or assembly 'file:///C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\lc.exe' or one of its dependencies. The specified file could not be found.

## Cause

Visual Studio 2017 runs the Microsoft .NET Framework License Compiler (lc.exe) to build license files (.licx files). The License Compiler refers to a particular registry for the installation path of the Software Development Kit (SDK) that's installed in the environment. Visual Studio 2017 can't find this registry because the location of the registry key and the folder structure of SDK are changed from the Microsoft .NET Framework 4.6.1.

## Workaround

To work around this issue, install the Windows SDK for the Microsoft .NET Framework 3.5 SP1 so that Visual Studio can load the lc.exe file that's located in the Windows SDK installation path.

This workaround applies to Visual Studio 2017 version 15.2 or an earlier version installed on Windows 7 or later Windows versions.

## Status

This problem is fixed in Visual Studio 2017 version 15.3.
