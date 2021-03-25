---
title: Running TPM Management console fails
description: Provides solutions to fix an error that occurs when you try to run the TPM Management console in Windows 10.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Devices and Drivers
ms.technology: windows-client-deployment
---
# "Cannot load management console" error when you try to run the TPM Management console

This article provides solutions to fix an error that occurs when you try to run the TPM Management console in Windows 10.

_Original product version:_ &nbsp; Windows 10, version 1809  
_Original KB number:_ &nbsp; 4026023

## Symptoms

Assume that you disable or clear the [Trusted Platform Module (TPM)](https://docs.microsoft.com/windows/device-security/tpm/trusted-platform-module-overview)  through the BIOS settings on a Windows 10, version 1703-based, or a Windows 10, version 1809-based device. When you try to run the TPM Management console (TPM.msc), you receive the following error message: Cannot load management console.

## Resolution

To fix this issue, use one of the following methods, depending on the situation:

### Method 1: TPM is cleared in BIOS

If the TPM is cleared through the BIOS settings, close and then restart the TPM Management console (TPM.msc) again.

### Method 2: TPM is disabled in BIOS

If the TPM is disabled through the BIOS settings, you have to re-enable it in BIOS or run the following Windows PowerShell command as an administrator:

```powershell
$tpm = gwmi -n root\cimv2\security\microsofttpm win32_tpm
$tpm.SetPhysicalPresenceRequest(6)
```

> [!Note]
> After you run the command, you must restart the operating system and accept any BIOS prompts.

## Status

Microsoft is researching this problem and will post more information in this article when the information becomes available.  

## References

For more information, see the following Windows Dev Center article:
[SetPhysicalPresenceRequest method of the Win32_Tpm class](https://msdn.microsoft.com/library/windows/desktop/aa376478%28v=vs.85%29.aspx)
