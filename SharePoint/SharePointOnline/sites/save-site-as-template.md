---
title: Sorry, something went wrong when you save a site as a template
description: This article describes Sorry, something went wrong error message when you save a SharePoint Online site as a template, and provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "Sorry, something went wrong" error message when you save a SharePoint Online site as a template

## Problem

Consider the following scenario:

1. You open the **Solution Gallery** in the **Solutions** area of **SiteSettings** in Microsoft SharePoint Online.

1. You change the **Require content approval for submitted items?** setting to ***Yes***.

1. When you try to save the site as a template, you receive the following error message:
    ```adoc
    Sorry, something went wrong
    
    An unexpected error has occurred.
    ```

## Solution

To work around this issue, change the **Require content approval for submitted items?** setting to ***No***, and then save the site as a template. To do this, follow these steps:

1. Browse to the SharePoint Online site in which you received the error message.

1. Click the gear icon for **Settings**, and then click **Site settings**.

1. In the **Web Designer Galleries** section, click **Solutions**.

1. On the ribbon, click the **LIBRARY** tab, and then click **Library Settings**.

1. Click **Versioning Settings**.

1. In the **Content Approval** section, set Require content approval for submitted items? to **No**, and then click **OK**.

1. Save the site as a template.

1. Re-enable content approval on the **Solution Gallery** after the template is successfully created, if it's necessary.

> [!NOTE]
> Any site that was created by using this template has the **Require content approval for submitted items?** setting set to ***No***. You may have to enable this setting for a site that you created from the template, if it's necessary.

## More information

This is a known issue in SharePoint Online.

**Note** It's currently not supported to save a modern site as a template.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
