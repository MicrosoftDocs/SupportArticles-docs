---
title: The number of items in this list exceeds the list view threshold
description: This article describes The number of items in this list exceeds the list view threshold error, and provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Lists and Libraries\Managing list view threshold errors
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "The number of items in this list exceeds the list view threshold" when you view lists in Microsoft 365

## Problem

When you view a SharePoint Online list in Microsoft 365 Enterprise, you receive the following error message:

**The number of items in this list exceeds the list view threshold, which is 5000 items. Tasks that cause excessive server load (such as those involving all list items) are currently prohibited.**

## Solution

To work around this issue, review the recommendations, techniques, and tips outlined in [Manage large lists and libraries in SharePoint](https://support.office.com/article/b8588dae-9387-48c2-9248-c24122f07c59).

## More information

This issue occurs because SharePoint Online uses the Large List Resource Throttling feature. By default, the list view threshold is configured at 5,000 items. When the defined item limit in a list is exceeded, the message is displayed.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
