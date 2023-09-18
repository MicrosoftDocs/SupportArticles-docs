---
title: VmSwitch Error 113 event
description: Discusses that VmSwitch Error 113 event is logged when you start or live migrate virtual machines in Windows Server 2012 R2.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: Tode, kaushika
ms.custom: sap:virtual-switch-manager-vmswitch, csstroubleshoot
ms.technology: hyper-v
---
# VmSwitch Error 113 event is logged when you start or live migrate virtual machines

This article provides a solution to VmSwitch Error 113 event that occurs when you start or live migrate virtual machines.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3001783

## Symptoms

Consider the following scenario:

- You have a Windows Server 2012 R2-based computer that is configured for one or more NIC teams by using Windows NIC Teaming (LBFO).
- You have implemented Windows NIC Teaming (LBFO) in Switch Independent teaming mode by using Hyper-V Port or Dynamic Load Balancing mode. Additionally, you have correctly configured the NICs to use non-overlapping processors. (For more information, see [KB2974384](https://support.microsoft.com/help/2974384)).
- A Hyper-V virtual switch is bound to one of the LBFO teams.
- You start a virtual machine on the Hyper-V server, or you live migrate a virtual machine from one server to another server.

In this scenario, the following Error 113 event is logged intermittently in the event log:

> Log Name: System  
Source: Microsoft-Windows-Hyper-V-VmSwitch  
Date: \<DateTime>  
Event ID: 113  
Task Category: None  
Level: Error  
Keywords:  
User: SYSTEM  
Computer: `Server1.contoso.com`  
Description:  
Failed to allocate VMQ for NIC EDCED345-4C96-4C75-92A0-0C4FC5688F73--35BEB899-5BE9-4128-900A-6FE0BBFC7B22
(Friendly Name: Network Adapter) on switch DE4F3664-68D9-4781-825B-882A540FAB08 (Friendly Name: VM Switch).
Reason - The OID failed. Status = {Operation Failed} The requested operation was unsuccessful.

Additionally, the Hyper-V VmSwitch may fail to allocate VMQ queues for virtual machines.

In the event description, the **Reason** text will always be **The OID failed**. The **Status** text will vary based on the network adapter driver that is being used. Some other **Status** examples include the following:

- Status = An invalid parameter was passed to a service or function.
- Status = Insufficient system resources exist to complete the API.
- Status = Unknown

## Cause

This problem occurs because the VmSwitch assumes that the default processor for VMQ is zero (0) when it performs VMQ allocation. This causes some network adapter drivers to reject the allocation and generate Error 113.

## Resolution

To resolve this problem, install [hotfix 3031598](https://support.microsoft.com/help/3031598).

## More information

There is another source of Hyper-V VmSwitch Error 113 that is not related to the problem that is mentioned in the Symptoms section. This error occurs when your Hyper-V server has more running virtual machines than the number of VMQ queues that are available on the physical network adapters. In this situation, the Error 113 description text resembles the following:

> Description:  
Failed to allocate VMQ for NIC  
EDCED345-4C96-4C75-92A0-0C4FC5688F73--35BEB899-5BE9-4128-900A-6FE0BBFC7B22  
(Friendly Name: Network Adapter) on switch DE4F3664-68D9-4781-825B-882A540FAB08 (Friendly Name: VM Switch).  
Reason - Maximum number of VMQs supported on the Protocol NIC is exceeded. Status = Insufficient system  
resources exist to complete the API.  

> [!NOTE]
> In this event description, the **Reason** text clearly states **Maximum number of VMQs supported on the Protocol NIC is exceeded**.
