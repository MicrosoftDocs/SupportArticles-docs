---
title: Use the Disk Management Snap-in
description: Describes how to use the Disk Management Snap-in to manage Basic and Dynamic Disks.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Backup, Recovery, Disk, and Storage\Partition and volume management , csstroubleshoot
---
# How to use the Disk Management Snap-in to manage Basic and Dynamic Disks  

This article describes how to use the Disk Management Snap-in to manage Basic and Dynamic Disks.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 323442

## Summary

You can use the Windows Server 2003 Disk Management snap-in tool to manage your hard disks and the volumes or partitions that they contain. With Disk Management, you can create and delete partitions; format volumes with the FAT, FAT32, or NTFS file systems; change basic disks to dynamic disks, and change dynamic disks back to basic disks; and create fault-tolerant disk systems. You can perform most disk-related tasks without having to restart your computer because most configuration changes take effect immediately. This article describes some of the more common disk storage management tasks that you can perform by using Disk Management.

### Start Disk Management

> [!NOTE]
> You must be logged on as Administrator or a member of the Administrators group to use Disk Management.

1. Click Start, point to Administrative Tools, and then click Computer Management.
2. In the console tree, click Disk Management.

    The Disk Management window that appears displays your disks and volumes in a graphical view or list view.

   To customize whether you view your disks and volumes in the upper or lower pane of the window, point to Top or Bottom on the View menu, and then click the view that you want.  

   > [!NOTE]
   > Before a new, unpartitioned disk can be used in Windows (partitioned or upgraded to Dynamic Disk), it must contain a disk signature. The first time that you run the Disk Management snap-in after a new hard disk is installed, the Disk Signature and Upgrade Disk Wizard starts. If you cancel the wizard, you may find that when you try to create a partition on the new hard disk, the Create Partition option is unavailable (appears dimmed).

### How to Manage Basic Disks

Basic disk storage supports partition-oriented disks. A basic disk is a physical disk that contains basic volumes (primary partitions, extended partitions, or logical drives). On master boot record (MBR) disks, you can create up to four primary partitions on a basic disk, or up to three primary partitions and one extended partition. You can also use free space on an extended partition to create logical drives. On GUID partition table (GPT) disks, you can create up to 128 primary partitions. Because you are not limited to four partitions on GPT disks, you do not have to create extended partitions on logical drives.

Use basic disks, instead of dynamic disks, on computers that run Microsoft Windows XP Professional or a member of Windows Server 2003 that are configured to dual-boot or multi-boot with Microsoft Windows XP Home Edition, Microsoft Windows NT 4.0, Microsoft Windows Millennium Edition (Me), Microsoft Windows 98 or earlier, or Microsoft MS-DOS. These operating systems cannot access data that is stored on dynamic disks.

> [!NOTE]
> Windows Server 2003 operating systems and Windows XP Professional do not support multidisk basic volumes (such as spanned, mirrored, stripe sets, or stripe sets with parity) that were created by using Windows NT 4.0 or earlier.

#### Create a New Partition or Logical Drive

1. In the Disk Management window, choose one to create:

   - To create a new partition, right-click unallocated space on the basic disk where you want to create the partition, and then click New Partition.

   -or-
   - To create a new logical drive, right-click free space on an extended partition where you want to create the logical drive, and then click New Logical Drive.
2. On the **Welcome to the New Partition Wizard** page, click Next.
3. On the Select Partition Type page, click the type of partition that you want to create, and then click Next.
4. On the Specify Partition Size page, specify the size in megabytes (MB) of the partition that you want to create, and then click Next.
5. On the **Assign Drive Letter or Path** page, enter a drive letter or drive path, and then click Next.
6. On the Format Partition page, specify the formatting options that you want, and then click Next.
7. On the **Completing the New Partition Wizard** page, verify that the options that you selected are correct, and then click Finish.  

Disk Management creates the new partition or logical drive and displays it in the appropriate basic disk in the Disk Management window. If you chose to format the partition in step 6, the format process now starts.

#### Format a Partition or Logical Drive

1. In the Disk Management window, right-click the partition or logical drive that you want to format, and then click Format.
2. Specify the formatting options that you want, and then click OK.
3. Click OK when you are prompted to confirm the formatting changes.

#### View the Properties of a Partition or Logical Drive

1. In the Disk Management window, right-click the partition or logical drive that you want to view the properties of, and then click Properties.
2. Click the appropriate tab to view a property.

#### Delete a Partition or Logical Drive

1. In the Disk Management window, right-click the partition or logical drive that you want to delete, and then click Delete Partition or Delete Logical Drive.
2. Click Yes when you are prompted to confirm the deletion.  

   >[!Note]  
   >
   >- When you delete a partition or logical drive, you delete all data on that partition or logical drive and the partition or logical drive itself.
   >- You cannot delete the system partition, the boot partition, or a partition that contains the active paging (swap) file.
   >- You cannot delete an extended partition unless the extended partition is empty. You must delete all logical drives before you can delete the extended partition.

#### Change a Basic Disk to a Dynamic Disk

Before you change a basic disk to a dynamic disk, note the following instructions:

- You must have at least 1 megabyte (MB) of unallocated disk space available on any master boot record (MBR) basic disk that you want to change to a dynamic disk.
- When you change a basic disk to a dynamic disk, you change the existing partitions on the basic disk to simple volumes on the dynamic disk.
- After you change a basic disk to a dynamic disk, you cannot change the dynamic volumes back to partitions. Delete all dynamic volumes on the disk first, and then change the dynamic disk back to a basic disk.
- Windows Server 2003 operating systems, Windows XP Professional, and Windows 2000 support dynamic disks. After you change a basic disk to a dynamic disk, you can only access the disk locally from these operating systems.  

To change a basic disk to a dynamic disk:

1. In the graphical view of the Disk Management window, right-click the basic disk that you want to change, and then click
 **Convert to Dynamic Disk**.

   > [!NOTE]
   > To right-click the basic disk, you must right-click the gray area that contains the disk title at the left of the Disk Management details pane (for example, Disk 0).
2. Click to select the check box next to the disk that you want to change, and then click OK.
3. If you want to view the list of volumes in the disk, click Details in the **Disks to Convert** dialog box.
4. Click Convert.
5. Click Yes when you are prompted to confirm the conversion, and then click OK.

### How to Manage Dynamic Disks

Dynamic disk storage supports volume-oriented disks. A dynamic disk is a physical disk that contains dynamic volumes. With dynamic disks, you can create simple volumes, volumes that span multiple disks (spanned and striped volumes), and fault-tolerant volumes (mirrored and RAID-5 volumes). Dynamic disks can contain an unlimited number of volumes.

Local access to dynamic disks (and the data that they contain) is limited to computers that run Windows Server 2003 operating systems, Windows XP Professional, or Windows 2000. You cannot access or create dynamic volumes on computers that are configured to dual-boot or multi-boot a Windows Server 2003, Windows XP Professional, or Windows 2000 and one or more of Windows XP Home Edition, Windows NT 4.0 and earlier, Windows Millennium Edition, Windows 98 Second Edition and earlier, or MS-DOS.

You create dynamic disks when you use the **Convert to Dynamic Disk** command in Disk Management to change a basic disk.

#### Create a Simple Volume or Spanned Volume

1. In the Disk Management window, choose one to create:

   - To create a simple volume, right-click unallocated space on the dynamic disk where you want to create the simple volume, and then click New Volume.

   -or-
   - To create a spanned volume, right-click unallocated space on the dynamic disk where you want to create the spanned volume, and then click New Volume.
2. On the **Welcome to the New Volume Wizard** page, click Next.
3. On the Select Volume Type page, click either **Simple volume** or
 **Spanned volume**, and then click Next.
4. On the Select Disks page, select one below:

   - If you are creating a simple volume, verify that the disk that you want to create a simple volume on is listed in the
 **Selected dynamic disks** box.

   -or-
   - If you are creating a spanned volume, click to select the disks that you want under **All available dynamic disks**, and then click Add.

     Verify that the disks that you want to create a spanned volume on are listed in the **Selected dynamic disks** box.
5. In the Size box, specify the size (in MB) that you want for the volume, and then click Next.
6. On the **Assign Drive Letter or Path** page, enter a drive letter or drive path, and then click Next.
7. On the Format Volume page, specify the formatting options that you want, and then click Next.
8. On the **Completing the New Volume Wizard** page, make sure that the options that you selected are correct, and then click Finish.

#### Extend a Simple Volume or Spanned Volume

If you want to increase the size of a simple or spanned volume after you create it, you can extend it by adding unallocated free space on the dynamic disk. To extend a simple or spanned volume:

1. In the Disk Management window, right-click the simple or spanned volume that you want to extend, and then click Extend Volume.
2. On the **Welcome to the Extend Volume Wizard** page, click Next.
3. On the Select Disks page, click to select the disk or disks that you want to extend the volume on, and then click Add.
4. Verify that the disks that you want to extend the volume on are listed in the **Selected dynamic disks** box.
5. In the Size box, specify how much unallocated disk space (in MB) that you want to add, and then Next.
6. On the **Completing the Extend Volume Wizard** page, make sure that the options that you selected are correct, and then click Finish.  

   >[!Note]  
   >
   >- You can only extend NTFS volumes or volumes that do not yet contain a file system.
   >- If you upgraded from Windows 2000 to Windows Server 2003 (or to Windows XP Professional), you cannot extend a simple or spanned volume that you originally created as a basic volume and then changed to a dynamic volume in Windows 2000.
   >- You cannot extend the system or boot volume.

#### Create a RAID-5 Volume

A RAID-5 volume is a fault-tolerant volume in which data and parity is striped across three or more physical disks. If part of one physical disk fails, you can recover the data on the failed disk by using the data and parity information on the functioning disks.

#### Format a Dynamic Volume

1. In the Disk Management window, right-click the dynamic volume that you want to format, and then click Format.
2. Specify the formatting options that you want, and then click OK.
3. Click OK when you are prompted to confirm the formatting changes.

#### View the Properties of a Dynamic Volume

1. In the Disk Management window, right-click the dynamic volume that you want to view the properties of, and then click Properties.
2. Click the appropriate tab to view a property.

#### Delete a Dynamic Volume

1. In the Disk Management window, right-click the dynamic volume that you want to delete, and then click Delete Volume.
2. Click Yes when you are prompted to confirm the deletion.  
   >[!Note]  
   >
   >- When you delete a volume, you delete all data on the volume and the volume itself.
   >- You cannot delete the system volume, the boot volume, or any volume that contains the active paging (swap) file.

#### Change a Dynamic Disk Back to a Basic Disk

Before you can change a dynamic disk back to a basic disk, you must delete all volumes from the dynamic disk.

To change a dynamic disk back to a basic disk, right-click the dynamic disk that you want to change back to a basic disk in the Disk Management window, and then click
 **Convert to Basic Disk**.

> [!NOTE]
> To right-click the disk, right-click the gray area that contains the disk title at the left of the Disk Management details pane (for example, Disk 0 ).

### Troubleshooting

When a disk or volume fails, Disk Management displays status descriptions of disks and volumes in the Disk Management window. These descriptions, which are shown in the following list, inform you of the current status of the disk or volume.

- Online: It is the normal disk status when the disk is accessible and functioning correctly.
- Healthy: It is the normal volume status when the volume is accessible and functioning correctly.
- Online (Errors) (displayed with dynamic disks only): I/O errors may have been detected on the dynamic disk.

  To resolve this issue, right-click the disk, and then click Reactivate Disk to return the disk to Online status.
- Offline or Missing (displayed with dynamic disks only): The disk may be inaccessible. This issue may occur if the disk is corrupted or made temporarily unavailable.

  To resolve this issue, repair any disk, controller, or connection problems, verify that the physical disk is turned on and correctly attached to the computer, right-click the disk, and then click Reactivate Disk to return the disk to Online status.  

For a complete list of disk and volume status descriptions, see Disk Management Help. (In the Disk Management snap-in, click the Action menu, and then click Help. )
