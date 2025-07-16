---
title: Error 0x8004e4d0 when signing in to OneDrive 
description: Fixes an issue in which you can't sign in to OneDrive and you receive error code 0x8004e4d0.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 167187
ms.reviewer: salarson, prbalusu
appliesto: 
  - OneDrive for Business
search.appverid: MET150
ms.date: 12/17/2023
---
# Error 0x8004e4d0 when signing in to OneDrive

## Symptoms  

Users in your organization can't sign in to Microsoft OneDrive, and they receive the following error message:

> You don't have access to this service. For help, Contact your IT department. (Error Code: 0x8004e4d0).

## Cause  

This issue is usually caused by a site user ID mismatch. 

This issue most frequently occurs if a user account is deleted in the Microsoft 365 admin center or in Active Directory (in directory synchronization scenarios), and the account is then re-created by using the same user principal name (UPN) but a different ID value. When the user tries to access a site collection or OneDrive, the user has an incorrect ID.

A second scenario involves directory synchronization with an Active Directory organizational unit (OU). This issue might occur if a user has already signed in to SharePoint, and then is moved to a different OU and resynced with SharePoint.

## Resolution  

To fix the issue, check whether a new UPN exists. If it does, [delete the new UPN](/azure/active-directory/fundamentals/add-users-azure-active-directory#delete-a-user), and then [restore the original UPN](/azure/active-directory/fundamentals/active-directory-users-restore).

If you're not comfortable with using this procedure, see [Fix site user ID mismatch in SharePoint or OneDrive](/sharepoint/troubleshoot/sharing-and-permissions/fix-site-user-id-mismatch) for an automated solution to fix the issue. 
