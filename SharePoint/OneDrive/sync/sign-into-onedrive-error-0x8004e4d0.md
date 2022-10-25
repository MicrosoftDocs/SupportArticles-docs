---
title: Error 0x8004e4d0 when signing in to OneDrive 
description: Fixes an issue in which you can't sign in to OneDrive and you receive error code 0x8004e4d0.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 167187
ms.reviewer: salarson, prbalusu
appliesto: 
  - OneDrive for Business
search.appverid: MET150
ms.date: 9/28/2022
---
# Error 0x8004e4d0 when signing in to OneDrive

## Symptoms  

Users in your organization can't sign in to Microsoft OneDrive, and they receive the following error message:

> You don't have access to this service. For help, Contact your IT department. (Error Code: 0x8004e4d0).

## Cause  

This error might be caused by a permissions issue that affects the OneDrive site that's being synchronized.  

This issue most frequently occurs if a user account is deleted in the Microsoft 365 admin center or in Active Directory (in directory synchronization scenarios), and the account is then re-created by using the same user principal name (UPN) but a different ID value. When the user tries to access a site collection or OneDrive, the user has an incorrect ID.

A second scenario involves directory synchronization with an Active Directory organizational unit (OU). This issue might occur if a user has already signed in to SharePoint, and then is moved to a different OU and resynced with SharePoint.

## Resolution  

To fix this issue, [delete the newly created user](/azure/active-directory/fundamentals/add-users-azure-active-directory#delete-a-user) and [restore the original user](/azure/active-directory/fundamentals/active-directory-users-restore).

> [!NOTE]
> If you can't determine whether there is a site user ID mismatch, run the [Check User Access Diagnostic](/sharepoint/troubleshoot/administration/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business#resolution-option-1-run-the-check-user-access-diagnostic) to verify.

If you can't restore the original user and the issue persists, follow these steps to create a support request:

1. As an administrator, select [OneDrive Site User ID Mismatch](https://aka.ms/PillarOneDriveIDMismatch) to populate a help query in the [Microsoft 365 admin center](https://go.microsoft.com/fwlink/p/?linkid=2024339).
2. At the bottom of the pane, select **Contact Support** > **New Service Request**.  
3. Leave the description blank.
4. After the ticket is opened, gather the UPN and OneDrive URL that have the issue, and provide them to the support agent.
