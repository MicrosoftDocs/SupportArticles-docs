---
title: Unable to find an entry point error when updating SQL Server 2022
description: This article documents an issue where applying a SQL Server 2022 Cumulative Update (CU) from the command line generates an error message.
ms.date: 01/31/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.author: brcarrig  
---
# Unable to find an entry point error when updating SQL Server 2022

This article documents an issue where applying a SQL Server 2022 Cumulative Update (CU) from the command line generates an error message.

_Applies to:_ &nbsp; SQL Server 2022 on Windows  

## Symptoms

Consider the following scenario:

- You have a computer that's running an OS that has an earlier build of the Windows OS than Windows 10 Build 20348, such as Windows Server 2016 or Windows Server 2019.

- You apply a cumulative update (CU) to SQL Server 2022 using **setup.exe** from the command line. For information on how to run setup from command line see [Install and configure SQL Server on Windows from the command prompt](/sql/database-engine/install-windows/install-sql-server-from-the-command-prompt)

In this scenario, an exception occurs in the setup console during the update process, displaying the following error message:

> System.EntryPointNotFoundException: Unable to find an entry point named 'GetNumaNodeProcessorMask2' in DLL 'kernel32.dll'

## Cause

When the **setup.exe** runs on an OS version where the [GetNumaNodeProcessorMask2 API](/windows/win32/api/systemtopologyapi/nf-systemtopologyapi-getnumanodeprocessormask2) is unavailable, an exception appears in the setup console.

## Resolution

No resolution steps are necessary as the exception does not affect the setup behavior or success of the update. 

## More information

This exception is only visible in the setup console when running **setup.exe** from the command line and applies to only CU15 and above.
