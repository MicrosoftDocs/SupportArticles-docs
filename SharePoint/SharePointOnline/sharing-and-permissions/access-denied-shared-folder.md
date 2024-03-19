---
title: Access Denied error when accessing a shared folder
description: Describes issues that occur when users try to access a shared folder on a SharePoint or OneDrive site that has Limited-access user permission lockdown mode enabled.   
author: helenclu
ms.author: luche
manager: dcscontentpm
localization_priority: Normal
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Permissions\Errors
  - CSSTroubleshoot
  - CI 174348
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
appliesto: 
  - SharePoint Online
  - OneDrive for Business
ms.reviewer: prbalusu, salarson
---

# "Access Denied" error when trying to access a shared folder

## Symptoms

Consider the following scenario:

- You have a SharePoint or OneDrive site.
- The site has the **Limited-access user permission lockdown mode** site collection feature activated. 
- You share a specific folder with another user.
- The other user tries to access the shared folder.

In this scanario, the other user receives one of the following error messages:

- Access Denied
- You need permission to access this resource

## Cause

When you share a folder with a user who can't access the parent folder or site, SharePoint assigns the user [Limited Access](/sharepoint/understanding-permission-levels#default-permission-levels) to the parent items. Specifically, SharePoint allows the user to access the folder without obtaining permission to access the parent folder and other items (other than limited access). However, when **Limited-access user permission lockdown mode** is enabled, the user doesn't have access to the folder because the necessary limited access permission on other items no longer works correctly.

## Workaround

To work around this issue, use one of the following options, as appropriate for your situation:

- Share individual files but not folders.
- Share a whole site collection or subsite.
- If your site doesn't require **Limited-access user permission lockdown mode**, [disable this site collection feature](https://support.microsoft.com/office/enable-or-disable-site-collection-features-a2f2a5c2-093d-4897-8b7f-37f86d83df04).

  **Note:** Other features, such as publishing, might require this feature to work correctly.
