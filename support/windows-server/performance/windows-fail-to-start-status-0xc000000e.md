---
title: Fail to restart Windows after full OS recovery
description: Fixes a problem in which you receive an error message when you restart Windows Server 2008 R2 after a full OS recovery
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
---
# Error message when you restart Windows Server after a full OS recovery: Windows failed to start. Status: 0xc000000e

This article provides help to solve an error that occurs when you restart Microsoft Windows Server 2008 R2 after you perform a full OS recovery.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2261423

## Symptoms

When you restart for the first time after you do a full OS recovery of Windows 2008 R2, you receive the following error message:

> Windows failed to start. A recent hardware or software change might be the cause. To fix the problem:
>
> 1. Insert your Windows installation disc and restart your computer.
> 2. Choose your language settings, and then click Next.
> 3. Click Repair your computer.
>
> If you do not have this disc, contact your system administrator or computer manufacturer for assistance.
>
> Status: 0xc000000e
>
> Info: The boot selection failed because a required device is inaccessible.

## Cause

When you do a new installation of Windows Server 2008 R2 from a DVD to unallocated space, two partitions are created. During a recovery operation, the contents of the Boot folder are first restored from the Automated System Recovery (ASR) Writer backup and then restored again from the backup on drive C. This double restore action causes an inconsistency in the drive GUID definitions within the Boot folder data. This inconsistency leads to the boot error.

## Resolution

To recover from this error, use the bcdedit command-line tool. To do this, follow these steps:

1. Start the server by using Windows Server 2008 R2 media.
2. Select **Repair your computer**.
3. Select **Command Prompt**.
4. At the command prompt, run the bcdedit command. Lists of items appear under **Windows Boot Manager** and under **Windows Boot Loader**.
5. Look for the values for the following items:

    1. Under **Windows Boot Manager**, the **Device** item should be set to **unknown**.
    2. Under **Windows Boot Loader**, the **Device** and **osdevice** items should be set to **unknown**.

6. Run the following three commands to correct the settings, and then restart the computer:

    1. `bcdedit /set {default} device partition=c:`
    2. `bcdedit /set {default} osdevice partition=c:`
    3. `bcdedit /set {bootmgr} device partition=c:`

7. Or, locate `X:\Sources\Recovery`, and then run StartRep.exe to start a quick automated startup repair utility that corrects boot environment values.

> [!NOTE]
> This issue occurs only with certain backup tools. When most backup tools are used, you experience no GUID corruption.

## More information

When you do a new installation of Windows Server 2008 R2 from a DVD to unallocated space, two partitions are created. The first partition is 100 MB, and the remaining space becomes drive C. The 100-MB partition is a System Reserved Partition. This partition contains OS boot files and has no drive letter.

You can see the two partitions by running the mountvol command from the command line or by using the Disk Management interface.

You can change this default behavior of the Windows Server 2008 R2 installation by manually partitioning and naming the C:\ volume before you install Windows Server 2008 R2 from a DVD. This lets you install Windows Server 2008 R2 on a single partition without having the 100 MB System Partition created.

When the unnamed 100 MB System Reserved Partition doesn't exist, the Windows Server 2008 R2 installation puts the boot files in a hidden folder on drive C. This hidden folder is named Boot.

When a backup tool backs up a standard installation of Windows 2008 R2, it looks through the System Reserved Partition to back up the boot files by using the VSS Writer called Automated System Recovery Write (ASR Writer). You can see this VSS Writer by running the vssadmin list writers command at the command prompt.

When a full OS backup or restore occurs on a standard installation of Windows Server 2008 R2 that has the System Reserved Partition, there should be no problems booting up afterward. This is because the ASR Writer correctly reads and writes the needed data to the boot location, and no GUID corruption occurs.

However, when the Boot folder exists on a named volume like drive C, the contents of the Boot folder are backed up by the file system in addition to being backed up by the ASR Writer.

During a restore operation, the contents of the Boot folder are first restored from the ASR Writer backup and then restored again from the drive C backup. This double restore causes an inconsistency in the drive GUID definitions within the Boot data. This inconsistency leads to the boot error

To avoid this issue, use one of the following methods:

- When you do a full OS recovery of Windows 2008 R2, make sure that you check for the presence of `C:\Boot` in Backup Archive and Restore. Then, if `C:\Boot` exists, make sure that you exclude it before you start the full OS recovery.

- For Windows 2008 R2 clients on which `C:\Boot` resides because the 100 MB System Reserved Partition is absent, exclude this folder from being backed up.
