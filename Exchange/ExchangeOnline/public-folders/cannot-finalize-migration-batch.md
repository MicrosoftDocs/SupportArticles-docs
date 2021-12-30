---
title: Can't finalize a public folder migration batch
description: When you use the Complete-MigrationBatch cmdlet to finalize a public folder migration batch, you receive "The migration batch can't be completed" error message.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
localization_priority: Normal
ms.custom:
- CI 159691
- Exchange Online
- CSSTroubleshoot
ms.reviewer: meerak; batre
editor: v-jesits
appliesto: 
- Exchange Online
search.appverid: MET150
---
# Error when finalizing a migration batch of public folders to Exchange Online

## Symptoms

You start a migration batch of public folders to Exchange Online. When you use the [Complete-MigrationBatch](/powershell/module/exchange/complete-migrationbatch) cmdlet to finalize the migration batch, you receive the following error message:

```output
The migration batch can't be completed due to one or more users having a last sync date older than 7 days.
    + CategoryInfo          : NotSpecified: (:) [Complete-MigrationBatch], MigrationBatchC...nsientException 
    + FullyQualifiedErrorId : [RequestId=<Request ID>, [FailureCategory=Cmdlet-MigrationBatchCannotBeCom 
   pletedTransientException] 123ABCD0,Microsoft.Exchange.Management.Migration.MigrationService.Batch.CompleteMigrationBatch 
    + PSComputerName        : outlook.office365.com 
```

## Cause

The finalization fails because stale public folder mailbox migration requests aren't synced successfully and recently. The stale requests cause delay and failure of the completion of the migration batch. If any request isn't synced successfully within seven days, a check that ensures all requests are in the healthy state fails.

## Resolution

To fix this issue, follow these steps:

1. Run the following cmdlets to check the status of the migration batch and all public folder mailbox migration requests.

   - For the migration batch, run the [Get-MigrationBatch](/powershell/module/exchange/get-migrationbatch) cmdlet.

        The following screenshot is an example of the output:

        :::image type="content" source="media/cannot-finalize-migration-batch/get-migrationbatch-cmdlet.png" alt-text="Screenshot of the output for the Get-MigrationBatch cmdlet.":::
   - For all public folder mailbox migration requests, run the [Get-PublicFolderMailboxMigrationRequest](/powershell/module/exchange/get-publicfoldermailboxmigrationrequest) cmdlet.

        The following screenshot is an example of the output:

        :::image type="content" source="media/cannot-finalize-migration-batch/get-publicfoldermailboxmigrationrequest-cmdlet.png" alt-text="Screenshot of the output for the Get-PublicFolderMailboxMigrationRequest cmdlet.":::

    If the status isn't displayed as **Synced**, wait until the status is displayed as **Synced**. If the status is displayed as **Failed**, investigate why the status is failed.

2. Run the following cmdlets to check the last synced date of the migration batch and all public folder mailbox migration requests.

   - For the migration batch, run the following [Get-MigrationBatch](/powershell/module/exchange/get-migrationbatch) cmdlet:

        ```powershell
        Get-MigrationBatch |?{$_.MigrationType -like "*PublicFolder*"} | ft *last*sync*
        ```

     The following screenshot is an example of the output:

        :::image type="content" source="media/cannot-finalize-migration-batch/lastsynceddatetime-value.png" alt-text="Screenshot of the LastSyncedDateTime value.":::

   - For all public folder mailbox migration requests, run the following [Get-PublicFolderMailboxMigrationRequest](/powershell/module/exchange/get-publicfoldermailboxmigrationrequest) cmdlet:

        ```powershell
        Get-PublicFolderMailboxMigrationRequest | Get-PublicFolderMailboxMigrationRequestStatistics |ft targetmailbox,*last*sync*
        ```

     The following screenshot is an example of the output:

        :::image type="content" source="media/cannot-finalize-migration-batch/lastsuccessfulsynctimestamp-value.png" alt-text="Screenshot of the LastSuccessfulSyncTimestamp value":::

    The `LastSyncedDateTime` value and the `LastSuccessfulSyncTimestamp` value should be within seven days. If not, review and ensure all public folder mailbox migration requests are synced successfully and recently.

Sometimes, the status of the migration batch and all public folder mailbox migration requests are displayed as **Synced**. However, the `LastSyncedDateTime` value of the migration batch is displayed as an old date.

See the following screenshot for an example:

:::image type="content" source="media/cannot-finalize-migration-batch/old-date.png" alt-text="Screenshot of the LastSyncedDateTime value that is displayed as an old date.":::

In this scenario, wait up to an hour because the migration batch has not been updated by the Mailbox Replication Service. Then, check the `LastSyncedDateTime` value again. If the synced date is updated, use the `Complete-MigrationBatch` cmdlet to finalize the migration batch.
