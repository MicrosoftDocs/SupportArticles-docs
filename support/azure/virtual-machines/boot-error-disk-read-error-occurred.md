---
title: Troubleshoot boot error - disk read error occurred
description: This article provides steps to resolve issues in which the disk can't be read in an Azure VM.
services: virtual-machines, azure-resource-manager
documentationcenter: ''
author: genlin
tags: azure-resource-manager
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting-problem-resolution
ms.date: 11/14/2023
ms.author: genli
---

# Troubleshoot boot error - disk read error occurred

This article provides steps to resolve issues in which the disk can't be read in an Azure virtual machine (VM).

## Symptoms

When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of the VM, you see that the screenshot displays a prompt that contains the message "A disk read error occurred. Press Ctrl+Alt+Del to restart."

   :::image type="content" source="media/boot-error-disk-read-error-occurred/disk-read-error-occurred-message.png" alt-text="Screenshot of A disk read error occurred message.":::  

## Cause

This error message indicates that the disk structure is corrupted and unreadable. If you're using a Generation 1 VM, it's also possible that the disk partition containing the boot configuration data isn't set to **Active**.

## Solution

### Process overview

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

1. Create and Access a Repair VM.
1. Select a Solution:
   - [Set Partition Status to Active](#set-partition-status-to-active)
   - [Fix the Disk Partition](#fix-the-disk-partition)
1. Enable serial console and memory dump collection.
1. Rebuild the VM.

> [!NOTE]
> When encountering this boot error, the Guest operating system (OS) is not operational. You'll be troubleshooting in offline mode to resolve this issue.

### Create and access a repair VM

1. Use steps 1-3 of the [VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md) to prepare a Repair VM.
1. Using Remote Desktop Connection, connect to the Repair VM.

### Set partition status to active

Generation 1 VMs should first verify that the OS partition that holds the BCD store is marked as **Active**. If you have a Generation 2 VM, skip ahead to [Fix the Disk Partition](#fix-the-disk-partition), as the Status flag was deprecated in the later generation.

1. Open an elevated command prompt (cmd.exe).
1. Enter **diskpart** to launch the **DISKPART** tool.
1. Enter **list disk** to list the disks on the system and identify the attached OS virtual hard disk (VHD).
1. Once the attached OS VHD is located, enter **sel disk #** to select the disk. See the following image for an example of where Disk 1 is the attached OS VHD.

   :::image type="content" source="media/boot-error-disk-read-error-occurred/list-select-disk.png" alt-text="Screenshot of the diskpart window, which shows the result of listing and then selecting disk.":::

1. Once the disk is selected, enter **list partition** to list the partitions of the selected disk.
1. Once the boot partition is identified, enter **sel partition #** to select the partition. The boot partition is often approximately 350 MB in size.  See the following image in which Partition 1 is the boot partition.

   :::image type="content" source="media/boot-error-disk-read-error-occurred/list-select-partition.png" alt-text="Screenshot of the diskpart window, which shows the result of listing and then selecting partition.":::

1. Enter **detail partition** to check the status of the partition. See the following screenshots for examples of the partition being set to **Active: No** or **Active: Yes**.

   **Active: No**

   :::image type="content" source="media/boot-error-disk-read-error-occurred/detail-partition-active-no.png" alt-text="Screenshot of the diskpart window with the output of the detail partition command, where Partition 1 is set to Active: No.":::

   **Active: Yes**

   :::image type="content" source="media/boot-error-disk-read-error-occurred/detail-partition-active-yes.png" alt-text="Screenshot of the diskpart window with the output of the detail partition command, where partition 1 is set to Active: Yes.":::

1. If the partition isn't set to **Active**, enter **active** to change the Active flag.
1. Enter **detail partition** to check that the status change was completed properly, and verify that the output includes **Active: Yes**.
1. Enter **exit** to close the DISKPART tool and save your configuration changes.

### Fix the disk partition

1. Open an elevated command prompt (cmd.exe).
1. Use the following command to run **CHKDSK** on the disk(s) and perform error fixes:

   `chkdsk <DRIVE LETTER>: /f`

   Adding the **/f** command option fixes any errors on the disk. Make sure to replace **< DRIVE LETTER >** with the letter of the attached OS VHD.

### Enable the serial console and memory dump collection

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

**Recommended**: Before you rebuild the VM, enable the Serial Console and memory dump collection by following these steps:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../includes/azure/enable-serial-console-memory-dump-collection.md)]

### Rebuild the VM

Use [step 5 of the VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to rebuild the VM.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
