---
title: A SharePoint Online list item attachment doesn't open in the Office client app
description: You can't open a SharePoint Online list item with an attachment in the Office client application as expected.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# A SharePoint Online list item attachment doesn't open in the Office client application as expected

## Problem

Consider the following scenario.

- You have a SharePoint Online list item with an attachment present.
- You have taken steps to configure SharePoint Online to open documents in the client application by using one or more of the following methods:

  - You removed the Office Online license from the affected user account.
  - You changed the list's **Opening Documents in the Browser** setting in **Advanced Settings** to **Open in the client application**.

- Attachments for list items continue to open in the Internet browser.

## Solution

To resolve this issue, activate the **Open Documents in Client Applications by Default site** collection feature in Site settings. To do this, follow these steps:

1. Click the gear icon to open **Settings**, and then click **Site settings**.
1. Click **Site collection features**.

   > [!NOTE]
   > If the **Site collection features** option isn't present, you must first click **Go to top level site settings**.

1. Locate the **Open Documents in Client Applications by Default** feature in the list, and then click **Activate**.

   > [!NOTE]
   > This setting will affect the behavior of the SharePoint Online site collection.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
