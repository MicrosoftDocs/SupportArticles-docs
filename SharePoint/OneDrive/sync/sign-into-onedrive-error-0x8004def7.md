---
title: Error 0x8004def7 when signing in to OneDrive
description: Fixes an issue in which you can't sign in to OneDrive and you receive error code 0x8004def7.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 168011
  - CSSTroubleshoot
ms.reviewer: bpeterse
appliesto: 
  - Microsoft OneDrive
  - OneDrive for Business
search.appverid: 
  - MET150
ms.date: 12/17/2023
---

# Error 0x8004def7 when signing in to OneDrive

## Symptoms  

When you try to sign in to Microsoft OneDrive, you can't sign in, and you receive error code 0x8004def7.  

## Cause

This problem has the following possible causes:

- Your OneDrive storage exceeded its storage limit.
- Your account was suspended.
- The OneDrive sync app has configuration issues.  

## Resolution  

To resolve this problem, try the following methods. If one method doesn't work, try the next method.

- [Check your OneDrive storage](https://support.microsoft.com/office/manage-your-onedrive-storage-and-limits-989fce19-ade6-4e2f-81fb-941eabefee28) to determine how much space you've used. If you have exceeded or are getting close to the storage limit, [delete files or folders in OneDrive](https://support.microsoft.com/office/delete-files-or-folders-in-onedrive-21fe345a-e488-4fa7-932b-f053c1bebe8a) to free up space.  

- [Unlink and relink OneDrive](https://support.microsoft.com/office/unlink-and-re-link-onedrive-3c4680bf-cc36-4204-9ca5-e7b24cdd23ea#:~:text=How%20to%20reconfigure%20or%20move%20your%20OneDrive%20folder,any%20entries%20containing%20%E2%80%9COneDrive%20Cached%20Credentials%22.%20More%20items). This method can resolve existing OneDrive sync app configuration issues.  

- [Reset OneDrive](https://support.microsoft.com/office/reset-onedrive-34701e00-bf7b-42db-b960-84905399050c#:~:text=To%20reset%20the%20OneDrive%20desktop%20sync%20app%20in,then%20click%20on%20the%20OneDrive%20desktop%20app.%20). This method resets all OneDrive settings and sometimes resolves sync issues. OneDrive will run a full sync after the reset.  

- If you have a Skype, Xbox, Hotmail, or Outlook.com account, you also have a OneDrive account. Even if you access other Microsoft services, your OneDrive account will be frozen if you haven't accessed your OneDrive account in 12 months, or if you exceed your storage limit. To determine why your account is frozen and learn how to unfreeze your account, see [What does it mean when your OneDrive account is frozen?](https://support.microsoft.com/office/what-does-it-mean-when-your-onedrive-account-is-frozen-5e76147b-b7d5-4bcb-ba28-b91e3eb636b6)
