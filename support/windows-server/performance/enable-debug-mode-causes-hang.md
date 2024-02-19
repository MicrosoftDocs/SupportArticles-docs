---
title: Enable Debug mode causes to hang
description: Provides a solution to an issue where the Operating System with debug mode enabled may hang if no Debugger is connected.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jdickson
ms.custom: sap:system-hang, csstroubleshoot
---
# Enabling Debug mode causes Windows to hang if no Debugger is connected

This article provides a solution to an issue where the Operating System with debug mode enabled may hang if no Debugger is connected.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2816225

## Symptoms

On a computer that is running Windows 7 or Windows Server 2008 R2, after installing Debugging Tools for Windows, the Operating System with debug mode enabled may hang if an application throws user-mode exception.

## Cause

When Debug mode is enabled and the debugger hasn't connected because of the user mode exception, the system will hang waiting for a debugger to intervene from the breakpoint.

## Resolution

To resolve this problem, disable Debug mode using one of the following methods:

- **Using System Configuration settings**

    1. Using keyboard press, **Windows Key+R** to open **Run** box.
    2. Type **MSCONFIG** and then press **Enter**.
    3. Select **Boot** tab and then select **Advanced options**.
    4. **Uncheck** on the **Debug** check box.
    5. Select **OK**.
    6. Select **Apply** and then **OK**.
    7. Restart the computer.

- **Using Command Line Interface**

    1. Open an **elevated Command prompt**.
    2. Type the following command and press **Enter**:  
        **bcdedit -debug off**
    3. Restart the computer.

## More information

> [!NOTE]
> Windows shouldn't be run in Debug mode permanently. Debug mode is enabled for connecting to Kernel Debug using Debuggers like Debugging Tools for Windows (WinDbg) and must be turned off once the purpose is accomplished.  
> Some Windows 7 systems might be shipped with DEBUG switch enabled, ensure to disable it.  
> To download Debugging Tools for Windows and more information, see [Download the Windows Driver Kit (WDK)](/windows-hardware/drivers/download-the-wdk).
