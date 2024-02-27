---
title: Can't open a mailbox using MAPI over HTTP
description: Describes an issue that blocks Outlook users from opening their mailboxes. This issue occurs when they're trying to use MAPI over HTTP in an Exchange Server 2016 environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook can't open a mailbox by using MAPI over HTTP

_Original KB number:_ &nbsp; 3191500

## Symptoms

Users can't open their mailboxes in Microsoft Outlook by using MAPI over HTTP.

## Cause

This issue occurs if all authentication methods for the MAPI virtual directory are disabled.

Editing the MAPI virtual directory through the Exchange Admin Center causes the `Set-MapiVirtualDirectory` cmdlet to run without having `IISAuthenticationMethods` configured. The syntax of the cmdlet resembles the following:

```powershell
Set-MapiVirtualDirectory -ExternalUrl 'https://mapi.contoso.com/mapi' -IISAuthenticationMethods @() -Identity '1d4e91f5-b1ae-4863-a071-2822210f05b9'
```

## Resolution

To resolve this issue, use the `Set-MapiVirtualDirectory` cmdlet to enable the IIS authentication methods, as follows:

```powershell
Get-MapiVirtualDirectory -Server <ServerName>| Set-MapiVirtualDirectory -IISAuthenticationMethods Ntlm,OAuth,Negotiate
```

## More information

For more information about this cmdlet, see [Set-MapiVirtualDirectory](/powershell/module/exchange/set-mapivirtualdirectory).
