---
title: Unable to share or break inheritance in SharePoint and OneDrive
description: Fixes an issue in which you can't share or break inheritance of a folder, list, or library because of too many uniquely permitted items in a list or library. 
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro 
ms.topic: article
ms.prod: sharepoint-server-itpro 
localization_priority: Normal
ms.custom: 
- CI 114943
- CSSTroubleshoot
ms.reviewer: prbalusu, salarson, clake
appliesto:
- SharePoint Online
- OneDrive for Business
search.appverid: MET150
---
# "Exceeds list view threshold" or "too many items with unique permissions" error when trying to share or break inheritance

## Symptoms

When you try to share or break the inheritance of a folder in Microsoft SharePoint Online or Microsoft OneDrive for Business, you receive one of the following error messages:

- > Microsoft.SharePoint.SPQueryThrottledException","message":{"lang":"en-US","value":"The attempted operation is prohibited because it exceeds the list view threshold enforced by the administrator."},"status":500,"
- > OneDrive Sharing Failed: The attempted operation is prohibited because it exceeds the list view threshold enforced by the administrator.
- > You cannot break inheritance for this item because there are too many items with unique permissions in this list.

## Cause

This issue occurs for one of the following reasons:

- When a list, library, or folder contains more than 100,000 items, you can neither break permission inheritance nor reinherit permissions on the list, library, or folder. However, you can still break inheritance on the individual items within that list, library, or folder, up to the maximum number of unique permissions.
- The supported limit of unique permissions for items in a list or library is 50,000. However, the recommended general limit is 5,000. Making changes to more than 5,000 uniquely permitted items at a time takes longer. Therefore, for large lists, design the list to have as few unique permissions as possible.

## Resolution

To fix this issue, use the following methods:

- Reduce the number of uniquely permitted items in a list or library.
- Follow best practices for lists, such as having a low list item count.

## More information

For more information about lists and libraries, see the following articles:

- [Items in lists and libraries](/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-limits#items-in-lists-and-libraries)
- [Manage large lists and libraries in SharePoint](https://support.office.com/article/manage-large-lists-and-libraries-in-sharepoint-b8588dae-9387-48c2-9248-c24122f07c59)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).