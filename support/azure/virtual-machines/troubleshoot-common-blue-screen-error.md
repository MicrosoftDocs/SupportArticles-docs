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
ms.date: 12/18/2023
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

### Step 1: Locate the dump file and submit a support ticket

[!INCLUDE [Collect OS Memory Dump File](../../includes/azure/collect-os-memory-dump-file.md)]

If you can't find the dump file, go to the next steps to enable the dump log and the serial console, and then reproduce the issue.

### Step 2: Enable the dump log and the serial console

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

To enable the dump log and the serial console, follow these steps:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../includes/enable-serial-console-memory-dump-collection.md)]

### Step 3: Reproduce the issue

1. [Detach the OS disk, and then reattach the OS disk to the affected VM](./troubleshoot-recovery-disks-portal-windows.md).

1. Start the VM to reproduce the issue so that a dump file is generated.

1. Repeat the instructions in the [Step 1: Locate the dump file and submit a support ticket](#step-1-locate-the-dump-file-and-submit-a-support-ticket) section.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
