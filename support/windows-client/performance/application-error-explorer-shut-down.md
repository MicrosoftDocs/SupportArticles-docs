---
title: Application Error in Explorer.exe When You Shut Down or Restart Windows
description: Provides a workaround to an application error in Explorer.exe when you shut down or restart Windows.
ms.date: 07/25/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:system performance\shutdown performance (slow,unresponsive)
- pcy:WinComm Performance
---
# Application error in Explorer.exe when you shut down or restart Windows

## Symptoms

You receive the following error message when Windows 8.1 or Windows Server 2012 R2 is shutting down:

> explorer.exe - Application Error  
The instruction at \<memory address\> referenced memory at \<memory address\>. The memory could not be "\<read or write\>".  
> Click on OK to terminate the program.

> [!NOTE]
> The shutdown process continues after the error message is displayed. The error doesn't harm the computer, and it can be safely ignored.

This issue occurs when you right-click the Start tip or press the Windows key+X keyboard shortcut, and then you use the **Shut down or sign out** option to shut down or restart Windows.

## Workaround

To work around this issue, use the Settings charm to shut down or restart Windows.

## Cause

This error occurs because the **Explorer.exe** process accesses memory that has already been freed during the shutdown process.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
