---
title: Unknown devices (VMBUS) in Device manager
description: Describes an issue where unknown devices appear in Device Manager of a virtual machine.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Activation
ms.technology: windows-server-deployment
---
# Unknown Device (VMBUS) in Device manager in Virtual Machine for AVMA

This article describes an issue where unknown devices appear in Device Manager of a virtual machine.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2925727

## Symptoms

On a Windows Server 2012 R2 Datacenter Hyper-V host, you may see two **unknown devices** under Other Devices in device manager of any virtual machine running operating systems earlier than Windows Server 2012 R2.

If you view the properties of these devices and check driver details, Hardware IDs, or Compatible IDs, they'll show the following:

- vmbus\\{4487b255-b88c-403f-bb51-d1f69cf17f87}
- vmbus\\{3375baf4-9e15-4b30-b765-67acb10d607b}
- vmbus\\{99221fa0-24ad-11e2-be98-001aa01bbf6e}
- vmbus\\{f8e65716-3cb3-4a06-9a60-1889c5cccab5}

## Cause

These Virtual Devices (VDev) are provided for Automatic Virtual Machine Activation (AVMA) to communicate with the host. AVMA is only supported on virtual machines running Windows Server 2012 R2 or later versions of operating systems.

## Resolution

The unknown devices are harmless and can be ignored.

## More information

For more information about Automatic Virtual Machine Activation (AVMA), see the following:

[https://technet.microsoft.com/library/dn303421.aspx](https://technet.microsoft.com/library/dn303421.aspx)
