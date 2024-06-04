---
title: Windows stop error - 0x0000007E system thread exception not handled
description: Resolve issues in which the guest OS encounters a problem and tries to restart your Azure VM. The message states that "A system thread exception wasn't handled."
services: virtual-machines
author: mibufo
tags: azure-resource-manager
ms.service: virtual-machines
ms.collection: windows
ms.workload: infrastructure-services
ms.tgt_pltfrm: na
ms.topic: troubleshooting-problem-resolution
ms.date: 05/15/2024
ms.custom: sap:My VM is not booting
---

# Windows stop error - 0x0000007E system thread exception not handled

This article provides steps to resolve issues in which the guest operating system (guest OS) encounters a problem and tries to restart your Azure virtual machine (VM). Additionally, you receive the following error message:

> A system thread exception wasn't handled.

## Symptoms

When you use [boot diagnostics](./boot-diagnostics.md) to view a screenshot of the VM output, you notice that Windows has to restart after it returns either a "SYSTEM THREAD EXCEPTION NOT HANDLED" stop code or a "0x0000007E" error code.

:::image type="content" source="media/windows-stop-error-system-thread-exception-not-handled/system-thread-exception-not-handled.png" alt-text="Screenshot shows the (Your PC ran into a problem and needs to restart. We'll restart for you) message and a SYSTEM THREAD EXCEPTION NOT HANDLED stop code." border="false":::

## Cause

The cause of this issue can't be determined until a memory dump file is analyzed. Continue to collect the memory dump file.

## Solution

> [!TIP]
> If you have a recent backup of the VM, you can try to [restore the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the restart problem.

To resolve this problem, gather a memory dump file for the incident and send the file to Microsoft Support. To collect the dump file, follow the instructions in the next sections.

[!INCLUDE [Collect OS Memory Dump File](../../../includes/azure/collect-os-memory-dump-file.md)]

> [!NOTE]
> If you're having trouble locating the *Memory.dmp* file, you can try to use [non-maskable interrupt (NMI) calls in the serial console](./serial-console-windows.md#use-the-serial-console-for-nmi-calls) instead. You can use [this guidance to generate a crash dump file by using NMI calls](/troubleshoot/windows-client/performance/generate-a-kernel-or-complete-crash-dump#use-nmi).

## Next steps

> [!div class="nextstepaction"]
> [Troubleshoot Azure Virtual Machine boot errors](./boot-error-troubleshoot.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
