---
title: Can't start computer from a USB flash drive
description: You can't start a computer from an external removable USB hard disk that's formatted to use the FAT32 file system. This issue occurs because the USB drive is treated as a floppy disk. Provides a resolution.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, huiwu
ms.custom: sap:partition-and-volume-management, csstroubleshoot
---
# You can't start a computer from a USB flash drive that is formatted to use the FAT32 file system

This article works around a startup failure when you use a USB flash drive that's formatted to use the FAT32 file system.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 954457

## Symptoms

You format a USB flash drive to use the FAT32 file system. When you try to start the computer from this USB flash drive, the startup process stops responding, and the screen is black.

## Cause

This issue occurs because the USB flash drive is listed as removable media. Therefore, the Windows operating system doesn't create a master boot record (MBR) on the USB flash drive when you format the flash drive to use the FAT32 file system. The USB flash drive is treated as a super floppy disk. The FAT32 startup code doesn't support starting a computer from a super floppy disk without an MBR.

The BIOS tries to transfer the control of the startup from the USB flash drive to the FAT32 startup code. However, the FAT32 startup code doesn't support this scenario.

## Workaround

To work around this issue, use the `Diskpart` command prompt utility to create and format the boot partition on the USB flash drive.

For more information about how to use `Diskpart`, see [DiskPart Command-Line Options](/previous-versions/windows/it-pro/windows-vista/cc766465(v=ws.10)).

## How to differentiate between the MBR and the boot sector

Currently, the Windows operating system uses signatures at offset 3 in the boot sector to determine whether the sector is a boot sector. These signatures don't appear in the MBR. The signatures are as follows:

- FAT16: MSDOS5.0
- FAT32: MSDOS5.0
- NTFS: NTFS

## How to determine whether the boot sector is FAT32, FAT16, or NTFS

Check two strings in the boot sector to determine if the USB flash drive was formatted by using one of the following file systems:

- FAT32
- FAT16
- NTFS

If the strings contain FAT32, FAT16, or NTFS, the boot sector was formatted in that particular file system format.
