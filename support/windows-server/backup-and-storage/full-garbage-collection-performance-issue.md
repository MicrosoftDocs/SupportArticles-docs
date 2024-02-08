---
title: Full garbage collection causes performance issues
description: Describes issues that are triggered by the data churn that is associated with full garbage collection jobs in Windows Server. Provides workarounds.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:deduplication, csstroubleshoot
---
# Churn from Full Garbage Collection during deduplication can cause performance problems in Windows Server

This article provides workarounds for performance problems that are caused by the churn from full garbage collection during deduplication.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3066175

## Symptoms

Full garbage collection jobs reclaim more free space than "regular" garbage collection. However, full garbage collection generates much more churn on the volume. This is because every chunk container is compacted (rewritten) if there are any unreferenced chunks.

This churn on the volume may cause the following problems and side effects:

- Deletion of Volume Shadow Copy Service (VSS) shadow copies
- Heavy I/O load on the system, especially if the server is already running a high-churn or IO-intensive deduplication workload
- Increased volume workloads for some solutions (such as incremental backup and file replication) that grow because of file churn

## Cause

This behavior may occur in the following situations:

- When a workload includes many file deletes or file in-place writes. This causes many chunks to become unreferenced. Problems are also triggered by deletes that cause many chunk containers with old and new chunks to experience compaction.
- When a system has relatively little physical free space, NTFS first uses free space that doesn't cause shadow copy storage-area consumption. If the volume has little free space, NTFS allocates space for new files in areas that trigger "copy on write" behavior. When the storage area runs out, VSS deletes the shadow copies.

## Workaround

To work around these issues, use one of the following methods:

- Configure VSS to use a separate (possibly dedicated) volume for its diff area ("shadow storage area"). You can do this by using Vssadmin.exe and other tools. This workaround helps with the shadow-copy deletion issue.

    > [!NOTE]
    > There are other performance benefits to having the diff area on dedicated volumes.  

- Configure deduplication not to run **Full GC**  but to run garbage collection only in regular mode. By default, garbage collection jobs are scheduled to run weekly. Also by default, every fourth garbage collection job is set to run in Full GC (on a monthly cadence).

    > [!NOTE]
    > You can run Full GC on demand by manually running the following Windows PowerShell command:  
    >
    > `Start-DedupJob <volume> -Type GarbageCollection -Full`  

To prevent Full GC, configure the following registry key:  
 `HKLM\System\CurrentControlSet\Services\ddpsvc\Settings /v DeepGCInterval /t REG_DWORD /d 0xffffffff`  

If the system is clustered, you will have to configure the following registry key instead:  
 `HKLM\CLUSTER\Dedup\ /v DeepGCInterval /t REG_DWORD /d 0xffffffff`  

This workaround helps to reduce all the side effects that are described in the "Symptoms" section. However, regular-mode garbage collection is not as thorough as Full GC. Some unreferenced deduplication chunks may not be reclaimed if the system never runs Full GC. Nevertheless, regular-mode garbage collection should still reclaim more than 95 percent of unreferenced data.

On a system that's running Windows Server 2012, make sure that [hotfix 2897997](https://support.microsoft.com/help/2897997) is installed. (This is not necessary for Windows Server 2012 R2.)
