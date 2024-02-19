---
title: New logging mechanism for VDS
description: The old VDS logging mechanism is removed in Windows 8 and a new one is introduced.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, lichunli
ms.custom: sap:partition-and-volume-management, csstroubleshoot
---
# Introduce the new logging mechanism for the VDS

This article introduces the new logging mechanism for Virtual Disk Service (VDS) in Windows Server 2012.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2759114

## Introduction

The VDS in Microsoft Windows Server is a set of APIs that provides a single interface to manage disks. The VDS provides an end-to-end solution to manage storage hardware and disks and to create volumes on the disks. This article introduces the new logging mechanism for VDS in Windows Server 2012. The VDS logging for previous version of Windows is removed.

## More information

To help you troubleshoot any problems with the VDS, capture VDS trace. To capture VDS trace, follow these steps:

1. Open an elevated command prompt, and then run the following commands:
    1. `md %systemroot%\system32\LogFiles\VDS`
    2. `Logman start vds -o %systemroot%\system32\LogFiles\VDS\VdsTrace.etl -ets -p {012F855E-CC34-4da0-895F-07AF2826C03E} 0xffff 0xff`
2. Reproduce the problem.
3. After repro, go back to the command prompt from step 1 and run the following command to stop the VDS trace:
    1. `Logman stop vds -etsTrace file Vds`

Trace.etl can be found under `%systemroot%\system32\LogFiles\VDS\`. Use TraceView.exe to browse the file or send the VdsTrace.etl file to Microsoft customer support. Customers must obtain the corresponding operating system symbol files from Microsoft public symbol servers in order to read the VdsTrace.etl file. More information about TraceView.exe, click on the following article:

[TraceView](/windows-hardware/drivers/devtest/traceview)
