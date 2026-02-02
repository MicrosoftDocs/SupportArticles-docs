---
title: A file that was synchronized in SharePoint Online or OneDrive is moved to the recycle bin
description: Describes an issue when a file in a synchronized SharePoint Online or OneDrive library is moved to the recycle bin. 
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: nirupme
ms.custom: 
  - sap:Backup and Restore\Site Recycle Bin
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - OneDrive
ms.date: 01/29/2026
---

# A file that was synchronized in SharePoint Online or OneDrive is moved to the recycle bin

## Summary
This article discusses the scenario when a file in a SharePoint Online or OneDrive library is moved to the recycle bin after the library is synchronized. The article explains the actions that might cause the issue and the steps you can take to find out more information.

## Symptoms

When you synchronize a Microsoft SharePoint Online library or a OneDrive library to your computer by using the OneDrive sync client (onedrive.exe), a file that was synchronized is unexpectedly moved from the library to the SharePoint Online or OneDrive recycle bin.

## Cause

This issue occurs because a user accidentally deleted the file, or a local application for the user who synchronized the library deleted the file. 

## Resolution

To identify the user who deleted the affected file, open the SharePoint Online or OneDrive recycle bin, and then check the **Deleted By** field for the affected file. The account that's listed in this field is for the user who performed the delete operation.

Try to determine whether the file was intentionally or accidentally deleted by the identified user. This information is important if multiple users are synchronizing a single library. For example, in some cases, a user might try to copy a file that might have been accidentally moved to another directory. This action removes the file from the synchronized library.

If the file wasn't intentionally or accidentally deleted by the **Deleted By** user, ask the user whether a local process might have moved or deleted the file. For example, local virus-protection software could be configured to quarantine files.

## More information

By design, any file that is syncing locally when it is deleted is moved to the local recycle bin.

If a folder is deleted from a locally synced SharePoint library, the OneDrive sync client processes this action as a standard file system deletion. The OneDrive sync client then syncs this change to the cloud (SharePoint/OneDrive). When other users who synced the same library receive this update, their devices also delete the folder locally. Therefore, the operating system moves the deleted folder into each user’s local recycle bin. The OneDrive client makes sure that the local folders and the cloud library are kept in sync. This process also applies to empty folders.
