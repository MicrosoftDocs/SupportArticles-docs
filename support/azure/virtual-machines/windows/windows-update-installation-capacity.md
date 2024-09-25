---
title: Troubleshoot OS start up – Windows Update installation capacity
description: Steps to resolve issues where Windows Update (KB) gets an error and becomes unresponsive in an Azure VM.
services: virtual-machines, azure-resource-manager
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting
ms.date: 06/13/2024
ms.author: genli
ms.custom: sap:My VM is not booting
---
# Troubleshoot OS start up – Windows Update installation capacity

**Applies to:** :heavy_check_mark: Windows VMs

This article provides steps to resolve issues in an Azure virtual machine (VM) where Windows Update (KB) gets an error and becomes unresponsive.

## Symptom

When you use Boot diagnostics to view the screenshot of the VM, you will see that the screenshot displays Windows Update (KB) in progress, but failing with the error code: **C01A001D**. The following image shows Windows Update (KB) stuck with the message "Error C01A001D applying update operation ##### of ##### (######)":

:::image type="content" source="media/troubleshoot-windows-update-installation-capacity/error-code-c01a001d.png" alt-text="Screenshot of error code: C01A001D when applying Windows Update.":::

## Cause

In this situation, the operating system (OS) is unable to complete a Windows Update (KB) installation as a core file can't be created on the file system. Based on this error code, the operating system is unable to write any files to the disk.

## Solution

### Process Overview

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

1. Create and access a Repair VM.
1. Free space on disk.
1. Enable serial console and memory dump collection.
1. Rebuild the VM.

> [!NOTE]
> When encountering this error, the Guest OS is not operational. Troubleshoot this issue in offline mode to resolve this issue.

### Create and Access a Repair VM

1. Use steps 1-3 of the [VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md) to prepare a Repair VM.
1. Using Remote Desktop Connection, connect to the Repair VM.

### Free Up Space on the disk

To solve the issue:

- Resize the disk up to 1 TB if it is not already at the maximum size of 1 TB.
- Perform a disk cleanup.
- De-fragment the drive.

1. Check if the disk is full. If the disk size is below 1 TB, expand it up to a maximum of 1 TB [using PowerShell](/azure/virtual-machines/windows/expand-os-disk).
1. If the disk is already 1 TB, you will need to perform a disk cleanup.
   1. Use the [Disk Cleanup tool](https://support.microsoft.com/help/4026616/windows-10-disk-cleanup) to free up space.
1. Once resizing and clean-up are finished, de-fragment the drive using the following command:

   ```console
   defrag <LETTER ASSIGN TO THE OS DISK>: /u /x /g
   ```

Depending upon the level of fragmentation, de-fragmentation could take several hours.

### Enable the Serial Console and memory dump collection

**Recommended**: Before you rebuild the VM, enable the Serial Console and memory dump collection by following these steps:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../../includes/azure/enable-serial-console-memory-dump-collection.md)]

### Rebuild the VM

Use [step 5 of the VM Repair Commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to rebuild the VM.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
