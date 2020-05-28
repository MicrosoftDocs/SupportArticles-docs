---
title: Items are missing from search results when Office 365 users search their mailbox in Outlook on the web
description: Describes an issue in which items are missing in the search results when Office 365 users search their mailbox by using the search box in Outlook on the web. Provides a resolution.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: Office 365
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: alinastr
appliesto: 
- Exchange Online
search.appverid: MET150
---

# Items are missing from search results when Office 365 users search their mailbox in Outlook on the web

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_&nbsp;2835179

## Problem

When Microsoft Office 365 users search their mailbox in Outlook on the web (formerly known as Outlook Web App), they notice that lots of messages are missing from the search results. Additionally, gaps may be present in the date range of items that are returned in the search results.

## Cause

This problem occurs if the search returns more than 250 items.

## Solution

Take any of the following actions:

- Reduce the scope of the search to only specific folders or subfolders.
- Use more-specific search terms.
- Use Microsoft Outlook in Cached Exchange Mode to search the mailbox.

    > [!NOTE]
    > If you use Outlook to search the Online Archive folder, you will receive the same limited search results as Outlook on the web. This is because Outlook accesses the Online Archive folder in Online Mode.

## More information

Outlook on the web displays up to 250 items in the search results. Be aware that, to reduce the time to show search results, users may receive only a subset of the results. In this scenario, click **Get more results** at the bottom of the search results to view additional results up to the limit of 250 items.

For more information, see [Search Mail and People in Outlook Web App](https://support.office.com/article/88108edf-028e-4306-b87e-7400bbb40aa7).

Sill need help? Go to [Microsoft Community](https://answers.microsoft.com/).
