---
title: The Office 365 top navigation bar displays either Sites or Newsfeed instead of OneDrive in SharePoint Online
description: Describes an issue in which the Office 365 top navigation bar displays either Sites or Newsfeed instead of OneDrive in SharePoint Online.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# Office 365 top navigation bar displays either Sites or Newsfeed instead of OneDrive

## Problem

Consider the following scenario:

- You browse to a OneDrive for Business library.

- You click the gear icon, and then you click either **Site Contents** or **Site Settings**.

- On the **Site Contents** or **Site Settings** page for the OneDrive for Business site, you examine the Microsoft Office 365 top navigation bar.

In this scenario, the Office 365 top navigation bar displays either **Sites** or **Newsfeed**. However, you expect it to display OneDrive.

**NOTE** This issue doesn't affect the top navigation bar for the OneDrive for Business library.

## Solution

This behavior is expected. A **Sites** or **Newsfeed** link is displayed in the Office 365 top bar navigation based on your Enterprise Social Collaboration settings.

## More information

To set the Enterprise Social Collaboration feature, follow these steps:

1. Sign in to the Office 365 portal.

2. Click the **Admin** tile, click **SharePoint**, and then click **settings**.

3. View the **Enterprise Social Collaboration** section.

**NOTES**

- If you select **Use Yammer.com service**, the top navigation bar displays **Sites** on some OneDrive for Business pages. This occurs even if you change the setting to **Use SharePoint Newsfeed (default)**.

- If you select **Use SharePoint Newsfeed (default)**, and if you have never set the **Use Yammer.com service** option, the top navigation bar displays **Newsfeed** on some OneDrive for Business pages.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
