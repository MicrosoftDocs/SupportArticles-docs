---
title: NDR error 554 4.3.2 mailbox busy
description: Fixes an issue in which you can't send mail to a mailbox in Exchange Online if the mailbox has reached the limit of items in a folder.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
ms.reviewer: saurkosh, jamesmi, romccart, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# "554 4.3.2 mailbox busy" when sending emails to a mailbox in Exchange Online

_Original KB number:_ &nbsp; 4024024

## Symptoms

When you send email messages to a mailbox in Microsoft Exchange Online, the messages aren't delivered, and you receive the following error message:

> Remote Server returned '554 4.3.2 mailbox busy; STOREDRV.Deliver.Exception:StoragePermanentException.MapiExceptionMaxObjsExceeded; Failed to process message due to a permanent exception with message Cannot complete delivery-time processing.

## Cause

This problem may occur if the mailbox has reached the limit of items in a folder. In Exchange Online, the limit is one million.

## Resolution

To resolve this problem, move emails from the folder that contains one million items to another folder or to an archive.

## More information

To find the number of items within each folder in a mailbox, run the following PowerShell command:

```powershell
Get-MailboxFolderStatistics -Identity <UPN> | FT Name, FolderPath, ItemsInFolder -AutoSize
```

For more information about the limits, see [Exchange Online limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
