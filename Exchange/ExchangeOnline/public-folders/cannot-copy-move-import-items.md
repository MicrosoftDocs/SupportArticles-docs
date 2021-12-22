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

When you try to copy, move, or import many items to a public folder in Microsoft Outlook, only part of them are processed. In this situation, you receive one of the following error messages:

- > Can't move the items. The item could not be moved. The items may have been already moved or deleted.
- > Your server administrator has limited the number of items you can open simultaneously. Try closing messages you have opened or removing attachments and images from unsent messages you are composing.

For example, you try to import a large .pst or .csv file that contains more than 1,000 items. However, only about 400 items are imported to a public folder in Outlook.

If you use a diagnostic tool such as [Fiddler](/office365/troubleshoot/diagnostic-logs/run-fiddler-trace) to collect diagnostic logs, the following exceptions are recorded:

- TooManyObjectsOpenedException
- MapiExceptionSessionLimit

## Cause

Exchange Server has [open item limits](/exchange/architecture/mailbox-servers/managed-store/managed-store-limits#open-item-limits) for each Outlook session. When the number of items to be processed exceeds the limits, the operation fails.

## Workaround

To work around this issue, use Cached Exchange mode instead.

**Note**: Outlook will retrieve information from the offline Outlook Data File (.ost) in Cached Exchange mode.

1. [Download public folders in Cached Exchange Mode](https://support.microsoft.com/office/download-public-folders-in-cached-exchange-mode-39807488-8098-4a9c-b246-4c25e3e20510).
1. [Add public folders to Favorites in Outlook](/exchange/collaboration-exo/public-folders/use-favorite-public-folders#add-public-folders-to-favorites-in-outlook).
