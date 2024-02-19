---
title: VM shutdown actions don't run
description: Describes a problem that prevents virtual machine shutdown actions from running in Windows Server 2012 and Windows 8. Occurs when shutdowns are triggered by the OS because of a low battery condition.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, raackley
ms.custom: sap:virtual-machine-state, csstroubleshoot
---
# VM shutdown actions don't run when a host shuts down because of a low battery

This article helps solve a problem that prevents virtual machine shutdown actions from running.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3058418

## Symptoms

Consider the following scenario:

- You're running Windows Server 2012 R2 on a computer that has an attached uninterruptible power supply (UPS) or on a laptop.
- This Windows Server 2012 R2-based system has the Hyper-V role installed and is hosting virtual machines.
- The battery is running out of power.
- The host operating system shuts down because of the low battery condition.
- After you restart the computer, you notice the virtual machines are in a Stopped state and that errors are logged in the virtual machine event logs.  

In this scenario, the configured host shutdown actions for the virtual machine (Stop VM, Save VM state, Shut down VM) don't run as expected, and the virtual machines are not gracefully shut down or saved. This behavior may be indicated by the following event log entries on the guest VMs:

> Log Name: Microsoft-Windows-Hyper-V-Worker-Admin  
Source: Microsoft-Windows-Hyper-V-Worker  
Event ID: 18590  
Level: Critical  
Description:  
'*Guestname*' has encountered a fatal error. The guest operating system reported that it failed with the following error codes: ErrorCode0: 0xEF, *[additional variable information]*  

> Event ID: 6008  
Source: Event Log  
Type: Error  
Description:  
The previous system shutdown at *Time* on *Date* was unexpected.

## Cause

When a shutdown is triggered by a low battery (either **Low**  or **Critical**  levels), services that are running on the system are not notified of the shutdown. This behavior occurs because a clean operating system shutdown is prioritized over stopping services, as stopping services can block shutdowns for a lengthy period. Because Hyper-V relies on service notifications to trigger the configured actions on the guest VMs, the configured actions don't run before the host shuts down.

> [!NOTE]
> This behavior does not apply when the system is shut down by third-party UPS software.

## Resolution

When you're running a Hyper-V server that has an attached UPS, use the UPS manufacturer's software to correctly handle battery threshold levels and to initiate a regular system shutdown when appropriate.
