---
title: Best practices for using dynamic disks
description: Describes the best practices for using dynamic disks on Windows Server 2003-based computers.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, mjacquet
ms.custom: sap:partition-and-volume-management, csstroubleshoot
---
# Best practices for using dynamic disks on Windows Server 2003-based computers

This article describes the best practices for using dynamic disks on Windows Server 2003-based computers.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 816307

## Summary

If you use dynamic disks, you can create fault-tolerant volumes (mirrored volumes and RAID-5 sets) and large multiple-disk (or logical unit number [LUN]) volumes by using striped and spanned volumes. These features are available only on dynamic disks. Dynamic disks are more robust and fault-tolerant in the way they store and replicate disk and volume configuration information. Dynamic disks are primarily designed to always be online. For this reason, they aren't available on removable media. Follow the recommendations in this article to keep your data online and accessible.

## More information

After you create a partition on Windows Server 2003, the partition must be formatted and assigned a drive letter before data can be stored on it. Windows Server 2003 supports two different types of disks for partitions, basic and dynamic disks. On basic disks, partitions are known as basic volumes. Basic volumes include primary partitions and logical drives. On dynamic disks, partitions are known as dynamic volumes. Dynamic volumes include simple, striped, spanned, mirrored, and RAID-5 volumes.

Volumes are an area of storage on a hard disk. A volume is formatted by using a file system, such as file allocation table (FAT) or NTFS file system, and it has a drive letter assigned to it. You can view the contents of a volume by clicking its icon in Windows Explorer or in My Computer. A single hard disk can have multiple volumes, and volumes can also span multiple disks.

## Best practices and limitations of using dynamic disks

Dynamic disks offer advantages over basic disks. Basic disks use the original MS-DOS-style master boot record (MBR) partition tables to store primary and logical disk partitioning information. Dynamic disks use a private region of the disk to maintain a Logical Disk Manager (LDM) database. The LDM database contains volume types, offsets, memberships, and drive letters of each volume. The LDM database is also replicated, so each dynamic disk knows about every other dynamic disk configuration. This feature makes dynamic disks more reliable and recoverable than basic disks.

Before you use dynamic disks, consider the following recommended best practices and limitations of using dynamic disks.

## Dynamic disks vs. basic disks

Before you convert basic disks to dynamic disks, determine whether you require features provided by dynamic disks. If you don't require spanned volumes, striped volumes, mirrored volumes, or RAID-5 sets, it may be best to use basic disks.

> [!NOTE]
> If you want to increase the size of a hardware RAID-5 disk LUN but don't have to span the NTFS file system volume across different physical disks (or LUNs), continue to use basic disks. You can use the DiskPart.exe utility to extend the NTFS volume after you add new storage capacity to the RAID volume. DiskPart.exe is a text-mode command interpreter that you can use to manage objects (disks, partitions or volumes) by using scripts or direct input from a command prompt. For more information, see [Extend a data volume in Windows](extend-data-volume.md)

## Storage devices

If you decide to use dynamic disks and you have both locally attached storage (IDE-based storage or Small Computer System Interface [SCSI]-based storage) and storage that is located on a storage area network (SAN), consider the following recommendations, depending on your situation:

- Use dynamic disks on only the SAN storage drives and keep the locally attached storage as basic disks.

or

- Use basic disks on the SAN storage drives and configure the locally attached storage as dynamic disks. These recommendations are based on the way that the LDM keeps track of dynamic disks and synchronizes the databases. By following these recommendations, if you experience an unplanned outage and lose access to the SAN storage housing the dynamic disks, all dynamic disks drop offline from the Windows Server 2003-based computer at the same time. Because you have no dynamic disks attached locally, there are no LDM database synchronization issues to contend with when the SAN disks eventually come back online. If you have even one dynamic disk on the locally attached storage, you run the risk of the LDM databases being mismatched, and you may have trouble getting one or more SAN-attached dynamic disks back online.

If your environment requires you to have dynamic disks in a mixed configuration that uses both locally attached storage and SAN-attached storage, it's a good idea to protect all fiber hubs, routers, switches, SAN cabinets, and the server from power outages by using uninterruptible power supplies (UPSs) on all connecting devices.

> [!NOTE]
>
> - In a mixed dynamic disk configuration, if you must take the SAN storage offline for maintenance, Microsoft recommends that you shut down the server before you take the SAN storage unit offline and then make sure that all the SAN devices are available again when you bring the server back online.
> - Windows does not support mounting a disk volume to multiple hosts at the same time. This restriction applies to volumes that are located on a BASIC disk or a dynamic disk. Volume corruption may occur if changes are made to the volume by both hosts. Windows also does not support exposing and then importing dynamic disks on multiple hosts (nodes) simultaneously. This practice can also lead to data loss or to LDM database corruption.

## Server clusters

Dynamic disks aren't supported for use with Windows Clustering. This restriction doesn't prevent you from extending an NTFS volume that is contained on a cluster shared disk (a disk that is shared between the computers in the cluster) that is basic.

You can use a third-party software such as Veritas Volume Manager to add the dynamic disk features to a Microsoft cluster infrastructure.

> [!NOTE]
> By default, Windows 2000 Server and Windows Server 2003 don't support dynamic disks in a Microsoft Cluster Server (MSCS) environment. You can use Veritas Volume Manager for Windows to add the dynamic disk features to a Microsoft server cluster. For customer service support about cluster issues after you install Veritas Volume Manager, please contact Veritas.  

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information.  

## Moving dynamic disks

If you move dynamic disks between systems, you may not be able to move the dynamic disks back to the original host. If you must move the dynamic disks, move all the dynamic disks from a computer at the same time, and make sure that they're all online and running on the destination computer before you try to import them to the new host. You must do it because the disk group name and the ID of the primary disk group of the host system (if a dynamic disk is present) is always kept. What makes the difference is whether there is at least one dynamic disk on the destination computer. One problem scenario occurs when there are no dynamic disks on the destination computer (so that computer ends up with the same disk group name as the source computer when the disks are moved to it) and then you want to move the disks back to the source computer. You may experience a problem if foreign disks that are being reimported have the same disk group name as the local computer.

## Disk signatures

When you start the Disk Management snap-in, all disks on the system are enumerated to see if any disks have changed or if any new disks have been added to the system. If Disk Management finds any disks that are unknown, that aren't initialized, or that don't have a disk signature in the MBR, Disk Management starts a wizard. The wizard prompts you to select the disks that you want to write disk signatures to. By default, no disks are selected. Select the check boxes next to the disk numbers to select the disks to be enumerated. You're then prompted to select the disks that you want to upgrade to dynamic disks. All disks that you upgrade have a disk signature added and are upgraded to dynamic disks.

When you start Disk Management, if the MBR of a dynamic disk is zeros, the wizard starts.

> [!NOTE]
> The MBR of a disk may be read as zeros if there is a hardware failure.

The wizard prompts you to convert the disk to a dynamic disk. If you permit the disk to be reconverted to dynamic, the original LDM database is overwritten by the newly initialized LDM database. Disk Management shows that disk as healthy, but it only shows the unallocated free space. If you have another healthy dynamic disk in the system at the time of conversion, its LDM database is replicated to the newly converted dynamic disk and a "missing" disk that represents the original dynamic disk is also shown in Disk Management.

## Missing dynamic disks

If Disk Management shows a missing dynamic disk, which means that a dynamic disk that was attached to the system can't be located. Because every dynamic disk in the system knows about every other dynamic disk, this "missing" disk is shown in Disk Management. Don't delete the missing disk's volumes or select the Remove Disk option in Disk Management unless you intentionally removed the physical disk from the system and you don't intend to ever reattach it. It's important because after you delete the disk and volume records from the remaining dynamic disk's LDM database, you may not be able to import the missing disk and bring it back online on the same system after you reattach it.

## Text-mode setup and Recovery Console

Never delete or create a partition on a dynamic disk during Windows 2000, Windows XP, or Windows Server 2003 text-mode Setup or when you start the computer by using the Recovery Console. If you do so, permanent data loss may occur.

## The mirrored drive

Never break a healthy system disk or boot dynamic mirrored volume and expect the mirrored drive to replace the original primary drive if it fails. The manually broken mirrored drive is assigned the next available drive letter, and this is updated to the permanent record in the LDM database. This means that regardless of what position that drive takes in the boot process, it's assigned the new (and incorrect) drive letter, so the operating system can't function correctly.

> [!NOTE]
> Windows software mirroring is a fault-tolerant solution that makes sure you can maintain access to data if you have a hardware disk failure. Software mirroring is not intended to be used as an offline backup mechanism.

## Hardware Mirroring

If you use dynamic disks with hardware mirroring, make sure that both parts of the hardware-mirrored drives aren't exposed to the same operating system at the same time. On hardware-mirrored disks, the LDM databases are exactly the same, but each dynamic disk on a system contains a unique DiskID in the LDM header so that LDM can distinguish one dynamic disk from another.

To expose both parts of a hardware-mirrored drive, break the hardware mirror by using the OEM RAID configuration utility, and then configure both disks as standalone drives that are both accessible to the operating system.

Unpredictable behavior may occur if two dynamic disks that are exactly the same are exposed to the operating system at the same time.

## References

For more information, see [How to use the Disk Management Snap-in to manage Basic and Dynamic Disks in Windows Server 2003](https://support.microsoft.com/help/323442)

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.
