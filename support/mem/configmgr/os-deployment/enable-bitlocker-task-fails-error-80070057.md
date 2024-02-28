---
title: Enable BitLocker task fails with error 80070057
description: Describes an issue in which the Enable BitLocker task fails with error 80070057 in Configuration Manager.
ms.date: 12/05/2023
ms.custom: sap:BitLocker and MBAM
ms.reviewer: kaushika
---
# Enable BitLocker task fails with error 80070057 in Configuration Manager

This article fixes an issue in which the **Enable BitLocker** task fails with error 80070057 in Configuration Manager.

_Original product version:_ &nbsp; Configuration Manager (current branch - version 1806)  
_Original KB number:_ &nbsp; 4474026

## Symptoms

After you upgrade to Configuration Manager current branch version 1806, the **Enable BitLocker** task fails, and you receive the following error message in the Smsts.log file:

> Command line: "OSDBitLocker.exe" /enable /wait:False /mode:TPM /pwd:AD /full:False  
> Initialized COM OSDBitLocker  
> Command line for extension .exe is "%1" %* OSDBitLocker  
> Set command line: "OSDBitLocker.exe" /enable /wait:False /mode:TPM /pwd:AD /full:False  
> FALSE, HRESULT=80070057 (..\main.cpp,238) OSDBitLocker  3580 (0x0DFC)  
> Invalid command line argument '/full' OSDBitLocker 3580 (0x0DFC)  
> ProcessCommandLine( argInfo ), HRESULT=80070057 (..\main.cpp,366) OSDBitLocker 3580 (0x0DFC)  
> Process completed with exit code 2147942487 TSManager 3364 (0x0D24)
>
> Failed to run the action: Enable BitLocker. This is usually caused by a problem with the program. Please check the Microsoft Knowledge Base to determine if this is a known issue or contact Microsoft Support Services for further assistance.  
> The parameter is incorrect.

## Cause

This issue is caused by an update in Configuration Manager current branch version 1806. The **Enable BitLocker** and **Pre-Provision BitLocker** actions require newer versions of OSDBitLocker.exe and OSDOfflineBitlocker.exe that are included in boot image version 5.00.8592.1008 and the Configuration Manager current branch version 1806 client package.

## Resolution

To fix this issue, update the boot image to version 5.00.8592.1008, and use the Configuration Manager current branch version 1806 client package in the task sequence.
