---
title: Unknown devices (VMBUS) in Device manager
description: Describes an issue where unknown devices appear in Device Manager of a virtual machine.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:activation, csstroubleshoot
ms.technology: windows-server-deployment
---
# Unknown Device (VMBUS) appears in Device manager in Virtual Machine

This article describes an issue where unknown devices appear in Device Manager of a virtual machine.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 2925727

## Symptoms

On virtual machines that are running on a Windows Server based Hyper-V host, you may see unknown devices under **Other Devices** in device manager.

If you view the properties of these devices and check driver details, Hardware IDs, or Compatible IDs, they'll show the following:

- vmbus\\{4487b255-b88c-403f-bb51-d1f69cf17f87}
- vmbus\\{3375baf4-9e15-4b30-b765-67acb10d607b}
- vmbus\\{99221fa0-24ad-11e2-be98-001aa01bbf6e}
- vmbus\\{f8e65716-3cb3-4a06-9a60-1889c5cccab5}
- vmbus\\{c376c1c3-d276-48d2-90a9-c04748072c60}
- vmbus\\{c4e5e7d1-d748-4afc-979d-683167910a55}

## Cause

These Virtual Devices (VDev) are provided for Automatic Virtual Machine Activation (AVMA) to communicate with the host. AVMA is only supported on virtual machines running Windows Server 2012 R2 or later versions of operating systems.

## Resolution

The unknown devices are harmless and can be ignored.

## More information

For more information about Automatic Virtual Machine Activation (AVMA), see [Automatic Virtual Machine Activation in Windows Server](/windows-server/get-started/automatic-vm-activation):
