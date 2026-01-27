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
  - OneDrive
ms.date: 12/17/2023
---

# A file that was synchronized in SharePoint Online or OneDrive is moved to the recycle bin

## Symptoms

When you synchronize a Microsoft SharePoint Online or OneDrive library to your computer by using the OneDrive sync client (onedrive.exe), a file that was synchronized is unexpectedly moved from the SharePoint Online or OneDrive library to the recycle bin for SharePoint Online or OneDrive.

## Why does this issue occur?

This issue occurs because a user accidentally deleted the file or it was removed by a local application for a user who was synchronizing the library. Check the **Deleted By** field for the affected file in the SharePoint Online or OneDrive recycle bin. The account that's listed in this field is for the user who performed the delete operation for the file. When you delete a file locally in a folder that's configured to synchronize by using the OneDrive sync application, the delete operation is synchronized with SharePoint Online, and the item is moved to the recycle bin.

You can confirm that the file wasn't intentionally or accidentally deleted by the user who is listed in the **Deleted By** field. This is important when multiple users are synchronizing a single library. For example, in some cases, a user may try to copy a file that might have been accidentally moved to another directory. This action removes the file from the synchronized library.

If the file wasn't intentionally or accidentally deleted, ask the user who's listed in the **Deleted By** field to determine whether a local process moved or deleted the file. For example, local virus-protection software might be configured to quarantine files.

> [!NOTE]
> If a folder is deleted from a locally synced SharePoint library, whether it’s empty or contains files, the OneDrive sync client processes this as a standard file system deletion. It then syncs this change to the cloud (SharePoint/OneDrive). When other users who have the same library synced receive this update, their devices also delete the folder locally. As a result, the operating system moves the deleted folder into each user’s local recycle bin. The OneDrive client ensures that local folders and the cloud library are kept in sync. When a deletion is made on any synced device, it is sent to the online library and then distributed to all other devices that sync the same library. Each device then deletes the folder locally, causing the operating system to move the item to that user’s local recycle bin. This process applies to empty folders as well.
