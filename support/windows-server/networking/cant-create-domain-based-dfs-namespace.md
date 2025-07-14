---
title: Can't create a domain-based DFS Namespace
description: Describes how to resolve an issue in which you see an access denied error when you try to create a domain-based namespace.
ms.date: 01/15/2025
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
ms.reviewer: kaushika, v-tappelgate, warrenw, albugn
ms.custom:
- sap:network connectivity and file sharing\dfs namespace (not replication)
- pcy:WinComm Networking
keywords: DFS Namespace
---

# "The namespace cannot be queried. Access is denied" error when you try to create a domain-based DFS Namespace 

This article describes how to resolve an issue in which you see an access denied error when you try to create a domain-based namespace.

_Applies to:_ &nbsp; All supported versions of Windows Server

When you sign in to Windows by using an account that belongs to the **Domain Admins** group, and then you try to create a domain-based namespace on any Distributed File System (DFS) namespace server, the operation fails. Windows returns an error message that resembles the following:

> \\\\contoso.com\\Public The namespace cannot be queried. Access is denied.

However, when this error occurs, you can still successfully create a standalone namespace.

## Cause 1: NTLM authentication fails

When you create a new domain-based namespace, a Domain Name System (DNS) query for the domain name is sent to the DNS server to receive a list of the A records for domain controllers (DCs). After receiving the DNS response, New Technology LAN Manager (NTLM) authentication is performed against one of these DCs.

Since the used account is a member of the **Protected Users** group, NTLM authentication fails with the `STATUS_ACCOUNT_RESTRICTION` error.

By default, accounts that are members of the **Protected Users** group can't authenticate with NTLM authentication.

### Wireshark trace example

```output
192.168.0.42    192.168.0.1        SMB2    681    Session Setup Request, NTLMSSP_AUTH, User: CONTOSO\Testuser
192.168.0.1        192.168.0.42    SMB2    130    Session Setup Response, Error: STATUS_ACCOUNT_RESTRICTION
```

## Resolution for cause 1: Remove the used account from the "Protected Users" group

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

To solve this issue, remove the used account from the **Protected Users** group to perform NTLM authentication. For more information, see [Protected Users Security Group](/windows-server/security/credentials-protection-and-management/protected-users-security-group).

## Cause 2: The SMB session isn't mutually authenticated

This error can also occur when you have implemented hardening (Server Message Block (SMB) mutual authentication) on the paths of the domain (for example, `\\Contoso.com\*` or `\\CONTOSO\*`).

The machine applying the hardening configuration can't create a `netdfs` pipe because the SMB session isn't mutually authenticated.

You can check if the hardening setting is implemented in your environment by running the `gpresult /h` command. You can also check the registry setting on the affected machine under:

`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths`

You should find entries for the domain name, like:

|Domain name  |Value name and data  |
|---------|---------|
|`\\corp\*`     |`RequireMutualAuthentication=1`<br>`RequireIntegrity=1`         |
|`\\corp.contoso.com\*`     |`RequireMutualAuthentication=1`<br>`RequireIntegrity=1`         |

## Resolution for cause 2: Set the RequireMutualAuthentication value to zero

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.
[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

To solve this issue, set the `RequireMutualAuthentication` value for `\\Contoso\*` and `\\contoso.com\*` to zero. After making these changes, you can create the namespace.

For example:

|Domain name  |Value name and data  |
|---------|---------|
|`\\corp.contoso.com\*`     |`RequireMutualAuthentication=0`<br>`RequireIntegrity=1`         |
|`\\corp\*`     |`RequireMutualAuthentication=0`<br>`RequireIntegrity=1`         |

### Example of a Process Monitor log file for this scenario

```output
10:32:48.8093671 AM    mmc.exe    3488    CreateFile    \\contoso.com\pipe\netdfs    0xC0000201    Desired Access: Generic Read/Write, Disposition: Open, Options: , Attributes: n/a, ShareMode: Read, Write, AllocationSize: n/a
```

Error c0000201 indicates, "A remote open failed because the network open restrictions were not satisfied."

> [!NOTE]
> The following Process Monitor filters are helpful:
>
> - `PID is 3488`, which is the PID of the DFS Management console
>
>     In the preceding Process Monitor output, 3488 is the PID of the DFS Management console process. Before you use this filter, identify the PID of the DFS Management console process first.
> - `Path contains \\contoso.com` (or `\\contoso`)

## More information

- [Protected Users Security Group](/windows-server/security/credentials-protection-and-management/protected-users-security-group)
- [Guidance about how to configure protected accounts](/windows-server/identity/ad-ds/manage/how-to-configure-protected-accounts)
