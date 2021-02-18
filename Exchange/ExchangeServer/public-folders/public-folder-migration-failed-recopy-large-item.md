---
title: Failed to recopy large item during a public folder migration
description: Fixes an issue in which you receive the "Failed to recopy large item" error during a public folder migration.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Server
- CI 141831
- CSSTroubleshoot
ms.reviewer:
appliesto:
- Exchange Server 2013
- Exchange Server 2016
- Exchange Server 2019
- Exchange Online
search.appverid: MET150
---
# "Failed to recopy large item" error in a public folder migration

## Symptoms

When you perform a public folder migration from Exchange Server on-premises to Exchange Online, you receive a "Failed to recopy large item" error message. For example:

> [AS8PR05MB8070] **Failed to recopy large item**: Item ([len=70, data=000000001A447390AA6611 CD9BC800AA002FC45A0900C1F54ED028C6E54FBFB688ACA28186DB00012A8622020000C1F54ED028C6E54FBFB688ACA28186DB00012A8638D70000]) MessageClass:"IPM.Post", Size: (**16.63 MB** (17,436,461 bytes)), Folder: ([len=46, data=000000001A447390AA6611CD9BC800AA002FC45A0300C1F54ED028C6E54FBFB688ACA28186DB00012A8622020000])

Alternatively, you receive a "MapiExceptionPermanentImportFailure" or "MapiExceptionMaxSubmissionExceeded" failure type (that's discussed in the "[More information](#more-information)" section).

In this case, the large item size to be migrated is 16.63 MB, which is less than the maximum item size set on the Exchange Online public folder mailboxes and less than the Exchange Online organization's limit.

By default, the maximum item size (`MaxReceiveSize` or `MaxSendSize`) that can be sent or received in Exchange Online public folder mailboxes is 35 MB, and it can be increased up to 150 MB.

## Cause

The issue occurs if Exchange Server on-premises public folders at the source side have items with a size larger than the `MaxItemSize` value set on the individual public folder level.

## Resolution

Here's how to increase the public folder limits in Exchange Server on-premises:

1. Identify the `MaxItemSize` value set on the public folder by running the following [Exchange Management Shell](/powershell/exchange/exchange-management-shell) command:

   ```powershell
   Get-PublicFolder <\PF1> |FT Identity, MaxItemSize
   ```

   **Note:** Replace the \<\PF1> placeholder with the path of the failed migration public folder.

   If you want to get the identity of the public folders where the `MaxItemSize` value is set, run the following Exchange Management Shell command:

   ```powershell
   Get-PublicFolder \ -Recurse | where {$_.MaxItemSize -ne $null}| FT Identity, MaxItemSize
   ```

2. Increase the `MaxItemSize` value on the public folder by running the following Exchange Management Shell command:

   ```powershell
   Set-PublicFolder <\PF1> – MaxItemSize Unlimited
   ```

   **Note:** Replace the \<\PF1> placeholder with the path of the failed migration public folder.

3. Wait for the next auto-incremental sync on the public folder mailbox migration request in Exchange Online. When the auto-incremental sync is completed and the large items are copied, the request will restart the public folder migration. Alternatively, run the following commands in [Exchange Online PowerShell](/powershell/exchange/exchange-online-powershell) to force the incremental sync and restart the public folder migration:

    ```powershell
    Get-PublicFolderMailboxMigrationRequest | where {$_.TargetMailbox -eq "<Mailbox1>"} | Resume-PublicFolderMailboxMigrationRequest
    Start-MigrationBatch PublicFolderMigration
    Stop-MigrationBatch PublicFolderMigration
    ```

    **Note:** Replace the \<Mailbox1> placeholder with the identity of the public folder mailbox.

## More information

To find a "MapiExceptionPermanentImportFailure" failure type, you can retrieve the failures on the statistics of the public folder mailbox migration request by running the following Exchange Online PowerShell commands:

```powershell
$pf_stats = Get-PublicFolderMailboxMigrationRequest | where {$_.TargetMailbox -eq "Mailbox1"} | Get-PublicFolderMailboxMigrationRequestStatistics -IncludeReport 
$pf_stats.Report.Failures | group failuretype | ft -a 
```

**Note:** Replace the \<Mailbox1> placeholder with the identity of the failed public folder mailbox.

The last failure in the migration report usually refers to the "MapiExceptionPermanentImportFailure" issue. When you drill down to the failure, run the following Exchange Online PowerShell command to check the associated error message to see your current message size limitation.

```powershell
$pf_stats.Report.Failures[-1].Message
```

For example, the error message shows as follows:

> Message           : MapiExceptionPermanentImportFailure: Data import failed (hr=0x80004005, ec=0)  
                     --> Cannot save changes made to an item to store. --> MapiExceptionMaxSubmissionExceeded: Unable to save changes. (hr=0x80004005, ec=1242)  
> Lid: 59176   dwParam: **0x800000**   Msg: **Limitation**

In this case, the limitation value is 0x800000 (8 MB) and the large item size is 16.63 MB.

**Note:** To get the size limitation in MB, divide the limitation value by 1MB by running the command (as shown in the following screenshot):

:::image type="content" source="media/public-folder-migration-failed-recopy-large-item/windows-powershell.png" alt-text="Screenshot of the limitation value divide by 1 MB.":::

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
