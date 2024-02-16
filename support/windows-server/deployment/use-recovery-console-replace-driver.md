---
title: How to replace a driver by using Recovery Console
description: Describes how to use Recovery Console to replace a driver on a Windows Server 2003-based computer that you can't start.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:devices-and-drivers, csstroubleshoot
---
# How to replace a driver by using Recovery Console

This step-by-step article describes how to use Recovery Console to replace a driver on a Windows Server 2003-based computer that you can't start.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 816104

## Requirements

To replace a driver, you must have a functional copy of the driver files and you must know the location of folder that contains the driver file.

> [!NOTE]
> Only the Administrator account can obtain access to Recovery Console.

[back to the top](#requirements)  

## Start Recovery Console

To start Recovery Console, use one of the following methods.

### Recovery Console is installed

1. Start your computer.
2. When you're prompted to select an operating system, select **Microsoft Windows Server 2003 Recovery Console**.

    > [!NOTE]
    > If Recovery Console does not appear in the list, Recovery Console is not installed. Follow the steps in the next section to start Recovery Console.
3. Select the Windows installation that you want to repair, and then press ENTER.
4. Type the Administrator password, and then press ENTER.

    > [!NOTE]
    > Recovery Console uses the Administrator password that you configured when you installed Windows Server 2003. Changes that you make to the Administrator password after you install Windows Server 2003 do not apply to Recovery Console.

### Recovery Console isn't installed

1. Start your computer by using the Windows CD-ROM.

2. At the **Welcome to Setup** screen, press R to repair the installation, and then press C to start Recovery Console.

3. Select the Windows installation that you want to repair, and then press ENTER.
4. Type the Administrator password, and then press ENTER.

    > [!NOTE]
    > Recovery Console uses the Administrator password that you configured when you installed Windows Server 2003. Changes that you make to the Administrator password after you install Windows Server 2003 do not apply to Recovery Console.

[back to the top](#requirements)  

## Extract the driver files from the Windows Server 2003 installation CD-ROM

Installation files are stored on the Windows Server 2003 installation CD-ROM in compressed folders that are known as cabinet (.cab) files. Driver files are stored in the Driver.cab file. To use original driver files that are included on the Windows Server 2003 installation CD-ROM to replace damaged driver files:

1. Insert the Windows Server 2003 installation CD-ROM in the CD-ROM drive.
2. At the command prompt in Recovery Console, type expand **d:** \i386\driver.cab /f: **filename** [ **path** ], and then press ENTER, where:

    - **d:** is the CD-ROM drive letter
    - **filename** is the name of the file you want to expand
    - **path** is the folder where to copy the driver file

    Typically, driver files (.sys) are stored in the `%SystemRoot%\System32\Drivers` folder. For example, to replace the `Atimpab.sys` driver file, you might use the expand `d:\i386\driver.cab /f:atimpab.sys %systemroot%\System32\Drivers\` command.

    > [!NOTE]
    > In this command, you must use the /f switch because the Driver.cab CAB file contains more than one file.

[back to the top](#requirements)  

## Replace the driver files by using the COPY command

If the driver files that you want aren't located in a cabinet (.cab) file, you can use the Recovery Console copy command to overwrite the damaged files:

1. At the command prompt, type copy [ **source_path** ] **source_filename** [ **destination_path** ] **destination_filename**, and then press ENTER, where:

    - **source_path** is the path for the source replacement file
    - **source_filename** is the name of the replacement file
    - **destination_path** is the path for the driver file that you want to replace
    - **destination_filename** is the name of the driver file that you want to replace

    For example, to replace the Atimpab.sys file with a known good copy from a floppy disk, you might use the copy `a:\atimpab.sys c:\winnt\system32\drivers\atimpab.sys` command.

    > [!NOTE]
    > The copy command in Recovery Console does not support wildcard characters. Because of this, you can copy only one file at a time. If you must replace more than one file, use multiple copy commands.
2. When you're prompted to confirm that you want to overwrite the existing file, press Y, and then press ENTER.  

[back to the top](#requirements)  

## Add Recovery Console to an existing installation

You can add Recovery Console to an existing installation of Windows Server 2003 by using the winnt32.exe /cmdcons command. Recovery Console requires approximately 7 megabytes (MB) of free disk space in the system partition on the hard disk.

[back to the top](#requirements)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
