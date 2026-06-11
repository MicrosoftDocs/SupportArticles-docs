---
title: No active public folder mailboxes were found error if Complete-MigrationBatch cmdlet fails
description: Resolves an issue in which the Complete-MigrationBatch cmdlet fails a migration batch and returns a "No active public folder mailboxes were found" error message.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.custom: 
  - sap:Public Folder Configuration
  - Exchange Server
  - CSSTroubleshoot
  - CI 9832
  - CI 11984
ms.topic: troubleshooting
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Online
ms.reviewer: v-six, v-kccross
ms.date: 06/03/2026
---

# "No active public folder mailboxes were found" error if Complete-MigrationBatch cmdlet fails a migration batch

## Summary

When you migrate public folders from Microsoft Exchange Server to Exchange Online in a multi-domain environment, the `Complete-MigrationBatch` cmdlet can fail and return a "No active public folder mailboxes were found" error message. This issue occurs if the public folder mailbox and its associated Active Directory user account exist in different domains. In this situation, Exchange can’t locate an active public folder mailbox. To resolve the issue, move the associated Active Directory account to the same domain that hosts Exchange Server, and then run the `Complete-MigrationBatch` cmdlet again.

## Symptoms

Consider the following scenario:

- You migrate public folders from Exchange Server to Exchange Online.
- The on-premises environment has multiple Active Directory domains.
- You run the `Complete-MigrationBatch` command.

In this scenario, the migration batch goes into a failed state and generates the following error message:

```output
"No active public folder mailboxes were found. This happens when no public folder mailboxes are provisioned or they are provisioned in 'HoldForMigration' mode."
```

:::image type="content" source="media/migrationbatch-fails-no-public-folder-mailboxes/Get-MigrationBatch-command.png" alt-text="Screenshot of the Get-MigrationBatch command.":::

:::image type="content" source="media/migrationbatch-fails-no-public-folder-mailboxes/Complete-MigrationBatch-error-message.png" alt-text="Screenshot of the Complete-MigrationBatch error message.":::

## Cause

This problem occurs because the public folder mailbox and associated user account aren't in the same Active Directory domain. For example, the user account that's associated with the public folder mailbox is in contoso.com, and Exchange Server hosts the mailbox in subdomain.contoso.com.

## Resolution

To fix this problem, move the Active Directory account that's associated with the public folder mailbox to the same domain that hosts Exchange Server. For example, if Exchange Server is in the root domain (contoso.com) and the associated account is in a subdomain (subdomain.contoso.com), move the account to the root domain. Then, run the `Complete-MigrationBatch` cmdlet again.

Depending on the version of the operating system, you can use either [Active Directory Migration Tool](https://support.microsoft.com/help/4089459) or the [Move-ADObject](/powershell/module/activedirectory/move-adobject) cmdlet in [Active Directory PowerShell](/powershell/module/activedirectory/) to move the user between domains.

For example, run the following PowerShell cmdlet to move the user that's associated with PFMBX4 from subdomain.contoso.com to contoso.com:

```powershell
Move-ADObject -Identity "CN=PFMBX4,CN=Users,DC=subdomain,DC=contoso,DC=com" -TargetPath "CN=Users,DC=contoso,DC=com" -TargetServer dc1.contoso.com
```
