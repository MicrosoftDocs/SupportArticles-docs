---
title: Virtual machine LUNs disappear after you configure them as MPIO devices
description: When you use discrete device assignment to connect a LUN to a virtual machine, you cannot use that LUN as an MPIO device
ms.date: 11/03/2021
author: v-tappelgate
ms.author: v-tappelgate
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.technology: hyper-v
keywords: DDA,passthrough,pass-through,LUN,MPIO
---

# Virtual machine LUNs disappear after you configure them as MPIO devices

_Applies to:_ &nbsp;Windows Server 2022, Windows Server 2019, Windows Server 2016, Microsoft Hyper-V Server 2016

## Symptoms

You're using a virtual machine (VM) host that runs Windows Server 2016 or a later version, and you configure a VM on the host by following steps that resemble the following:

1. In addition to the Hyper-V role, you install the Multipath I/O (MPIO) feature on the VM host.
1. You create a VM on the specified host, and install MPIO on the VM.
1. You use [Discrete Device Assignment (DDA)](/windows-server/virtualization/hyper-v/deploy/deploying-storage-devices-using-dda.md) to connect one or more physical LUNs to the VM.
   When you check the settings of the VM in Hyper-V manager, the Settings page lists the DDA disks (the physical LUNs, also known as pass-through disks) as physical disks.
   image
   When you connect to the VM and then open Disk Management, the tool lists the new LUNs as unallocated disks.
1. On the VM, you open the MPIO Settings tool and configure the LUNs as MPIO devices. Then you restart the VM.
1. After the VM restarts, you connect to it and then open Disk Management again. The new LUNS no longer appear in the tool.

## Status

This behavior is by design.

## More information

The DDA and MPIO features both rely on the Host Bus Adapter (HBA) that connects a LUN to the VM. The two features cannot use the same HBA at the same time. You cannot configure DDA disks on a VM as MPIO devices.

> [!NOTE]  
> The VM host does not access the DDA disks. You can still configure MPIO on the VM host when a VM on that host uses DDA disks.
