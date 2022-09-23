---
title: Error 0x8004e4d0 when signing in to OneDrive 
description: Fixes an issue in which you can't sign in to OneDrive with the error code 0x8004e4d0.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 167187
ms.reviewer: salarson
appliesto: 
  - OneDrive for Business
search.appverid: MET150
ms.date: 9/23/2022
---
# Error 0x8004e4d0 when signing in to OneDrive  

## Symptoms  

Users in your organization can't sign in to Microsoft OneDrive and receive the following error message:

> You don't have access to this service. For help, Contact your IT department. (Error Code: 0x8004e4d0).

## Cause  

This error may be caused by a permission issue with the OneDrive site that's being synchronized.  

This issue most frequently occurs when a user is deleted and the account is then re-created with the same user name. The account in the Microsoft 365 admin center or Active Directory (in directory synchronization scenarios) is deleted and re-created with the same user principal name (UPN). The new account is created by using a different ID value. When the user tries to access a site collection or OneDrive, the user has an incorrect ID. A second scenario involves directory synchronization with an Active Directory organizational unit (OU). If users have already signed in to SharePoint, and then are moved to a different OU and resynced with SharePoint, they may experience this problem.

## Resolution  

To fix this issue, [delete the newly created user](/azure/active-directory/fundamentals/add-users-azure-active-directory#delete-a-user) and [restore the original user](/azure/active-directory/fundamentals/active-directory-users-restore).

> [!NOTE]
> If you can't determine whether there is a site user ID mismatch, run the [Check User Access Diagnostic](/sharepoint/troubleshoot/administration/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business#resolution-option-1-run-the-check-user-access-diagnostic) to verify.

If you can't restore the original user and the issue persists, follow these steps to create a support request:

1. As an administrator, select [OneDrive Site User ID Mismatch](https://admin.microsoft.com/AdminPortal/?searchSolutions=OneDrive%20Site%20User%20ID%20Mismatch), and it'll populate a help query in the [Microsoft 365 admin center](https://go.microsoft.com/fwlink/p/?linkid=2024339).
2. At the bottom of the pane, select **Contact Support** > **New Service Request**.  
3. Leave the description blank.
4. After the ticket is opened, provide the support agent with the UPN and OneDrive URL that have the issue.
