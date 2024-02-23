---
title: Error when running Windows PowerShell cmdlet in Exchange Server 2013
description: Describes an issue in which an administrator can't use the Set-Mailbox cmdlet to convert a user mailbox on another server to a Shared type. Provides workarounds.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jmartin, excontent, helenl, genli, christys, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Remote PowerShell cmdlet fails in an Exchange Server 2013 environment

_Original KB number:_ &nbsp;3067263

## Symptoms

When an administrator signs in a server in a Microsoft Exchange Server 2013 environment and then tries to run a Windows PowerShell cmdlet that requires a proxy to a different back-end mailbox server (For example, the administrator tries to run `set-userphoto`), the operation fails, and the administrator receives an error that resembles the following:

```console
Error on proxy command 'Set-Mailbox -Type:'Shared' -Identity: <ID>
-Confirm:$False -Force:$True' to server Exchange_Server: Server version <version number>, Proxy method RPS:
The WinRM client cannot process the request. The connection string should be of the form
[transport://]host[:port][/suffix] where transport is one of "http" or "https". Transport, port and suffix are optional. The host may be a hostname or an IP address. For IPv6 addresses, enclose the address in brackets - e.g. "http://[1::2]:80/wsman". Change the connection string and try the request again.
```

## Cause

This issue occurs because the access token of the current Exchange administrator is so large that it exceeds the connection string length limitation in the Windows Remote Management (WinRM) component. The connection string length limitation is hard-coded to 2,048 bytes.

## Workaround

To work around this issue, use one or more of the following methods.

### Method 1: Install Exchange Server 2013 Cumulative Update 2 or a later cumulative update

In Exchange Server 2013 Cumulative Update 2, a feature was added to compress the access token. However, if the token remains larger than the limitation in WinRM, even after it's compressed, the error continues to occur. In this case, use either method 2 or method 3 to work around the issue.

### Method 2: Reduce the number of groups of which the Exchange administrator is a member

### Method 3: Create a new Exchange administrator account

Create a new account for Exchange administrative use, and make sure that this account is a member of only the minimum number of required groups.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
