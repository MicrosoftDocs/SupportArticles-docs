---
title: ReFS volume using DPM becomes unresponsive on Windows Server 2016
description: Describes an issue in which DPM or ReFS volume becomes unresponsive on Windows Server 2016.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jeffbo
ms.custom: sap:partition-and-volume-management, csstroubleshoot
---
# ReFS volume using DPM becomes unresponsive on Windows Server 2016

This article helps to resolve an issue in which DPM or ReFS volume becomes unresponsive on Windows Server 2016.

_Applies to:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4035951

## Symptom

You notice a Resilient File System (ReFS) volume that uses Data Protection Management (DPM) become unresponsive or freeze when you perform backups, specifically when DPM issues large block-clone operations.

## Cause  

DPM uses loopback-mounted-VHDs. These appear like normal disks to the OS. Therefore, these disks are displayed in Windows Explorer, Diskmgt, and other GUI tools. These tools periodically poll the disks to make sure that they are functioning correctly. This causes IOs to be sent down the loopback stack to the ReFS volume. If the ReFS volume is busy, these IOs will have to wait. Therefore, when ReFS performs a long-duration operation, such as flushing or a large block-clone call, these IOs will have to wait longer. When these IOs are stuck, the UI of Explorer or Diskmgt won't be refreshed. As a result, it appears like the disks are hung or dismounted.

Additionally, the loopback mount miniport driver (vhdmp) starts generating warning events if any IOs don't complete within 30 seconds.

> [!NOTE]
> No IO or file-system-operation fails during this process. All operations will succeed, and they will just take longer. Also, no volume will be dismounted. This issue is only a file-system-operation latency issue, which causes the UI to be stuck and port drivers to log errors.

## Resolution

This issue is resolved in the [July 18, 2017 cumulative update](https://support.microsoft.com/help/4025334/). The fix contains:

- Three tunable registry parameters
- A policy change that avoids making unnecessary volume flushes, which prevents ReFS from adding heavy latency to ongoing ReFS IOs.

## More Information

### How to set the tunable parameters

> [!IMPORTANT]
> Before you follow these steps, make sure that you have read and implemented the three registry parameters as described in [KB article 4016173](https://support.microsoft.com/help/4016173/fix-heavy-memory-usage-in-refs-on-windows-server-2016-and-windows-10). If these don't adequately address any issues that you encounter,do not disable these registry parameters. These parameters and the ones described in this section do not overlap functionally, so they can be used together.  

This update describes additional registry parameters that help address the latency issues described in the "Symptoms" section. These parameters can be used in any combination.  

> [!Warning]
> Serious problems might occur if you change the registry incorrectly by using Registry Editor or by using another method. These problems might require you to reinstall the operating system. Microsoft cannot guarantee that these problems can be resolved. Change the registry at your own risk.  

> [!IMPORTANT]
>
> - A restart is required for these parameter changes to take effect.
> - These parameters must be set consistently on every node of a failover cluster.

### Tunable parameters

#### Option 1

This option disables cached pins, which were a major cause of the large active working set.  

Specify the indicated values in the following subkey:  

- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem`
- Value Name: RefsDisableCachedPins  
- Set RefsDisableCachedPins = 1
- Value Type: REG_DWORD

#### Option 2

This option adds a heuristic to ReFS checkpointing logic, which causes ReFS to checkpoint when the delete queue reach a certain size. IOs are stuck on ReFS because the checkpoint logic would get stuck processing a large delete queue.  

Specify the indicated values in the following subkey:  

- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem`
- Value Name: RefsProcessedDeleteQueueEntryCountThreshold  
- Set RefsProcessedDeleteQueueEntryCountThreshold = 2048  
- Value Type: REG_DWORD

> [!Note]
> Setting RefsProcessedDeleteQueueEntryThreshold to lower values causes ReFS to checkpoint more frequently. Set the value to 2048, then reduce the value to 1024, then 512.  

#### Option 3

Large duplicate extents calls introduce latency into the system, as other operations will have to wait until these long-running operations are complete. This option reduces the size of the duplicate extents call.

> [!Note]
> DPM will set this registry key change as the default value as part of UR4, which will release within August 2017.

Specify the indicated values in the following subkey:  

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Data Protection Manager\Configuration\DiskStorage`
- Value Name: DuplicateExtentBatchSizeinMB
- Set DuplicateExtentBatchSizeinMB = 100. (Default is 2000 [2GB]. Any value from 1 - 4095 is accepted).
- Value Type: REG_DWORD

#### Option 4

This option extends the TimeOutValue.  

Specify the indicated values in the following subkey:  

- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Disk`
- Value Name: TimeOutValue  
- Set TimeOutValue (in seconds) = 0x78  
- Value Type: REG_DWORD

> [!Note]
> The default value for TimeOutValue is 0x41 (65 decimal). 0x78 translates to 120 decimal.
