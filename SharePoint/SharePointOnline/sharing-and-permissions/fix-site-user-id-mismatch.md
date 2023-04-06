---
title: Fix site user ID mismatch issues in SharePoint or OneDrive
description: Describes common issues that are caused by site user ID mismatch and how to use the Site User Mismatch Diagnostic to fix these issues.  
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

# Fix site user ID mismatch issues in SharePoint or OneDrive

## Symptoms

When users in your organization try to access a OneDrive or SharePoint site by using a new account that shares the same username as a previous account, they experience one or more of the following issues:

- An "Access denied" error message
- An inconsistent user experience
- A new OneDrive site with a suffix appended to the end of the expected URL. The suffix can be a number, or a GUID. For example, `https://contoso-my.sharepoint.com/personal/UserA_Contoso_com1`.

## Cause

These issues usually occur when an account is deleted from the Microsoft 365 admin center and then a new account is created with the same user principal name (UPN) but with a different ID value. When the users try to access a SharePoint site or their OneDrive, their new ID doesn't match the old ID that's added to the site permission list. Therefore, they can no longer access the site.

These issues may also occur during directory synchronization between an Active Directory organizational unit (OU) and SharePoint. If users have already logged into SharePoint and are later moved to a different OU, they may experience the issues when the OU synchronizes with SharePoint.

## Resolution

To fix these issues, run the Site User Mismatch Diagnostic by using a Microsoft 365 administrator account.

> [!NOTE]
>
> - Microsoft 365 admin users have access to diagnostics that can be run within the tenant to verify possible issues with user access.
> - This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.
  
Select Run Tests below, which will populate the diagnostic in the Microsoft 365 admin center. The diagnostic performs a large range of verifications for internal users or guests who try to access SharePoint and OneDrive sites.

> [!div class="nextstepaction"]
> [Run Tests: Site User ID Mismatch](https://aka.ms/PillarSiteUserIDMismatch)

### Common scenarios

Here are more details when you use the Site User Mismatch Diagnostic to fix some common scenarios.

#### User ID mismatch for a SharePoint site

The diagnostic removes the mismatched ID.

To fix the issue, besides running the diagnostic, administrators can also [manually remove the old user account from the UserInfo list](/sharepoint/remove-users#site-by-site-in-sharepoint) and then grant the permissions to the new user account.

#### Access denied issue for a OneDrive site

The diagnostic reconnects the owner to the OneDrive site.

> [!NOTE]
>
> - When fixing the issue, administrators must avoid taking any manual actions, such as updating the owners of the OneDrive site or editing the user profile properties that are associated with OneDrive.
> - Make sure that the user account matches the site URL. Administrators are prohibited from connecting sites that may have been previously owned by another user account.

#### A user is directed to a new OneDrive site with a suffix appended to the end of the expected URL

To fix the issue, administrators must run the diagnostic with the following input parameters:

- The affected user account, such as UserA@contoso.com
- The original site URL, such as `https://contoso-my.sharepoint.com/personal/UserA_Contoso_com`

The diagnostic verifies whether the user can be assigned ownership of the original site. If the verification is successful, it'll offer to reconnect the user to their original site and recycle the current new active site such as `https://contoso-my.sharepoint.com/personal/UserA_Contoso_com1`. If the new site needs to be recovered, administrators can [Restore the deleted OneDrive](/sharepoint/restore-deleted-onedrive).

## More information

For more information about access issues in SharePoint and OneDrive, see ["Access Denied" or "You need permission to access this site" errors in SharePoint Online and OneDrive for Business](/sharepoint/troubleshoot/administration/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business).
