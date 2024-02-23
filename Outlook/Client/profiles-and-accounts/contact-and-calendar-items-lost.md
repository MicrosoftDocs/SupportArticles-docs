---
title: Contact and Calendar items are lost after you delete an IMAP account
description: Fixes an issue in which Contact and Calendar items are lost after you delete an IMAP account in Outlook 2013. This issue occurs even if you have backed up the offline Outlook data file.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae, aruiz, naokon
appliesto: 
  - Microsoft Office 2013 Service Pack 1
  - Outlook 2013
search.appverid: MET150
ms.date: 10/30/2023
---
# Contact and Calendar items are lost after you delete an IMAP account in Outlook 2013

_Original KB number:_ &nbsp; 3062835

## Symptoms

After you delete an IMAP account in Microsoft Outlook 2013, and then you restore the IMAP account on that computer or you add the same account on a different computer, you notice that Contact and Calendar items are missing. This occurs even though you first synchronize the offline Outlook data file (`.ost`) with the IMAP account.

## More information

This problem is by design. Because of a change in Microsoft Outlook 2013 Service Pack 1, the `.ost` file is also deleted when an email account such as an IMAP or Exchange account is deleted from an Outlook profile. The `.ost` file that is associated with the IMAP account contains Contact and Calendar items. Therefore, these items are deleted together with the `.ost` file.

## Status

Microsoft is researching this problem and will post more information in this article when the information becomes available.
