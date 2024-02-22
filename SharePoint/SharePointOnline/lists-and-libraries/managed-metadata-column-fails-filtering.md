---
title: Filtering doesn't work for Tasks list with a Managed Metadata column
description: When trying to filter a Tasks list using the Managed Metadata column, the list doesn't filter as expected.
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

# Filtering doesn't work for Managed Metadata column in SharePoint Online Tasks list

## Problem

Consider the following scenario:

- You have a Tasks list in SharePoint Online.
- The Tasks list has a Managed Metadata column which displays values from a term set.

In this scenario, when you try to filter the list using the Managed Metadata column, the list doesn't filter as expected. For example, no values that match the filter will be displayed.

## Solution

To work around this issue, enable server rendering on the list view Web Part for the affected Tasks list. To do this, follow these steps:

1. Browse to the affected page, and then open the page in edit mode.
1. Click the drop-down arrow in the upper-right corner of the Web Part for the tasks list, and then click **Edit Web Part**.
1. On the right side of the page in the Web Part properties controls, click the plus sign (+) on the **Miscellaneous section**, click to select the **Server Render** check box, and then click **OK**.
1. Save the changes to the page.

> [!NOTE]
> You must follow these steps for each view for the Tasks list.

## More information

This is a known issue in SharePoint Online.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
