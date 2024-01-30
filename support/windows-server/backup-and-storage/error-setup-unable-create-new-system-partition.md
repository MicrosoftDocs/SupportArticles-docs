---
title: Windows Setup in a boot from SAN configuration reports Setup was unable to create a new system partition or locate an existing system partition
description: Works around an issue where you can't install Windows in the boot LUN from SAN configuration when there are multiple physical paths to the boot LUN.
ms.date: 11/10/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kimnich, kaushika
ms.custom: sap:multipath-i/o-mpio-and-storport, csstroubleshoot
ms.subservice: backup-and-storage
---
# Windows Setup in a boot from SAN configuration reports: Setup was unable to create a new system partition or locate an existing system partition

This article provides workarounds for an issue where you can't install Windows in the boot LUN from SAN configuration when there are multiple physical paths to the boot LUN.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2826787

## Symptoms

Consider the following scenario:

- You're installing Windows Server 2008, Windows Server 2008 R2, or Window Server 2012 in a boot from SAN configuration.
- There are multiple physical paths to the boot LUN.
- The boot LUN is raw and hasn't been initialized by Windows.

In this scenario, when you select the boot LUN in on the "Where do you want to install Windows?" step of the installation wizard, all paths to the LUN are displayed separately and a message is displayed:

Windows Server 2012 and Windows Server 2008 R2:

> "Setup was unable to create a new system partition or locate an existing system partition. See the Setup log files for more information."

:::image type="content" source="media/error-setup-unable-create-new-system-partition/install-windows.png" alt-text="Screenshot of the error message which shows at the bottom of the Install Windows window.":::

Windows Server 2008:

> "Windows cannot find a system volume that meets requirements for installation."

## Cause

Windows is unable to install to a RAW disk with multiple physical paths. If the boot LUN is presented on a single physical path or if the boot LUN has already been initialized prior to installing Windows, Setup will proceed as expected.

There are two methods for working around this behavior.

## Workaround 1: Present the boot LUN on a single path

Configure a single path to the boot LUN when installing Windows. For multiple HBA port configurations, only one HBA port should be connected to the SAN during Windows Setup.

## Workaround 2: Initialize the boot LUN prior to running setup

This method is ideal for scenarios where physically disconnecting the additional SAN connections isn't possible or is difficult.

In multiple-path disk configurations Windows Setup doesn't recognize a disk as bootable until the disk is initialized and the disk signature is present. To initialize the boot LUN and prepare the disk for Windows Setup, you must create a new partition and then delete the newly created partition. Creating a new partition will initialize the disk, write the disk signature, and create a partition. Deleting the partition will remove the newly created partition but leave the disk initialized with the disk signature. It's important to delete the partition so Windows Setup can create both the System Reserved partition and the Operating System Volume. Otherwise, Windows Setup doesn't create the System Reserved partition.

Detailed steps for Workaround 2 are as follows:

1. In the Install Windows dialog box of Windows Setup, under **Where do you want to install Windows?**, select **Disk 0** and then click the **Drive Options** (advanced) link.
2. Select **New** to create a new partition.
3. Click **Apply** to accept the default partition size.
4. Click **OK** on the dialog box that explains that additional partitions may be created automatically by Windows.
5. Now, select **Delete** to remove the newly created partition while leaving the disk in its initialized state.
6. Click **OK** on the warning dialog box to acknowledge that any data on the disk will be lost.
7. Reboot the system and run Windows Setup normally. Windows Setup will recognize the disk and Setup will continue.
