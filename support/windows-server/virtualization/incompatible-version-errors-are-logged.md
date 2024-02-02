---
title: Incompatible version errors are logged
description: Describes a problem that occurs when you start Windows Server 2008 R2 as a Windows Server 2008 Hyper-V guest.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installation-and-configuration-of-hyper-v, csstroubleshoot
---
# Incompatible version errors are logged in the System log when you start Windows Server 2008 R2 as a Windows Server 2008 Hyper-V guest

This article provides a solution to an issue that occurs when you start Windows Server 2008 R2 as a Windows Server 2008 Hyper-V guest.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 972108

## Symptoms

When you start a Windows Server 2008 R2 guest operating system on a Windows Server 2008 Hyper-V host, the following events may be logged in the System log.

Event messages logged on the Windows Server 2008 Hyper-V host system:

> Log Name: System  
Source: vmbus  
Event ID: 2  
Level: Error  
Computer: 2008SRV.contoso.com  
Description: The parent partition uses a different VMBus version. You need to Install a matching VMBus version in this guest installation.

> Log Name: System  
Source: VMSMP  
Event ID: 26  
Level: Error  
Computer: 2008SRV.contoso.com  
Description: NIC driver on '2008R2-Guest' cannot load because it is incompatible with the server virtualization stack. Server version 2 Client version 196610 (VMID 9A5FAAC3-1F7A-442D-9525-46B39ACE22DB).

> Log Name: System  
Source: storvsp  
Event ID: 5  
Level: Error  
Computer: 2008SRV.contoso.com  
Description: A storage device in '2008R2-Guest' cannot load because it is incompatible with the server virtualization stack. Server version 2.0 Client version 4.2 (VMID 9A5FAAC3-1F7A-442D-9525-46B39ACE22DB).

Event messages logged on the Windows Server 2008 R2 guest operating system:

> Log Name: System  
Source: netvsc  
Event ID: 12  
Level: Warning  
Computer: 2008R2SRV  
Description: VSP rejected attempt to use protocol version '3.2'.

## Cause

During the protocol negotiation process between Virtualization Services Provider (VSP) and Virtualization Services Clients (VSC), an error message is logged if the VSC version is later than the VSP version. The error occurs because of a "failed" negotiation for a version match between VSC and VSP. However, the negotiation continues and eventually succeeds. The only effect is that incompatible version errors are logged in the System log.

## Resolution

You can safely ignore these error events. The correct drivers are loaded based on the successful version negotiation.

## More information

In Windows Server 2008 and in Windows Server 2008 R2, the protocol version negotiation for synthetic devices works as follows:

- VSC sends VSP a proposed version, starting with its preferred version, such as the newest version.
- VSP checks the version against a table of supported versions.
- If the proposed version matches one of the supported versions, VSP sends a "success" message.
- Otherwise, VSP sends a "fail" message and the process is repeated until the VSC is out of versions to try.

