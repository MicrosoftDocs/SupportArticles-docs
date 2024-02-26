---
title: Fix heavy memory usage in ReFS
description: Discusses memory pressure and performance issues that occur in the Resilient File System (ReFS) in Windows. Provides a resolution and workarounds.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:partition-and-volume-management, csstroubleshoot
---
# FIX: Heavy memory usage in ReFS on Windows

This article provides a solution to memory pressure and performance issues that occur in the Resilient File System (ReFS) in Windows.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 4016173

## Symptoms

You notice heavy memory usage on a computer that's running Windows 10, Windows Server 2016, Windows Server 2019, Windows Server, 1903 or Windows Server, version 1909.

## Cause

To provide greater resiliency for its metadata, the Resilient File System (ReFS) in Windows Server 2016 uses allocate-on-write semantics for all metadata updates. Which means that ReFS never makes in-place updates to metadata. Instead, it makes all writes to newly allocated regions.

However, allocating-on-write causes ReFS to issue more metadata I/O to new regions of the volume than write-in-place file systems do. Additionally, ReFS uses block caching logic to cache its metadata in RAM. It isn't as resource-efficient as file caching logic.

Together, the ReFS block caching logic and allocate-on-write semantics cause ReFS metadata streams to be large. ReFS uses the cache manager to create the metadata streams, and the cache manager lazily unmaps inactive views. In some situations, this lazy unmapping causes the active working set on the server to grow. This creates memory pressure that can cause poor performance.

## Resolution

This issue is addressed in cumulative update 4013429 that was released on March 14, 2017. The update introduces three tunable registry parameters.

Cumulative update 4013429 is available through Windows Update. You can also download it directly through the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=4013429).

For more information, see [March 14, 2017—KB4013429 (OS Build 14393.953)](https://support.microsoft.com/help/4013429/)

## How to set the tunable parameters

This update provides three tunable registry parameters to address large ReFS metadata streams. You can use the following optional methods to set the parameters. These parameters can be used in any combination because they don't overlap functionally.

> [!IMPORTANT]
>
> - A restart is required for these parameter changes to take effect.
> - These parameters must be set consistently on every node of a failover cluster.

## Option 1

This option causes ReFS to try a complete an MM unmap of all metadata streams at every checkpoint. This option will produce the expected result only if the volume is idle and doesn't have any mapped pages.

Specify the indicated values in the following subkey:  

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem`  
Value Name: **RefsEnableLargeWorkingSetTrim**  
Set RefsEnableLargeWorkingSetTrim = **1**  
Value Type: **REG_DWORD**  

## Option 2

ReFS has a lazy MM unmap logic. So when ReFS cycles the entire namespace to complete an MM unmap, it unmaps at a certain granularity. The amount of virtual address space that is unmapped is determined by the following formula:

RefsNumberOfChunksToTrim *128 MB (for volume of size > 10 TB)
RefsNumberOfChunksToTrim* 64 MB (for volume of size < 10 TB)

This option works if the VA range that's being unmapped doesn't have any active references (that is, mapped metadata pages).

Specify the indicated values in the following subkey:  

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem`  
Value Name: **RefsNumberOfChunksToTrim**  
Value Type: **REG_DWORD**  
DEFAULT (if not set or 0): **4**  

> [!NOTE]
> Setting **RefsNumberOfChunksToTrim** to higher values causes ReFS to trim more aggressively. It reduces the amount of memory that's being used. Set the trim value to an appropriate number: 8, 16, 32, and so on.

## Option 3

In this option, ReFS sends down an MM trim inline while it unmaps its metadata page. This is the most aggressive option because it can cause performance regression if ReFS is used on high-performance media, such as an SSD or NVMe.

Specify the indicated values in the following subkey:  

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem`  
Value Name: **RefsEnableInlineTrim**  
Value Type: **REG_DWORD**  
Set **RefsEnableInlineTrim = 1**  

**Recommendation:**  

If a large active working set causes poor performance, first try to set **RefsEnableLargeWorkingSetTrim = 1**.

If this setting doesn't produce a satisfactory result, try different values for **RefsNumberOfChunksToTrim**, such as 8, 16, 32, and so on.

If this still doesn't provide the wanted effect, set **RefsEnableInlineTrim = 1**.

## More information

To update its metadata, ReFS uses allocate-on-write instead of writing-in-place to improve its resiliency to corruption.  

Writing-in-place is susceptible to torn writes. It occurs if a power failure or an unexpected dismount causes a write to be only partially completed.  

Allocating-on-write enables ReFS to reliably maintain metadata consistency after a power failure or an unexpected dismount. It's because ReFS can still reference the previous, consistent metadata copy.  

## References

- [Resilient File System (ReFS) overview](/windows-server/storage/refs/refs-overview)
