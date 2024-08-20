---
title: Offline item count differs from server count
description: Describes an Outlook issue in which the number of items in the Server folder doesn't match the number in the Offline folder. This issue involves a synchronization filter on one of the folders. A resolution is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sending, Receiving, Synchronizing, or viewing email\Other
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robevans
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Offline item count for a folder in Outlook differs from the server item count

_Original KB number:_ &nbsp; 3044375

## Symptoms

In Microsoft Outlook, you discover that the server count and offline item count for a particular folder don't match. The following screenshot illustrates this issue.

:::image type="content" source="media/offline-item-count-for-folder-differs-from-server-count/server-count-and-offline-item-count.png" alt-text="Screenshot of the Synchronization tab in Inbox Properties. In this example, Server folder contains 39 items and Offline folder contains two items." border="false":::

## Cause

This issue occurs when a synchronization filter is configured for a folder.

## Resolution

If you no longer require the filter or if you didn't mean to enable it in the first place, follow these steps to remove the filter:

1. In the **details** pane in Outlook, right-click the folder, and then select **Properties**.
2. Select the **Synchronization** tab, and then select **Filter**.
3. Select **Clear All**, or adjust the filter criteria as needed.

> [!NOTE]
> The changes will not be applied until the next Send/Receive operation in Outlook.

## More information

While Outlook is in Offline mode, the synchronization filter process doesn't work.
