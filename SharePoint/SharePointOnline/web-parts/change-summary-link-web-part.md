---
title: Sorry, something went wrong when you change the Summary Links Web Part
description: This article describes an issue where Sorry, something went wrong error when you try to change the Summary Links Web Part in SharePoint Online, and provides a solution.
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

# "Sorry, something went wrong" when you change the "Summary Links" Web Part in SharePoint Online

## Problem

Consider the following scenario:

- You have a Microsoft SharePoint Online site collection that has the **SharePoint Server Publishing Infrastructure** option enabled.

- The site collection includes a subsite that contains a **Summary Links Web Part**.

- You save the subsite as a template by using the **Save site as template** functionality.

- You use the saved template to create another subsite in the site collection.

- You browse to the new site and then try to create a new link, edit an existing link, or change the contents or settings in the **Summary Links** Web Part.

In this scenario, you receive the following error message:

```adoc
Sorry, something went wrong

List does not exist.

The page you selected contains a list that does not exist. It may have been deleted by another user.
```

## Solution/Workaround

To work around this issue, delete and then re-create the Web Part on the page. After you have done this, populate the required links.

## More information

This issue occurs because SharePoint doesn't support **Save Site as Template** functionality when the **SharePoint Server Publishing Infrastructure** option is enabled.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
