---
title: Windows boot error 0xc000014c on an Azure VM
description: Fixes an issue that triggers error code 0xc000014c when you try to start an Azure-based virtual machine.
ms.date: 07/21/2020
ms.reviewer: jarrettr
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
---
# Windows boot error 0xc000014c on an Azure VM

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4010141

## Symptoms

Windows doesn't start. Instead, the system generates the following error:

> File: \Windows\System32\config\system  
Status: 0xc000014c  
Info: The operating system could not be loaded because the system registry file is missing or contains errors.

## Cause

This issue occurs because either the hive is corrupted or it is not closed correctly.

## Resolution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To fix the issue, follow these steps.

### Repair the corrupted hive

1. Delete the virtual machine (VM). Make sure that you select the **Keep the disks**  option when you do this.
2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM. Open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.
4. On the OS disk you attached, navigate to `\windows\system32\config`. Copy all the files as a backup in case a rollback is required.
5. On the OS disk you attached, copy the files in `\windows\system32\config\regback` and replace the files in `\windows\system32\config`.
6. Detach the repaired OS disk from the troubleshooting VM. Then, create a new VM from the OS disk.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
