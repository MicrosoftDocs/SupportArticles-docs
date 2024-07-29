---
title: Windows stop error 0xC0000102 Status File Corrupt
description: Understand how to fix error 0xC0000102 (Status File Corrupt) that occurs on an Azure virtual machine (VM).
ms.date: 07/12/2024
ms.reviewer: jarrettr, v-leedennis
ms.service: virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---

# Windows stop error 0xC0000102 Status File Corrupt

**Applies to:** :heavy_check_mark: Windows VMs

This article provides steps to resolve issues where the Windows operating system (OS) encounters the stop error 0xC0000102, which keeps an Azure virtual machine (VM) from booting.

## Symptoms

When you use [boot diagnostics](/azure/virtual-machines/troubleshooting/boot-diagnostics) to view the screenshot of the VM, the screenshot displays the message that the OS encountered error code 0xC0000102 during startup.

:::image type="content" source="media/error-code-0xC0000102-status-file-corrupt/error-code-0xc0000102.png" alt-text="Screenshot shows the detailed information about Error 0xC0000102.":::

:::image type="content" source="media/error-code-0xC0000102-status-file-corrupt/0xc0000102-status.png" alt-text="Error 0xC0000102 on a CMD screen.":::

## Cause

Error 0xC0000102 is a STATUS_FILE_CORRUPT_ERROR, which means a corrupted file is preventing your VM from starting correctly. There are two possible causes for this error code:

- The file displayed in the error message is corrupt.
- The disk structure has become corrupt and unreadable.

## Solution

### Try restoring the VM from a backup

If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the start problem. If restoring the VM from backup isn't possible, follow these steps:

1. Create and Access a Repair VM
2. Repair or replace the corrupt file
3. Enable serial console and memory dump collection
4. Rebuild the VM

> [!NOTE]
> When encountering this error, the Guest OS isn't operational. You'll be troubleshooting in offline mode to resolve this issue.

### Step 1: Create and access a repair VM

1. Follow steps 1-3 of the VM [repair process example](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands#repair-process-example) to prepare a Repair VM.
2. Use Remote Desktop Connection connect to the Repair VM.

### Step 2: Repair or replace the corrupt file

Repair or replace the corrupted binary (*.sys*) file by following these steps:

[!INCLUDE [Repair or replace system binary file procedure](../../../includes/azure/virtual-machines-windows-repair-replace-system-binary-file.md)]

### Step 3: Enable the Serial Console and memory dump collection

Before rebuilding the VM, it is recommended to enable memory dump collection and Serial Console. To do so, follow these steps:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../../includes/azure/enable-serial-console-memory-dump-collection.md)]

### Step 4: Rebuild the VM

Use [step 5 of the VM Repair Commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands) to rebuild the VM.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
