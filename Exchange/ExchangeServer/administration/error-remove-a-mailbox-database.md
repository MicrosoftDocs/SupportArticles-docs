---
title: Error when you try to remove a mailbox database
description: Provides a resolution for a mailbox-database-contains-one-or-more-mailboxes error that you receive when you try to remove a mailbox database.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
  - CI 186972
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 02/14/2024
ms.reviewer: batre, meerak, v-trisshores
---

# Error when you try to remove a mailbox database

## Symptoms

When you try to remove a Microsoft Exchange Server database by running the [Remove-MailboxDatabase](/powershell/module/exchange/remove-mailboxdatabase) PowerShell cmdlet, you receive an error message that resembles the following message:

> This mailbox database contains one or more mailboxes, mailbox plans, archive mailboxes, public folder mailboxes, arbitration mailboxes, or audit mailboxes. To get a list of all mailboxes in this database, run the command Get-Mailbox -Database \<database ID\>... To disable a non-arbitration mailbox so that you can delete the mailbox database, run the command Disable-Mailbox \<mailbox ID\>... Audit mailboxes should be moved to another server; to do this, run the command New-MoveRequest \<parameters\>. If this is the last server in the organization, run the command Get-Mailbox -AuditLog | Disable-Mailbox...

## Cause

Exchange Server prevents users from removing a database that contains an enabled mailbox that's one of the following mailbox types:

- User mailbox
- Archive mailbox
- Public folder mailbox
- Arbitration mailbox
- Audit log mailbox

## Resolution

> [!NOTE]
>
> - Run the following PowerShell cmdlets in the Exchange Management Shell (EMS).
> - You can't move a mailbox to another database in Exchange Server if the database that currently hosts the mailbox is the last one in your organization. You can only disable or remove the mailbox.

To fix the issue, follow these steps:

1. Set the [scope of the EMS session](/powershell/module/exchange/set-adserversettings#-viewentireforest) to the entire forest in Active Directory Domain Services by running the following PowerShell cmdlet:

   ```PowerShell
   Set-ADServerSettings -ViewEntireForest $true
   ```

2. Move, disable, or remove any enabled user mailboxes in the database:

   1. Get a list of enabled user mailboxes by running the following PowerShell commands:

      ```PowerShell
      userMailboxes = Get-Mailbox -Database <database name> | where {$_.IsMailboxEnabled}
      userMailboxes
      ```

      If the list is empty, go to step 3.

   2. Select any of the following options:

      - To move the user mailboxes to another database, run the following PowerShell cmdlet:

        ```PowerShell
        userMailboxes | New-MoveRequest -TargetDatabase <target database name>
        ```

      - To disable the user mailboxes, run the following PowerShell cmdlet:

        ```PowerShell
        userMailboxes | Disable-Mailbox
        ```

      - To remove the user mailboxes, run the following PowerShell cmdlet:

        ```PowerShell
        userMailboxes | Remove-Mailbox
        ```

3. Move or disable any enabled archive mailboxes in the database:

   1. Get a list of enabled archive mailboxes by running the following PowerShell commands:

      ```PowerShell
      archiveMailboxes = Get-Mailbox -Archive -Database <database name> | where {$_.IsMailboxEnabled}
      archiveMailboxes += Get-Mailbox | where {$_.ArchiveDatabase -eq "<database name>"} | where {$_.IsMailboxEnabled}
      archiveMailboxes
      ```

      If the list is empty, go to step 4.

   2. Select either of the following options:

      - To move the archive mailboxes to another database, run the following PowerShell cmdlet:

        ```PowerShell
        archiveMailboxes | New-MoveRequest -TargetDatabase <target database name>
        ```

      - To disable the archive mailboxes, run the following PowerShell cmdlet:

        ```PowerShell
        archiveMailboxes | Disable-Mailbox -Archive
        ```

4. Move, disable, or remove any enabled public folder mailboxes in the database:

   1. Get a list of enabled public folder mailboxes by running the following PowerShell commands:

      ```PowerShell
      pfMailboxes = Get-Mailbox -PublicFolder -Database <database name> | where {$_.IsMailboxEnabled}
      pfMailboxes
      ```

      If the list is empty, go to step 5.

   2. Select any of the following options:

      - To move the public folder mailboxes to another database, run the following PowerShell cmdlet:

        ```PowerShell
        pfMailboxes | New-MoveRequest -TargetDatabase <target database name>
        ```

      - To disable the public folder mailboxes, run the following PowerShell cmdlet:

        ```PowerShell
        pfMailboxes | Disable-Mailbox -PublicFolder
        ```

      - To remove the public folder mailboxes, run the following PowerShell cmdlet:

        ```PowerShell
        pfMailboxes | Remove-Mailbox -PublicFolder
        ```

5. Move, disable, or remove any enabled arbitration mailboxes in the database:

   1. Get a list of enabled arbitration mailboxes by running the following PowerShell commands:

      ```PowerShell
      arbitrationMailboxes = Get-Mailbox -Arbitration -Database <database name> | where {$_.IsMailboxEnabled}
      arbitrationMailboxes
      ```

      If the list is empty, go to step 6.

   2. Select any of the following options:

      - To move the arbitration mailboxes to another database, run the following PowerShell cmdlet:

        ```PowerShell
        arbitrationMailboxes | New-MoveRequest -TargetDatabase <target database name>
        ```

      - To disable the arbitration mailboxes, run the following PowerShell cmdlet:

        ```PowerShell
        arbitrationMailboxes | Disable-Mailbox -Arbitration
        ```

        **Note**: If you disable an arbitration mailbox, you might have to provide other parameters. For example:

        ```PowerShell
        arbitrationMailboxes | Disable-Mailbox -Arbitration -DisableArbitrationMailboxWithOABsAllowed -DisableLastArbitrationMailboxAllowed
        ```

      - To remove the arbitration mailboxes, run the following PowerShell cmdlet:

        ```PowerShell
        arbitrationMailboxes | Remove-Mailbox -Arbitration
        ```

        **Note**: If you remove an arbitration mailbox, you might have to provide other parameters. For example:

        ```PowerShell
        arbitrationMailboxes | Remove-Mailbox -Arbitration -RemoveArbitrationMailboxWithOABsAllowed -RemoveLastArbitrationMailboxAllowed
        ```

6. Move, disable, or remove any enabled audit log mailboxes in the database:

   1. Get a list of enabled audit log mailboxes by running the following PowerShell commands:

      ```PowerShell
      auditMailboxes = Get-Mailbox -AuditLog -Database <database name> | where {$_.IsMailboxEnabled}
      auditMailboxes
      ```

      If the list is empty, go to step 7.

   2. Select any of the following options:

      - To move the audit log mailboxes to another database, run the following PowerShell cmdlet:

        ```PowerShell
        auditMailboxes | New-MoveRequest -TargetDatabase <target database name>
        ```

      - To disable the audit log mailboxes, run the following PowerShell cmdlet:

        ```PowerShell
        auditMailboxes | Disable-Mailbox
        ```

      - To remove the audit log mailboxes, run the following PowerShell cmdlet:

        ```PowerShell
        auditMailboxes | Remove-Mailbox -AuditLog
        ```

7. Wait for any pending mailbox move to finish, and then retry the command to remove the database.
