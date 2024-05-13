---
title: VM is unresponsive while applying default domain controllers policy
titlesuffix: Azure Virtual Machines
description: This article provides steps to resolve issues where the Default Domain Controllers Policy prevents the booting of an Azure VM.
services: virtual-machines, azure-resource-manager
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.service: virtual-machines
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting-problem-resolution
ms.date: 05/10/2024
ms.author: genli
ms.custom: sap:My VM is not booting
---

# VM is unresponsive while applying default domain controllers policy

This article provides steps to resolve issues where the Default Domain Controllers Policy prevents the booting of an Azure Virtual Machine (VM).

## Symptom

When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of the VM, you will see that the screenshot displays the OS becoming unresponsive while booting with the message **Default Domain Controllers Policy**.

  :::image type="content" source="media/vm-unresponsive-domain-controllers-policy/default-domain-controllers-policy.png" alt-text="Screenshot shows that the O S is stuck, with the message: Default Domain Controllers Policy." border="false":::

## Cause

This issue may be due to recent changes made to the Default Domain Controllers Policy. Otherwise, a memory dump file analysis will need to be performed to determine the root cause.

## Solution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

If you have recently made changes to the Default Domain Controllers Policy, you may wish to undo those changes to fix the issue. If you are not sure what is causing the issue, collect a memory dump and then submit a support ticket.

### Collect the memory dump file

To resolve this issue, you should first gather the memory dump file for the crash and then contact support with the memory dump file. To collect the dump file, follow the instructions in the following sections.

[!INCLUDE [Collect OS Memory Dump File](../../../includes/azure/collect-os-memory-dump-file.md)]

> [!NOTE]
> If you're having trouble locating the *Memory.dmp* file, you can try to use [non-maskable interrupt (NMI) calls in the serial console](./serial-console-windows.md#use-the-serial-console-for-nmi-calls) instead. You can follow the guide to [generate a crash dump file using NMI calls](/troubleshoot/windows-client/performance/generate-a-kernel-or-complete-crash-dump).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
