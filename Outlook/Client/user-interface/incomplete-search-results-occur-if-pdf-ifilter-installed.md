---
title: Incomplete search results if PDF iFilter installed
description: Provides a resolution for the issue that you may receive incomplete search results in Microsoft Outlook when a PDF iFilter is installed.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: vivekst, gregmans
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook for Microsoft 365
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 01/30/2024
---
# Incomplete search results may occur in Outlook when a PDF iFilter is installed

_Original KB number:_ &nbsp; 2925203

## Symptoms

- When you use instant search in Microsoft Outlook, you receive a message that states **No matches found** or you receive an InfoBar message that states **Search results may be incomplete because items are still being indexed**.
- If you check the status of indexing, you see there are still items remaining to be indexed in the **Indexing Status** window.
- When you review the events in the application event log, you see items with the following parameters:

| Event ID| Source| Task Category| Description |
|---|---|---|---|
|10023|Search|Gatherer|The protocol host process \<PID> did not respond and is being forcibly terminated {filter host process 6104|
|10024|Search|Gatherer|The filter host process \<PID> did not respond and is being forcibly terminated.|

## Cause

This problem occurs when a PDF iFilter stalls the Windows Desktop search indexer, causing frequent reindexing of Outlook items.

## Resolution

To resolve this problem, update any applications that offer PDF file functionality with the latest patches. Then, follow these steps to rebuild the index.

1. In Control Panel, select **Indexing Options**.

   If **Indexing Options** does not appear in Control Panel, type *Indexing Options* in the **Search Control Panel** text box, and then select the **Indexing Options** search result.

2. In the Indexing Options dialog box, select **Advanced**.
3. Select **Rebuild**.
4. Select **OK** in the Rebuild Index dialog box.
