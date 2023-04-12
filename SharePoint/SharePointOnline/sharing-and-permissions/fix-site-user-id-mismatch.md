---
title: Fix site user ID mismatch in SharePoint or OneDrive
description: Describes common issues that are caused by a site user ID mismatch. Discusses how to use the Site User Mismatch Diagnostic to fix these issues.  
author: helenclu
ms.author: luche
manager: dcscontentpm
localization_priority: Normal
ms.date: 4/4/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 173318
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
appliesto: 
  - SharePoint Online
  - OneDrive for Business
ms.reviewer: prbalusu, salarson
---

# Fix site user ID mismatch in SharePoint or OneDrive

## Symptoms

When users in your organization try to access a OneDrive or SharePoint site by using a new account that shares a username with a previous account, users experience one or more of the following issues:

- An "Access denied" error message
- An inconsistent user experience
- A new OneDrive site that has a suffix appended to the expected URL (the suffix can be a number or a GUID, such as `https://contoso-my.sharepoint.com/personal/UserA_Contoso_com1`)

## Cause

These issues usually occur if an account is deleted from the Microsoft 365 admin center, and then a new account is created by using the user principal name (UPN) that was used by the deleted account but that has a different ID value. When users try to access a SharePoint site or their OneDrive, their new ID doesn't match the old ID that's added to the site permission list. Therefore, they can no longer access the site.

These issues might also occur during directory synchronization between an Active Directory organizational unit (OU) and SharePoint. If users have already logged in to SharePoint and are later moved to a different OU, they might experience these issues when the OU synchronizes with SharePoint.

## Resolution

To fix these issues, run the Site User Mismatch Diagnostic by using a Microsoft 365 administrator account.

> [!NOTE]
>
> - Microsoft 365 administrator can run diagnostics within the tenant to identify possible issues that affect user access.
> - This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.
> - When they fix the issues for OneDrive sites, administrators must make sure that the user account matches the site URL. Administrators are prohibited from connecting OneDrive sites that might have been previously owned by another user account.
> - If the diagnostic has successfully resolved an issue that's related to a OneDrive site, the changes might take approximately 24 hours to take effect. This period includes updating the OneDrive tile to point to the correct site and recycling any additional OneDrive sites.

Select the following **Run Tests** link. This command populates the diagnostic in the Microsoft 365 admin center. The diagnostic performs a large range of verifications for internal users and guests who try to access SharePoint and OneDrive sites.

> [!div class="nextstepaction"]
> [Run Tests: Site User ID Mismatch](https://aka.ms/PillarSiteUserIDMismatch)

### Common scenarios

The following sections describe in more detail what occurs when you use the Site User Mismatch Diagnostic to fix some common issues.

#### User ID mismatch for a SharePoint site

The diagnostic removes the mismatched ID.

To fix this issue, administrators can run the diagnostic, [manually remove the old user account from the UserInfo list](/sharepoint/remove-users#site-by-site-in-sharepoint), and then grant permissions to the new user account.

#### Access denied for a OneDrive site

The diagnostic reconnects the owner to the OneDrive site.

> [!NOTE]  
> When  administrators fix this issue, they must avoid taking any manual actions, such as updating the owners of the OneDrive site or editing the user profile properties that are associated with OneDrive.

#### A user is directed to a new OneDrive site that has a suffix appended to the expected URL

To fix this issue, administrators must run the diagnostic by specifying the following input parameters:

- The affected user account, such as UserA@contoso.com
- The original site URL, such as `https://contoso-my.sharepoint.com/personal/UserA_Contoso_com`

The diagnostic checks whether the user can be assigned ownership of the original site. If the diagnostic is successful, it offers to reconnect the user to their original site and recycle the current new active site such as `https://contoso-my.sharepoint.com/personal/UserA_Contoso_com1`. If the new site has to be recovered, administrators can [restore the deleted OneDrive](/sharepoint/restore-deleted-onedrive).

## More information

For more information about access issues in SharePoint and OneDrive, see ["Access Denied" or "You need permission" errors in SharePoint Online and OneDrive](../administration/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business.md).
