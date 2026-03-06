---
title: Tuning memory usage in ReFS
description: Discusses how to apply a cumulative update and configure registry entries to reduce ReFS memory usage.
ms.date: 03/09/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:backup, recovery, disk, and storage\partition and volume management
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Tuning memory usage in ReFS on Windows

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 4016173

## Summary

Resilient File System (ReFS) can consume large amounts of memory because of its allocate-on-write metadata semantics and block caching logic. On systems that run Windows Server 2016, Windows Server 2019, or related versions, this behavior can cause memory pressure that degrades server performance.

This article describes the cause of the issue and explains how to apply a cumulative update and configure registry entries to reduce ReFS memory usage.

## Symptoms

You notice heavy memory usage on a computer that's running Windows 10, Windows Server 2016, Windows Server 2019, Windows Server, 1903 or Windows Server, version 1909.

## Cause

To provide greater resiliency for its metadata, the Resilient File System (ReFS) in Windows Server 2016 uses *allocate-on-write* semantics for all metadata updates. This approach means that ReFS never makes in-place updates to metadata. Instead, it makes all writes to newly allocated regions.

However, allocating-on-write causes ReFS to issue more metadata I/O to new regions of the volume than write-in-place file systems do. Additionally, ReFS uses block caching logic to cache its metadata in RAM. It isn't as resource-efficient as file caching logic.

Because of the ReFS block caching logic and allocate-on-write semantics, ReFS uses large metadata streams. ReFS uses the cache manager to create the metadata streams, and the cache manager unmaps inactive views in a lazy manner. In some situations, this lazy unmapping causes the active working set on the server to grow. This growth creates memory pressure that can, in turn, cause poor performance.

## Resolution

This issue is addressed in cumulative update 4013429, which was released on March 14, 2017. The update introduces three tunable registry entries that you can use to adjust large ReFS metadata streams.

Cumulative update 4013429 is available through Windows Update. You can also download it directly from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=4013429).

For more information, see [March 14, 2017—KB4013429 (OS Build 14393.953)](https://support.microsoft.com/help/4013429/)

### How to set the tunable registry entries

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

You can use Registry Editor or command-line commands (such as `reg add`) to set the registry entries. The scopes of these parameters don't overlap, so you can use them in any combination. The registry entries are all under the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem` subkey.

| Value name | Type | Default value | Effects |
| --- | --- | --- | --- |
| `RefsEnableLargeWorkingSetTrim` | REG_DWORD | | When set to 1, ReFS tries to a complete an MM unmap of all metadata streams at every checkpoint. |
| `RefsNumberOfChunksToTrim` | REG_DWORD | 4 | Affects the granularity at which ReFS unmaps when it cycles the entire namespace. Setting `RefsNumberOfChunksToTrim` to higher values causes ReFS to trim more aggressively. It reduces the amount of memory that's being used. |
| `RefsEnableInlineTrim` | REG_DWORD | | |

> [!IMPORTANT]
>
> - After you change these parameters, you have to restart the computer.
> - On a failover cluster, you have to set these parameters the same way on every cluster node.

If you see poor performance because of a large active working set, follow these steps to tune ReFS behavior.

1. Verify that the volume is idle and doesn't have any mapped pages, and then set `RefsEnableLargeWorkingSetTrim` to `1`. Then monitor the system to see if performance improves.
1. If performance doesn't improve sufficiently, verify that the VA range that's being unmapped doesn't have any active references (that is, mapped metadata pages).
1. Change the value of `RefsNumberOfChunksToTrim`. Try different values, such as `8`, `16`, `32`, and so forth.
   > [!NOTE]  
   > The following formulas determine the granularity at which ReFS unmaps virtual address space:
   >
   > - `RefsNumberOfChunksToTrim` \* 128 MB (for volume of size > 10 TB)
   > - `RefsNumberOfChunksToTrim` \* 64 MB (for volume of size < 10 TB)
1. If performance still doesn't improve, set `RefsEnableInlineTrim` to `1`.

## More information

To improve its resiliency to corruption, ReFS uses allocate-on-write instead of writing-in-place to update its metadata. A power failure or an unexpected dismount can cause "torn writes" (writes that are only partially completed) in a system that uses writing-in-place. However, under the same circumstances, a system that uses allocate-on-write can still reference the previous, consistent metadata copy. In this manner, ReFS reliably maintains metadata consistency.

## References

- [Resilient File System (ReFS) overview](/windows-server/storage/refs/refs-overview)
