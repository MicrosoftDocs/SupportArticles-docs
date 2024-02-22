---
title: Can't sort or filter a column in SharePoint Online
description: Unable to sort or filter a column in SharePoint Online because the field may not be filterable, or the number of items returned exceeds the list view threshold enforced.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "Cannot show the value of the filter" error when you try to sort or filter a column in SharePoint Online

## Problem

When you click the drop-down arrow to sort or filter a column in the view in Microsoft SharePoint Online, you receive the following message:

**Cannot show the value of the filter. The field may not be filterable, or the number of items returned exceeds the list view threshold enforced by the administrator.**

## Solution

To resolve this issue, reduce the number of items in the view for the affected list or library to 5,000 items or less. To do this, take one of the following actions, as appropriate for your situation:

- Create a new view for the list or library or change the existing view. When you do this, use indexed columns and filtering to keep the view size for the list to 5,000 items or less. For more information about how to create a filtered view that has a column index, go to [Manage large lists and libraries in SharePoint](https://support.office.com/article/manage-large-lists-and-libraries-in-sharepoint-b8588dae-9387-48c2-9248-c24122f07c59
).

  > [!NOTE]
  > The list limit to add or remove an indexed column is 20,000 items.

- Create folders in the library, and put items in the folders to keep the view for the library to 5,000 items or less.

## More information

This issue occurs when your list or library exceeds the list view threshold limit of 5,000 items for a view.

For more information, go to [SharePoint Online limits](/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-limits
).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).