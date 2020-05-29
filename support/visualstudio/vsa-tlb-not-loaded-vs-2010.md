---
title: Microsoft.Vsa.tlb could not be loaded error
description: Resolves an error that occurs in Visual Studio 2010 after you upgrade from Windows 8 to Windows 8.1. This issue occurs when you start the Visual Studio.
ms.date: 04/22/2020
ms.prod-support-area-path:
ms.reviewer: adrianv, andneil
---
# Microsoft.Vsa.tlb could not be loaded when starting Visual Studio 2010 after upgrading to Windows 8.1

This article provides the resolution to solve the **Microsoft.Vsa.tlb could not be loaded** error that occurs when you start Microsoft Visual Studio 2010 after you upgrade from Windows 8 to Windows 8.1.

_Original product version:_ &nbsp; Visual Studio Premium 2010, Visual Studio Professional 2010, Visual Studio Ultimate 2010  
_Original KB number:_ &nbsp; 2898975

## Symptoms

Assume that you have Microsoft Visual Studio 2010 installed on a Windows 8-based computer, and then you upgrade to Windows 8.1. However, when you start Visual Studio 2010, you receive the following error message:

> The file %WINDIR%\Microsoft.NET\Framework\v2.0.50727\Microsoft.Vsa.tlb could not be loaded. An attempt to repair this condition failed because the file could not be found.  
> Please reinstall this program.

## Resolution

To resolve this issue, use one of the following methods:

- Install the [Microsoft .NET Framework 3.5](/dotnet/framework/install/dotnet-35-windows-10).
- Repair the Visual Studio installation:

  1. Click **Start**, click **Control Panel**, click **Programs**, and then click **Programs and Features**.
  2. Right-click the version of Visual Studio 2010 that you've installed, and then click **Change**.
  3. Click **Repair** when the Visual Studio 2010 Setup wizard opens.
