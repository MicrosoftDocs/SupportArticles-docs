---
title: Unable to share or break inheritance in SharePoint and OneDrive
description: Fixes an issue in which you can't share or break inheritance of a folder, list, or library because of too many uniquely permitted items in a list or library.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Permissions\Inheritance
  - CI 114943
  - CSSTroubleshoot
ms.reviewer: prbalusu, salarson, clake
appliesto: 
  - SharePoint Online
  - OneDrive for Business
search.appverid: MET150
ms.date: 12/17/2023
---
# "You can't share this folder because there are too many items in the folder" error when trying to share or break inheritance

## Symptoms

When you try to share or break the inheritance of a folder in Microsoft SharePoint Online or Microsoft OneDrive for Business, you receive one of the following error messages:

- > You can't share this folder because there are too many items in the folder.
- > You can't share this item because too many items have already been shared in this library.

## Cause

This issue occurs for one of the following reasons:

- When a folder, library, or list contains more than 100,000 items, you can neither break permission inheritance nor reinherit permissions on the folder, library, or list. However, you can still break inheritance on the individual items within that folder, library, or list, up to the maximum number of unique permissions.
- The supported limit of unique permissions for items in a list or library is 50,000. However, the recommended general limit is 5,000. Making changes to more than 5,000 uniquely permitted items at a time takes longer. Therefore, for large lists, design the list to have as few unique permissions as possible.

## Resolution

To fix this issue, use the following methods:

- Reduce the number of items in the folder, library or list that you want to break permission inheritance or reinherit permissions on. You can move some items out first, break or reinherit permissions, and then move them back.
- Reduce the number of uniquely permitted items in a list or library.

## More information

For more information about lists and libraries, see [Items in lists and libraries](/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-limits#items-in-lists-and-libraries).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
