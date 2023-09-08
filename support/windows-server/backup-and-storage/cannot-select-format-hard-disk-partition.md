---
title: Can't select or format hard disk partition
description: Describes a problem that may occur when you try to install Windows.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, kimnle
ms.custom: sap:partition-and-volume-management, csstroubleshoot
ms.technology: windows-server-backup-and-storage
---
# You cannot select or format a hard disk partition when you try to install Windows

This article provides solutions to an issue where you fail to select or format a hard disk partition when you try to install Windows.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 927520

> [!NOTE]
> Support for Windows Vista without any service packs installed ended on April 13, 2010. To continue receiving security updates for Windows, make sure you're running Windows Vista with Service Pack 2 (SP2). For more information, see [Support is ending for some versions of Windows](https://support.microsoft.com/help/14223/windows-xp-end-of-support).

> [!IMPORTANT]
> Dynamic discs are only supported for:
>
> - Windows Vista Business
> - Windows Vista Enterprise
> - Windows Vista Ultimate.
> - Windows 7 Enterprise
> - Windows 7 Professional
> - Windows 7 Ultimate
> - Windows Server 2008 R2 Datacenter
> - Windows Server 2008 R2 Enterprise
> - Windows Server 2008 R2 Standard
> - Windows Web Server 2008 R2
>
> They are not supported for Windows Vista Home Basic, Windows Vista Home Premium, Windows 7 Home Basic, Windows 7 Starter, and Windows 7 Home Premium.
>
> There is one exception. When you upgrade your computer from Windows XP Media Center Edition to Windows Vista Home Premium, some dynamic discs are handled and supported.

## Symptoms

When you try to install Windows Vista, Windows 7 or Windows Server 2008 R2, you may experience one or more of the following symptoms:

- The hard disk on which you want to install Windows Vista, Windows 7, or Windows Server 2008 R2is not listed.
- You cannot select a hard disk partition on which to install Windows Vista, Windows 7, or Windows Server 2008 R2.
- You cannot format a hard disk partition or partitions.
- You cannot set the correct size for a hard disk partition.
- You receive the following error message:

    > Windows is unable to find a system volume that meets its criteria for installation

## Cause

This problem may occur for one of the following reasons:

- Windows is incompatible with a mass storage controller or a mass storage driver.
- A mass storage controller or a mass storage driver is outdated.
- The hard disk on which you want to install Windows Vista, Windows 7 or Windows Server 2008 R2 is a dynamic disk.
- A data cable in the computer is loose, or another hardware issue has occurred.
- The hard disk or the Windows file system is damaged.
- You tried to select a FAT32 partition or another type of partition that is incompatible with Windows Vista, Windows 7 or Windows Server 2008 R2.

To resolve this problem, use one or more of the following methods.

## Resolution 1: Verify that partition is compatible with Windows

You cannot install Windows on a FAT32 partition. Additionally, you must correctly configure dynamic disks for use with Windows. To verify that the partition is compatible with Windows Vista, Windows 7 or Windows Server 2008 R2, follow these steps:

1. For a dynamic disk that has a simple volume, use the Diskpart.exe utility to configure the disk as an active disk. For more information about how to use the Diskpart.exe utility, see [DiskPart Command-Line Options](/previous-versions/windows/it-pro/windows-vista/cc766465(v=ws.10)).

2. For a FAT32 partition, reformat the partition, or convert the partition to an NTFS file system partition by using the Convert.exe command.

    > [!NOTE]
    > When you format a partition, all data is removed from the partition. This data includes all the files on the partition.

## Resolution 2: Update drivers for the hard disk controller

If you want to install Windows Vista Windows 7 or Windows Server 2008 R2 as an upgrade, update the drivers for the hard disk controller to the latest drivers.

> [!NOTE]
> Windows Setup provides a feature to migrate current drivers to the new operating system. Therefore, Windows Setup may use the drivers that are currently installed on the computer. If the computer does not have the latest drivers installed, the Setup program may use the outdated drivers. In this case, you may experience compatibility problems.

## Resolution 3: Provide correct drivers for hard disk controller

If you are trying to perform a clean installation of Windows, you must provide the correct drivers for the hard disk controller. When you are prompted to select the disk on which to install Windows, you must also click to select the **Load Driver** option. Windows Setup will guide you through the rest of the process.

## Resolution 4: Examine Setupact.log file to verify that partition is active

If you receive the following error message, verify that the partition is active by examining the Setupact.log file:

> Windows is unable to find a system volume that meets its criteria for installation

> [!NOTE]
>
> - If you install Windows Vista, Windows 7 or Windows Server 2008 R2 as an upgrade, the Setupact.log file is located in the **Drive**:\$WINDOWS.~BT\Sources\Panther folder. **Drive** represents the drive that contains the existing Windows installation.
> - If you perform a clean installation of Windows Vista, Windows 7 or Windows Server 2008 R2, the Setupact.log file is located in the **Drive**:\$WINDOWS\Sources\Panther folder. **Drive** represents the DVD drive that contains the Windows Setup files.

To verify that the partition is active, follow these steps:

1. Insert the DVD into the DVD drive.
2. On the **disk selection** screen, press SHIFT+F10. A **Command Prompt** (CMD) window opens.
3. Change the directory to locate the Setupact.log file, and then open the Setupact.log file.
4. Locate the **DumpDiskInformation** section. This section contains information about partition mapping.
5. In the **DumpDiskInformation** section, locate the log entry that resembles the following.

    > Disk [0] partition [1] is an active partition

6. If this log entry appears after an entry that resembles the following, the hard disk may not be configured to use a Windows-based operating system.

    > Unknown

    In this case, use the Diskpart.exe utility to configure a different partition as active.

    > [!NOTE]
    > This step prevents a third-party operating system from starting.

7. Close the **Command Prompt** window.

## Resolution 5: Check for firmware updates and for system BIOS updates

For firmware updates and for system BIOS updates, contact the manufacturer of the hardware in the computer.

## Resolution 6: Verify that system BIOS correctly detects hard disk

For information about how to verify that the system BIOS correctly detects the hard disk, contact the manufacturer of the computer hardware.

## Resolution 7: Use Chkdsk.exe to check for problems

Run the Chkdsk.exe utility to check for disk problems. Replace the hard disk if it is damaged.

## Resolution 8: Use Diskpart.exe to clean disk and rerun Windows Setup

If you have tried all the methods that are listed in this section and the problem persists, use the Diskpart.exe utility to clean the disk, and then run Windows Setup again.

> [!NOTE]
> Use this method only if you want to perform a clean installation of Windows. When you clean the hard disk, it is formatted. All partitions and all data on the hard disk are permanently removed. We strongly recommend that you back up the files on the hard disk before you clean the disk.

To use the Diskpart.exe utility to clean the hard disk, follow these steps:

1. Insert the DVD into the DVD drive.
2. On the **disk selection** screen, press SHIFT+F10. A **Command Prompt** window opens.
3. Type *diskpart*, and then press ENTER to open the diskpart tool.
4. Type `list disk`, and then press ENTER. A list of available hard disks is displayed.
5. Type `sel disk number`, and then press ENTER. **number** is the number of the hard disk that you want to clean. The hard disk is now selected.
6. Type `det disk`, and then press ENTER. A list of partitions on the hard disk is displayed. Use this information to verify that the correct disk is selected.
7. Make sure that the disk does not contain required data, type `clean all`, and then press ENTER to clean the disk. All the partitions and all the data on the disk is permanently removed.
8. Type `exit`, and then press ENTER to close the diskpart tool.
9. Close the **Command Prompt** window.
10. Click the **Refresh** button to update the **disk selection** screen. This step lists the disk.
11. Run Windows Setup to perform a clean installation of Windows.
