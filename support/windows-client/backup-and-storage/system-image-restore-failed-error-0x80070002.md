---
title: System Image Recovery fails with a 0x80070002 error
description: Describes a system image restore problem that occurs in Windows 8.1 when you try to recover from a backup that's stored on a partition on the system disk. A resolution is provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Backup, Recovery, Disk, and Storage\Configuring and using Windows Backup or other recovery, csstroubleshoot
---
# System Image Recovery fails with a 0x80070002 error

This article describes a system image restore problem that occurs in Windows 8.1 when you try to recover from a backup that's stored on a partition on the system disk. A resolution is provided.

_Applies to:_ &nbsp; Windows 8.1  
_Original KB number:_ &nbsp; 2989057

## Symptoms

Consider the following scenario:

- You're running Windows 8.1, and you have the Windows 8.1 update (KB2919355) installed.
- You've taken a system image backup and saved it to a partition on the same disk as drive C.
- The partition that you saved the backup to is much smaller than drive C.

When you try to recover from the backup by using System Image Recovery, it fails and returns the following error:

> The system image restore failed.  
Error details: The system cannot find the file specified. (0x80070002)

Additionally, you can't start Windows after this error occurs.

## Cause

The error occurs because the backup image is prematurely dismounted during the restore process.

## Workaround

When you start the system after this error occurs, it generally goes into Automatic Repair mode. However, this process fails. To recover, follow these steps:

1. Click **Advanced options**.
2. Under **Choose an option**, click **Troubleshoot**, click **Advanced options**, and then click **Command Prompt**.
3. Using DISKPART, locate the volume where the OS was installed. After the problem occurs, the volume will be recognized as a RAW volume (drive C in the following example).

    ```console
    X:\Windows\System32>diskpart

    Microsoft DiskPart version 6.3.9600

    Copyright (C) 1999-2013 Microsoft Corporation.
    On computer: MININT-NS2UFF8

    DISKPART> list volume

     Volume ###  Ltr Label       Fs    Type        Size   Status    Info
     ---------- --- ----------- ----- ---------- ------- --------- --------
     Volume 0 E DVD-ROM 0 B No Media
     Volume 1 C RAW Partition 2970 GB Healthy
     Volume 2 D New Volume NTFS Partition 29 GB Healthy
     Volume 3 Recovery NTFS Partition 300 MB Healthy Hidden

    ```

    > [!NOTE]
    > The drive letters may differ in your installation of Windows.

4. Format the RAW volume:

    ```console
    DISKPART> select volume 1

    Volume 1 is the selected volume.

    DISKPART> format fs=NTFS quick

    100 percent completed
    ```

5. Exit DISKPART, and then close the command prompt:

    ```console
    DISKPART> exit

    Leaving DiskPart...
    ```

6. Under **Choose an option**, click **Troubleshoot**, click **Advanced options**, and then click **System Image Recovery**.
7. Follow the steps in the Re-image Your Computer Wizard to complete the restore from the backup that you saved.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

Microsoft regularly releases software updates to address specific bugs. If Microsoft releases a software update to resolve this bug, this article will be updated with additional information.
