---
title: Microsoft.Vsa.tlb could not be loaded
description: This article describes that an error occurs in Visual Studio 2010 after you upgrade from Windows 8 to Windows 8.1. This problem occurs when you start the Visual Studio.
ms.date: 04/22/2020
ms.prod-support-area-path:
ms.reviewer: adrianv, andneil
---
# Error (Microsoft.Vsa.tlb could not be loaded) when you start Visual Studio 2010 after upgrading to Windows 8.1

This article helps you resolve the problem where you receive an error when you start Microsoft Visual Studio 2010 after you upgrade from Windows 8 to Windows 8.1: Microsoft.Vsa.tlb could not be loaded.

_Original product version:_ &nbsp; Visual Studio Premium 2010, Visual Studio Professional 2010, Visual Studio Ultimate 2010  
_Original KB number:_ &nbsp; 2898975

## Symptoms

Assume that you have Visual Studio 2010 installed on a Windows 8 computer, and then you upgrade to Windows 8.1. When you start Visual Studio 2010, you receive the following error message:

> The file %WINDIR%\Microsoft.NET\Framework\v2.0.50727\Microsoft.Vsa.tlb could not be loaded. An attempt to repair this condition failed because the file could not be found.  
> Please reinstall this program.

## Resolutions

To resolve this problem, use one of the following methods:

- Install the [Microsoft .NET Framework 3.5](/dotnet/framework/install/dotnet-35-windows-10).
- Repair the Visual Studio installation:

  1. Select **Start**, select **Control Panel**, select **Programs**, and then select **Programs and Features**.
  2. Right-click the version of Visual Studio 2010 that you've installed, and then select **Change**.
  3. Select **Repair** when the Visual Studio 2010 Setup wizard opens.
