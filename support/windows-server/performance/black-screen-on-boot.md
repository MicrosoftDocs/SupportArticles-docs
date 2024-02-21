---
title: Black screen on boot
description: Provides a solution to an issue where restarting a Windows x86-based computer fails with black screen.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, mjacquet
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
---
# Black screen on boot

This article provides a solution to an issue where restarting a Windows x86-based computer fails with black screen.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 155053

## Symptoms

When you restart a Windows x86-based computer, the computer stops with an empty, black screen immediately after the power-on self test (POST) is completed.

## Cause

The master boot record (MBR), partition tables, boot sector, or NTLDR file is corrupted.

## Resolution

1. Create a Windows boot disk to start the computer.

    If you can start the computer without errors, the damage is limited to the master boot record (MBR), boot sector, or the NTLDR file. After Windows is running, immediately back up any data of value. Use Disk Administrator to verify that partitions on the boot drive are the correct size. If there are invalid partitions, the best solution is to re-create those partitions and reformat the affected drives, then restore the data from the most recent back up tape. If the system cannot be started from a Windows boot disk, you will most likely have to reinstall Windows and restore from tape.

2. Run the latest virus scanning software to verify no virus is present. MS-DOS-based virus software is sufficient for this purpose, even if the file system is NTFS. MS-DOS-based virus programs can be run from an MS-DOS boot disk.

3. Ensure the master boot record (MBR) is valid. Boot from a virus-free MS-DOS version 5.0 or later boot disk with FDISK on it. Run the `FDISK /MBR` command:

    > [!WARNING]
    > If your computer is infected virus, using the `FDISK /MBR` switch may prevent you from being able to start your computer. Before using the `FDISK /MBR` command, you should be certain that your computer is not infected with a virus.

4. If the primary boot partition is a file allocation table (FAT) partition, boot from an MS-DOS disk, perform a `SYS C:` command to make the drive MS-DOS bootable, and then perform step 5 to replace the Windows boot sector.

5. Run Windows Setup and choose the Repair option. Choose the Inspect boot Sector and Restore Startup Environment options. If the boot sector on the boot drive is corrupted, this should repair it.

6. If the system still fails to boot correctly, use Attrib.exe or File Manager to remove the file attributes from the NTLDR file located in the root of the system partition. Copy a new NTLDR file from the i386 directory of the Windows CD-ROM to replace the existing one.

7. If you are running Windows and the system partition is NTFS, you may have a fragmented MFT that prevents the system from booting.
