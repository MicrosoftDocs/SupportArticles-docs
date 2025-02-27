---
title: Can't access SMB file server through DNS CNAME
description: Describes an issue in which you can't access SMB file server share by using the DNS CNAME. Provides a resolution.
ms.date: 01/15/2025
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kaushika, waltere, nedpyle, nkechiharris
ms.custom:
- sap:network connectivity and file sharing\access to file shares (smb)
- pcy:WinComm Networking
---
# SMB file server share access is unsuccessful through DNS CNAME alias

This article explains how to resolve issues when accessing a Server Message Block (SMB) server by using a canonical name (CNAME).

## Symptoms

Consider the following scenario:

- You have an SMB file server, such as a Windows Server-based computer or a network attached storage (NAS).
- The server has files and resources that are accessible by using their NetBIOS name, Domain Name System (DNS) fully qualified domain name (FQDN), and alias (CNAME).
- You have a client that's running Windows 10, Windows 11, Windows Server 2016, or a later version of Windows Server.
- On the client, you can use the NetBIOS name or FQDN to access the SMB share with an application or a user account.

In this scenario, when you use the CNAME to access the SMB share by running one of the following commands, the command fails.

- `\\CNAME.contoso.com\share_name`
- `\\CNAME\share_name`
- `NET USE * \\CNAME\share_name`
- `NET USE * \\CNAME.contoso.com\share_name`
- `New-PSDrive -Name "x" -PSProvider "FileSystem" -Root "\\CNAME\share_name" -Persist`
- `New-PSDrive -Name "x" -PSProvider "FileSystem" -Root "\\CNAME.contoso.com\share_name" -Persist`

And you might receive an error message that resembles one of the following examples:

> \\\\CNAME.contoso.com\\share_name is not accessible. You might not have permission to use this network resource. Contact the administrator of this server to find out if you have access permissions.
>
> Account restriction is preventing this user from signing in. For example: blank passwords are not allowed, sign-in times are limited or a policy restriction has been enforced.

> \\\\CNAME.contoso.com\\share_name is not accessible. You might not have permission to use this network resource. Contact the administrator of this server to find out if you have access permissions.
>
> Logon Failure: The target account name is incorrect.

## Cause

This issue can be caused by one of the following reasons:

- Configuration issue or SMB server service hardening issue.
- The service principal name (SPN) for the DNS alias (CNAME) record for the file share server is missing.

## Resolution

To resolve this issue, avoid using the DNS CNAME to configure the file server's alternative name. Instead, configure it by defining an alias by using the netdom command:

```console
Netdom computername <ComputerOriginalName> /add:<Alias>
```

For more information, see [Using Computer Name Aliases in place of DNS CNAME Records](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/using-computer-name-aliases-in-place-of-dns-cname-records/ba-p/259064).
