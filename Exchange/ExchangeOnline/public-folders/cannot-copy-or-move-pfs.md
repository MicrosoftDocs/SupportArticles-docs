---
title: Can't move or copy public folders
description: Fixes an issue in which you can't make a copy of a public folder in the same path as the source public folder.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 161484
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: haembab, batre
appliesto: 
  - Exchange Online
  - Outlook
search.appverid: MET150
ms.date: 10/13/2022
---
# Unable to copy or move public folders in Outlook

## Symptoms

When you try to copy or move a public folder from one location to another, you receive the following error message:

> Cannot move or copy folders. Cannot copy folder. A top-level folder cannot be copied to one of its subfolders. Or you may not have appropriate permissions for the folder. To check your permissions for the folder, right-click the folder, and then click Properties on the shortcut menu.

For example, you'll see this error message when you try either of the following copy operations:  

- Make a copy of a public folder under the same parent public folder. Consider *PF1* to be a parent public folder and *PF2* to be a public folder nested under it. If you try to make a copy of *PF2* under *PF1*, the copy operation might fail.

- Make a copy of a public folder and its subfolder under the same parent public folder. Consider *PF1* to be a parent public folder, *PF2* to be a public folder nested in PF1 along with its subfolder PF3. If you have **Owner** permission for PF1, but **Author** permission for *PF2* and *PF3*, and you try to make a copy of *PF2* and *PF3* under *PF1*, the copy operation will only copy *PF2* but not *PF3*.

## Cause

The error message is displayed due to the following reasons:

When you use Outlook, if you make a copy of a public folder at the same location as the original folder, Outlook appends the word "copy" to the display name of the copied public folder. If the number of characters in the display name of the original public folder is already at the maximum limit allowed, Outlook is unable to append the word "copy" to it during the copy operation. So the copy operation fails and the error message is displayed.

If you have **Owner** permissions to a parent folder *PF1* but **Author** permissions to the folders nested in it such as *PF2\PF3*, an operation to make a copy of *PF2\PF3* under *PF1* will execute only partially. The copy operation will create a copy of *PF2* but not *PF3* and display the error message.

## Resolution

To make a copy of a public folder in the same path as the source public folder, ensure that the path doesn't already have another folder with the same display name. Then use the following process:
1. [Download public folders in Cached Exchange Mode](https://support.microsoft.com/office/download-public-folders-in-cached-exchange-mode-39807488-8098-4a9c-b246-4c25e3e20510).
1. [Add public folders to Favorites in Outlook](/exchange/collaboration-exo/public-folders/use-favorite-public-folders#add-public-folders-to-favorites-in-outlook).
1. Copy the public folder under **Favorites**.

To make a copy of a public folder and its subfolder in the same path as the source public folder, make sure you have **Owner** permissions for the source public folder and its parent folder. For example, if PF1 is a parent folder with *PF2\PF3* as subfolders nested in it, then to make a copy of *PF2\PF3*, you should have **Owner** permissions for both *PF1* and *PF2*.

## Related content

[Can't copy, move, or import more than 1,000 items to public folders in Outlook](cannot-copy-move-import-items.md)
