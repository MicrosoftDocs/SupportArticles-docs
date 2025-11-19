---
title: Troubleshoot OS startup – Windows Update installation capacity
description: Steps to resolve issues where Windows Update (KB) gets an error and becomes unresponsive in an Azure VM.
services: virtual-machines, azure-resource-manager
documentationcenter: ''
author: JarrettRenshaw
manager: dcscontentpm
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting
ms.date: 06/13/2024
ms.author: jarrettr
ms.custom: sap:My VM is not booting
---
# Troubleshoot OS startup – Windows Update installation capacity

**Applies to:** :heavy_check_mark: Windows VMs

This article provides steps to resolve issues in an Azure virtual machine (VM) where Windows Update (KB) gets an error and becomes unresponsive.

[!INCLUDE [Azure VM Windows Update / Windows OS Upgrade Diagnostic Tools](~/includes/azure/virtual-machines-runcmd-wu-tools.md)]

## Symptom

When you use boot diagnostics to view the screenshot of the VM, the screenshot displays Windows Update (KB) in progress, but failing with the error code: **C01A001D**. The following image shows Windows Update (KB) stuck with the message "Error C01A001D applying update operation ##### of ##### (######)":

:::image type="content" source="media/troubleshoot-windows-update-installation-capacity/error-code-c01a001d.png" alt-text="Screenshot of error code: C01A001D when applying Windows Update." lightbox="media/troubleshoot-windows-update-installation-capacity/error-code-c01a001d.png":::

## Cause

In this situation, the operating system (OS) can't complete a Windows Update (KB) installation because a core file can't be created on the file system. Based on this error code, the operating system can't write any files to the disk.

## Solution

### Process overview

> [!TIP]
> If you have a recent backup of the VM, you can try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the startup issue.

1. Create and access a repair VM.
1. Free space on disk.
1. Enable serial console and memory dump file collection.
1. Rebuild the VM.

> [!NOTE]
> When this error occurs, the guest OS isn't operational. Troubleshoot this issue in offline mode.

### Create and access a repair VM

1. To prepare a repair VM, perform steps 1-3 of the [VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md).
1. Connect to the `repair VM` by using a `Remote Desktop connection`.

### Free up space on the disk

To solve the issue:

- Resize the disk up to 1 TB if it isn't already at the maximum size of 1 TB.
- Perform a disk cleanup.
- Defragment the drive.

1. Check whether the disk is full. If the disk size is less than 1 TB, expand it to a maximum of 1 TB [using PowerShell](/azure/virtual-machines/windows/expand-os-disk).
1. If the disk already contains 1 TB of data, you must perform a disk cleanup to free up space. Use the [Disk Cleanup tool](https://support.microsoft.com/help/4026616/windows-10-disk-cleanup).
1. After resizing and cleanup are finished, defragment the drive by running the following command:

   ```console
   defrag <LETTER ASSIGN TO THE OS DISK>: /u /x /g
   ```

Depending upon the level of fragmentation, defragmentation could take several hours.

### Enable the Serial Console and memory dump file collection

**Recommended**: Before you rebuild the VM, enable the Serial Console and memory dump file collection by following these steps:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../../includes/azure/enable-serial-console-memory-dump-collection.md)]

### Rebuild the VM

Use [step 5 of the VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to rebuild the VM.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
