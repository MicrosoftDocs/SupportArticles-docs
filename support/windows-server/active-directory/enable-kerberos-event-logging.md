---
title: Enable Kerberos event logging
description: Discusses how to turn on detailed Kerberos logging on a particular computer, and how to use that information for troubleshooting.
ms.date: 05/04/2026
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm, v-appelgatet
ai.usage: ai-assisted
ms.custom:
- sap:active directory\user,computer,group,and object management
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# How to enable Kerberos event logging

_Original KB number:_ &nbsp; 262177

## Summary

When you troubleshoot Kerberos, you can turn on detailed Kerberos logging for the event log. Kerberos logging can affect computer performance and generate a significant amount of log data. Therefore, it's turned off by default. Enable it only if you need it to troubleshoot Kerberos issues.

> [!IMPORTANT]
> Detailed Kerberos logging captures events that indicate "expected" errors, such as `KDC_ERR_PREAUTH_REQUIRED`. Expected errors occur during typical operations and don't indicate issues. For more information, see [Examples of common Kerberos codes](#examples-of-common-kerberos-codes).

## Enable Kerberos event logging on a computer

To enable Kerberos logging, follow these steps on the computer that you want to use for recording log data.

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

1. Start Registry Editor, and locate `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters`. If the `Parameters` entry doesn't exist, create it.

1. Add the following registry value:

   - Registry value: `LogLevel`  
   - Value type: REG_DWORD  
   - Value data: `0x1`

1. Close Registry Editor. The setting takes effect immediately, and the system log starts recording Kerberos events.

> [!NOTE]  
> Detailed Kerberos logging might affect the computer's performance. When you finish troubleshooting, remove the registry entry from the computer.

## Examples of common Kerberos codes

The following table lists common Kerberos codes, when they might occur, and what to do about them. Notice that some of these codes are expected during regular operations and don't indicate that an issue occurred. If you see codes other than the codes that are listed here, contact your system or domain administrator.

| Code | Context | Recommendation |
| - | - | - |
| `KDC_ERR_PREAUTH_REQUIRED` | Code that the server sends as part of its response to the client's first Authenticate Server (AS) request. The first AS request doesn't include all the information that the server needs. The server's response identifies the information that the server expects, such as supported encryption types. If the server uses AES encryption, the response includes the salts to add to the password before it's hashed. | This behavior is by design. Ignore this code. |
| `KDC_ERR_S_BADOPTION` | Code that the server sends if the client's ticket request included options or delegation flags that the server can't respond to or doesn't support. Typically, the client automatically sends another request that uses different options or flags. | Unless you're troubleshooting a delegation problem, ignore this error. |
| `KDC_ERR_S_PRINCIPAL_UNKNOWN` | Code that the server sends if it doesn't recognize the service principal name (SPN) that a client requested access to. There are multiple situations in which this issue can occur. Typically, either the client request is incorrect, or the application or service isn't configured correctly. When this issue occurs, the client automatically sends a request to authenticate by using NTLM. If the server is configured to allow NTLM authentication, the client authenticates, and the user doesn't notice the issue. | For detailed troubleshooting information, see [Kerberos generates KDC_ERR_S_PRINCIPAL_UNKNOWN or KDC_ERR_PRINCIPAL_NOT_UNIQUE error](../windows-security/kerberos-error-kdc-err-s-principal-unknown-or-not-unique.md). |
| `KRB_AP_ERR_MODIFIED` | Code that indicates that the client couldn't decrypt the service ticket. Because more than one issue can cause this error, check for related events. | For detailed troubleshooting information, see [Kerberos authentication troubleshooting guidance](../windows-security/kerberos-authentication-troubleshooting-guidance.md). |
