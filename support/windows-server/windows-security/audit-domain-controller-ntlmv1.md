---
title: Audit use of NTLMv1 on a domain controller
description: Steps to audit the usage of NTLMv1 on a Windows Server-based domain controller.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Windows Security Technologies\Legacy authentication (NTLM), csstroubleshoot
---
# Audit use of NTLMv1 on a Windows Server-based domain controller

This article introduces the steps to test any application that's using NT LAN Manager (NTLM) version 1 on a Microsoft Windows Server-based domain controller.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4090105

## Summary

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft can't guarantee that these problems can be solved. Modify the registry at your own risk.

You may do this test before setting computers to only use NTLMv2. To configure the computer to only use NTLMv2, set **LMCompatibilityLevel** to **5** under the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa` key on the domain controller.

## NTLM auditing

To find applications that use NTLMv1, enable Logon Success Auditing on the domain controller, and then look for Success auditing Event 4624, which contains information about the version of NTLM.

You will receive event logs that resemble the following ones:

```output
Sample Event ID: 4624  
Source: Microsoft-Windows-Security-Auditing  
Event ID: 4624  
Task Category: Logon  
Level: Information  
Keywords: Audit Success  
Description:  
An account was successfully logged on.  
Subject:  
Security ID: NULL SID  
Account Name: -  
Account Domain: -  
Logon ID: 0x0  
Logon Type: 3  

New Logon:  
Security ID: ANONYMOUS LOGON  
Account Name: ANONYMOUS LOGON  
Account Domain: NT AUTHORITY  
Logon ID: 0xa2226a  
Logon GUID: {00000000-0000-0000-0000-000000000000}

Process Information:  
Process ID: 0x0  
Process Name: -  
Network Information:  
Workstation Name: Workstation1  
Source Network Address:\<ip address>  
Source Port: 49194

Detailed Authentication Information:  
Logon Process: NtLmSsp  
Authentication Package: NTLM  
Transited Services: -  
Package Name (NTLM only): NTLM V1  
Key Length: 128
```

## More information

This logon in the event log doesn't really use NTLMv1 session security. There's actually no session security, because no key material exists.

The logic of the NTLM Auditing is that it will log NTLMv2-level authentication when it finds NTLMv2 key material on the logon session. It logs NTLMv1 in all other cases, which include anonymous sessions. Therefore, our general recommendation is to ignore the event for security protocol usage information when the event is logged for **ANONYMOUS LOGON**.

Common sources of anonymous logon sessions are:

- [Computer Browser Service](/previous-versions/windows/it-pro/windows-server-2003/cc778351(v=ws.10)): It's a legacy service from Windows 2000 and earlier versions of Windows. The service provides lists of computers and domains on the network. The service runs in the background. However, today this data is no longer used. We recommend that you disable this service across the enterprise.

- SID-Name mapping: It can use anonymous sessions. See [Network access: Allow anonymous SID/Name translation](/windows/security/threat-protection/security-policy-settings/network-access-allow-anonymous-sidname-translation). We recommend that you require authentication for this functionality.

- Client applications that don't authenticate: The application server may still create a logon session as anonymous. It's also done when there are empty strings passed for user name and password in NTLM authentication.
