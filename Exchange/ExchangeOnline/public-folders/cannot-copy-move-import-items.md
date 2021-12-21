---
title: Can't copy, move, or import items to a public folder in Outlook
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

# Errors when trying to copy, move, import items to public folders in Outlook

## Symptoms

When you try to copy, move, or import many items to a public folder in Microsoft Outlook, only a few items are copied, moved, or imported. The operation fails with one of the following error messages:

- > Can't move the items. The item could not be moved. The items may have been already moved or deleted.
- > Your server administrator has limited the number of items you can open simultaneously. Try closing messages you have opened or removing attachments and images from unsent messages you are composing.

For example, you have a file (such as a .pst or .csv file) that has more than 1000 items. The operation to import the file to a public folder fails in Outlook.

If you use a diagnostic tool such as [Fiddler](/office365/troubleshoot/diagnostic-logs/run-fiddler-trace) to collect diagnostic logs, the following exceptions are recorded:

- TooManyObjectsOpenedException
- MapiExceptionSessionLimit

## Cause

Exchange Server has [open item limits](/exchange/architecture/mailbox-servers/managed-store/managed-store-limits#open-item-limits) for each Outlook session. There are limits for the number of items that can be opened by a mailbox in a session. When you use Outlook in Online mode, it takes time to release opened items, and the operation to copy, move, import items fails.

## Workaround

To work around this issue, use Outlook in Cached Exchange mode instead.

**Note**: Outlook will retrieve information from the offline Outlook Data File (.ost) in Cached Exchange Mode.

1. In Outlook, enable the [Download Public Folder Favorites](https://support.microsoft.com/office/download-public-folders-in-cached-exchange-mode-39807488-8098-4a9c-b246-4c25e3e20510) option.
1. [Add the public folder to the Favorites folder](/exchange/collaboration-exo/public-folders/use-favorite-public-folders#add-public-folders-to-favorites-in-outlook).
1. Copy, move, or import the items to the public folder.
