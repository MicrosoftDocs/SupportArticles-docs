---
title: Enable debug logging in Virtual Machine Manager
description: Describes how to enable debug logging in Microsoft System Center Virtual Machine Manager.
ms.date: 12/09/2022
ms.topic: how-to
ms.reviewer: bicheria, jarrettr, v-weizhu
---
# How to enable debug logging in Virtual Machine Manager

This article describes how to enable debug logging in Microsoft System Center 2016 Virtual Machine Manager (SC 2016 VMM), System Center 2019 Virtual Machine Manager (SC 2019 VMM), and System Center 2022 Virtual Machine Manager (SC 2022 VMM). VMM Event Trace Log (ETL) files provide useful debug logging for troubleshooting many different VMM issues.

_Original product version:_ &nbsp; Microsoft System Center 2012 Virtual Machine Manager Service Pack 1, Microsoft System Center 2012 R2 Virtual Machine Manager   
_Original KB number:_ &nbsp; 2913445

## Steps to enable VMM debug logging

1. Create a folder that's named *C:\vmmlogs*.

2. Open an elevated Windows PowerShell window on the VMM server or host computer, and then run the following command:

    ```powershell
    logman delete VMM
    ```

    The command above deletes any existing definitions of the trace. You can safely ignore any "Data Collector Set was not found" errors you receive.
    
    ```powershell
    logman create trace VMM -v mmddhhmm -o $env:SystemDrive\VMMlogs\VMMLog_$env:computername.ETL -cnf 01:00:00 -p Microsoft-VirtualMachineManager-Debug -nb 10 250 -bs 16 -max 512
    ```
3. Start the trace by running the following command in the elevated Windows PowerShell window:

    ```powershell
    logman start VMM
    ```
4. Reproduce your issue.

5. As soon as you reproduce your issue, stop the trace by running the following command:

    ```powershell
    logman stop VMM
    ```

    > [!NOTE]
    > You can find the ETL file in *C:\vmmlogs*.

6. To convert the trace file, run the following command from a command prompt:

    ```console
    Netsh trace convert <filename>
    ```

    In this command, the placeholder \<filename> represents the name of the ETL file that you find in step 5. The converted trace file will have a name in the format *\<filename>.txt*.
