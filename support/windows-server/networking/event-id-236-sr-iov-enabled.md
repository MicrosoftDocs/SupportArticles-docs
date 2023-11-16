---
title: Event ID 236 on a Hyper-V server that has SR-IOV enabled on a VM in Windows Server
description: Address an Event ID 236 that occurs on a Hyper-V server that has SR-IOV enabled on a VM in Windows Server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, yuvraja
ms.custom: sap:windows-nic-teaming-load-balance-failover, csstroubleshoot
ms.technology: networking
---
# Event ID 236 on a Hyper-V server that has SR-IOV enabled on a VM in Windows Server

This article provides a solution to an Event ID 236 that occurs on a Hyper-V server that has SR-IOV enabled on a VM in Windows Server.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 4136996

## Symptom

On a Windows Server 2016, a Windows Server 2019, a Windows Server, version 1903, or a Windows Server, version 1909 computer that has Hyper-V role enabled, there's a guest virtual machine (VM) that is running Windows Server, and the VM has Single Root I/O Virtualization (SR-IOV) enabled. When the VM or the computer is restarted, event ID 236 is logged in the System log.

The event may have description that resembles the following example:

> Failed to allocate virtual function for NIC (Friendly Name: Network Adapter), status = {Drive Not Ready}

## Cause

Event 236 is logged when the user-mode process tries to allocate a virtual function before the VM and the host communication channel is established.

## More information

The user mode process will retry to enable I/O Virtualization at a later stage in few moments. You can verify the IOV VF function by using the PowerShell cmdlet [Get-NetAdapterSriovVf](/powershell/module/netadapter/get-netadaptersriovvf?view=win10-ps&preserve-view=true).
