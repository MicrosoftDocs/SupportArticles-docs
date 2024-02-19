---
title: Unexpected warning and error messages in a virtualized Windows Server failover cluster
description: Describes an issue where unexpected warning and error messages occur in a Windows Server failover cluster that has been configured to run as a guest (virtual machine) in a Hyper-V environment.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: ctimon, sdwyer, kaushika
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
---
# Unexpected warning and error messages in a virtualized Windows Server failover cluster

This article describes an issue where unexpected warning and error messages occur in a Windows Server failover cluster that has been configured to run as a guest (virtual machine) in a Hyper-V environment.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2014304

## Symptoms

In a Windows Server failover cluster that has been configured to run as a guest (virtual machine) in a Hyper-V environment, the following messages are written to the logs that are indicated in the message details:

> Warning message:
>
> Log Name:  Microsoft-Windows-FailoverClustering-Manager/Admin  
Source:  Microsoft-Windows-FailoverClustering-Manager/Admin  
Event ID:  4694  
Level:  Warning  
Hyper-V management tools were not found on the system.  Creation and management of virtual machines will be disabled in Failover Cluster Manager.  Install Hyper-V role admin tools for servers or RSAT tools for clients to enable those options.  
Error message:  
>
> Log Name:  Microsoft-Windows-Hyper-V-High-Availability/Admin  
Source:  Hyper-V-High-Availability  
Event ID:  21123  
Level:  Error  
Failed to set the migration networks at the VMMS: Class not registered (0x80040154)  

## Cause

These messages are registered because of the new functionality in Windows Server failover clusters. This new functionality includes better interoperability with Hyper-V. Even when the failover cluster is running in a virtualized environment as a guest (virtual machine), the failover clustering feature expects aspects of the Hyper-V role to be available. When the failover cluster doesn't find these Hyper-V aspects, these messages are written to the logs in question.

## Resolution

To resolve the warning message, install the Hyper-V role Remote Server Administration tools. To add the Hyper-V Remote Server Administration tools, follow these steps:  

1. Click **Start**, click **Administrative Tools**, and then click **Server Manager**.
2. In the navigation pane, click **Features**, and then click **Add Features**.
3. Expand **Remote Server Administration Tools.**  
4. Click **Hyper-V Tools**, click **Next**, and then click **Install**.

There's no workaround or resolution for the error message. However, you can safely ignore this error message in this scenario.

## More information

In a Windows Server 2008 R2 IA-64 environment, there's no workaround for this error message because Hyper-V doesn't support the IA-64 architecture.
