---
title: Disk partition requirement for using Windows RE tools on a UEFI-based computer
description: Introduces the disk partition requirement for using Windows RE tools on a UEFI-based computer.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:bitlocker, csstroubleshoot
---
# Disk partition requirement for using Windows RE tools on a UEFI-based computer

This article discusses the disk partition requirements for using Windows Recovery Environment (RE) tools on a Unified Extensible Firmware Interface (UEFI) computer.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3135522

## More information

The disk partition for Windows RE tools must be at least 300 megabytes (MB). Typically, between 500-700 MB is allocated for the Windows RE tools image (Winre.wim), depending on base language and added customizations.

The allocation for Windows RE must also include sufficient free space for backup utilities to capture the partition. Follow these guidelines to create the partition:

- For Windows operating systems prior to Windows 10, version 2004 or Windows Server 2022:

   - If the partition is smaller than 500 MB, it must have at least 50 MB of free space.
   - If the partition is 500 MB or larger, it must have at least 320 MB of free space.
   - If the partition is larger than 1 gigabyte (GB), it must have at least 1 GB of free space.

- For Windows operating systems later than Windows 10, version 2004 or Windows Server 2022, the partition must have at least 200 MB of free space.
- The partition must use the following Type ID:

  DE94BBA4-06D1-4D40-A16A-BFD50179D6AC
- The Windows RE tools should be in a partition that's separate from the Windows partition. This separation supports automatic failover and the startup of partitions that are encrypted by using Windows BitLocker Drive Encryption.

> [!IMPORTANT]
> If Windows RE doesn't work as expected, double the specified free space for the partition. For example, if your partition is less than 500 MB and has 50 MB of free space, increase the free space to 100 MB.
