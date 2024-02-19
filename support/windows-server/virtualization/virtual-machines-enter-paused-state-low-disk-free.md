---
title: Virtual machines enter paused state
description: Provides a resolution for the issue that Virtual machines enter the paused state due to low disk free space.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, stevenxu
ms.custom: sap:virtual-machine-state, csstroubleshoot
---
# Virtual machines enter the paused state due to low disk free space

This article provides a resolution for the issue that Virtual machines enter the paused state due to low disk free space.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2486243

## Symptoms

Consider the following scenario:

1. You install the Hyper-V role on a computer that is running Windows Server 2008 or Windows Server 2008 R2.
2. You create some virtual machines and store their VHD files into a local hard drive.
3. You attempt to start these virtual machines.

In this scenario, you are unable to start these virtual machines. Their states are changed to "Critical - Paused". You receive the error message "Unable to connect to the Virtual machine Manager Server vmm. The attempt to connect timed out" when you attempt to connect these virtual machines by using System Center Virtual Machine Manager admin console.

In addition, the event below is added into the Microsoft-Windows-Hyper-V-VMMS-Admin log:

>Log Name: Microsoft-Windows-Hyper-V-VMMS-Admin  
Source: Microsoft-Windows-Hyper-V-VMMS  
Date: \<date & time>  
Event ID: 16060  
Task Category: None  
Level: Error  
Keywords:  
User: SYSTEM  
Computer: \<computer name>  
Description:  
\<virtual machine> has been paused because it has run out of disk space on '\<path>'  

## Cause

The hard drives that store these VHD files or snapshots of these virtual machines are out of disk free space.

## Resolution

To fix the issue, free disk space on these hard drives or move these VHD files to a new location.

## More information

In a particular scenario where you have Virtual Machines configured in Cluster Shared Volume (CSV), and if the CSV disk runs out of free space, the VMs enter into paused state. However, the Virtual Machines on the other nodes of the cluster that do not own the CSV are not affected.

Following event is added into the Microsoft-Windows-Hyper-V-VMMS-Admin log:

>Log Name: Microsoft-Windows-Hyper-V-VMMS-Admin  
Source: Microsoft-Windows-Hyper-V-VMMS  
Date: \<date & time>  
Event ID: 16050  
Task Category: None  
Level: Warning  
User: SYSTEM  
Computer: \<computer name>  
Description: \<virtual machine> is about to run out of disk space on '\<path>'  

The node that owns the Cluster Shared Volume keeps checking the disk space and warns. When the warning is received, the Virtual machine's go into the paused critical state. The Node that doesn't own the CSV, will not have any ways to determine if it is running out of space on CSV volume and hence will allow the virtual machines to run the cluster nodes that don't own the CSV.
