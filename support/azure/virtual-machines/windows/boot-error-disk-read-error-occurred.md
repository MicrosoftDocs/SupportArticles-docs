---
title: Troubleshoot boot error - disk read error occurred
description: This article provides steps to resolve issues in which the disk can't be read in an Azure VM.
services: virtual-machines, azure-resource-manager
documentationcenter: ''
author: JarrettRenshaw
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.date: 07/12/2024
ms.author: jarrettr
ms.custom: sap:My VM is not booting
---

# Troubleshoot boot error - disk read error occurred

**Applies to:** :heavy_check_mark: Windows VMs

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

[!INCLUDE [Verify that Windows partition is active](../../../includes/azure/windows-vm-verify-set-active-partition.md)]

### Fix the disk partition

1. Open an elevated command prompt (cmd.exe).
1. Use the following command to run **CHKDSK** on the disk(s) and perform error fixes:

   `chkdsk <DRIVE LETTER>: /f`

   Adding the **/f** command option fixes any errors on the disk. Make sure to replace **< DRIVE LETTER >** with the letter of the attached OS VHD.

### Enable the serial console and memory dump collection

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

**Recommended**: Before you rebuild the VM, enable the Serial Console and memory dump collection by following these steps:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../../includes/azure/enable-serial-console-memory-dump-collection.md)]

### Rebuild the VM

Use [step 5 of the VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to rebuild the VM.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
