---
title: '"Number of public folder mailboxes cannot exceed more than 100" error when creating a migration batch'
description: Provides a solution for an issue in which you try to create a public folder migration batch but receive an error message that says the number of public folder mailboxes can't exceed 100.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 186185
ms.reviewer: gmuntean, batre, meerak, v-trisshores
appliesto: 
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: 
  - MET150
ms.date: 01/30/2024
---

# "Number of public folder mailboxes cannot exceed more than 100" error when creating a migration batch

## Symptoms

When you try to create a public folder migration batch in Exchange Online by using the [New-MigrationBatch](/powershell/module/exchange/new-migrationbatch) PowerShell cmdlet and a [CSV mapping file](/exchange/collaboration/public-folders/migrate-to-exchange-online#step-3-generate-the-csv-files), you receive the following error message:

> Microsoft.Exchange.Configuration.Tasks.ThrowTerminatingErrorException|Number of public folder mailboxes cannot exceed more than 100 for modern public folder migration.

## Cause

### Cause 1

Exchange Online sets a limit of 100 for the total number of unique public folder mailboxes that can be specified in the mapping file. The `TargetMailbox` column of your CSV mapping file lists more than 100 unique public folder mailboxes.

### Cause 2

The `TargetMailbox` column of your CSV mapping file lists 100 unique public folder mailboxes, but a current limitation of the CSV mapping file is that the public folder mailbox that's specified in the final entry can't be used in a previous entry.

> [!NOTE]
> The issue doesn't apply to a CSV mapping file that lists fewer than 100 unique public folder mailboxes.

## Solution

Use the appropriate solution, depending on the cause.

### Resolution for Cause 1

Make sure that your CSV mapping file contains no more than 100 unique public folder mailbox entries.

### Workaround for Cause 2

Make sure that the public folder mailbox that's specified in the final entry of the CSV mapping file isn't specified in any previous entry.
