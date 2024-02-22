---
title: A list view Web Part for a tasks list doesn't filter values
description: This article describes an issue where a list view Web Part for a tasks list doesn't filter values from a connected Web Part in SharePoint Online or SharePoint Server 2013, and provides a solution.
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
  - SharePoint Server
ms.date: 12/17/2023
---

# A list view Web Part for a tasks list doesn't filter values from a connected Web Part

## Problem

Consider the following scenario:

- You create a tasks list (that is, you select **Tasks** for the list type) in Microsoft SharePoint Online or Microsoft SharePoint Server 2013.

- You create a custom list that contains values.

- You configure a lookup column in the tasks list to obtain information from the custom list.

- You open a page in edit mode and than add list view Web Parts for both the tasks list and the custom list.

- You configure a connection between the two Web Parts by editing the Web Part for the tasks list. Then, you click **Connections**, click **Get Filter Values From**, and then select the custom list.

- You save your changes to the page.

- When you click the arrow to filter values in the custom list, the Web Part for the tasks list doesn't filter the results on the page for the values as expected.

## Solution/Workaround

To work around this issue, enable server rendering on the list view Web Part for the affected tasks list. To do this, follow these steps:

1. Browse to the affected page, and then open the page in edit mode.

1. Click the drop-down arrow in the upper-right corner of the Web Part for the tasks list, and then click **Edit Web Part**.

1. On the right side of the page in the Web Part properties controls, click the plus sign (+) on the **Miscellaneous** section, click to select the **Server Render** check box, and then click **OK**.

1. Save the changes to the page.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
