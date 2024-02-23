---
title: Search results shown without message preview text
description: Describes an issue that causes search results to be displayed without Message Preview text in Outlook.
ms.author: meerak
author: cloud-writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae, genli
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Search results are displayed without message preview in Outlook

_Original KB number:_ &nbsp; 4230295

## Symptoms

In Microsoft Outlook, you have **Message Preview** enabled and set to **1 line**, **2 lines**, or **3 lines**. When you do a search in Outlook, the results may be displayed without the message preview text.

## Cause

This behavior is by design in most cases. Depending on the nature of the data that is returned by the underlying search technology and the search scope that is used, the message preview may not be displayed in the search results. You may also see a mixture of search results, with some message displayed together with the preview text and other messages without it.

## Resolution

To change this behavior, try setting the **Message Preview** setting on all mailboxes instead of on a single folder. To do this, follow these steps:

1. On the **View** tab, select **Message Preview**, and then select **Off**. If you're prompted, select **All mailboxes**.
2. Select **Message Preview** again, and then select the preview setting that you prefer (**1 Line**, **2 Lines**, or **3 Lines**).
3. Select **All mailboxes** in the dialog box that appears.

> [!NOTE]
> This only changes the behavior in certain scenarios. Therefore, the behavior may continue to occur after you follow these steps. If this is the case, the behavior is by design.
