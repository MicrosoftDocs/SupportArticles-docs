---
title: Enable Kerberos event logging
description: This article provides a solution on how to enable Kerberos event logging on a particular machine.
ms.date: 05/05/2026
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm
ms.custom:
- sap:active directory\user,computer,group,and object management
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# How to enable Kerberos event logging

_Original KB number:_ &nbsp; 262177

## Summary

When you troubleshoot Kerberos, you can turn on detailed Kerberos logging for the event log. Kerberos logging can affect computer performance and generate a significant amount of log data, so it's turned off by default. Only enable it if you need it for troubleshooting Kerberos issues.

> [!IMPORTANT]
> Detailed Kerberos logging captures events that indicate "expected" errors, such as `KDC_ERR_PREAUTH_REQUIRED`. Expected errors occur during typical operations and don't indicate issues. For more information, see [Examples of common Kerberos codes](#examples-of-common-kerberos-codes).

## Enable Kerberos event logging on a computer

To enable Kerberos logging, follow these steps on the computer that you want to use for recording log data.

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

1. Start Registry Editor, and go to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters`. If the `Parameters` entry does not exist, create it.

1. Add the following registry value:

   - Registry value: `LogLevel`  
   - Value type: REG_DWORD  
   - Value data: `0x1`

1. Close Registry Editor. The setting immediately takes effect, and the system log starts recording Kerberos events.

> [!NOTE]  
> Detailed Kerberos logging might affect the computer's performance. When you finish troubleshooting, remove the registry entry from the computer.

## Examples of common Kerberos codes

The following table lists common Kerberos codes, when they might occur, and what to do about them. Notice that some of these codes are expected during regular operations and don't indicate that an issue has occurred. If you see codes other than those listed here, contact your system or domain administrator.

| Code | Context | Recommendation |
| - | - | - |
| `KDC_ERR_PREAUTH_REQUIRED` | Code that the server sends as part of its response to the client's first Authenticate Server (AS) request. The first AS request doesn't include all of the information that the server needs. The server's response identifies the information that the server expects, such as supported encryption types. In the case of AES encryption, the response includes the salts to be used to encrypt the password hashes with. | This behavior is by design. Ignore this code. |
| `KDC_ERR_S_BADOPTION` | Code that the server sends if the client's ticket request included options or delegation flags that the server can't respond to or doesn't support. Typically, the client automatically sends another request that uses different options or flags. | Unless you're troubleshooting a delegation problem, ignore this error. |
| `KDC_ERR_S_PRINCIPAL_UNKNOWN` | Code that the server sends when it doesn't recognize the service principal name (SPN) that a client requested access to. There are multiple situations in which this issue can occur. Typically, either the client request is incorrect, or the application or service isn't configured correctly. When this issue occurs, the client automatically sends a request to authenticate by using NTLM. If the server is configured to allow NTLM authentication, the client authenticates and the user doesn't notice the issue. | For detailed troubleshooting information, see [Kerberos generates KDC_ERR_S_PRINCIPAL_UNKNOWN or KDC_ERR_PRINCIPAL_NOT_UNIQUE error](../windows-security/kerberos-error-kdc-err-s-principal-unknown-or-not-unique.md). |
| `KRB_AP_ERR_MODIFIED` | Code that indicates that the client couldn't decrypt the service ticket. Because more than one issue can cause this error, check for related events. | For detailed troubleshooting information, see [Kerberos authentication troubleshooting guidance](../windows-security/kerberos-authentication-troubleshooting-guidance.md). |
