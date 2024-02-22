---
title: Search-MailboxAuditLog returns an error message that says the AQS parser has been removed
description: Provides a resolution for an issue in which the Search-MailboxAuditLog cmdlet in Exchange Server 2019 returns an Advanced Query Syntax parser error message.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom:
  - CI 175995
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jcoiffin, lusassl, meerak, v-trisshores
appliesto:
  - Exchange Server 2019
search.appverid: MET150
ms.date: 01/24/2024
---

# Search-MailboxAuditLog returns "AQS parser has been removed"

## Symptoms

You run the [Search-MailboxAuditLog](/powershell/module/exchange/search-mailboxauditlog) PowerShell cmdlet in Microsoft Exchange Server 2019 on a server that has Microsoft Windows Server 2022 Core or Windows Server 2019 Core installed. However, the command fails and returns the following error message:

> AQS parser has been removed from Windows 2016 Server Core.

For example, you receive the error message about the [Advanced Query Syntax](/windows/win32/lwef/-search-2x-wds-aqsreference) (AQS) parser when you run the following command:

```PowerShell
Search-MailboxAuditLog <mailbox ID> -ShowDetails
```

## Cause

The default locale of the system account on the server isn't English (United States). As a best practice, the default locale of the system account on the server should be set to English (United States) to avoid localization issues.

To check the default locale of the system account, run the following PowerShell cmdlet:

```PowerShell
Get-ItemProperty -Path "Registry::HKEY_USERS\S-1-5-18\Control Panel\International" | FL LocaleName
```

## Resolution

To fix the issue, follow these steps on the server:

1. Run the following [PsExec](/sysinternals/downloads/psexec) command at an elevated command prompt to start a PowerShell session that connects to the system account:

   ```powershell
   PsExec -sid PowerShell
   ```

2. Run the following command in the PowerShell session to set the default locale of the system account to English (United States):

   ```powershell
   Set-Culture -CultureInfo en-US
   ```

3. Restart the server.
