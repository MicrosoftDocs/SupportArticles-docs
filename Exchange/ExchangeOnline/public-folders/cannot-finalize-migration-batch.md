---
title: Can't finalize a public folder batch migration
description: When you use the Complete-MigrationBatch cmdlet to finalize a public folder batch migration, you receive a migration batch can't be completed error message.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 159691
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: meerak, batre, v-chazhang
editor: v-jesits
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when finalizing a batch migration of public folders to Exchange Online

## Symptoms

You're using batch migration to migrate Microsoft Exchange Server public folders to Exchange Online. When you finalize the migration from the Exchange admin center or by using the [Complete-MigrationBatch](/powershell/module/exchange/complete-migrationbatch) cmdlet, you receive the following error message:

```output
The migration batch can't be completed due to one or more users having a last sync date older than 7 days.
    + CategoryInfo          : NotSpecified: (:) [Complete-MigrationBatch], MigrationBatchC...nsientException 
    + FullyQualifiedErrorId : [RequestId=<Request ID>, [FailureCategory=Cmdlet-MigrationBatchCannotBeCom 
   pletedTransientException] 123ABCD0,Microsoft.Exchange.Management.Migration.MigrationService.Batch.CompleteMigrationBatch 
    + PSComputerName        : outlook.office365.com 
```

## Cause

To be able to finalize the migration, a check is made to make sure that all recent public folder migration requests were successfully synchronized. Any problem that prevents the requests from being processed will delay the batch migration and might prevent it from being completed. In this situation, the check will fail and return an error.

## Resolution

To fix this issue, follow these steps:

1. Make sure that the status shows as **Synced** for the migration batch and all public folder mailbox migration requests. To check the status, run the following PowerShell cmdlets:

   - For the migration batch, run [Get-MigrationBatch](/powershell/module/exchange/get-migrationbatch).

        The following screenshot shows an example of the output.

        :::image type="content" source="media/cannot-finalize-migration-batch/get-migrationbatch-cmdlet.png" alt-text="Screenshot of the output for the Get-MigrationBatch cmdlet.":::
   - For all public folder mailbox migration requests, run [Get-PublicFolderMailboxMigrationRequest](/powershell/module/exchange/get-publicfoldermailboxmigrationrequest).

        The following screenshot shows an example of the output.

        :::image type="content" source="media/cannot-finalize-migration-batch/get-publicfoldermailboxmigrationrequest-cmdlet.png" alt-text="Screenshot of the output for the Get-PublicFolderMailboxMigrationRequest cmdlet.":::

    If the status of any migration request is something other than **Synced**, wait until the status changes to **Synced**. If the status of any migration request is **Failed**, investigate the reason for the failure.

1. Check the last synchronization time of the migration batch and all public folder mailbox migration requests.

   - For the migration batch, run the following [Get-MigrationBatch](/powershell/module/exchange/get-migrationbatch) cmdlet:

        ```powershell
        Get-MigrationBatch |?{$_.MigrationType -like "*PublicFolder*"} | ft *last*sync*
        ```

     The following screenshot shows an example of the output.

        :::image type="content" source="media/cannot-finalize-migration-batch/lastsynceddatetime-value.png" alt-text="Screenshot of the LastSyncedDateTime value.":::

   - For all public folder mailbox migration requests, run the following [Get-PublicFolderMailboxMigrationRequest](/powershell/module/exchange/get-publicfoldermailboxmigrationrequest) cmdlet:

        ```powershell
        Get-PublicFolderMailboxMigrationRequest | Get-PublicFolderMailboxMigrationRequestStatistics |ft targetmailbox,*last*sync*
        ```

     The following screenshot shows an example of the output.

        :::image type="content" source="media/cannot-finalize-migration-batch/lastsuccessfulsynctimestamp-value.png" alt-text="Screenshot of the LastSuccessfulSyncTimestamp value":::

    The value of `LastSyncedDateTime` (for the migration batch) and `LastSuccessfulSyncTimestamp` (for each migration request) should be within the past seven days. If it is outside the previous week, review the migration requests to make sure that they all were successfully synchronized recently.

    **Note:** In some cases, the status of the migration batch and all migration requests is **Synced**, but the `LastSyncedDateTime` value shows a very old date. For example, the value is **01-01-1601 00:00:00**. This might occur because the Mailbox Replication Service hasn't updated the migration batch. In this case, wait up to one hour, and then recheck the value of `LastSyncedDateTime`.

1. Run the `Complete-MigrationBatch` cmdlet to finalize the migration batch.
