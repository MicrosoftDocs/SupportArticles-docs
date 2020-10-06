---
title: Disk Defragmenter Limitations
description: Describes the Disk Defragmenter Limitations.
ms.date: 09/21/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Partition and volume management
ms.technology: BackupStorage
---
# Disk Defragmenter Limitations in Windows 2000, Windows XP, and Windows Server 2003

This article describes the Disk Defragmenter Limitations.

_Original product version:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 227463

## Summary

The Disk Defragmenter tool is based on the full retail version of Diskeeper by Diskeeper Corporation. The version that is included with Microsoft Windows 2000 and later provides limited functionality in maintaining disk performance by defragmenting volumes that use the FAT, the FAT32, or the NTFS file system.

## More information

This version has the following limitations:

- It can defragment only local volumes.
- It can defragment only one volume at a time.
- It cannot defragment one volume while scanning another.
- It cannot be scheduled.
- It can run only one Microsoft Management Console (MMC) snap-in at a time.
- It cannot defragment NTFS volumes with cluster sizes larger than 4 kilobytes (KB) in Windows 2000.This limitation has been removed for Disk Defragmenter in Microsoft Windows XP and Microsoft Windows Server 2003.
- Fine-grained movement of uncompressed NTFS file data is not possible in Windows 2000. Moving a single file cluster also moves the 4-KB part of the file that contains the cluster. This limitation has been removed for Disk Defragmenter in Windows XP and later.
- In Windows 2000, it does not defragment NTFS metadata files, such as the Master File Table (MFT), or the metadata that describes a directory's contents. This limitation has been removed in Windows XP and later. It cannot defragment encrypted files in Windows 2000. This limitation has been removed in Windows XP and later.

For additional information about the limitations of Disk Defragmenter and improvements in Windows XP, visit the following Microsoft Web site: [https://msdn.microsoft.com/msdnmag/issues/01/12/xpkernel/default.aspx](https://msdn.microsoft.com/msdnmag/issues/01/12/xpkernel/default.aspx)

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.
