---
title: Azure VM is unresponsive while applying Security Policy to the system
description: This article provides steps to resolve issues where the load screen is stuck when VM is unresponsive while applying security policy to the system in an Azure VM.
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.service: azure-virtual-machines
ms.collection: windows
ms.workload: infrastructure-services
ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.date: 08/01/2024
ms.custom: sap:My VM is not booting
---
# Azure VM is unresponsive while applying Security Policy to the system

**Applies to:** :heavy_check_mark: Windows VMs

This article provides steps to resolve issues where the OS hangs and becomes unresponsive while it is applying a security policy in an Azure VM.

## Symptoms

When you use [Boot diagnostics](boot-diagnostics.md) to view the screenshot of the VM, you will see that the screenshot displays the OS stuck while booting with the message:

> 'Applying security policy to the system'.

:::image type="content" source="media/unresponsive-vm-apply-security-policy/apply-policy-1.png" alt-text="Screenshot of Windows Server 2012 R2 startup screen is stuck." border="false":::

:::image type="content" source="media/unresponsive-vm-apply-security-policy/apply-policy-2.png" alt-text="Screenshot of OS startup screen is stuck."border="false":::

## Cause

There is a plethora of potential causes of this issue. You will not be able to know the source until after a memory dump analysis is performed.

## Resolution

### Process Overview

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

1. [Create and Access a Repair VM](#create-and-access-a-repair-vm)
2. [Enable Serial Console and Memory Dump Collection](#enable-serial-console-and-memory-dump-collection)
3. [Rebuild the VM](#rebuild-the-vm)
4. [Collect the Memory Dump File](#collect-the-memory-dump-file)

### Create and Access a Repair VM

1. Use [steps 1-3 of the VM Repair Commands](repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to prepare a Repair VM.
2. Use Remote Desktop Connection connect to the Repair VM.

### Enable Serial Console and Memory Dump Collection

To enable memory dump collection and Serial Console, follow these steps:

[!INCLUDE [Enable Serial Console and Memory Dump Collection](../../../includes/azure/enable-serial-console-memory-dump-collection.md)]

### Rebuild the VM

Use [step 5 of the VM Repair Commands](repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to reassemble the VM.

### Collect the Memory Dump File

To resolve this problem, you would need first to gather the memory dump file for the crash and contact support with the memory dump file. To collect the dump file, follow these steps:

[!INCLUDE [Collect OS Memory Dump File](../../../includes/azure/collect-os-memory-dump-file.md)]

## Next steps

If you have issues when you apply Local Users and Groups policy see [VM is unresponsive when applying Group Policy Local Users and Groups policy](unresponsive-vm-apply-group-policy.md).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
