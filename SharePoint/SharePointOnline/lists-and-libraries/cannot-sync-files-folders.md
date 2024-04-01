---
title: You can't sync files or folders, or you receive errors when you open files
description: Describes an issue that occurs when you upload or create a folder that's named _private in SharePoint Online, and provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Lists and Libraries\Add shortcut to OneDrive
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - OneDrive for Business
ms.date: 12/17/2023
---

# You can't sync files or folders in Microsoft 365, or receive errors when you open files in Office Online

> [!NOTE]
> This article applies only to the previous OneDrive for Business sync client (groove.exe). In most cases, we recommend that you [use the newer OneDrive sync client](https://support.office.com/article/sync-files-with-the-onedrive-sync-client-in-windows-615391c4-2bd3-4aae-a42a-858262e42a49) (onedrive.exe) instead. [Which version of OneDrive am I using?](https://support.office.com/article/which-version-of-onedrive-am-i-using-19246eae-8a51-490a-8d97-a645c151f2ba)

## Problem

After you upload or create a folder that's named "_private" in Microsoft SharePoint Online or in OneDrive for Business, you experience one or more of the following issues:

- When you synchronize the _private folder by using the OneDrive for Business sync app, you receive the following error message for any files that are in the folder:

    > This file name contains invalid characters.

- When you synchronize the _private folder by using the OneDrive for Business sync app, the folder itself is synchronized, but no files in the folder are synchronized.

- You try to open an item that exists in the _private folder in Microsoft Office Online, you receive the following error message:

    > Sorry, this document can't be opened for editing.

## Solution

To work around this issue, use a folder name other than "_private" in SharePoint Online or OneDrive for Business.

## More information

This issue occurs because a folder that's named "_private" isn't supported in SharePoint Online.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
