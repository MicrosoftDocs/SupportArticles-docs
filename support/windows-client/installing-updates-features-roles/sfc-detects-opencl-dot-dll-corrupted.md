---
title: SFC detects Opencl.dll as corrupted
description: Fixes an issue that causes SFC to detect Opencl.dll as corrupted in Windows 10.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Installing Windows Updates, Features, or Roles\Failure to install Windows Updates, csstroubleshoot
---
# SFC detects Opencl.dll as corrupted in Windows 10

This article provides a solution to an issue that causes SFC to detect Opencl.dll as corrupted in Windows 10.

_Applies to:_ &nbsp; Windows 10, version 1809  
_Original KB number:_ &nbsp; 3178332

## Symptoms

After you run the `SFC /scannow` command in Windows 10, it detects a corrupted system file. The cbs.log file shows that %windir%\syswow64\opencl.dll is detected to be corrupted.

For more information about how to analyze the `SFC /scannow` result, see [Analyze the log file entries that SFC.exe generates in Windows Vista](analyze-sfc-program-log-file-entries.md).

## Resolution

To fix this issue, run the following command:

```console
Dism /online /cleanup-image /restorehealth
```

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
