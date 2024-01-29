---
title: Using Hyper-V with large-sector drives
description: Describes the issues and guidance that are associated with running Hyper-V in Windows Server 2008 and Windows Server 2008 R2.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, senthilr
ms.custom: sap:configuration-of-virtual-machine-settings, csstroubleshoot
ms.subservice: hyper-v
---
# Using Hyper-V with large-sector drives in Windows Server 2008 and Windows Server 2008 R2

This article describes the issues and guidance that are associated with running Hyper-V in Windows Server 2008 and Windows Server 2008 R2.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2515143

## Summary

Over the next few years, the data-storage industry will be transitioning the physical format of hard disk drives from 512-byte sectors to 4,096-byte sectors (also known as 4K sectors). This transition is driven by several factors. These include increases in storage density and reliability.

However, most of the software industry depends on disk sectors that are 512 bytes long. Therefore. a change in this sector size would introduce major compatibility issues in many applications. To minimize the effect on the ecosystem, hard disk vendors are introducing transitional 512-byte emulation drives (also known as 512e drives). These drives have some of the advantages of 4 kilobyte (KB) native drives, such as improved format efficiency and an improved ECC scheme. And, they have fewer compatibility issues than they would have if they exposed a 4-KB sector size at the disk interface.

Some basic disk terminology that is used in this document is as follows:

Physical disks. Disks that are exposed by the physical hardware.

Virtual disks. Disks that are created by the software (VHD) stack.

Logical sector size. Minimum required alignment of IO that is exposed by a disk. Any IOs that do not confirm to this rule will fail.

Physical sector size. Actual physical sector size of storage data on a disk. This is the quantum of data access from the disk.

512e disks. Disks that directly report a 512-byte logical sector size but have a physical sector size of 4 KB - Firmware translate 512 bytes writes to 4k writes RMW (Read Modify Write). In today's drives, this translation introduces a performance penalty.

Native 4K disks. Disks that directly report a 4-KB logical sector size and have a physical sector size of 4 KB - The disk can accept only 4-KB IOs to the disks. However, the software stack can provide 512-byte logical sector size support through RMW support.

## Effect when hosting VHDs on 512e disks

512e disks can perform writes only on a physical sector. That is, a 512e disk cannot directly write a 512-byte sector write that is issued to it. The internal process in the disk that makes this write possible includes the following three steps:

1. The disk has to read the 4-KB physical sector into its internal cache. The cache contains the 512-byte logical sector that is referred to in the write.
2. The data in the 4-K buffer is changed to include the updated 512-byte logical sector.
3. The disk must perform a write of the updated 4-KB buffer back to its physical sector on the disk.

This process is known as a "Read-Modify-Write," or RMW. In today's drives, this RMW process causes a decrease in performance in VHDs. This occurs for one or more of the following reasons:

- Dynamic and differencing VHDs have a 512-byte sector bitmap in front of their data payload. In addition, footer/header/Parent Locators all align to the 512-byte sector. Therefore, it is common for the VHD driver to issue 512 bytes writes to update these structures. This results in the RMW behavior that is described here.
- It is common for applications to issue reads and writes in sizes that are multiples of 4 KB (the default cluster size of NTFS). Because there is a 512-byte sector bitmap in front of the data payload block of dynamic and differencing VHDs, the 4-KB blocks are not aligned to the physical 4-KB boundary. Each 4K write that is issued by the current parser to update the payload data will then translate into two reads for two blocks on the disk. These are then updated and then later written back to the two disk blocks.

- Because VHDs can only expose a virtual disk that has a logical sector size of 512 bytes, applications will continue to issue 512-byte aligned IOs even if they can issue 4K aligned IOs to optimize performance on these disks.

## Effect when hosting VHDs on native 4K disks

The VHD driver today assumes that the size of the physical sector of the disk is 512 bytes and issues 512-bytes IOs. This makes the VHD driver incompatible with these disks. Therefore, the VHD stack does not open the VHD files on physical 4-KB sector disks.

## Recommended actions when you use large-sector disks

1. Internal testing shows that the virtualized workload experiences some decrease in performance when the VHDs are hosted on specific 512e drives. The extent of the performance decrease depends on various factors. These include the workload IO characteristics and the specific 512e drive. The decrease in performance could also be affected by the following factors:

    - Hardware specifics such as how much cache and how many optimizations are implemented in the firmware of the disk.
    - Whether the workload triggers a larger number of unaligned IOs and therefore incurs the RMW penalty.

    If the workload is performance critical, take one of the following actions:

    - Use fixed VHDs. Fixed VHDs don't experience the performance issues that are associated with dynamic and differencing disks. (For more information, see the "Effect when hosting VHDs on 512e disks" section.)
    - If dynamic or differencing disks are needed, use regular 512-byte drives for hosting the VHDs that are associated with the workload.

    Work with your storage hardware and RAID vendors to validate the effect on your storage setup.

2. Windows 2008 and Windows 2008 R2 support 4K drives. However, you cannot use native 4-KB disks together with Hyper-V in Windows Server 2008 and Windows Server 2008 R2.

For more information, click the following article number to view the article in the Microsoft Knowledge Base:  
[2510009](https://support.microsoft.com/help/2510009) Microsoft support policy for 4K sector hard drives in Windows
