---
title: Boot error – "this is not a bootable disk"
description: This article provides steps to resolve issues where the disk isn't bootable in an Azure Virtual Machine
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.collection: windows
ms.workload: infrastructure-services
ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.date: 07/10/2024
ms.custom: sap:My VM is not booting
---
# Boot Error – This is not a Bootable Disk

**Applies to:** :heavy_check_mark: Windows VMs

This article provides steps to resolve issues where the disk isn't bootable in an Azure Virtual Machine (VM).

## Symptoms

When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of the VM, you'll see that the screenshot displays a prompt with the message 'This is not a bootable disk. Please insert a bootable floppy and press any key to try again...'.

Figure 1

:::image type="content" source="media/troubleshoot-guide-not-bootable-disk/not-bootable-disk.png" alt-text="Screenshot of the message.":::

## Cause

This error message means the OS boot process couldn't locate an active system partition. This error could also mean that there's a missing reference in the Boot Configuration Data (BCD) store, preventing it from locating the Windows partition.

## Solution

### Process Overview

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

1. Create and Access a Repair VM.
2. Set Partition Status to Active.
3. Fix the Disk Partition.
4. **Recommended**: Before you rebuild the VM, enable serial console and memory dump collection.
5. Rebuild the Original VM.

   > [!NOTE]
   > When encountering this boot error, the Guest OS isn't operational. You'll be troubleshooting in offline mode to resolve this issue.

### Create and Access a Repair VM

1. Use steps 1-3 of the [VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md) to prepare a Repair VM.
2. Using Remote Desktop Connection connect to the Repair VM.

### Set Partition Status to Active

[!INCLUDE [Verify that Windows partition is active](../../../includes/azure/windows-vm-verify-set-active-partition.md)]

### Fix the Disk Partition

1. Open an elevated command prompt (cmd.exe).
2. Use the following command to run *CHKDSK* on the disk(s) and fix errors:

   `chkdsk <DRIVE LETTER>: /f`

   Adding the '/f' command option will fix any errors on the disk. Make sure to replace \<DRIVE LETTER\> with the letter of the attached OS VHD.

### Recommended: Before you rebuild the VM, enable Serial Console and memory dump collection

To enable Serial Console and memory dump collection, follow these steps:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../../includes/azure/enable-serial-console-memory-dump-collection.md)]

### Rebuild the Original VM

Use [step 5 of the VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to reassemble the VM.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
