---
title: Virtual machine that's running on Windows Server 2012 R2 doesn't start
description: Describes an issue that prevents a Windows Server 2012 R2-based virtual machine from running. Occurs even though Task Manager indicates that there's sufficient available memory. A workaround is provided.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:virtual-machine-will-not-boot, csstroubleshoot
---
# Virtual machine that's running on Windows Server 2012 R2 doesn't start

This article provides a workaround for an issue that prevents a Windows Server 2012 R2-based virtual machine from running. This issue occurs even though Task Manager indicates that there's sufficient available memory.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2962295

## Symptoms

A virtual machine that's running in Windows Server 2012 R2 doesn't start, and you receive the following error message. This occurs even though Task Manager indicates that there's sufficient available memory.

> '\<**Virtual Machine Name**>' could not initialize.  
Not enough memory in the system to start the virtual machine '\<**Virtual Machine Name**>'

Also, the following event is logged in the Microsoft-Windows-Hyper-V-VMMS-Admin log.

> Log Name: Microsoft-Windows-Hyper-V-VMMS-Admin  
Event ID: 19544  
Level: Error  
Description:  
Failed to start the virtual machine 'Virtual Machine Name' which required xxxx MB of memory because only **xxxx** MB was available in the system (Virtual machine ID \<**Virtual Machine ID**>).

## Cause

When Windows Server 2012 R2 starts, the Hyper-V host dynamically reserves the minimum amount of memory that's required to run the host operating system and any applications. The size of this reservation depends on several factors.

The remaining memory is available to virtual machines. However, this quantity differs from what is displayed in Task Manager as "available memory." Therefore, the virtual machine may not start even if the Hyper-V host appears to have sufficient memory according to Task Manager.

To accurately check the available memory for virtual machines, see the [Workaround](#workaround) section to use the performance object and counter name.

## Workaround

To start the virtual machine, either free up sufficient memory on the host or resize the virtual machine based on availability according to the performance counter mentioned below.

The following performance counter can be used to explicitly check how much memory is available for virtual machines:

Hyper-V Dynamic Memory Balancer\\Available Memory

> [!NOTE]
>
> - The instance name is "System Balancer."
> - The Hyper-V Dynamic Memory Balancer\\Available Memory value depends on the amount of memory that's used by the application installed in the Hyper-V host, and the amount that's used by vmwp.exe.

The counter shows how much memory is available for starting the virtual machine. Therefore, if you encounter this issue, the available memory that's shown in Task Manager doesn't help. However, the available memory that's shown in the performance counter may indicate the actual available memory for Hyper-V.
