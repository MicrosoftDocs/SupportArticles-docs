---
title: Can't move or copy public folders
description: Fixes an issue in which you can't make a copy of a public folder in the same path as the source public folder.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - CI 161484
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: haembab, batre
appliesto: 
  - Exchange Online
  - Outlook
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't copy or move public folders in Outlook

## Symptoms

When you try to copy or move a public folder from one location to another in Microsoft Outlook, you receive the following error message:

> Cannot move or copy folders. Cannot copy folder. A top-level folder cannot be copied to one of its subfolders. Or you may not have appropriate permissions for the folder. To check your permissions for the folder, right-click the folder, and then click Properties on the shortcut menu.

For example, you see this error message when you try either of the following copy operations:  

- Make a copy of a public folder under the same parent public folder. Consider *PF1* to be a parent public folder and *PF2* to be a public folder that's nested beneath it. If you try to make a copy of *PF2* under *PF1*, the copy operation fails.

- Make a copy of a public folder and its subfolder under the same parent public folder. Consider *PF1* to be a parent public folder and *PF2* to be a public folder that's nested beneath PF1 together with its own subfolder, *PF3*. If you have the **Owner** permission for PF1, but the **Author** permission for *PF2* and *PF3*, and you try to make a copy of *PF2* and *PF3* under *PF1*, the copy operation will copy only *PF2* but not *PF3*.

## Cause

This error occurs for the following reasons:

When you use Outlook, if you make a copy of a public folder at the same location as the original folder, Outlook appends the word "copy" to the display name of the copied public folder. If the number of characters in the display name of the original public folder is already at the upper limit, Outlook can't append the word "copy" to it during the copy operation. Therefore, the copy operation fails.

If you have **Owner** permissions to a parent folder *PF1* but **Author** permissions to the folders nested beneath it, such as *PF2\PF3*, an operation to make a copy of *PF2\PF3* beneath *PF1* runs only partially. The copy operation creates a copy of *PF2* but not *PF3*, and then it return an error message.

## Resolution

To make a copy of a public folder in the same path as the source public folder, make sure that the path doesn't already have another folder that has the same display name. Then follow these steps:
1. [Download public folders in Cached Exchange Mode](https://support.microsoft.com/office/download-public-folders-in-cached-exchange-mode-39807488-8098-4a9c-b246-4c25e3e20510).
1. [Add public folders to Favorites in Outlook](/exchange/collaboration-exo/public-folders/use-favorite-public-folders#add-public-folders-to-favorites-in-outlook).
1. Copy the public folder that's beneath **Favorites**.

To make a copy of a public folder and its subfolder in the same path as the source public folder, make sure that you have the **Owner** permission for the source public folder and its parent folder. For example, if *PF1* is a parent folder that has *PF2\PF3* as subfolders nested beneath it, you should have **Owner** permissions for both *PF1* and *PF2* in order to make a copy of *PF2\PF3*.

## Related content

[Can't copy, move, or import more than 1,000 items to public folders in Outlook](cannot-copy-move-import-items.md)
