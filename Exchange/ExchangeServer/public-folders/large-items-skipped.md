---
title: Large items are skipped during public folder migration
description: Fixes an issue in which large items are skipped during a public folder migration and you receive the Failed to recopy large item error in the migration report.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CI 141831
  - CSSTroubleshoot
ms.reviewer: mireb
appliesto: 
  - Exchange Server 2010
  - Exchange Server 2013
  - Exchange Server 2016
  - Exchange Server 2019
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Large items are skipped during public folder migration

## Symptoms

When you run a public folder migration from Microsoft Exchange Server on-premises to Exchange Online, you notice that one or more items are skipped during the migration because they have been marked as large items. The [migration report](/exchange/mailbox-migration/migration-users-status-report#migration-users-report-in-classic-exchange-admin-center-classic-eac) displays a "Failed to recopy large item" informational message that resembles the following:

> [\<ServerName>] **Failed to recopy large item**: Item ([len=70, data=000000001A447390AA6611 CD9BC800AA002FC45A0900C1F54ED028C6E54FBFB688ACA28186DB00012A8622020000C1F54ED028C6E54FBFB688ACA28186DB00012A8638D70000]) MessageClass:"IPM.Post", Size: (**16.63 MB** (17,436,461 bytes)), Folder: ([len=46, data=000000001A447390AA6611CD9BC800AA002FC45A0300C1F54ED028C6E54FBFB688ACA28186DB00012A8622020000])

In this example, the size of the item that was marked as large and skipped during migration is 16.63 MB.

## Cause

This issue occurs because either or both the following conditions are true:

- The value of the `MaxItemSize` parameter for individual public folders in Exchange Server on-premises is less than the size of the item that's skipped.
- The value of the `MaxReceiveSize` parameter in Exchange Online public folder mailboxes is less than the size of the item that's skipped.  

## Resolution

If multiple items were skipped, find their sizes in MB by running commands such as the following in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

```powershell
$pf = Get-PublicFolderMailboxMigrationRequest | Get-PublicFolderMailboxMigrationRequestStatistics -IncludeReport  
$pf.Report.LargeItems | Select-Object *,@{ Name="MessageSizeInMB"; Expression={ [Math]::Round(($_.MessageSize / 1MB), 2) } } |FT DateReceived, Subject, MessageSizeInMB  
```

Then, check the current limits that are set in Exchange Online and in Exchange Server on-premises. Increase the limits as appropriate to accommodate the size of the largest item that was skipped.

### Check the current item limit on the public folder mailboxes in Exchange Online

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the following cmdlet to determine the current limit:

   ```powershell
   Get-Mailbox -PublicFolder | FT Identity, MaxReceiveSize
   ```

3. Compare the size of the large items that were skipped to the current limit.  

   By default, the maximum size of the items (the value of the `MaxReceiveSize` or `MaxSendSize` parameters) that can be sent or received in Exchange Online public folder mailboxes is 35 MB. This limit can be increased to a maximum of 150 MB by running the following cmdlet:

   ```powershell
   Set-Mailbox -PublicFolder <Mailbox1> -MaxReceiveSize 150MB
   ```

   **Notes:**

   - If the size of the largest item that was skipped is more than the current limit but less than 150 MB, increase the current limit to a greater value to accommodate the size of the item.
   - If the size of the large items that were skipped is more than 150 MB, the items were skipped by design. In this case, you can safely ignore the issue. If this skipping isn't acceptable, you can stop the migration.

### Check the current item limit for individual public folders in Exchange Server on-premises

1. In [Exchange Management Shell](/powershell/exchange/exchange-management-shell), run the following cmdlet to determine the value of the `MaxItemSize` parameter that's set on the affected public folder:

   ```powershell
   Get-PublicFolder <\PF1> |FT Identity, MaxItemSize
   ```

   **Note:** In this cmdlet, replace \<\PF1> with either the path or the identity of the affected public folder.

   To determine the identity of a public folder that has a value set for the `MaxItemSize` parameter, run the following cmdlet in Exchange Management Shell:  

   ```powershell
   Get-PublicFolder \ -Recurse | where {$_.MaxItemSize -ne $null}| FT Identity, MaxItemSize
   ```

2. If the size of the largest item that was skipped is more than the value of the `MaxItemSize` parameter that's set on the public folder, run the following cmdlet in Exchange Management Shell to increase the value of the parameter:

   ```powershell
   Set-PublicFolder <\PF1> – MaxItemSize Unlimited
   ```

   **Note:** In this cmdlet, replace <\PF1> with either the path or the identity of the affected public folder.

### Resume incremental synchronization

Wait for the next auto-incremental sync on the public folder mailbox migration request in Exchange Online for the migration to resume. During the sync, the large items will be copied.

Alternatively, you can run the following cmdlets in Exchange Online PowerShell to force the incremental sync by resuming the public folder migration request:

```powershell
Get-PublicFolderMailboxMigrationRequest | where {$_.TargetMailbox -eq "<Mailbox1>"} | Resume-PublicFolderMailboxMigrationRequest
```

**Note:** In this cmdlet, replace \<Mailbox1> with the identity of the public folder mailbox being migrated.

Then, restart the public folder migration batch:

```powershell
Stop-MigrationBatch PublicFolderMigration
Start-MigrationBatch PublicFolderMigration
```

## More information

If items are marked as large and skipped during public folder migration, the "MapiExceptionPermanentImportFailure" with "MapiExceptionMaxSubmissionExceeded" failure type will be registered. This failure type might not display in the **Migration** pane in the [Exchange admin center](/exchange/exchange-admin-center) during the migration or be listed in the migration report. However, you can use the following steps to find it:

1. Run the following cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) to retrieve all failures that are listed in the statistics of the public folder mailbox migration request:  

   ```powershell
   $pf_stats = Get-PublicFolderMailboxMigrationRequest | where {$_.TargetMailbox -eq "<Mailbox1>"} | Get-PublicFolderMailboxMigrationRequestStatistics -IncludeReport 
   $pf_stats.Report.Failures | group failuretype | ft -a   
   ```

   **Note:** In this cmdlet, replace \<Mailbox1> with the identity of the affected public folder mailbox.

2. Run the following cmdlet to locate the MapiExceptionPermanentImportFailure failure type and check the error message that's associated with it:

   ```powershell
   $pf_stats.Report.Failures | where {$_.FailureType -eq "MapiExceptionPermanentImportFailure"} | select -last 1
   ```

   The last failure in the output list is usually MapiExceptionPermanentImportFailure.  

   The error message that's associated with it should resemble the following:  

   > Message           : **MapiExceptionPermanentImportFailure**: Data import failed (hr=0x80004005, ec=0)  
                         --> Cannot save changes made to an item to store. --> **MapiExceptionMaxSubmissionExceeded**: Unable to save changes. (hr=0x80004005, ec=1242)

3. In the Locator ID (Lid) stack of the failure, check the values of one of the following Lids:

   57370, 32794, 53274, 40986, 45098, 61482, 59176, 34600, 42114, 58498

   These Lids might have the keyword "Limitation" appended to them, as shown in the following example for Lid 59176:

   > Lid: 59176   dwParam: **0x800000**   Msg: Limitation

   This example is the value that's specified in the MapiExceptionPermanentImportFailure failure type for the item that is 16.63 MB in size and was skipped during migration.  

   The current value set for the `MaxItemSize` parameter on the individual public folder in Exchange Server on-premises is 0x800000 (this equals 8 MB). However, this value is smaller than 16.63 MB. Because of this setting for the individual on-premises public folders, the Exchange Online Mailbox Replication Service (MRS) enforces the same migration item size limit, and it skips the item that is 16.63 MB in size.

   **Note:** To determine the equivalent of the displayed size (such as 0x800000) in MB, divide it by 1 MB, as shown in the following screenshot:

   :::image type="content" source="media/public-folder-migration-failed-recopy-large-item/windows-powershell.png" alt-text="Screenshot of the limitation value divide by 1 MB.":::
