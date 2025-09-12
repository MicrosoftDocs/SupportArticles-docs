---
title: Can't start Windows Simulator after an upgrade
description: Resolves a problem in which you can't start Windows Simulator in Visual Studio 2012 after you upgrade to Windows 8.1.
ms.date: 04/27/2020
ms.custom: sap:Integrated Development Environment (IDE)\Other
ms.reviewer: sbonev, meyoung
---
# Can't start Windows Simulator after you upgrade to Windows 8.1 in Visual Studio 2012

This article helps you resolve the problem where you can't start Windows Simulator in Microsoft Visual Studio 2012 after you upgrade to Windows 8.1.

_Original product version:_ &nbsp; Visual Studio 2012  
_Original KB number:_ &nbsp; 2892596

## Symptoms

Consider the following scenario:

- You have Visual Studio 2012 installed on a Windows 8-based computer.
- You upgrade the computer to Windows 8.1.
- You try to start the Windows simulator in Visual Studio.

In this scenario, you receive the following error message:

> Windows Simulator needs your current credentials. Please lock this computer, then unlock it using your current password and run the Windows simulator again.

## Resolution

To resolve this problem, use one of the following methods:

- Apply the update from [Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2 update rollup: November 2013](https://support.microsoft.com/help/2887595).
- Install [Visual Studio 2012 Update 4](https://support.microsoft.com/help/2872520).
- Repair Visual Studio 2012. To do this, follow these steps:
    1. Click **Start**, click **Control Panel**, click **Programs**, and then click **Programs and Features**.
    2. Right-click the version of Visual Studio 2012 that you have installed, and then click **Change**.
    3. Click **Repair** when the Visual Studio 2012 Setup wizard opens.

## Status

Microsoft has confirmed that this is a problem in the products that are listed in the Applies to section.

## Applies to

- Visual Studio Premium 2012
- Visual Studio Ultimate 2012
- Visual Studio Test Professional 2012
- Visual Studio Express 2012 for Windows 8
- Visual Studio Express 2012 for Windows Desktop
- Visual Studio Express 2012 for Windows Phone  
