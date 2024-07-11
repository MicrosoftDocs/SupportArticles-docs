---
title: Windows boot error 0xc0000098 on an Azure VM
description: Provides the resolution for the error code 0xc0000098.
ms.date: 06/21/2024
ms.reviewer: jarrettr, v-leedennis
ms.service: virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---
# Windows boot error 0xc0000098 on an Azure VM

**Applies to:** :heavy_check_mark: Windows VMs

_Original KB number:_ &nbsp; 4010137

This article provides a solution to an issue where Windows VM doesn't start with error code 0xc0000098.

## Symptoms

Windows doesn't start. Instead, the system generates an error that resembles the following:

> File: \\\<BINARY>  
Status: 0xc0000098  
Info: Windows failed to load because a critical system driver is missing or corrupt.

In this message, \<BINARY> represents the actual binary file that's found.

## Cause

This issue occurs if a binary is from a different version of Windows than the operating system of the virtual machine.

## Resolution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To fix the issue, follow these steps.

### Step 1: Attach the OS disk of the VM to another VM as a data disk

1. Delete the virtual machine (VM). Make sure that you select the **Keep the disks** option when you do this.
2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM. Open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.

### Step 2: Repair or replace the binary file

Repair or replace the system binary (*.sys*) file by following these steps:

[!INCLUDE [Repair or replace system binary file procedure](../../../includes/azure/virtual-machines-windows-repair-replace-system-binary-file.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
