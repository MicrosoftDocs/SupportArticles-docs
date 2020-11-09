---
title: "Title goes here"
ms.author: v-todmc
author: mccoybot
manager: dcscontentpm
ms.date: xx/xx/xxxx
audience: Admin|ITPro|Developer
ms.topic: article
ms.service: sharepoint-online
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- ADD PRODUCT
ms.custom: 
- CI ID
- CSSTroubleshoot 
ms.reviewer: MS aliases for tech reviewers and CI requestor, without "@microsoft.com".  
description: "How to resolve the error "Virus Found" in SharePoint Server 2013 when the antivirus scanner is unavailable ."
---

# Change to how lists are named in Lists, Teams, and SharePoint

Modern List creation is an update to the Microsoft Lists, Microsoft Teams, and SharePoint appwebs. The default content type of new lists will be set to the name of the list instead of to “Item.” This change will be rolled out to standard release tenants by the end of November 2020.

Users update previously created lists by following these steps:

## Step 1. Add the "Item” content type to the list.

1.	Go to **List settings**.
2.	Select **Add from existing site content types**.
3.	Select and add the “Item” content type.
4.	Select **Add**.
    :::image type="content" source="media/change-to-how-lists-are-named/change-to-how-lists-are-named-1.png" alt-text="Select and add the Item content type.":::
 
## Step 2. Make "Item” the default, and hide the old default content type.

1.	Select **Change new button order and default content type**.
2.	Set the position of “Item” as **1**. Clear the check box beneath **Visible** for any other content type to hide that content type (such as “Content scheduler” in the example below).
    :::image type="content" source="media/change-to-how-lists-are-named/change-to-how-lists-are-named-2.png" alt-text="Set the position of Item as 1.":::
 
## Step 3. Copy all fields from the old default content type to the new default content type.

1.	Select the “Item” content type, and then select **Add from existing site or list columns**.
2.	Add all the columns that are required, and then adjust the column ordering, as necessary.

## Step 4. Move all items from the old default content type to the new "Item” default content type.

To do this, bulk edit all list items. 
:::image type="content" source="media/change-to-how-lists-are-named/change-to-how-lists-are-named-3.gif" alt-text="Bulk move all the old content types to the new default content types.":::


## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).