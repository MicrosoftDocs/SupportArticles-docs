---
title: Visual Studio 2012 Help Viewer 2.0 crashes
description: This article provides a resolution to resolve the crash problem when you launch Help Viewer 2.0 in Visual Studio 2012.
ms.date: 05/12/2022
ms.custom: sap:Integrated Development Environment (IDE)\Other
---

# Visual Studio 2012 Help Viewer 2.0 crashes

This article helps you resolve the Microsoft Visual Studio 2012 Help Viewer crash problem.

_Original product version:_ &nbsp; Visual Studio Premium 2012  
_Original KB number:_ &nbsp; 2879007

## Symptoms

When you launch Help within Visual Studio 2012 by pressing F1 or by choosing View Help (CTRL+F1) from the **Help** menu on the **Standard Toolbar**, you may meet an issue where one of the following messages will be displayed:

- Error message 1

    > CLR_EXCEPTION_System.IO.FileNotFoundException
- Error message 2

    > Windows cannot find HlpViewer.exe. Make sure you typed the name correctly, and then try again.

## Cause

The Help Viewer 2.0 or one of its components is missing or damaged.

## Resolution

To resolve this issue, you must close all instances of Visual Studio 2010, open the **Program and Features** applet from the Control Panel, select the installed instance of Visual Studio 2012, select **Change**, and continue with the **Repair** option.

## Reset personal preferences

You may need to reset your personal preferences in the **Tools** > **Options** dialog as repairing an application overwrites those settings. It's suggested you preserve your settings before proceeding with the **Repair**. From the **Main Menu**, select **Tools** and then select **Import and Export Settings**.
