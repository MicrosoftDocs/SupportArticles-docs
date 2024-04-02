---
title: Windows stop error Status System Process Terminated
description: This article provides steps to resolve issues where the operating system encounters the stop error 0xC000021A, which prevents the booting of an Azure virtual machine.
services: virtual-machines, azure-resource-manager
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.reviewer: jarrettr, v-leedennis
ms.date: 10/10/2023
---

# Windows stop error - 0xC000021A Status System Process Terminated

This article provides steps to resolve issues where the operating system (OS) encounters the stop error 0xC000021A, which keeps an Azure virtual machine (VM) from booting.

## Symptoms

When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of the VM, the screenshot displays the message that the OS encountered an error during boot, with the following message:

> Your PC ran into a problem and needs to restart. We're just collecting some error info, and then you can restart. (##% complete) If you'd like to know more, you can search online later for this error: 0xC000021a.

:::image type="content" source="media/windows-stop-error-system-process-terminated/stop-error.png" alt-text="Screenshot of stop error code: #0xC000021A with the message Your PC ran into a problem and needs to restart.":::

## Cause

Error 0xC000021A means **STATUS_SYSTEM_PROCESS_TERMINATED**.

This error occurs when a critical process, such as WinLogon (winlogon.exe) or the Client Server Run-Time Subsystem (csrss.exe) fails. Once the kernel detects that either of those services have stopped, it raises the **STOP 0xC000021A** error. This error may have several causes, including:

- Mismatched system files have been installed.
- A Service Pack or KB update installation has failed.
- A backup program that is used to restore a hard disk did not correctly restore files that may have been in use.
- An incompatible third-party program has been installed.

## Solution 1: Restore the VM from a backup

If you have a recent backup of the VM, you can try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

## Solution 2: Collect the memory dump file

If restoring the backup doesn't solve the problem, you have to collect a memory dump file so that the crash can be analyzed. To collect the dump file, see the following sections.

#### Attach the OS disk to a new Repair VM

1. Use steps 1-3 of the [VM repair process example](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to prepare a Repair VM.
2. Using **Remote Desktop Connection**, connect to the Repair VM.

#### Locate the dump file and submit a support ticket

1. On the repair VM, go to windows folder in the attached OS disk. If the driver letter that is assigned to the attached OS disk is F, go to F:\Windows.
2. Locate the memory.dmp file, and then [submit a support ticket](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) with the memory dump file.
3. If you are having trouble locating the memory.dmp file, you may wish to use [non-maskable interrupt (NMI) calls in serial console](./serial-console-windows.md#use-the-serial-console-for-nmi-calls) instead. You can follow the guide to [generate a crash dump file using NMI calls here](/windows/client-management/generate-kernel-or-complete-crash-dump).

## Next steps

- For further troubleshooting information, see [troubleshooting common boot errors](./boot-error-troubleshoot.md) or [how to troubleshoot a Windows VM by attaching the OS disk to a recovery VM](./troubleshoot-recovery-disks-windows.md). You should also familiarize yourself with [how to use boot diagnostics to troubleshoot a virtual machine](./boot-diagnostics.md).
- For more information about using Resource Manager, see [Azure Resource Manager overview](/azure/azure-resource-manager/management/overview).
- If you cannot connect to your VM, see [Troubleshoot RDP connections to an Azure VM](./troubleshoot-rdp-connection.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
