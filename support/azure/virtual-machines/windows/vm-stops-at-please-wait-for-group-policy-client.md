---
title: Azure VM stops at (Please wait for the Group Policy Client) screen
description: Describes what to do if an Azure Virtual Machine stops at the (Please wait for the Group Policy Client) screen.
services: virtual-machines, azure-resource-manager
author: JarrettRenshaw
manager: dcscontentpm
tags: azure-resource-manager
ms.assetid: 3f6383b5-81fa-49ea-9434-2fe475e4cbef
ms.service: azure-virtual-machines
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting-problem-resolution
ms.date: 05/15/2024
ms.author: jarrettr
ms.custom: sap:My VM is not booting
---
# Azure VM stops at "Please wait for the Group Policy Client" screen

**Applies to:** :heavy_check_mark: Windows VMs

## Symptoms

When you start your Azure virtual machine (VM), the VM stops responding, and you receive the following message:

> Please wait for the Group Policy Client

:::image type="content" source="media/vm-stops-at-please-wait-for-group-policy-client/wait-for-group-policy-client-screen.png" alt-text="The Please wait for the Group Policy Client screen." border="false":::

## Cause

Windows is trying to process and apply Group Policy settings to this VM. If there are many policy settings, or complex policy settings, this process can take time.

We recommend that you wait up to an hour for the VM to complete processing the policy settings. If the VM is still stopped at this screen after one hour, collect a memory dump file for cause analysis by Microsoft Support.

## Solution

To resolve this problem, the memory dump file must be analyzed. Collect the memory dump file and send it to Microsoft Support. To collect the memory dump file, follow the instructions in the following sections.

[!INCLUDE [Collect OS Memory Dump File](../../../includes/azure/collect-os-memory-dump-file.md)]

> [!NOTE]
> If you're having trouble locating the *Memory.dmp* file, you can try to use [non-maskable interrupt (NMI) calls in the serial console](./serial-console-windows.md#use-the-serial-console-for-nmi-calls) instead. You can use [this guidance to generate a crash dump file by using NMI calls](../../../windows-client/performance/generate-a-kernel-or-complete-crash-dump.md#use-nmi).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
