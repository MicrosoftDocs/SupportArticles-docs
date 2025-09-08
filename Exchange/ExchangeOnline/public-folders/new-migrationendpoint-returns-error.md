---
title: Error when creating public folder migration endpoint
description: Provides a resolution for an issue that occurs when you try to create a PublicFolder or PublicFolderToGroups type of migration endpoint in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: batre, ninob
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 08/13/2024
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

To resolve the errors, make sure that the databases that host the two mailboxes are on the same server. Follow these steps:

1. Run the following commands to locate the database that hosts the primary hierarchy public folder mailbox:

    ```powershell
    Set-ADServerSettings -ViewEntireForest:$true
    Get-MailboxDatabase (Get-Mailbox -PublicFolder | ?{$_.IsRootPublicFolderMailbox -eq $true}).database | Get-MailboxDatabaseCopyStatus
    ```

2. Run the following commands to locate the database that hosts the arbitration mailbox named "SystemMailbox{bb558c35-97f1-4cb9-8ff7-d53741dc928c}":

    ```powershell
    Set-ADServerSettings -ViewEntireForest:$true
    Get-MailboxDatabase (Get-Mailbox -Arbitration "SystemMailbox{bb558c35-97f1-4cb9-8ff7-d53741dc928c}").database | Get-MailboxDatabaseCopyStatus
    ```
    
    > [NOTE!]
    > If the arbitration mailbox doesn't exist or is corrupted, [re-create the arbitration mailbox](/exchange/architecture/mailbox-servers/recreate-arbitration-mailboxes) and ensure that it is located in the same mailbox database that hosts the primary hierarchy public folder mailbox. 

3. Run the following commands to move the arbitration mailbox to the database that hosts the primary hierarchy public folder mailbox:

     ```powershell
    Set-ADServerSettings -ViewEntireForest:$true
    Get-Mailbox -Arbitration "SystemMailbox{bb558c35-97f1-4cb9-8ff7-d53741dc928c}" | New-MoveRequest -TargetDatabase <Database that hosts Primary hierarchy public folder mailbox)
    ```

4. Run the following command to check whether MRS Proxy is enabled on the server which hosts the arbitration and primary hierarchy public folder mailboxes.

    ```powershell
    Get-WebServicesVirtualDirectory -Server <servername> |fl *mrsproxy*
    ```

5. If the value of the MRSProxyEnabled parameter that's returned in is not **True**, run the following command to enable MRS Proxy:

    ```powershell
    Get-WebServicesVirtualDirectory -Server batexch5 |Set-WebServicesVirtualDirectory -MRSProxyEnabled:$true
    ```

6. Re-create the migration endpoint. 
