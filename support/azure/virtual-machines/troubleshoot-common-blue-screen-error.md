---

title: Blue screen errors when booting an Azure VM
description: Learn how to troubleshoot the issue that the blue screen error is received when booting.
services: virtual-machines
documentationCenter: ''
author: genlin
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
ms.topic: troubleshooting-problem-resolution
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 11/14/2023
ms.author: genli
---

# Windows shows blue screen error when booting an Azure VM

This article describes blue screen errors that you might encounter when you boot a Windows Virtual Machine (VM) in Microsoft Azure. It provides steps to help you collect data for a support ticket.

## Symptoms

A Windows VM doesn't start. When you check the boot screenshots within [Boot diagnostics](./boot-diagnostics.md), you see one of the following error messages in a blue screen:

> Your PC ran into a problem and needs to restart. We're just collecting some error info, and then you can restart.

> Your PC ran into a problem and needs to restart.

## Cause

There might be many reasons why you experience a stop error. The most common causes are the following issues:

- Problem within a driver
- Corrupted system file or memory
- An application accessing a forbidden sector of the memory

## Solution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To resolve this problem, you first have to gather a dump file for the crash before you contact support. To collect the dump file, follow these steps:

### Part 1: Attach the OS disk to a recovery VM

1. Take a snapshot of the OS disk of the affected VM as a backup. For more information, see [Snapshot a disk](/azure/virtual-machines/windows/snapshot-copy-managed-disk).
2. [Attach the OS disk to a recovery VM](./troubleshoot-recovery-disks-portal-windows.md).
3. Remote desktop to the recovery VM.

### Part 2: Locate the dump file and submit a support ticket

1. On the recovery VM, go to the *Windows* folder on the attached OS disk. If the drive letter assigned to the attached OS disk is `F`, you need to go to *F:\\Windows*.
2. Locate the *memory.dmp* file, and then [submit a support ticket](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) that contains the dump file.

If you can't find the dump file, move to the next part to enable a dump log and a serial console.

### Part 3: Enable a dump log and a serial console

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

To enable a dump log and a serial console, follow these steps:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../includes/enable-serial-console-memory-dump-collection.md)]

### Collect the dump file

1. [Detach the OS disk, and then reattach the OS disk to the affected VM](./troubleshoot-recovery-disks-portal-windows.md).
1. Start the VM to reproduce the issue so that a dump file is generated.
1. Attach the OS disk to a recovery VM, collect the dump file, and then [submit a support ticket](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) that contains the dump file.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
