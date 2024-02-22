---
title: Restored deleted public folders from dumpster cause a migration batch failure
description: Fixes an issue in which you receive the ErrorFoldersRestoredDuringMigrationPermanentException failure when you run a public folder migration batch job.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 126163
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: haembab
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# "ErrorFoldersRestoredDuringMigrationPermanentException" error in a public folder migration batch

## Symptoms

When you run a public folder migration batch job, you receive the following error message:

> ErrorFoldersRestoredDuringMigrationPermanentException

:::image type="content" source="media/public-folder-migration-batch-error/failure.png" alt-text="Screenshot of the error message when you run a public folder migration batch job." lightbox="media/public-folder-migration-batch-error/failure.png":::

## Cause

This problem occurs because the public folder restore operation isn't supported during migrations that begin with the [ExcludeDumpster](https://techcommunity.microsoft.com/t5/exchange-team-blog/announcing-the-support-for-modern-public-folder-migrations/ba-p/608004) parameter. The problem occurs if the following conditions are met:

- The public folder migration batch was created by using the `ExcludeDumpster` parameter.
- You recovered deleted public folders from the dumpster in the source while you ran the migration batch job.

## Resolution

To resolve this problem, use one of the following methods, as appropriate for your situation.

### Method 1: Remove the recovered public folders

1. Identify the entry IDs of the recovered folders. Here's how to check the report and identify the entry IDs.

   **Method 1: Use Exchange admin center**

   1. In Exchange admin center, select **Recipients** > **Migration**.
   1. Select the migration batch, and then select **View details** under **Mailbox status**.
   1. Select the failed migration mailbox, and then select **Download the report for this user**.

      Note the identity of the failed migration mailbox. In the following example, the identity is *Mailbox1*.

      :::image type="content" source="media/public-folder-migration-batch-error/download-report.png" alt-text="Screenshot of the downloading the report for failed mailbox." lightbox="media/public-folder-migration-batch-error/download-report.png":::

   1. In the report, search for the keyword "recovered" to find the entry IDs of the recovered folders. The entry ID is the first data value of the recovered folder entry, as shown in the following example.

      :::image type="content" source="media/public-folder-migration-batch-error/entry-id.png" alt-text="Screenshot of the entry ID of recovered folder." lightbox="media/public-folder-migration-batch-error/entry-id.png":::

   **Method 2: Use PowerShell**

   1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell#connect-to-exchange-online-powershell-using-mfa-and-modern-authentication).
   1. Retrieve the failed public folder mailbox migration request by running the following cmdlet:

      ```powershell
      $failed_req = Get-PublicFolderMailboxMigrationRequest -Status Failed 
      $failed_req
      ```

      Note the identity of the failed migration mailbox.

   1. Export the statistics of the failed public folder mailbox migration request to an xml file by running the following cmdlet:

      ```powershell
      $failed_req | foreach { Get-PublicFolderMailboxMigrationRequestStatistics $_.Identity -IncludeReport -DiagnosticInfo verbose | Export-Clixml "PF_failed_$($_.TargetMailbox)_$($_.RequestGuid).xml" }
      ```

      :::image type="content" source="media/public-folder-migration-batch-error/export-statistics.png" alt-text="Screenshot of the cmdlet to export statistics." lightbox="media/public-folder-migration-batch-error/export-statistics.png":::

      The .xml file is created on your computer, as shown in the following example.

      :::image type="content" source="media/public-folder-migration-batch-error/xml-path.png" alt-text="Screenshot of downloaded .xml file path." lightbox="media/public-folder-migration-batch-error/xml-path.png":::

   1. Import the xml file by running the following cmdlet:

      ```powershell
      $failedreport=Import-Clixml "<Path of the xml file>"
      ```

      **Note:** `$failedreport` is a variable that you can customize. \<Path of the xml file> represents the actual path.

   1. Retrieve the entry IDs of the recovered folders from `$failedreport` by running the following cmdlet:

      ```powershell
      $failedreport.Report.Entries|where {[string]$_ -like "*recovered*"}|%{[string]$_}
      ```

      The entry ID is the first data value of the recovered folder entry, as shown in the following example.

      :::image type="content" source="media/public-folder-migration-batch-error/check-entry.png" alt-text="Screenshot of the entry ID that is the first data value of the recovered folder entry." lightbox="media/public-folder-migration-batch-error/check-entry.png":::

2. Remove the recovered public folder by running the following cmdlet:

   ```powershell
   Remove-PublicFolder -Identity "<EntryID>"
   ```

   Replace the \<EntryID> placeholder with the entry ID that you found in step 1. For more information about this cmdlet, see the "Examples" section of [Remove-PublicFolder](/powershell/module/exchange/remove-publicfolder#examples).

3. Start the migration of the failed mailbox by running the following cmdlet:

   ```powershell
   Start-MigrationUser "<FailedMailbox>"
   ```

   Replace the \<FailedMailbox> placeholder with the identity of the failed migration mailbox that you noted in step 1. For more information about this cmdlet, see [Start-MigrationUser](/powershell/module/exchange/start-migrationuser).

### Method 2: Don't specify the ExcludeDumpster parameter

If you don't want to remove the recovered public folders, restart the migration without specifying the `ExcludeDumpster` parameter.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
