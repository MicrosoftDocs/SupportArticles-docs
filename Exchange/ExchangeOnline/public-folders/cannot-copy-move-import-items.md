---
title: Can't copy, move, or import many items to a public folder in Outlook
description: When you try to copy, move, or import many items to a public folder in Outlook, the operation fails with the error messages.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
localization_priority: Normal
ms.custom:
- CI 159185
- Exchange Online
- CSSTroubleshoot
ms.reviewer: haembab; meerak; batre
appliesto: 
- Exchange Online
search.appverid: MET150
---

# Can't copy, move, or import many items to public folders in Outlook

## Symptoms

When you try to copy, move, or import many items (such as emails, contacts, and posts) to a public folder in a single Outlook session, only part of them are processed. In this situation, you receive one of the following error messages:

- > Can't move the items. The item could not be moved. The items may have been already moved or deleted.
- > Your server administrator has limited the number of items you can open simultaneously. Try closing messages you have opened or removing attachments and images from unsent messages you are composing.

For example, you try to import a large .pst or .csv file that contains more than 1,000 items. However, only about 400 items are imported to a public folder in Outlook.

## Cause

Exchange Server has a hard limit on the number of items that can be opened by a single mailbox during a single Outlook session. As a result, when the number of open items in Outlook exceeds [open item limits](/exchange/architecture/mailbox-servers/managed-store/managed-store-limits#open-item-limits), Outlook takes time to release the opened items. So, the copy, move, or import operation of those items to a public folder in Online mode doesn't complete and the following exceptions are raised:

- TooManyObjectsOpenedException
- MapiExceptionSessionLimit

## Resolution

To fix this issue, open Outlook in Cached Exchange mode for copy, move, or import operations with public folders that involve a large number of items.

**Note**: Outlook will retrieve information from the offline Outlook Data File (.ost) in Cached Exchange mode.

1. [Download public folders in Cached Exchange Mode](https://support.microsoft.com/office/download-public-folders-in-cached-exchange-mode-39807488-8098-4a9c-b246-4c25e3e20510).
1. [Add public folders to Favorites in Outlook](/exchange/collaboration-exo/public-folders/use-favorite-public-folders#add-public-folders-to-favorites-in-outlook).
1. Copy, move, or import items to the public folder under **Favorites**.
