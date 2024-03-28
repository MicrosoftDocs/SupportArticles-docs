---
title: Azure VM stops (Please wait for the Group Policy Client) screen
description: Describes what to do if an Azure Virtual Machine stops at the (Please wait for the Group Policy Client) screen.
services: virtual-machines, azure-resource-manager
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.assetid: 3f6383b5-81fa-49ea-9434-2fe475e4cbef
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting
ms.date: 01/25/2021
ms.author: genli
---

# Azure VM stopped at "Please wait for the Group Policy Client" screen

## Symptoms

When you start your Azure virtual machine (VM), the screen stops and displays the message:

> Please wait for the Group Policy Client

:::image type="content" source="media/vm-stops-at-please-wait-for-group-policy-client/wait-for-group-policy-client-screen.png" alt-text="The Please wait for the Group Policy Client screen." border="false":::

## Cause

Windows is trying to process and apply Group Policies to this VM. If there are many policies, or complex policies, this process can take time.

We advise that you wait up to an hour for the VM to complete processing the policies. If the VM is still stopped at this screen after one hour, collect a memory dump for cause analysis and then contact Microsoft support.

## Collect the memory dump file

To resolve this problem, the memory dump will need to be analyzed. Collect the memory dump file and contact support. To collect the memory dump file, follow these steps:

### Attach the OS disk to a new Repair VM

1. Use steps 1-3 of the [VM Repair Commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands) to prepare a Repair VM.
1. Using **Remote Desktop Connection**, connect to the Repair VM.

### Locate the dump file and submit a support ticket

1. On the Repair VM, go to windows folder in the attached OS disk. For instance, if the driver letter that is assigned to the attached OS disk is F, go to F:\Windows.
1. Locate the memory.dmp file, and then [submit a support ticket](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) with the memory dump file.

> [!NOTE]
> If you are having trouble locating the memory.dmp file, try to use [non-maskable interrupt (NMI) calls in serial console](/azure/virtual-machines/troubleshooting/serial-console-windows#use-the-serial-console-for-nmi-calls) instead. You can follow the guide to [generate a crash dump file using NMI calls here](/windows/client-management/generate-kernel-or-complete-crash-dump).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
