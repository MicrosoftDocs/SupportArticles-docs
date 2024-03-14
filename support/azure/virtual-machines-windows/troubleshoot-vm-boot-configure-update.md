---
title: VM startup is stuck on "Getting Windows ready. Don't turn off your computer" in Azure
description: Introduce the steps to troubleshoot the issue in which VM startup is stuck on "Getting Windows ready. Don't turn off your computer."
services: virtual-machines
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting-problem-resolution
ms.reviewer: jarrettr, v-leedennis
ms.date: 12/18/2023
ms.author: genli
---

# VM startup is stuck on "Getting Windows ready. Don't turn off your computer" in Azure

This article describes the "Getting ready" and "Getting Windows ready" screens that you may encounter when you start a Windows virtual machine (VM) in Microsoft Azure. It provides steps to help you collect data for a support ticket.

[!INCLUDE [Feedback](../../includes/feedback.md)]

## Symptoms

A Windows VM doesn't start. When you use **Boot diagnostics** to get the screenshot of the VM, you may see that the VM displays the message "Getting ready" or "Getting Windows ready".

:::image type="content" source="media/troubleshoot-vm-boot-configure-update/getting-ready.png" alt-text="Screenshot of the Windows Server 2012 R2 V M, showing the message: Getting ready.":::

:::image type="content" source="media/troubleshoot-vm-boot-configure-update/getting-windows-ready.png" alt-text="Screenshot of the V M, showing the message: Getting Windows ready." border="false":::

## Cause

Usually, this problem occurs when the server does the final restart after the configuration is changed. The configuration change might be initialized by Windows updates or by the changes on the roles or feature of the server. For Windows Update, if the updates were large, the operating system needs more time to reconfigure the changes.

## Solution 1: Restore the VM from a backup

If you have a recent backup of the VM, you can try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the startup problem.

## Solution 2: Collect an OS memory dump file

If restoring the VM from backup isn't possible or doesn't resolve the problem, you have to collect a memory dump file so that the crash can be analyzed.

### Step 1: Collect the dump file directly

[!INCLUDE [Collect OS Memory Dump File](../../includes/azure/collect-os-memory-dump-file.md)]

If you can't find the dump file, go to the next steps to enable the dump log and the serial console, and then trigger the memory dump process.

### Step 2: Enable the dump log and the serial console

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

To enable the dump log and the serial console, run the following script:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../includes/azure/enable-serial-console-memory-dump-collection.md)]

Make sure that there's enough space on the disk to allocate as much memory as the RAM, which depends on the size that you're selecting for this VM. If there isn't enough space or this is a large size VM (G, GS or E series), you can change the location in which this file is created and refer that to any other data disk that's attached to the VM. To do this, you have to modify registry keys, as shown in the following code:

```cmd
reg load HKLM\BROKENSYSTEM F:\windows\system32\config\SYSTEM

REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\CrashControl" /v DumpFile /t REG_EXPAND_SZ /d "<DRIVE LETTER OF YOUR DATA DISK>:\MEMORY.DMP" /f
REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\CrashControl" /v DumpFile /t REG_EXPAND_SZ /d "<DRIVE LETTER OF YOUR DATA DISK>:\MEMORY.DMP" /f

reg unload HKLM\BROKENSYSTEM
```

### Step 3: Trigger the memory dump process

1. [Detach the OS disk and then Re-attach the OS disk to the affected VM](./troubleshoot-recovery-disks-portal-windows.md).
2. Start the VM and access the serial console.
3. Select **Send Non-Maskable Interrupt(NMI)** to trigger the memory dump.

    :::image type="content" source="media/troubleshoot-vm-boot-configure-update/run-nmi.png" alt-text="Screenshot of the Send Non-Maskable Interrupt item.":::

4. Follow the instructions in [Step 1: Collect the dump file directly](#step-1-collect-the-dump-file-directly) again.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
