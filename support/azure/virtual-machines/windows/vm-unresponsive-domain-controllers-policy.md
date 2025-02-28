---
title: VM unresponsive when Default Domain Controllers Policy is applied
titlesuffix: Azure Virtual Machines
description: This article provides steps to resolve issues in which the Default Domain Controllers Policy prevents an Azure VM from restarting.
services: virtual-machines, azure-resource-manager
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting-problem-resolution
ms.date: 05/15/2024
ms.author: genli
ms.custom: sap:My VM is not booting
---
# VM is unresponsive when Default Domain Controllers Policy is applied

**Applies to:** :heavy_check_mark: Windows VMs

This article provides steps to resolve an issue in which the Default Domain Controllers Policy prevents an Azure Virtual Machine (VM) from restarting.

## Symptom

When you use [Boot diagnostics](./boot-diagnostics.md) to view a screenshot of the VM, you notice that the VM is becoming unresponsive when you try to restart it, and you see a "Default Domain Controllers Policy" message.

  :::image type="content" source="media/vm-unresponsive-domain-controllers-policy/default-domain-controllers-policy.png" alt-text="Screenshot shows that the O S is stuck and displays the text: Default Domain Controllers Policy." border="false":::

## Cause

This issue might occur because of recent changes in the Default Domain Controllers Policy. However, a memory dump file analysis must be performed to determine the root cause of the issue.

## Solution

> [!TIP]
> If you have a recent backup of the VM, you can try to [restore the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the restart problem.

If you recently made changes to the Default Domain Controllers Policy, you might want to undo those changes to fix the issue. If you don't know what's causing the issue, collect a memory dump file and create a support ticket.

### Collect the memory dump file

To resolve this issue, gather a memory dump file for the incident, and send the memory dump file to Microsoft Support. To collect the dump file, follow the instructions in the following sections.

[!INCLUDE [Collect OS Memory Dump File](../../../includes/azure/collect-os-memory-dump-file.md)]

> [!NOTE]
> If you're having trouble locating the *Memory.dmp* file, you can try to use [non-maskable interrupt (NMI) calls in the serial console](./serial-console-windows.md#use-the-serial-console-for-nmi-calls) instead. You can use [this guidance to generate a crash dump file by using NMI calls](../../../windows-client/performance/generate-a-kernel-or-complete-crash-dump.md#use-nmi).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
