---
title: Unable to save a list or library as a template in SharePoint Online
description: Unable to save a list or library as a template with selecting the option to Include Content.
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

# Error when you save a list or library as a template in SharePoint Online

## Problem

Consider the following scenario:

- You create or import a term set in SharePoint Online.
- You create or modify a Content Type in the list or in the Content Type Hub to include 10 or more Managed Metadata columns by using the managed metadata from the term set.
- You add an item to the list or library.
- You browse to the settings for the list or library in order to save it as a template, and then you select the option to **Include Content**.

When you click **OK**, you receive the following error message:

**_catalogs/lt/*name of the list*.stp**

> [!NOTE]
> The *name of the list* placeholder represents the actual name of the list in which you experience the issue.

Additionally, you may encounter this issue if you have any combination of 10 or more Managed Metadata columns in your list or library. For example, assume you're using a Content Type that contains 9 Managed Metadata columns, and you add an additional Managed Metadata column to the list or library. This triggers the error.

## Solution/Workaround

To work around this issue, save the template without selecting the option to **Include Content**. Or limit the number of Managed Metadata columns in a list or library that you want to create a template from to fewer than 10.

## More information

This issue occurs because the list view threshold enforces a limit of 10 Managed Metadata columns for a list or library in SharePoint Online.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
