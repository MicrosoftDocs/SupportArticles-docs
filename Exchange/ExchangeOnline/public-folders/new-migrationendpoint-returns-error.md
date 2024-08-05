---
title: Error when creating public folder migration endpoint
description: Provides a resolution for an issue that occurs when you run the New-MigrationEndpoint cmdlet to create a PublicFolder or PublicFolderToGroups type of migration endpoint in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: batre, ninob, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when creating public folder migration endpoint

_Original KB number:_ &nbsp;4052729

## Symptoms

When you run the `New-MigrationEndpoint` cmdlet to create a PublicFolder or PublicFolderToGroups type of migration endpoint in Microsoft Exchange Online, you get one of the following error messages:

> MAPI provider is not supported for mailbox with version <*VersionNumber*> on server <*ServerName*>.

> Write-ErrorMessage : |Microsoft.Exchange.Data.Storage.Management.MigrationTransientException|

## Cause

These errors occur because the following mailboxes aren't on the same mailbox database:

- The primary hierarchy public folder mailbox.
- The arbitration mailbox that's named "SystemMailbox{bb558c35-97f1-4cb9-8ff7-d53741dc928c}"

## Resolution

To resolve this problem, make sure that the databases that host these two mailboxes are on the same server. To do this, follow these steps:

1. Locate the database that hosts the primary hierarchy public folder mailbox by running the one of the following cmdlet options:

    ```powershell
    Set-ADServerSettings -ViewEntireForest:$true
    Get-MailboxDatabase (Get-Mailbox -PublicFolder | ?{$_.IsRootPublicFolderMailbox -eq $true}).database | Get-MailboxDatabaseCopyStatus
    ```

2. Locate the database that hosts the arbitration mailbox named "SystemMailbox{bb558c35-97f1-4cb9-8ff7-d53741dc928c}" by running one the following cmdlet options:

    ```powershell
    Set-ADServerSettings -ViewEntireForest:$true
    Get-MailboxDatabase (Get-Mailbox -Arbitration "SystemMailbox{bb558c35-97f1-4cb9-8ff7-d53741dc928c}").database | Get-MailboxDatabaseCopyStatus
    ```

3. Use following command to move the arbitration mailbox to the database that hosts Primary hierarchy public folder mailbox.

     ```powershell
    Set-ADServerSettings -ViewEntireForest:$true
    Get-Mailbox -Arbitration "SystemMailbox{bb558c35-97f1-4cb9-8ff7-d53741dc928c}" | New-MoveRequest -TargetDatabase <Database that hosts Primary hierarchy public folder mailbox)
    ```
Note:
In case there is problem with the arbitration mailboxes (like the arbitration mailbox do not exists or are corrupted), use [this](https://learn.microsoft.com/exchange/architecture/mailbox-servers/recreate-arbitration-mailboxes) article to re-create the 
arbitration mailboxes and ensure the conditions mentioned in the cause section are satisfied.

4. Use following command to ensure the server hosting the arbitration mailbox and primary hierarchy public folder mailbox has MRS Proxy enabled.

    ```powershell
    Get-WebServicesVirtualDirectory -Server <servername> |fl *mrsproxy*
    ```

If MRSProxyEnabled is not True, use following command to enable the MRS Proxy:

    ```powershell
    Get-WebServicesVirtualDirectory -Server batexch5 |Set-WebServicesVirtualDirectory -MRSProxyEnabled:$true
    ```

5. Try creating the migration endpoint
