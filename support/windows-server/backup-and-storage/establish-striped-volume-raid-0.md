---
title: How to establish a striped volume (RAID 0) in Windows Server 2003
description: Describes the steps to establish a striped volume (RAID 0) in Windows Server 2003.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:partition-and-volume-management, csstroubleshoot
ms.technology: windows-server-backup-and-storage
---
# How to establish a striped volume (RAID 0) in Windows Server 2003

This article describes the steps to establish a striped volume (RAID 0) in Windows Server 2003.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 323433

## Summary

A striped volume (RAID 0) combines areas of free space from multiple hard disks (anywhere from 2 to 32) into one logical volume. Data that is written to a striped volume is interleaved to all disks at the same time instead of sequentially. Therefore, disk performance is the fastest on a RAID 0 volume as compared to any other type of disk configuration. Administrators prefer to use striped volumes when input/output (I/O) speed is important. Any file system, including FAT, FAT32, or NTFS, can be used on a striped volume.

## Requirements

- There must be at least two hard disk drives. IDE, small computer system interface (SCSI), or mixed architecture is permissible.
- All disks involved in the striped volume must be dynamic disks.
- Each portion of the free space must be exactly the same (for example, the size and file system type).

## How to set up the Disk Management system

1. Click **Start**, point to **Administrative Tools**, and then click **Computer Management**.
2. Expand the **Storage** node.
3. Click **Disk Management**.
4. On the **View** menu, point to **Top**, and then click **Disk List**.

    In the right pane, a column appears that lists the attributes of each disk in the system.
5. On the **View** menu, point to **Bottom**, and then click **Graphical View**.

    A color-coded graphical view of the disks on the system is displayed.

The Disk Description pane (which is displayed in gray) is positioned on the left side of the volume description, which is displayed in color. The disk description contains information about each disk's disk number, whether it's a basic or dynamic configuration, its size, and its status (online or offline).

The volume descriptions are color-coded. They hold information about each volume, such as the drive letter (if assigned), whether the volume is allocated or unallocated, the partition or volume size, and the health status of the volume.

## Requirements to make sure that disks are set up to support a striped volume

- **Disks**: A minimum of two disks are needed to support striping.
- **Type**: Any disks involved in striping must be dynamic. Conversion from basic to dynamic goes very quickly without data loss. After you complete the conversion procedure, you must restart the computer.
- **Capacity**: The striped volume can take the whole disk or as little as 50 megabytes (MB) for each disk.
- **Unallocated space**: Any disks that you want to upgrade to a dynamic disk must contain at least 1 MB of free space at the end of the disk for the upgrade to succeed. Disk Management automatically reserves this free space when it creates partitions or volumes on a disk, but disks with partitions or volumes that are created by other operating systems may not have this free space available.
- **Status**: The status of all disks involved in a striped volume must be online when you create the striped volume.
- **Device Type**: You can install striping on any dynamic disk even if there are mixed drive architectures on the system. For example, IDE, Enhanced IDE (EIDE), and SCSI drives can all be used in one striped volume.

## How to upgrade to dynamic disks

If the disks that are going to be involved in the striped volume are already dynamic disks, proceed to the "How to Convert to Striped Volume" section of this article.

> [!NOTE]
> You must be logged on as an administrator or a member of the Administrators group to complete this procedure. If your computer is connected to a network, network policy settings may also prevent you from completing this procedure.

To upgrade a basic disk to a dynamic disk:

1. Before you upgrade disks, quit any programs that are running on those disks.
2. Right-click the gray Disk Description pane that is located to the left of the color-coded volume panes, and then click **Upgrade to Dynamic Disk**.
3. If the second disk isn't a dynamic disk, follow steps 1 and 2 to upgrade it to a dynamic disk.

## How to convert to striped volume

In this scenario, there are two disks on the computer, Disk 0 and Disk 1. Both disks are dynamic disks and have at least 1 gigabyte (GB) of free unallocated space on each disk for a total volume of 2 GB.

1. In the lower-right pane of the Disk Management tool, right-click the free, unallocated volume space on either disk, and then click **Create Volume**.
2. After the Create Volume Wizard starts, click **Next**.
3. Under **Volume Type**, click **Striped Volume** > **Next**.
4. In the left pane under **Select Two or More Disks**, a list is displayed that contains all disks that have enough free, unallocated space to participate in the striped volume.

    In the right pane under **Selected**, the disk that you right-clicked in step 1 is displayed.
5. In the left pane under **All Available Dynamic Disks**, click the disk, and then click **Add**.

    All disks that are displayed in the right pane are labeled **Selected**. View the bottom of the **Select Disk** dialog box under the **Size** label. The **For All Selected Disks** box displays the maximum size of the striped volume that you can make.

    > [!NOTE]
    > The volume on each disk is the same size in the completed striped volume. For example, if you have 100 MB on the first disk, you have 100 MB on the second disk. Therefore, the total size of your combined volumes is double that of the smaller of the volumes on the two disks.

    You can reduce the size of the volume by modifying the value in the **Disk Size** box. Keep in mind that on a system that has two disks, the total striped volume size is double the size that you enter. The **Total Volume Size** box under the right pane displays the actual size of the striped volume.
6. Click **Next** to advance to the Assign Drive Letter Path page of the wizard.
7. At this time, you may want to assign a drive letter to your striped volume (you can also do this at any other time). To do so, click **Assign Drive Letter**, and then enter an available drive letter.

    Alternatively, you can click **Do not assign drive letter or path**. You can also click **Mount this volume on an empty folder that supports drive paths**. However, this selection is beyond the scope of this article.
8. After you enter a drive letter for your striped volume, click **Next**.
9. Click **Format this partition with the following settings**, and then follow these steps:

    1. Enter the file system type.

        Note that FAT32 or NTFS is acceptable.
    2. Leave the default selection in the **Allocation Unit Size** box.
    3. In the **Volume Label** box, you can keep the default **New Volume** label or you can type you own label.
    4. At this time, you can click to select the **Quick Format** and **File and Folder Compression** check boxes. Or you can defer both of these tasks if you want.
10. Click **Next**, check your selection in the Summary window, and then click **Finish**.

The striped volumes are displayed on the two disks on your system. They have the same color code, the same drive letter (if you mapped the drive during the procedure), and they're both the same size.

## Troubleshooting

- Don't mix hardware RAID 0 with software RAID 0.
- A striped volume can't hold the system or boot partition of a Windows Server 2003-based system.
- You can't extend or mirror striped volumes.
- There's no fault tolerance on a striped volume. This means that if one of the disks becomes damaged or no longer functions properly, the whole volume is lost.
