---
title: Microsoft 365 Import job fails with MailboxAmbiguous error in the Import job log file
description: Describes an issue in which you can't use the Microsoft 365 Import Service to import PST files through the network or drive shipping.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Import service
  - CSSTroubleshoot
  - 'Associated content asset: 4555323'
ms.reviewer: subansal
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 05/05/2025
---
# Microsoft 365 Import job fails with MailboxAmbiguous error in the Import job log file

_Original KB number:_&nbsp;4025464

## Symptoms

When you use the Microsoft 365 Import Service in the Security & Compliance Center to import PST files through the network or drive shipping, you may receive an error message that resembles the following:

> Test.pst,Test@contoso.com,Failed,MailboxAmbiguous,0,0,,0,Microsoft.Exchange.Configuration.Tasks.ManagementObjectAmbiguousException, The operation couldn't be performed because Test@contoso.com matches multiple entries, such as 'Test'

## Cause

This issue occurs when you have objects that have the same user principal name (UPN) or Simple Mail Transfer Protocol (SMTP) address in Exchange Online.

## Workaround

To work around this issue, run the following commands to see whether the objects are recipients or soft-deleted users:

```powershell
Get-Recipient <SMTP_ADDRESS>
Get-Mailbox <SMTP_ADDRESS> -SoftDeletedMailbox
Get-MailUser <SMTP_ADDRESS> -SoftDeletedMailUser
```

After you find the user, you can use the Exchange GUID as the target mailbox in mapping the CSV file.

## More Information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
