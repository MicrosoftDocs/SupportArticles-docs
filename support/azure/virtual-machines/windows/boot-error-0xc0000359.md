---
title: Windows boot error 0xc0000359 in an Azure VM
description: Provides the resolution for the Windows boot error code 0xc0000359 in an Azure VM.
ms.date: 06/21/2024
ms.reviewer: jarrettr, v-leedennis
ms.service: virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---
# Windows boot error 0xc0000359 in an Azure VM

**Applies to:** :heavy_check_mark: Windows VMs

_Original KB number:_ &nbsp; 4010135

This article provides a solution to an issue where Windows VM doesn't start with 0xc0000359 error code.

## Symptoms

Windows doesn't start. Instead, the system generates an error that resembles the following:

> File: \Windows\System32\drivers\\\<BINARY>  
Status: 0xc0000359  
Info: Windows failed to load because a critical system driver is missing or corrupt.

In this message, \<BINARY> represents the actual binary file that's found.

## Cause

The issue occurs because the binary file is the 32-bit version and it needs to be replaced by the 64-bit version.

## Resolution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To fix the issue, follow these steps.

### Step 1: Attach the OS disk of the VM to another VM as a data disk

1. Delete the virtual machine (VM). Make sure that you select the **Keep the disks** option when you do this.
2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM. Open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.

### Step 2: Replace the corrupted file

Replace the corrupted system binary (*.sys*) file by following these steps:

[!INCLUDE [Replace system binary file procedure](../../../includes/azure/virtual-machines-windows-replace-system-binary-file.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
