---
title: A synced SharePoint file is moved to the recycle bin
description: When you synchronize a SharePoint Online or OneDrive library to your computer, a synced file is moved to the SharePoint Online or OneDrive recycle bin.
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

When you synchronize a Microsoft SharePoint Online library or a OneDrive library to your computer by using the OneDrive sync client (onedrive.exe), a file that was synchronized is unexpectedly moved from the library to the SharePoint Online or OneDrive recycle bin.

## Cause

This issue occurs because a user accidentally deleted the file, or a local application for the user who synchronized the library deleted the file. 

## Resolution

To identify the user who deleted the affected file, open the SharePoint Online or OneDrive recycle bin, and then check the **Deleted By** field for the affected file. The account that's listed in this field is for the user who performed the delete operation. 

Try to determine whether the file was intentionally or accidentally deleted by the identified user. This information is important if multiple users are synchronizing a single library. For example, in some cases, a user might try to copy a file that might have been accidentally moved to another directory. This action removes the file from the synchronized library.

If the file wasn't intentionally or accidentally deleted by the **Deleted By** user, ask the user whether a local process might have moved or deleted the file. For example, local virus-protection software could be configured to quarantine files.

## More information

If a folder is deleted from a locally synced SharePoint library, the OneDrive sync client processes this action as a standard file system deletion. The OneDrive sync client then syncs this change to the cloud (SharePoint/OneDrive). When other users who synced the same library receive this update, their devices also delete the folder locally. Therefore, the operating system moves the deleted folder into each user’s local recycle bin. The OneDrive client makes sure that local folders and the cloud library are kept in sync. This process also applies to empty folders.
