---
title: How to enable and disable Scheduled Tracing
description: Describes how to enable Scheduled Tracing for Microsoft Dynamics CRM.
ms.reviewer: 
ms.topic: how-to
ms.date: 3/31/2021
---
# How to enable and disable Scheduled Tracing for Microsoft Dynamics CRM

This article introduces how to enable and disable Scheduled Tracing for Microsoft Dynamics CRM.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2862025

## How to enable scheduled tracing

1. Set up the trace. When you set up the trace, enter all the required values. However, leave the TraceEnabled registry entry set to **0**.

2. Create a registry file that enables the trace. To do this, start Notepad, copy the following information to the document in Notepad, and then save the document as a .reg file:

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSCRM] "TraceEnabled"=dword:00000001`

3. Create a batch file that calls the .reg file. To do this, open a new document in Notepad, and then copy the following lines to the document in Notepad.

    > [!NOTE]
    > In the lines that you copy, replace the *<C:\Enable.reg>* placeholder with the path and the file name of the actual .reg file that you created in step 2.

    ```console
    @echo off
    regedit /s "<C:\Enable.reg>"
    exit
    ```

4. In **Control Panel**, add a new scheduled task that runs the new batch file that you created in step 3. Schedule the task for the time at which you want the trace to run.

## How to disable scheduled tracing

1. Create a registry file that disables the trace. To do this, start Notepad, copy the following information to the document in Notepad, and then save the document as a .reg file:

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSCRM] "TraceEnabled"=dword:00000000 "TraceRefresh"=dword:00000003`

    > [!NOTE]
    > You must change the value of the `TraceRefresh` registry entry. If you do not change the value of the `TraceRefresh` registry entry, the trace will not be disabled.

2. Create a batch file that calls the .reg file. To do this, open a new document in Notepad, and then copy the following lines to the document in Notepad.

    > [!NOTE]
    > In the lines that you copy, replace the *<C:\Disable.reg>*  placeholder with the path and the file name of the actual .reg file that you created in step 2.

    ```console
    @echo off
    regedit /s "<C:\disable.reg>"
    exit
    ```

3. In **Control Panel**, add a new scheduled task that runs the new batch file that you created in step 3. Schedule the task for the time at which you want the trace to be disabled.
