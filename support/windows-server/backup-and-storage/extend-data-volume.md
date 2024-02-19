---
title: Extend a data volume
description: Describes how to use the Diskpart.exe command prompt utility to extend a data volume in unallocated space. Also describes how to extend the boot partition.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:partition-and-volume-management, csstroubleshoot
---
# Extend a data volume in Windows

This article describes the following topics:

- How to use the Diskpart.exe command prompt utility to extend a data volume into unallocated space in Windows Server 2003, Windows XP, and Windows 2000.
- How to extend the boot partition in Windows Server 2008.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 325590

## Use Diskpart.exe to extend a data volume in Windows Server 2003, in Windows XP, and in Windows 2000

You can use the Diskpart.exe utility to manage disks, partitions, and volumes from a command-line interface. You can use Diskpart.exe on both Basic disks and Dynamic disks. If an NTFS volume resides on a hardware RAID 5 container that can add space to the container, you can extend the NTFS Volume with Diskpart.exe while the disk remains a Basic disk.

Use the extend command to incorporate unallocated space into an existing volume while preserving the data.

The following are the requirements for the extend command:

- The volume must be formatted with the NTFS file system.
- For Basic volumes, the unallocated space for the extension must be the next contiguous space on the same disk.
- For Dynamic Volumes, the unallocated space can be any empty area on any Dynamic disk on the system.
- Only the extension of data volumes is supported. System or boot volumes may be blocked from being extended, and you may receive the following error:

    > Diskpart failed to extend the volume. Please make sure the volume is valid for extending

- You can't extend the partition if the system page file is located on the partition. Move the page file to a partition that you don't want to extend.

To extend a partition or volume, first select the volume to give it the focus, and then specify how large to make the extension. To extend a volume, follow these steps:

1. At a command prompt, type *diskpart.exe*.
2. Type list volume to display the existing volumes on the computer.
3. Type *Select volume \<volume number>* where \<volume number> is number of the volume that you want to extend.
4. Type extend *[size=n] [disk=n] [noerr]*. The following section describes the parameters:

    - size=n

        The space, in megabytes (MB), to add to the current partition. If you don't specify a size, the disk is extended to use all the next contiguous unallocated space.

    - disk=n

        The dynamic disk on which to extend the volume. Space equal to size=n is allocated on the disk. If no disk is specified, the volume is extended on the current disk.

    - noerr

        For scripting only. When an error is thrown, this parameter specifies that Diskpart continue to process commands as if the error didn't occur. Without the noerr parameter, an error causes Diskpart to exit with an error code.

5. Type *exit* to exit Diskpart.exe.

When the extend command is complete, you should receive a message that states that Diskpart successfully extended the volume. The new space should be added to the existing drive while maintaining the data on the volume.

In Windows XP and Windows 2000, you can't use Diskpart.exe to extend a simple volume on a Dynamic disk that was originally created on a Basic disk. You can extend only simple volumes that were created after the disk was upgraded to Dynamic disk. If you try to extend a simple volume on a Dynamic disk that was originally created on a Basic disk, you receive the following error message. This restriction was removed in Windows Server 2003.

> Diskpart failed to extend the volume.  
> Please make sure the volume is valid for extending

> [!NOTE]
>
> - Windows Server 2003 and Windows XP include Diskpart.exe as part of the base operating system.
> - We recommend that you contact your system vendor for updated BIOS, firmware, drivers, and agents before you convert to Dynamic disks.

## Extend the boot partition in Windows Server 2008

To extend the boot partition in Windows Server 2008, follow these steps:

1. Click **Start** > **Server Manager**.
2. In the navigation pane, expand **Storage**, and then click **Disk Management**.
3. In the details pane, right-click the volume that you want, and then click **Extend Volume**.
4. Follow the instructions in the Extend Volume Wizard to extend the boot partition.

> [!NOTE]
> You can only extend the boot partition in contiguous unallocated disk space.
