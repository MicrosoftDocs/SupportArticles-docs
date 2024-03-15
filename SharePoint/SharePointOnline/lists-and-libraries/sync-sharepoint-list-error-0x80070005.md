---
title: 0x80070005 error when syncing a SharePoint Online list in Outlook
description: You cannot sync a SharePoint Online list in Outlook with the error 0x80070005 that you have no permission to view the SharePoint list.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# 0x80070005 error when you try to sync a SharePoint Online list in Outlook

## Problem

You have a Microsoft SharePoint Online list or library that was previously configured to sync data with Microsoft Outlook through the Connect to Outlook feature. However, when Outlook tries to sync the list, you receive the following error message:

```asciidoc
Task 'SharePoint' reported error (0x80070005): You do not have permission to view this SharePoint List <name of the SharePoint list or library>. Contact the SharePoint site administrator. HTTP 302.
```

## Solution

To resolve this issue, delete the SharePoint Online list or library from Outlook, and then reestablish the connection to Outlook. To do this, follow these steps. 

### Delete the list or library from Outlook

1. In the **Mail** section of Outlook, locate the SharePoint Lists folder in the navigation pane.
1. Right-click the list that you want to remove the connection for, click **Delete**, and then click **Yes** to confirm that this is what you want to do.

> [!NOTE]
> This procedure removes the library only from Outlook, not from the SharePoint site.

### Reconnect the SharePoint Online list or library to Outlook

1. Browse to the SharePoint Online list that you want to reconnect to Outlook.
1. On the SharePoint Online ribbon for the list, click **Connect to Outlook** in the **Connect & Export** section.
1. When you're prompted to open a program on your computer, click **Allow**.
1. If you're prompted to confirm the operation, click **Yes**.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
