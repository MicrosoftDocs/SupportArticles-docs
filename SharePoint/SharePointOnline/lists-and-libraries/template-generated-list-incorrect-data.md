---
title: Template-generated list doesn't display correct data for a column
description: This article describes an issue where template-generated list doesn't display correct data for a column in SharePoint Online, and provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Template-generated list doesn't display correct data for a column in SharePoint Online

## Problem

Consider the following scenario.

- You have a Microsoft SharePoint Online list or library that contains **Lookup** columns, **Managed Metadata** columns, or **Person or Group** columns.

- You save the list or library as a template.

- You use the template to create another list or library on another site collection or subsite.

When you try to use the **Lookup** columns, **Managed Metadata** columns, or **Person or Group** columns in this scenario, the selection is either blank or displays incorrect data.

## Solution

To resolve this issue, create a template from a list that doesn't contain **Lookup** columns,**Managed Metadata** columns, or **Person or Group** columns. Then, create the columns in the list after you create the list from the template.

Or, you can save the site as a template and then create a subsite by using the site that was saved from the template. You must create the site in the same site collection.

## More information

This issue occurs when you save a list that contains **Lookup** columns, **Managed Metadata** columns, or **Person or Group** columns as a template, and then you create a list on another subsite or site collection. List templates that contain these columns are supported only on the same site where they were created.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
