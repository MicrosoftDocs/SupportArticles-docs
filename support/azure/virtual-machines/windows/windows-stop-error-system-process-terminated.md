---
title: Windows Stop error - 0xC000021A Status System Process Terminated
description: Resolve issues in which the operating system encounters Stop error 0xC000021A and can't restart an Azure virtual machine.
services: virtual-machines, azure-resource-manager
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting-problem-resolution
ms.reviewer: jarrettr, v-leedennis
ms.date: 05/15/2024
ms.custom: sap:My VM is not booting
---
# Windows Stop error - 0xC000021A Status System Process Terminated

**Applies to:** :heavy_check_mark: Windows VMs

This article provides steps to resolve issues in which the operating system (OS) encounters Stop error code 0xC000021A. This error prevents an Azure virtual machine (VM) from restarting.

## Symptoms

When you use [Boot diagnostics](./boot-diagnostics.md) to view a screenshot of the VM, the screenshot displays the following message that states that the OS encountered an error during restart:

> Your PC ran into a problem and needs to restart. We're just collecting some error info, and then you can restart. (##% complete) If you'd like to know more, you can search online later for this error: 0xC000021a.

:::image type="content" source="media/windows-stop-error-system-process-terminated/stop-error.png" alt-text="Screenshot of Stop error code: #0xC000021A and the message, 'Your PC ran into a problem and needs to restart.'":::

## Cause

Error 0xC000021A means **STATUS_SYSTEM_PROCESS_TERMINATED**.

This error occurs when a critical process, such as Winlogon (*winlogon.exe*) or the Client Server Run-Time Subsystem (*csrss.exe*), fails. After the kernel detects that either of those services stopped, it returns the **STOP 0xC000021A** error code. This error might have several causes, including:

- Mismatched system files were installed.
- A Service Pack or KB update installation failed.
- A backup program that's used to restore a hard disk didn't correctly restore files that might have been in use.
- An incompatible third-party program was installed.

## Solution 1: Restore the VM from a backup

If you have a recent backup of the VM, you can try to [restore the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the restart problem.

## Solution 2: Collect the memory dump file

If restoring the backup doesn't solve the problem, collect a memory dump file so that the crash can be analyzed. To collect the dump file, see the following sections.

[!INCLUDE [Collect OS Memory Dump File](../../../includes/azure/collect-os-memory-dump-file.md)]

> [!NOTE]
> If you're having trouble locating the *Memory.dmp* file, you can try to use [non-maskable interrupt (NMI) calls in the serial console](./serial-console-windows.md#use-the-serial-console-for-nmi-calls) instead. You can use [this guidance to generate a crash dump file by using NMI calls](../../../windows-client/performance/generate-a-kernel-or-complete-crash-dump.md#use-nmi).

## Next steps

- For more troubleshooting information, see [troubleshooting common boot errors](./boot-error-troubleshoot.md) or [how to troubleshoot a Windows VM by attaching the OS disk to a recovery VM](./troubleshoot-recovery-disks-windows.md). You should also familiarize yourself with [how to use boot diagnostics to troubleshoot a virtual machine](./boot-diagnostics.md).
- For more information about how to use Resource Manager, see [Azure Resource Manager overview](/azure/azure-resource-manager/management/overview).
- If you can't connect to your VM, see [Troubleshoot Remote Desktop Protocol (RDP) connections to an Azure VM](./troubleshoot-rdp-connection.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
