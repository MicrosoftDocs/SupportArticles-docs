---
title: Windows stop error - 0x0000007E system thread exception not handled
description: This article provides steps to resolve issues where the guest OS encounters a problem and wishes to restart your Azure VM. The message will state that "A system thread exception wasn't handled".
services: virtual-machines
author: mibufo
tags: azure-resource-manager
ms.service: virtual-machines
ms.collection: windows
ms.workload: infrastructure-services
ms.tgt_pltfrm: na
ms.topic: troubleshooting-problem-resolution
ms.date: 05/10/2024
ms.custom: sap:My VM is not booting
---

# Windows stop error - 0x0000007E system thread exception not handled

This article provides steps to resolve issues where the guest operating system (guest OS) encounters a problem and attempts to restart your Azure virtual machine (VM). The error message that's displayed says, "A system thread exception wasn't handled."

## Symptoms

When you use [boot diagnostics](./boot-diagnostics.md) to view a screenshot of the VM output, you'll see that Windows needs to restart with either the "SYSTEM THREAD EXCEPTION NOT HANDLED" stop code or the "0x0000007E" error code.

:::image type="content" source="media/windows-stop-error-system-thread-exception-not-handled/system-thread-exception-not-handled.png" alt-text="Screenshot shows Your PC ran into a problem and needs to restart. We'll restart for you message and SYSTEM THREAD EXCEPTION NOT HANDLED stop code." border="false":::

## Cause

The cause can't be determined until a memory dump file is analyzed. Continue to collect the memory dump file.

## Solution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To resolve this problem, you first need to gather the memory dump file for the crash and then send the file to Microsoft support. To collect the dump file, follow the instructions in the next two sections.

[!INCLUDE [Collect OS Memory Dump File](../../../includes/azure/collect-os-memory-dump-file.md)]

> [!NOTE]
> If you're having trouble locating the *Memory.dmp* file, you can try to use [non-maskable interrupt (NMI) calls in the serial console](./serial-console-windows.md#use-the-serial-console-for-nmi-calls) instead. You can follow the guide to [generate a crash dump file using NMI calls](/troubleshoot/windows-client/performance/generate-a-kernel-or-complete-crash-dump).

## Next steps

> [!div class="nextstepaction"]
> [Troubleshoot Azure Virtual Machine boot errors](./boot-error-troubleshoot.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
