---
title: Event ID 4625 is logged
description: A security audit failure event ID 4625 is logged every 5 minutes in the Security event log.
ms.date: 06/23/2020
ms.reviewer: mihsar, charris, adoyle, jchornbe
---
# Event ID 4625 is logged every 5 minutes when using the Exchange 2010 management pack in Operations Manager

This article describes a by-design behavior that event ID 4625 is logged every 5 minutes when you use Microsoft Exchange 2010 management pack in System Center Operations Manager.

_Original product version:_ &nbsp; System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2591305

## Symptoms

When using the Exchange 2010 management pack in System Center Operations Manager, you may receive a security audit failure event in the Security event log every 5 minutes. Here is an example of the event:

> Log Name: Security  
> Source: Microsoft-Windows-Security-Auditing  
> Date:  
> Event ID: 4625  
> Task Category: Logon  
> Level: Information  
> Keywords: Audit Failure  
> User: N/A  
> Computer: *ComputerName*  
>
> Description:  
> An account failed to log on.
>
> Subject:  
> Security ID: NULL SID  
> Account Name: -  
> Account Domain: -  
> Logon ID: 0x0
>
> Logon Type: 3
>
> Account For Which Logon Failed:  
> Security ID: NULL SID  
> Account Name: Aextest_\<*GUID*>  
> Account Domain: \<Domain_name>
>
> Failure Information:  
> Failure Reason: Unknown user name or bad password.  
> Status: 0xc000006d  
> Sub Status: 0xc0000064
>
> Process Information:  
> Caller Process ID: 0x0  
> Caller Process Name: -
>
> Network Information:  
> Workstation Name: *WorkstationName*  
> Source Network Address: *SourceNetworkAddress*  
> Source Port: 30956
>
> Detailed Authentication Information:  
> Logon Process: NtLmSsp  
> Authentication Package: NTLM  
> Transited Services: -  
> Package Name (NTLM only): -  
> Key Length: 0

> [!NOTE]
> The account name will have the format Aextest_\<*GUID*>.

## Cause

The actual Exchange mailbox account used is extest_\<*GUID*>. This extra A is passed so that the test account doesn't get locked out.

## Resolution

This event can be ignored as it is by design.
