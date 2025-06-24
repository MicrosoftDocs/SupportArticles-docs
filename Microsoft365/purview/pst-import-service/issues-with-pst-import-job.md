---
title: Troubleshoot common PST import issues
description: Identify and resolve some common issues when using the Import service to import PST files into Microsoft 365.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Import service
  - CI 143255
  - CSSTroubleshoot
ms.reviewer: lindabr, andreza
appliesto: 
  - Microsoft 365
search.appverid: MET150
ms.date: 05/05/2025
---
# Issues that affect PST import jobs

When you use the Import service in the Security & Compliance Center to [import PST files](/microsoft-365/compliance/importing-pst-files-to-office-365) to user mailboxes in your organization, the last step in the procedure is to start the import job that you create. When the import process runs, you might experience issues, such as slow performance or job failure. This article lists some of the common issues that are related to PST import jobs, and provides resolutions that you can try.

## Import job is stuck or running slowly

The ingestion rate of the Microsoft 365 Import service to import a PST file into a mailbox is approximately 24 GB per day. This rate is typical. However, it can't be guaranteed because the Import service runs in an environment that is shared by multiple tenants.

**Note:** You should use the Import Service UI in Microsoft 365 to create new Import jobs. Using PowerShell for this task isn't supported.

If your import job is processing slowly or appears to be stuck, the PST file might be larger than the maximum recommended size of 20 GB. For the current job, expect a delay if it exceeds 20 GB.  For future imports, check the size of the PST file. If it exceeds 20 GB, check for and delete items from it that don't match your company guidelines for age, size, and other requirements. Alternatively, split the PST into multiple files.  

If you're importing multiple PSTs into the same mailbox, the ingestion rate of each file will be affected by the other files that are being imported sequentially into the same mailbox. PST files that are imported into different target mailboxes don't affect the ingestion rate.

## Import job shows skipped items because of errors

If there are corrupted items within the PST files, they're skipped during the import job. The number of skipped items is indicated in the **Items skipped (corrupted)** column of the Status message in the Import Service UI.

:::image type="content" source="media/issues-with-pst-import-job/status-message.png" alt-text="Screenshot of Status page with items skipped.":::

Alternatively, you can run the `Get-MailboxImportRequest` cmdlet to see the number of corrupted items:  

```powershell
Get-MailboxImportRequest  -BatchName user-repaired | Get-MailboxImportRequestStatistics -IncludeReport | FL
```

The output of this cmdlet should resemble the following sample. The number of corrupted items is the value of the `BadItemsEncountered` property.  

:::image type="content" source="media/issues-with-pst-import-job/bad-items.png" alt-text="Screenshot shows an example of the cmdlet output.":::

To fix the skipped items, do the following:

1. Run Scanpst.exe to diagnose and fix the errors in the PST files.
2. Upload the PST files again to the Azure storage location.
3. Create a new import job to import the PST files.

**Note:** If you reimport the PST into the same target root folder, items that have already been imported will be skipped, and no duplicates will be created.

## Import job fails with "MapiExceptionShutoffQuotaExceeded" error

The "MapiExceptionShutoffQuotaExceeded" error occurs if the size of the data that's imported is greater than the space that's available in the target mailbox when the import job is run.

If the target mailbox is an archive mailbox, you can import up to 100 GB of data from PST files into it. However, you can't enable the archive mailbox for auto-expansion because the auto-expansion feature doesn't support PST import and migration scenarios. For more information about auto-expanding archives, see [Overview of unlimited archiving in Microsoft 365](/microsoft-365/compliance/unlimited-archiving).  

If you experience the "MapiExceptionShutoffQuotaExceeded" error for the current import job, contact [Microsoft Support](https://support.microsoft.com/contactus) to have the scenario evaluated.

To avoid this error for future import jobs, make sure that you do the following:

1. Check the available space in the target mailbox, and the size of the source PST file.
1. If the total size of the PST files is greater than the available space in the target mailbox, delete unnecessary data. For example, delete such items as those that don't match your company guidelines for age, size, and other requirements.
1. Upload the updated PST files, and create a new import job to import the PST files.

If you have to import more than 100 GB of data or increase the available space in the target mailbox, contact [Microsoft Support](https://support.microsoft.com/contactus) to have your scenario evaluated.
