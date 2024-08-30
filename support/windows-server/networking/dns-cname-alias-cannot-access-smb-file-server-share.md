---
title: Can't access SMB file server
description: Describes an issue in which you can't access SMB file server share by using the DNS CNAME. Provides a resolution.
ms.date: 09/02/2024
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, waltere, nedpyle, nkechiharris
ms.custom: sap:Network Connectivity and File Sharing\Access to file shares (SMB), csstroubleshoot
---
# SMB file server share access is unsuccessful through DNS CNAME alias

This article explains how to resolve issues when accessing a Server Message Block (SMB) server using a Canonical Name (CNAME).

## Symptoms

Consider the following scenario:

- You have an SMB file server, such as a Windows Server-based computer or a Network Attached Storage (NAS).
- The server has files and resources that are accessible using NetBIOS name, the Domain Name System (DNS) fully qualified domain name (FQDN), and alias (CNAME).
- You have a client that's running Windows 10, Windows 11, Windows Server 2016, or a later version of Windows Server.
- On the client, you can use the NetBIOS name or the FQDN to access to an SMB share by with an application or a user account.

In this scenario, when you use the CNAME to access the SMB share by running one of the following commands, the command fails.

- `\\CNAME.contoso.com\share_name`
- `\\CNAME\share_name`
- `NET USE * \\CNAME\share_name`
- `NET USE * \\CNAME.contoso.com\share_name`
- `New-PSDrive -Name "x" -PSProvider "FileSystem" -Root "\\CNAME\share_name" -Persist`
- `New-PSDrive -Name "x" -PSProvider "FileSystem" -Root "\\CNAME.contoso.com\share_name" -Persist`

And you might receive the error message that reassembles the following screenshots:

> \\\\CNAME.contoso.com\\share_name is not accessible. You might not have permissions to use this network resource. Contact the administrator of this server to find out if you have access permissions.

> Account restriction is preventing this user from signing in. For example: blank passwords are not allowed, sign-in times are limited or a policy restriction has been enforced.

## Cause

This issue can be caused by one of the following reasons:

- Configuration issue or SMB server service hardening issue.
- Missing Service Principal Name (SPN) for DNS Alias (CNAME) record for the File Share Server.

## Resolution

To resolve this issue, avoid using DNS CNAMEs to configure alternative names for file servers. Instead, configure it by defining an alias by using the netdom command:

```console
Netdom computername <COMPUTEROriginalName> /add:<ALIAS>
```

## More information

For more information, see [Using Computer Name Aliases in place of DNS CNAME Records](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/using-computer-name-aliases-in-place-of-dns-cname-records/ba-p/259064).
