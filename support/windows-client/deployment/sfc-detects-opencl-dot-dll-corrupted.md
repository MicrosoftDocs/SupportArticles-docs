---
title: SFC detects Opencl.dll as corrupted
description: Fixes an issue that causes SFC to detect Opencl.dll as corrupted in Windows 10.
ms.date: 09/24/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Servicing
ms.technology: windows-client-deployment
---
# SFC detects Opencl.dll as corrupted in Windows 10

This article provides a solution to an issue that causes SFC to detect Opencl.dll as corrupted in Windows 10.

_Applies to:_ &nbsp; Windows 10, version 1809  
_Original KB number:_ &nbsp; 3178332

## Symptoms

After you run the `SFC /scannow` command in Windows 10, it detects a corrupted system file. The cbs.log file shows that %windir%\syswow64\opencl.dll is detected to be corrupted.

For more information about how to analyze the `SFC /scannow` result, see [Analyze the log file entries that SFC.exe generates in Windows Vista](/troubleshoot/windows-client/deployment/analyze-sfc-program-log-file-entries).

## Resolution

To fix this issue, run the following command:

```console
Dism /online /cleanup-image /restorehealth
```
