---
title: A synced SharePoint file is moved to the recycle bin
description: When you synchronize a SharePoint Online or OneDrive for Business library to your computer, a synced file is moved to the SharePoint Online or OneDrive for Business recycle bin.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Backup and Restore\Site Recycle Bin
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# A file that was synchronized in SharePoint Online or OneDrive for Business is moved to the recycle bin

## Problem

This article contains information that applies when you use the OneDrive sync client (onedrive.exe) or the OneDrive for Business sync client (groove.exe) OneDrive for Business sync client.

> [!NOTE]
> To determine which OneDrive sync client you're using, see [Which version of OneDrive am I using?](https://support.office.com/article/which-version-of-onedrive-am-i-using-19246eae-8a51-490a-8d97-a645c151f2ba)

When you synchronize a Microsoft SharePoint Online or OneDrive for Business library to your computer by using the OneDrive for Business sync application, a file that was synchronized is unexpectedly moved from the SharePoint Online or OneDrive for Business library to the SharePoint Online or OneDrive for Business recycle bin.

## Solution

This scenario frequently occurs because the file was accidentally deleted or was removed by a local application for a user who was synchronizing the library. You should check the **Deleted By** field for the affected file in the SharePoint Online or OneDrive for Business recycle bin. The account that's listed in this field is for the user who performed the delete operation for the file. When you delete a file locally in a folder that's configured to synchronize by using the OneDrive for Business sync application, the delete operation is synchronized with SharePoint Online, and the item is moved to the recycle bin.

You can confirm that the file wasn't intentionally or accidentally deleted by the user who is listed in the **Deleted By** field. This is important when multiple users are synchronizing a single library. For example, in some cases, a user may try to copy a file that may have been accidentally moved to another directory. This removes the file from the synchronized library.

If the file wasn't intentionally or accidentally deleted, you should have the user who's listed in the **Deleted By** field review the computer to determine whether a local process moved or deleted the item. For example, local virus-protection software may be configured to quarantine files.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
