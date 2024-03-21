---
title: Computer doesn't start after you change active partition
description: Provides a solution to an issue where the computer doesn't start after you mark your primary partition as active.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, DIASMITH
ms.custom: sap:System Performance\Startup or Pre-logon Reliability (crash, errors, bug check or Blue Screen), csstroubleshoot
---
# The computer does not start after you change the active partition by using the Disk Management tool

This article provides a solution to an issue where the computer doesn't start after you mark your primary partition as active.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 315261

## Symptoms

After you use the Windows Disk Management snap-in tool to mark your primary partition as active, the computer may not start, and you may receive the following error message:

> NTLDR is missing.
>
> Press Ctrl+Alt+Del to restart.

## Cause

This behavior occurs if the partition marked as active does not contain the Windows boot files or the boot files for another operating system. On Intel-based computers, the system partition must be a primary partition that has been marked as active for startup purposes. This partition must be located on the disk that the computer gains access to at startup. There can be only one active system partition at a time. If you want to use another operating system, you must first mark its system partition as active before restarting the computer.

## Resolution

> [!IMPORTANT]
> Before performing the steps listed below, make sure that you have a good backup of your critical data files.

To resolve this behavior, use one of the following procedures:

- Try changing the active partition by booting to a floppy disk and then using disk utilities to manually change the active partition:

  1. Boot to a command prompt by using a Microsoft Windows 95, Microsoft Windows 98, or Microsoft Windows Millennium Edition (Me) boot floppy disk.
  2. At the command prompt, type *fdisk*, and then press ENTER.
  3. When you are prompted to enable large disk support, click **Yes**.
  4. Click **Set active partition**, press the number of the partition that you want to make active, and then press ENTER.
  5. Press ESC.
  6. Remove the boot floppy disk, and then restart the computer.

- Boot the computer by using a Windows XP boot disk. For more information, see [Create a system repair disc](https://support.microsoft.com/help/17423).

- If the partition that has been incorrectly marked as active is formatted in the FAT file system, the FAT32 file system, or the NTFS file system, you may be able to use the Windows Recovery Console to correct the behavior.

For more information, see [What are the system recovery options in Windows?](https://support.microsoft.com/help/17101).

> [!NOTE]
> The system partition refers to the disk volume that contains the files that are needed to start Windows (for example, Ntldr, Boot.ini, and Ntdetect.com). On Intel x86-based computers, the system partition must be a primary partition that is marked active. On Intel x86 computers, this is always drive 0, the drive that the system BIOS searches when the operating system starts.

Using the Recovery Console, copy the Ntldr file from the Windows XP CD-ROM to the root directory of the current active partition. Follow these steps:

  1. Start your computer by using the Windows XP Setup floppy disks or by using the Windows XP CD-ROM.
  2. At the **Welcome to Setup** screen, press F10, or press R to repair.
  3. Press C to start the Recovery Console.
  4. Copy the Ntldr file from the Windows XP CD-ROM to the root of your system partition by using the following commands, pressing ENTER after each command:
    1. Type `cd ..` to go to the root of drive C.

        There is a space between the d and the two periods (..).
    2. Type the letter of the CD-ROM drive.
    3. Type `cd i386`.
    4. Type `Copy ntldr c:`.
    5. Type `Copy ntdetect.com c:`.
    6. Type `Bootcfg /add`.
    7. Type `Exit`.

If the partition was not formatted by using Windows, you might also need to run the Recovery Console fixboot command to make the active partition bootable.

After you can boot into Windows, it is recommended that you use the Windows Disk Management snap-in tool to reset the original system partition as the active partition, and then restart the computer.
