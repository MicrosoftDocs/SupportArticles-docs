---
title: Building a Windows 10 driver fails
description: This article describes a problem that prevents you from successfully building a Windows 10 driver in Visual Studio 2015, and provides a resolution.
ms.date: 04/27/2020
ms.custom: sap:Project - Build System\Build Issues
ms.reviewer: chrit, meerak
---
# Building a Windows 10 driver in Visual Studio 2015 fails

This article helps you resolve a problem that prevents you from successfully building a Windows 10 driver in Microsoft Visual Studio 2015.

_Original product version:_ &nbsp; Visual Studio 2015  
_Original KB number:_ &nbsp; 4011918

## Symptoms

When you try to build a Windows driver for Windows 10 by using Visual Studio 2015 and the Windows Driver Kit 10, the build is unsuccessful. This issue may occur if you install Visual Studio 2015 from a DVD or from the ISO you received as part of your MSDN subscription.

> [!NOTE]
> This problem doesn't occur if you use the default installation type (Typical for Windows 10 Developers) for Visual Studio 2015 from [Download the Windows Driver Kit (WDK)](/windows-hardware/drivers/download-the-wdk).  

## Cause

This problem occurs if the default installation type on the DVD or the ISO doesn't include the Windows 10 SDK in the installation.  

## Resolution

To resolve this problem, make sure that you include the Windows 10 SDK during the installation of Visual Studio 2015. To do this, follow these steps:

1. Start the installation of Visual Studio 2015.
2. Select **Custom** as the installation type.
3. Select **Windows and Web Development**.
4. Under **Universal Windows App Development Tools**, select **Windows 10 SDK**.
5. Continue with the installation of Visual Studio 2015.
6. After the installation is complete, install the Windows 10 Driver Kit.

When you try to build a Windows 10 driver in Visual Studio 2015, the corresponding Windows targets will be available to build and select under **Project Properties**.
