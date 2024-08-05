---
title: Dynamic Memory allocation in a Virtual Machine does not change although there is available memory on the host
description: Provides a solution to an issue where Dynamic Memory allocation in a virtual machine does not change
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ctimon
ms.custom: sap:Virtualization and Hyper-V\Configuration of virtual machine settings, csstroubleshoot
---
# Dynamic Memory allocation in a virtual machine does not change although there is available memory on the host

This article provides a solution to an issue where Dynamic Memory allocation in a virtual machine does not change, although there is available memory on the host.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2504962

## Symptoms

A virtual machine hosted on a Windows Server 2008 R2 SP1 Hyper-V server with Dynamic Memory configured may indicate a 'Low' or 'Warning' Memory Status in the Hyper-V Management snap-in. Additionally, there is available memory on the host that can be quickly verified by opening Task Manager in the Parent partition. With Task Manager open, select the **Performance** tab, and then click the **Resource Monitor** button at the bottom of the interface. With Resource Monitor open, select the **Memory** tab. The display will indicate how memory is being used in the Parent Partition. Open Event Viewer and verify that an Event ID 3322 is registered in the Microsoft-Windows-Hyper-V Worker/Admin log. The event message indicates additional memory cannot be allocated to the virtual machine because there is not enough free disk space to extend the memory contents file.

> Event ID: 3322  
 Source: Hyper-V-Worker  
 Level: Error  
 Description: \<Virtual Machine name>: Cannot allocate more memory to the virtual machine because there is not enough free disk space to extend the memory contents file '\<path to virtual machine .bin file>' to \<memory value>. (Virtual machine ID \<VM GUID>). To free up disk space, delete unnecessary files from the disk and try again.  

> [!Note]
> The *.bin file contains the virtual machine or snapshot memory contents. When dynamic memory is configured for a virtual machine, the size of this file can increase based on the memory configuration settings implemented by a user for that VM or the memory demand inside the virtual machine itself.

## Cause

There are two possible causes for this:

1. Disk space may not be available on the disk supporting the *.bin file.
2. In a Hyper-V Failover Cluster, a virtual machine can have its configuration information stored on cluster shared storage (a Physical disk resource or a Cluster Shared Volume (CSV). If the physical disk resource or the Cluster Shared Volume (CSV) goes Offline or Fails, the VM placed in a critical state. Once the storage is reconnected, the VM should no longer be in a critical state. However, virtual machine worker process (vmwp.exe) does not refresh all of its file handles.

## Resolution

1. Verify there is sufficient space on the storage supporting the virtual machine configuration files.
2. Execute a Live Migration of the virtual machine(s) experiencing the problem to another node in the cluster. This will re-establish the connections to the required files on the storage.
