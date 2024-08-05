---
title: Can't start Windows Simulator in Windows 8.1
description: This article resolves a problem in which you can't start the Windows Simulator in Visual Studio 2013 after you upgrade to Windows 8.1.
ms.date: 04/27/2020
ms.custom: sap:Debuggers and Analyzers\Visual Studio Debugger
ms.reviewer: pchapman, leolee, meyoung, lukewest
---
# Error when you debug an app in Visual Studio 2013: Windows Simulator needs your current credentials

This article helps you resolve the error (Windows Simulator needs your current credentials) that occurs when you debug an app in Microsoft Visual Studio 2013. This problem occurs after you upgrade to Windows 8.1.

_Original product version:_ &nbsp; Visual Studio Professional 2013  
_Original KB number:_ &nbsp; 2898148

## Symptoms

Assume that you have Visual Studio Professional 2013 installed on Windows 8 and then you upgrade to Windows 8.1 by using the option that preserves applications and settings. In this situation, when you try to use the Windows Simulator in Visual Studio 2013 to debug an app, you receive the following error message:

> Windows Simulator needs your current credentials. Please lock this computer, then unlock it using your current password and run the Windows Simulator again.

However, locking, unlocking, or restarting your computer does not resolve this issue.

## Resolution

To resolve this issue, apply the Windows 8.1 update rollups from the following Microsoft Knowledge Base articles:

- [Windows 8.1 and Windows Server 2012 R2 General Availability Update Rollup](https://support.microsoft.com/help/2883200)
- [Windows 8.1 and Windows Server 2012 R2 update rollup: October 2013](https://support.microsoft.com/help/2884846)

> [!NOTE]
> You must restart the computer after you apply the updates.

## References

For more information, see [Known issues for Visual Studio 2013](https://support.microsoft.com/help/2890846).
