---
title: Troubleshoot common import issues in Microsoft 365
description: Identify and resolve some common issues when using the Import service to import PST files into Microsoft 365.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office 365
localization_priority: Normal
ms.custom:
- CI 143255
- CSSTroubleshoot
ms.reviewer: lindabr, andreza
appliesto: 
- Microsoft 365 (Enterprise, Business, Government, Education)
- O365 Modern Support
- Office 365
search.appverid: MET150
---
# Issues with PST import jobs

When you use the Import service in the [Security & Compliance Center](https://protection.office.com) to import PST files to user mailboxes in your organization, the last step in the procedure is to start the import job that you create. When the import job runs, you might experience issues such as the slow speed of the import job or failed import jobs. This article lists some of the common issues related to PST import jobs and provides resolutions that you can try.  

- [Import job is stuck or running slowly](#import-job-is-stuck-or-running-slowly)
- [Import job fails due to errors in PST files](#import-job-fails-due-to-errors-in-PST-files)
- [Import job fails with "MapiExceptionShutoffQuotaExceeded" error](#import-job-fails-with-mapiexceptionshutoffquotaexceeded-error)

## Import job is stuck or running slowly

The typical ingestion rate for the Microsoft 365 Import service is approximately 24 gigabytes (GBs) per day. This rate could be lower because the Import service runs in a multi-tenant shared environment. Large PST files cause this issue.

Here are some scenarios to check:

- Make sure the size of the PST file doesn't exceed 20 GB. A PST file larger than 20 GB may affect the performance of the PST import. So each PST file you upload to the Azure Storage location should be no larger than 20 GB.
- Check your network capacity and confirm that it's within the recommended rate range. Each terabyte (TB) of data takes several hours to be uploaded to the Azure Storage location, depending on the capacity of the network. If the typical import rate of 24 GB per day doesn’t meet your requirements, consider using [another Microsoft 365 import method](/microsoft-365/compliance/use-drive-shipping-to-import-pst-files-to-office-365) or [ways to migrate multiple email accounts to Microsoft 365 or Office 365](/exchange/mailbox-migration/mailbox-migration).
- If you import many PST files in the same mailbox, the ingestion rate of each PST file will be affected by the other PST files that are imported into the target mailbox sequentially rather than simultaneously.

To learn more, see the following articles:

- [Use network upload to import your organization's PST files to Microsoft 365](/microsoft-365/compliance/use-network-upload-to-import-pst-files)
- [Overview of importing your organization's PST files](/microsoft-365/compliance/importing-pst-files-to-office-365#frequently-asked-questions-about-importing-pst-files-to-office-365)

> [!NOTE]
> Using PowerShell to create a new import job isn't supported, use the Import service UI in Microsoft 365 instead.

## Import job fails due to errors in PST files

If an import job fails and you encounter bad items, follow these steps:

1. Run the Inbox Repair tool (Scanpst.exe) to diagnose and fix errors in the PST files. For detailed instructions, see [How to repair your Outlook personal folder file (.pst)](/outlook/troubleshoot/data-files/how-to-repair-personal-folder-file).
2. Re-upload the PST files to the Azure Storage location.
3. Create a new import job to import the PST files again.

**Note:** If some items have already been imported, they will be skipped when you re-upload the files. Therefore, no duplicate items will be imported.

You can view the number of bad items encountered by running the following cmdlet:

```powershell
Get-MailboxImportRequest  -BatchName <BatchName> | Get-MailboxImportRequestStatistics -IncludeReport | FL
```

**Note:** Replace the \<BatchName> placeholder with your actual batch name.

Here's an example of output:

> PS C:\Users\ps  
> \>  
> Status                     : Completed  
> StatusDetail               : Completed  
> AzureBlobStorageAccountUri : `https://<youraccount>.blob.core.windows.net/ingestiondata/user_usnme%20-%20data.pst`  
> TargetAlias                : \<UserName>  
> TargetIsArchive            : True  
> TargetExchangeGuid         : \<TargetExchangeGuid>  
> TargetRootFolder           : Folder_PST  
> BatchName                  : \<user-repaired>  
> BadItemLimit               : Unlimited  
> **BadItemsEncountered**    : **46**  
> LargeItemLimit             : 0  
> LargeItemsEncountered      : 0  
> EstimatedTransferSize      : 657.8 MB (689,744,082 bytes)  
> EstimatedTransferItemCount : 3608  
> BytesTransferred           : 678.9 MB (711,898,413 bytes)  
> ItemsTransferred           : 3608  
> PercentComplete            : 100  
> Report                     :  
> …

## Import job fails with MapiExceptionShutoffQuotaExceeded error

This issue occurs because the data being imported is larger than the space available in the target mailbox.

**Note:** If the target mailbox is an archive mailbox, enabling it for auto-expansion won't help because auto-expansion doesn't support PST import scenarios nor migration scenarios. Currently, you can import up to 100 GB of data from PST files to a user's archive mailbox. For more information, see [Auto-expanding archiving and other compliance features](/microsoft-365/compliance/unlimited-archiving#auto-expanding-archiving-and-other-compliance-features).

If you encounter this error, follow these steps:

1. Check the available space in the target mailbox and the size of the source PST files.
2. Clean up unnecessary items in both the target mailbox and source PST files. For example, delete items that don’t match your company's policies due to age, size, etc.
3. Re-upload the PST files and try to perform the import again.
If you must import more than 100 GB of data or if you need more than 100 GB of available space in the target mailbox, [raise a support ticket](https://support.microsoft.com/contactus) so your scenario can be evaluated.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
