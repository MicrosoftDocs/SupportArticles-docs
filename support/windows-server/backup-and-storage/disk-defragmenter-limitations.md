---
title: Disk Defragmenter limitations
description: Describes the Disk Defragmenter limitations.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:backup,recovery,disk,and storage\partition and volume management
- pcy:WinComm Storage High Avail
---
# Disk Defragmenter limitations in Windows

This article describes the Disk Defragmenter limitations.

_Original KB number:_ &nbsp; 227463

## Summary

The Disk Defragmenter tool is based on the full retail version of Diskeeper by Diskeeper Corporation. The version that is included with Windows provides limited functionality in maintaining disk performance by defragmenting volumes that use the FAT, the FAT32, or the NTFS file system.

## More information

This version has the following limitations:

- It can defragment only local volumes.
- It can defragment only one volume at a time.
- It cannot defragment one volume while scanning another.
- It cannot be scheduled.
- It can run only one Microsoft Management Console (MMC) snap-in at a time.

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.
