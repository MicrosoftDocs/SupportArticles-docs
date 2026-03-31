---
title: Can't extend a disk volume because of the file system cluster limit
description: Discusses how to fix an error that occurs when you try to extend a disk volume and the requested size would exceed the maximum number of clusters (also called allocation units) that the file system supports.
ms.date: 04/01/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-appelgatet
ai.usage: ai-assisted
ms.custom:
- sap:backup,recovery,disk,and storage\partition and volume management
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Can't extend a disk volume because of the file system cluster limit

## Summary

This article helps you fix an error that occurs when you try to extend a disk volume and the requested size would exceed the maximum number of clusters (also called allocation units) that the file system supports. The article includes steps to fix the issue by adjusting the target volume size, creating an additional volume, or reformatting the volume.

## Symptoms

When you attempt to extend an existing disk volume, you receive an error message that resembles the following example:  

> The volume cannot be extended because the number of clusters will exceed the maximum number supported by the file system.

Before you tried to extend the volume, there weren't any recent configuration changes, system updates, or troubleshooting steps.  

## Cause

This issue occurs when the requested disk volume size exceeds the maximum number of clusters per volume that the current file system supports.

The number of clusters in a volume depends on the size of the volume and the size of the clusters. The maximum number of clusters per volume depends on the file system, such as NTFS (New Technology File System) or FAT32 (File Allocation Table 32), and the version of Windows. For more information, see the [Support for large volumes](/windows-server/storage/file-server/ntfs-overview#support-for-large-volumes) section of "NTFS overview."

If the volume extended beyond this limit, the file system wouldn't be able to use all the space. Therefore, Windows doesn't allow the extension.  

## Resolution

To resolve this issue, use one of the following methods:  

- **Adjust the target volume size**. Reduce the amount by which you want to extend the disk, so that the number of clusters stays within the supported limit of your current file system.

  > [!NOTE]  
  > If you aren't sure about the cluster limits for your file system, see the following resources:
  >
  > - [Description of Default Cluster Sizes for FAT32 File System](https://support.microsoft.com/topic/description-of-default-cluster-sizes-for-fat32-file-system-905ea1b1-5c4e-a03f-3863-e4846a878d31)
  > - [Support for large volumes](/windows-server/storage/file-server/ntfs-overview#support-for-large-volumes) in "NTFS overview."

- **Create and use an additional volume**. If reformatting the volume isn't an option, create an additional volume instead of extending the existing one.

- **Reformat the volume**. If it's feasible to reformat the volume, you can change the file system that the volume uses. For example, NTFS supports higher cluster limits than FAT32.

  > [!IMPORTANT]  
  >
  > - Before you reformat the volume, back up any data in the volume. Reformatting deletes all data in the volume.
  > - As the volume size increases, the default cluster size also increases and the number of clusters per volume decreases. If you're using NTFS or the Resilient File System (ReFS), you can change the cluster size when you reformat the volume. However, doing so might introduce performance issues and might not help resolve the cluster-per-volume limit issue. For more information, see the following resources:
  >
  >   - [Support for large volumes](/windows-server/storage/file-server/ntfs-overview#support-for-large-volumes) in "NTFS overview."
  >   - [Cluster size is too large](disk-space-problems-on-ntfs-volumes.md#cluster-size-is-too-large) in "Locate and correct disk space problems on NTFS volumes."
  >   - [Cluster size recommendations for ReFS and NTFS](https://techcommunity.microsoft.com/blog/filecab/cluster-size-recommendations-for-refs-and-ntfs/425960).

## Data collection

If you need to contact Microsoft Support for assistance, gather the following information:  

- A screenshot of the Disk Management tool that shows all the partitions and unallocated space.
- The version of Windows that you're using. To find this information, go to **Settings** > **System** > **About**.
- The file system type of the affected volume (for example, NTFS, FAT32, exFAT).
- The current size of the volume and the size you attempted to extend it to.
- The exact error message that you received when the extension failed.
- Any recent changes to the storage configuration or hardware.

To collect information about the volume, use the **Disk Management** tool or the [`diskpart`](/windows-server/administration/windows-commands/diskpart) command-line utility. For example, open an administrative Command Prompt window, and then run the following commands:

```console
diskpart
list volume
```

Identify the affected volume in the list, and then run the following commands:

```console
select volume <VolumeNumber>
detail volume
```

> [!NOTE]  
> In these commands, \<VolumeNumber> represents the number that's assigned to the volume in the list.

## References

- [Disk Management in Windows](https://learn.microsoft.com/windows-server/storage/disk-management/overview-of-disk-management)
- [`diskpart`](/windows-server/administration/windows-commands/diskpart)
- [NTFS overview](/windows-server/storage/file-server/ntfs-overview)
- [Locate and correct disk space problems on NTFS volumes](disk-space-problems-on-ntfs-volumes.md)
- [Cluster size recommendations for ReFS and NTFS](https://techcommunity.microsoft.com/blog/filecab/cluster-size-recommendations-for-refs-and-ntfs/425960)
- [Description of Default Cluster Sizes for FAT32 File System](https://support.microsoft.com/topic/description-of-default-cluster-sizes-for-fat32-file-system-905ea1b1-5c4e-a03f-3863-e4846a878d31)
