---
title: Invalid client IP address in security event ID 4624 in Windows 7 and Windows Server 2008 R2
description: Describes an issue that generates event 4624 and an invalid client IP address and port number when a client computer tries to access a host computer that's running RDP 8.0. Occurs in a Windows 7 or Windows Server 2008 environment. A resolution is provided.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
---
# Invalid client IP address in security event ID 4624 in Windows 7 and Windows Server 2008 R2

This article provides a resolution to an issue where event 4624 and an invalid client IP address and port number are generated when a client computer tries to access a host computer that's running RDP 8.0.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 3097467

## Symptoms

Assume that the Remote Desktop Protocol (RDP) 8.0 update for Windows 7 and Windows Server 2008 R2 (KB2592687) is installed and enabled through policy settings. When a user's remote desktop logs on to that computer, security event ID 4624 is logged and shows an invalid client IP address and port number, as follows:

> Log Name: Security  
Source: Microsoft-Windows-Security-Auditing  
Date: 9/14/2015 6:10:36 PM  
Event ID: 4624  
Task Category: Logon  
Level: Information  
Keywords: Audit SuccessUser: N/A  
Computer: \<computerFQDN>  
Description:  
An account was successfully logged on.  
>
> Subject:  
 Security ID: SYSTEM  
 Account Name: \< MachineName>$  
 Account Domain: \<DomainName>  
 Logon ID: 0x3e7  
>
> Logon Type: 10  
>
> New Logon:
 Security ID: \< DomainName>\\\<username>  
 Account Name: \< UserName>  
 Account Domain: \<DomainName>  
 Logon ID: 0x35137  
 Logon GUID: {00000000-0000-0000-0000-000000000000}  
>
> Process Information:  
 Process ID: 0x7cc  
 Process Name: C:\\Windows\\System32\\winlogon.exe  
>
> Network Information:  
 Workstation Name:\<computername>  
 Source Network Address: 244.230.0.0  
 Source Port: 0  
>
> Detailed Authentication Information:  
Logon Process: User32  
Authentication Package: Negotiate  
Transited Services: -  
Package Name (NTLM only): -  
Key Length: 0  
>
> This event is generated when a logon session is created. It is generated on the computer that was accessed.  
The subject fields indicate the account on the local system which requested the logon. This is most commonly a service such as the Server service, or a local process such as Winlogon.exe or Services.exe. The logon type field indicates the kind of logon that occurred. The most common types are 2 (interactive) and 3 (network). The logon type field indicates the kind of logon that occurred. The most common types are 2 (interactive) and 3 (network). The New Logon fields indicate the account for whom the new logon was created, i.e. the account that was logged on. The network fields indicate where a remote logon request originated. Workstation name is not always available and may be left blank in some cases.
>
> The authentication information fields provide detailed information about this specific logon request.
>
> - Logon GUID is a unique identifier that can be used to correlate this event with a KDC event.
> - Transited services indicate which intermediate services have participated in this logon request.
> - Package name indicates which sub-protocol was used among the NTLM protocols.
> - Key length indicates the length of the generated session key. This will be 0 if no session key was requested.

## Cause

This issue occurs because of a code change in RDP 8.0. In RDP 8.0, the client IP address is stored in a WTS_SOCKADDR structure. This differs from RDP 7.0 (the default RDP version in Windows 7 and Windows Server 2008 R2).

In Windows 8 and Windows Server 2012 (and later versions of Windows), the code logic for logging this event is rewritten based on the new design. That prevents this issue from occurring.

## Resolution

To resolve this issue, upgrade the RDP target computer to Windows 8 or Windows Server 2012 (or later). Or, disable RDP 8.0 in Windows 7 or Windows Server 2008 R2.

## More information

You may also encounter this issue if you're using a third-party RDP component to log on to Windows 7 or Windows Server 2008 R2 when that third-party component uses the same WTS_SOCKADDR structure. In this situation, consider upgrading the OS, or contact the component provider for assistance.
