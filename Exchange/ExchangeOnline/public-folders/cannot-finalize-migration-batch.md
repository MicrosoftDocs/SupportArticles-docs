---
title: Can't finalize a public folder batch migration
description: When you use the Complete-MigrationBatch cmdlet to finalize a public folder batch migration, you receive "The migration batch can't be completed" error message.
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
# Error when finalizing a batch migration of public folders to Exchange Online

## Symptoms

You're using batch migration to migrate Exchange Server public folders to Exchange Online. When you use the [Complete-MigrationBatch](/powershell/module/exchange/complete-migrationbatch) cmdlet to finalize the migration, you receive the following error message:

```output
The migration batch can't be completed due to one or more users having a last sync date older than 7 days.
    + CategoryInfo          : NotSpecified: (:) [Complete-MigrationBatch], MigrationBatchC...nsientException 
    + FullyQualifiedErrorId : [RequestId=<Request ID>, [FailureCategory=Cmdlet-MigrationBatchCannotBeCom 
   pletedTransientException] 123ABCD0,Microsoft.Exchange.Management.Migration.MigrationService.Batch.CompleteMigrationBatch 
    + PSComputerName        : outlook.office365.com 
```

## Cause

To be able to finalize the migration, a check is made to ensure that all public folder migration requests have been successfully synchronized recently. If there is any problem preventing the migration requests from completing the synchronization, it will cause a huge delay during the completion of the batch migration, and may prevent the batch migration from being completed. In this situation, the check will fail and return an error.

## Resolution

To fix this issue, follow these steps:

1. Make sure that the status of the migration batch and all public folder mailbox migration requests is **Synced**. To check the status, run the following PowerShell cmdlets.

   - For the migration batch, run the [Get-MigrationBatch](/powershell/module/exchange/get-migrationbatch) cmdlet.

        The following screenshot is an example of the output:

        :::image type="content" source="media/cannot-finalize-migration-batch/get-migrationbatch-cmdlet.png" alt-text="Screenshot of the output for the Get-MigrationBatch cmdlet.":::
   - For all public folder mailbox migration requests, run the [Get-PublicFolderMailboxMigrationRequest](/powershell/module/exchange/get-publicfoldermailboxmigrationrequest) cmdlet.

        The following screenshot is an example of the output:

        :::image type="content" source="media/cannot-finalize-migration-batch/get-publicfoldermailboxmigrationrequest-cmdlet.png" alt-text="Screenshot of the output for the Get-PublicFolderMailboxMigrationRequest cmdlet.":::

    If the status of any migration request isn't **Synced**, wait until the status changes to **Synced**. If the status of any migration request is **Failed**, investigate the reason for the failure.

1. Check the last synchronization time of the migration batch and all public folder mailbox migration requests.

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

    The value of`LastSyncedDateTime` (for the migration batch) and `LastSuccessfulSyncTimestamp` (for each migration request) should be within the past seven days. If not, review the migration request(s) and make sure that all migration requests have been successfully synchronized recently.

    **Note:** In some cases, the status of the migration batch and all migration requests is **Synced**, but the value of `LastSyncedDateTime` is a very old time, such as "01-01-1601 00:00:00". The reason is that the Mailbox Replication Service hasn't updated the migration batch. In this case, wait up to an hour, and then recheck the value of `LastSyncedDateTime`.

1. Use the `Complete-MigrationBatch` cmdlet to finalize the migration batch.
