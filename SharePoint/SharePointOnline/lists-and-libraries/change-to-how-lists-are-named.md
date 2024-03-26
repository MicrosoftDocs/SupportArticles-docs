---
title: Update to default content type setting for new lists in Modern Lists, Teams, and SharePoint
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
ms.custom: 
  - sap:Lists and Libraries\Content Types
  - CI 124631
  - CSSTroubleshoot
ms.reviewer: MS aliases for tech reviewers and CI requestor, without @microsoft.com.
description: Describes a change to how lists are named in Microsoft Lists, Teams, and SharePoint.
---

# Change to default content type setting for new lists in Modern Lists, Teams, and SharePoint

Modern List creation is an update to the Microsoft Lists, Microsoft Teams, and SharePoint appwebs. The default content type of new lists is currently set to the name of the list instead of “Item.” A fix is scheduled to be rolled out by the end of this month (November 2020) that will set the default content type to “Item” instead.

Users can update previously created lists by following these steps:

## Step 1: Add the "Item” content type to the list.



1.	Go to **List settings**.
2.	Select **Add from existing site content types**.

    > [!note]
    > If **Add from existing site content types** is not visible, then go to **Advanced settings** in the list and set **Allow management of content types** to **Yes**.
3.	Select and add the “Item” content type.
4.	Select **Add**.

    :::image type="content" source="media/change-to-how-lists-are-named/add-item-content-type.png" alt-text="Screenshot to select and add the Item content type to the list.":::
 
## Step 2: Make "Item” the default, and hide the old default content type.

1.	Select **Change new button order and default content type**.
2.	Set the position of “Item” as **1**. Clear the check box beneath **Visible** for any other content type to hide that content type (such as “Content scheduler” in the example below).

    :::image type="content" source="media/change-to-how-lists-are-named/set-item-content-type-1.png" alt-text="Screenshot to set the position of the Item content type as 1.":::
 
## Step 3: Copy all fields from the old default content type to the new default content type.

1.	Select the “Item” content type, and then select **Add from existing site or list columns**.
2.	Add all the columns that are required, and then adjust the column ordering, as necessary.

## Step 4: Move all items from the old default content type to the new "Item” default content type.

To do this, bulk edit all list items. 

:::image type="content" source="media/change-to-how-lists-are-named/bulk-edit-all-list-items.gif" alt-text="Bulk move all the old content types to the new default content types.":::


## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
