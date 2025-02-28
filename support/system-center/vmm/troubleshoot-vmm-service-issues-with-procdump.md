---
title: Troubleshoot VMM service issues using ProcDump
description: Describes how to use ProcDump to troubleshoot Virtual Machine Manager service (Vmmservice.exe) issues.
ms.date: 04/09/2024
ms.reviewer: jarrettr
---
# How to use ProcDump to troubleshoot Virtual Machine Manager service (Vmmservice.exe) issues

This article describes how to use ProcDump to troubleshoot Virtual Machine Manager service (Vmmservice.exe) issues.

_Original product version:_ &nbsp; System Center Virtual Machine Manager, System Center 2016 Virtual Machine Manager, System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 4294410

## Download ProcDump

ProcDump is a new command-line tool that allows you to monitor a running process for CPU spikes, and then create a memory dump (or dumps) based on specific criteria. You can use ProcDump to troubleshoot Virtual Machine Manager service (Vmmservice.exe) issues. You can download ProcDump from [ProcDump v9.0](/sysinternals/downloads/procdump).

## Use ProcDump

1. Create a folder on the C:\ drive named procdump.
2. Open an elevated command prompt and navigate to the `c:\procdump` folder. In the command-line, type the following command:

    ```console
    procdump.exe -ma -e vmmservice.exe
    ```

    > [!NOTE]
    > The `-ma` parameter will make it take a full dump of the process and `-e` will write a dump when the process encounters an unhandled exception.

3. To capture first chance exceptions, use the following command:

    ```console
    procdump -ma -e 1 -t -n 10 vmmservice.exe
    ```

This will attach the debugger to the VMMservice process. Reproduce the issue by launching the application or service and it will create a .dmp file in the `C:\procdump` folder.
