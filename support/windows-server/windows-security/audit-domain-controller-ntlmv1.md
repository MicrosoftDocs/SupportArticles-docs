---
title: Audit use of NTLMv1 on a domain controller
description: Discusses how to use event logs to audit the usage of NTLMv1 on a Windows Server-based domain controller.
ms.date: 02/3/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm, v-appelgatet
ms.custom:
- sap:windows security technologies\legacy authentication (ntlm)
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Audit use of NTLMv1 on a Windows Server-based domain controller

_Original KB number:_ &nbsp; 4090105

## Summary

This article describes how to audit NTLMv1 authentication on Windows Server domain controllers. Use this information to identify applications and services that still use NTLMv1 before you disable it in your environment.

NTLMv1 is a legacy authentication protocol that Microsoft deprecated in June 2024. For more information, see [Deprecated Features](/windows/whats-new/deprecated-features#deprecated-features).

To maintain security, identify any remaining NTLMv1 usage and migrate applications to use modern authentication protocols. To audit the use of any version of NTLM, use the methods that are described in this article and in [Removing NTLMv1, new audit event for use of NTLM](https://support.microsoft.com/topic/upcoming-changes-to-ntlmv1-in-windows-11-version-24h2-and-windows-server-2025-c0554217-cdbc-420f-b47c-e02b2db49b2e)

## NTLM auditing

To find applications that use NTLMv1, enable Logon Success Auditing on the DC. Then review the event log on the DC for Success auditing Event ID 4624, which contains information about the version of NTLM.

The text of Event ID 4624 resembles the following example:

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

## Using NTLMv2 exclusively

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

To configure a DC to only use NTLMv2 for authentication, configure the following registry value on the DC:

- Subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa`
- Entry: `LMCompatibilityLevel`
- Value: **5**

For more information, see [How to enable NTLM 2 authentication](enable-ntlm-2-authentication.md).

## More information

The sign-in (logon) operation that Event ID 4624 describes doesn't use NTLMv1 session security. There's actually no session security, because no key material exists.

The logic of the NTLM Auditing is that it logs NTLMv2-level authentication when it finds NTLMv2 key material on the sign-in session. It logs NTLMv1 in all other cases, which include anonymous sessions. Therefore, our general recommendation is to ignore the event for security protocol usage information when the event is logged for **ANONYMOUS LOGON**.

Common sources of anonymous logon sessions include the following applications and services:

- [Computer Browser Service](/previous-versions/windows/it-pro/windows-server-2003/cc778351(v=ws.10)): It's a legacy service from Windows 2000 and earlier versions of Windows. The service provides lists of computers and domains on the network. The service runs in the background. However, today this data is no longer used. We recommend that you disable this service across the enterprise.

- SID-Name mapping: It can use anonymous sessions. See [Network access: Allow anonymous SID/Name translation](/windows/security/threat-protection/security-policy-settings/network-access-allow-anonymous-sidname-translation). We recommend that you require authentication for this functionality.

- Client applications that don't authenticate: The application server might still create a logon session as an anonymous user. Similarly, it might create an anonymous session if it uses NTLM authentication together with empty user name and password strings.
