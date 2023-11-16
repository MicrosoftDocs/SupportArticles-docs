---
title: Extend partition of a cluster shared disk
description: Describes how to add additional storage capacity to a server cluster if the underlying hardware RAID supports.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, stevemat, ELDENC
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
ms.technology: windows-server-high-availability
---
# How to extend the partition of a cluster shared disk

This article describes how to add additional storage capacity to a cluster if the underlying hardware RAID supports capacity extension technology.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 304736

## Summary

Capacity extension provides the ability to add additional drives to an existing RAID set and extend the logical drive so that it appears as free space at the end of the same logical drive. You can use the Diskpart.exe command-line utility to extend an existing partition into free space. This process has the following requirements:

- The additional disk space must appear as free space at the end of the existing drive, and it must be directly behind the existing volume that is to be extended.
- The extension mustn't rely on software fault tolerance to combine the existing partition and free space.
- The disk signatures of the existing drive remain the same.
- Use of the Physical Disk Resource type for the disk. If the disk resource is provided by a third-party manufacturer, you must contact that manufacturer for information about how to increase disk space.

## More information

> [!IMPORTANT]
> If you add an additional drive to an existing array and the new drive appears as a new logical disk (instead of free space at the end of the existing drive), the hardware doesn't support capacity extension because it refers to the free space as a new drive, and the following procedure won't work. Some storage hardware will, by default, automatically create a new logical disk and volume for the new space despite the fact that the expansion of the existing logical disk is a possible option. When you are using server clusters of Windows Server 2003 or failover clusters of Windows Server 2008 or of Windows Server 2008 R2, software fault tolerance isn't natively supported, and the creation of a spanned volume (Volume Set) isn't a viable option. To add additional space:
>
> - Create a second physical disk resource.
> - Delete and then re-create the array with the additional disk, and then replace the disk.

## How to extend an existing drive into free space if the Hardware Supports Capacity Extension

You can do an online extension or an offline extension of a data volume.

### How to do an online extension of a data volume

You can do an online extension of a cluster data volume in Windows Server 2008 or in Windows Server 2008 R2 without stopping the cluster application(s). However, not all vendor-specific applications, drivers, and utilities for Windows Server 2003 fully support transparent online extension of cluster volumes. So we recommend that you test the specific hardware environment and hardware configuration to confirm that it will behave correctly before you do the online extension in Windows Server 2003.

To do an online extension of the disk partition, follow these steps:

1. Add the additional physical drives and extend the additional disk or disks as free space by using the instructions that are included with the hardware vendor documentation.
2. Open the Disk Management snap-in, verify that the new free space is added to the end of the proper drive.
3. Right-click the existing partition, and then select **Properties**. On the **General** tab, type a unique name for the partition. This name will be used to identify the partition that you want to extend.

    > [!NOTE]
    > If you encounter any problem with the previous steps when you are extending the drive, contact your hardware vendor for assistance.
4. Extend the partition by using one of the following methods:
   - Use the Disk Management snap-in in Windows Server 2008 R2

        To extend the partition by using the Disk Management snap-in, follow these steps:
        1. In Disk Management, right-click the data volume that you want to extend.
        2. Select **Extend Volume....**.
        3. Follow the instructions in the Extend Volume Wizard.

        > [!NOTE]
        > Windows Vista and Windows Server 2008 doesn't allow Disk Management snap-in to Extend volume and user should use diskpart to extend volume instead.

   - Use the Diskpart.exe utility

        To extend the partition by using the Diskpart.exe utility, follow these steps:
        1. Open a command prompt, type diskpart, and then press **ENTER**.
        2. At the DISKPART prompt, type list volume, and then press **ENTER** to display the existing volumes on the computer.
        3. At the DISKPART prompt, type **select volume *\<volume number>***, and then press **ENTER**. Here *volume number* is the number of the volume that you want to extend. The volume has the unique name that you created in step 3. The volume is listed in the output of the list volume command.
        4. At the DISKPART prompt, type extend, and then press **ENTER** to extend the partition into all of the available disk space to the end of the drive. Or, type **extend size=\<size>** to extend the selected volume by *size* megabytes (MB).
        5. Type exit, and then press **ENTER** to exit the command prompt.

### How to do an offline extension of a data volume

To do an offline extension of the disk partition in Windows Server 2003, follow these steps:

1. Back up the shared disk (or disks) that you want to extend.
2. Power off all but one node in the cluster.
3. Take the entire group that the physical disk resource is located in offline. Bring only the physical disk resource that is to be extended online. This process should close all open handles to the disk.

    > [!NOTE]
    > If you have any disk or Host Bus Adapter (HBA) utilities that access the disk, you may need to quit them or stop the services so that they will release any handles to the disk.
4. Add the additional physical drives and extend the additional disk or disks as free space by using the instructions that are included with the hardware vendor documentation.
5. Open the Disk Management snap-in, verify that the new free space is added to the end of the proper drive.
6. Right-click the existing partition, and then select **Properties**. On the **General** tab, type a unique name for the partition. This name will be used to identify the partition that you want to extend. Exit Disk Management snap-in.

    > [!NOTE]
    > If you encounter any problem with the previous steps when you are extending the drive, contact your hardware vendor for assistance.
7. Open a command prompt, type diskpart, and then press **ENTER**.
8. At the DISKPART prompt, type list volume, and then press **ENTER** to display the existing volumes on the computer.
9. At the DISKPART prompt, type **select volume *\<volume number>***, and then press **ENTER**. Here *volume number* is the number of the volume that you want to extend. The volume has the unique name that you created in step 6. The volume is listed in the output of the list volume command.
10. At the DISKPART prompt, type extend, and then press **ENTER** to extend the partition into all of the available disk space to the end of the drive. Or, type **extend size=\<size>** to extend the selected volume by *size* megabytes (MB).
11. Type exit, and then press **ENTER** to exit the command prompt.
12. Now that the volume is extended, you can bring the entire group that contains the physical disk resource online, and then power up all of the other nodes in the cluster.
13. Verify that the group can come online and failover to all other nodes in the cluster.
