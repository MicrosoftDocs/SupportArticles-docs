---
title: Mirror the system and boot partition
description: Describes how to mirror the system and boot partition (RAID1).
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:partition-and-volume-management, csstroubleshoot
---
# How to mirror the system and boot partition (RAID1) 

This article describes how to mirror the system and boot partition (RAID1).

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 323432

## Summary

This step-by-step article describes how to mirror the system and boot partition in Windows Server 2003. This scenario is based on the assumption that the system and boot files are located on disk 0 and that disk 1 is unallocated space.

### Requirements

- At least two hard-disk drives; IDE, small computer system interface (SCSI), or mixed architecture is permissible.
- The second drive must be at least the size of the volume on which the operating system boot and system files reside to permit mirroring.
- The Windows Server 2003 system and boot files must reside on the same volume to be mirrored.  

> [!NOTE]
> The memory dump file is written only to the boot hard disk. Windows Server 2003 can continue to work with a mirrored system disk configuration even if one of the disks in the mirror is removed. However, the memory dump file cannot be written to the remaining system disk in the mirror. You must schedule a system restart for the memory dump file to be written to the remaining hard disk.

### Set up the disk management system

1. Click Start, point to Administrative Tools, and then click Computer Management to open the Computer Management console.
2. Expand the Storage node.
3. Click Disk Management.
4. On the View menu, point to Top, and then click Disk List.  
    In the right pane, the attributes of each disk in the system are displayed.
5. On the View menu, point to Bottom, and then click Graphical View.

    At the bottom of the right pane, a color-coded graphical view of the disks on the system is displayed:

    - Disk description panel: The disk description panel (which is gray) is located to the left of the volume description, which is in color. The disk description contains information about each disk's disk number, whether its configuration is *basic* or *dynamic*, its size, and its online or offline status.
    - Volume description panel: The volume description panels are color-coded. They hold information about each volume, such as the drive letter (if assigned), whether the volume is allocated or unallocated, the partition or volume size, and the health status of the volume.

### Upgrade to dynamic disks

RAID systems require dynamic disks in Windows Server 2003. Any disks that you are upgrading must contain at least 1 megabyte (MB) of free space at the end of the disk for the upgrade to succeed. Disk Management automatically reserves this free space when it creates partitions or volumes on a disk, but disks with partitions or volumes that are created by other operating systems may not have this free space available.

> [!NOTE]
> You must be logged on as an administrator or a member of the Administrators group to complete this procedure. If your computer is connected to a network, network policy settings may also prevent you from completing this procedure.

To upgrade a basic disk to a dynamic disk, follow these steps:

1. Before you upgrade disks, quit any programs that are running on those disks.
2. Right-click the gray disk description panel, and then click
 **Upgrade to Dynamic Disk**.
3. If the second disk is not a dynamic disk, follow these steps to upgrade it to a dynamic disk.

### Mirror the boot and system volume

In this scenario, disk 1 is the disk on which the image of disk 0 will be mirrored.

> [!NOTE]
> Partitions are referred to as *volumes* when the disks are dynamic.

1. Disk 1 must be unallocated space before you can proceed with mirroring.
2. Right-click disk 0 (which contains the boot and system files), and then click Add Mirror.
3. A dialog box opens in which any disk on your system that is available for mirroring is displayed. Select the disk of your choice (in this example, it is disk 1), and then click Add Mirror.

    Both disk 0 and disk 1 will now have the same color code, the same drive letter, and the volumes will have the status note "Regenerating" displayed while the information is being copied from the first disk to the second disk. The system will automatically size the volume of the new mirror to the same size as of the original boot and system volume.
4. If you now want to boot from the new mirrored disk, you have to change the Boot.ini ARC path that points the computer to the partition in which the system files are located.

### Troubleshooting

After you upgrade a basic disk to a dynamic disk, any existing partitions on the basic disk become (dynamic) simple volumes. You cannot change the dynamic volumes back to partitions.

A dynamic disk cannot contain partitions or logical drives, nor can it be accessed by MS-DOS or by any Windows operating systems other than Windows Server 2003.

> [!IMPORTANT]
> Do not use a hardware RAID solution and a software RAID solution on the same disk.
