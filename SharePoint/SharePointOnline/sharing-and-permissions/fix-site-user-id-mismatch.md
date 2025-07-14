---
title: Fix site user ID mismatch in SharePoint or OneDrive
description: Provides a diagnostic that offers resolutions for common issues caused by a site user ID mismatch. 
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
ms.date: 08/09/2024
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Permissions\Errors
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
- A new OneDrive site that has a suffix appended to the expected URL such as `https://contoso-my.sharepoint.com/personal/UserA_Contoso_com1` (the suffix can be a number or a GUID)

## Cause

These issues usually occur if a user account is deleted from the Microsoft 365 admin center, and then a new account is created by using the user principal name (UPN) that was used by the deleted account. The new account is assigned a new ID value even though the UPN is the same. However, the UserInfo list for the SharePoint and OneDrive sites that's associated with the account has only the old ID. When users try to access a SharePoint site or their OneDrive site by using their new account, their new ID doesn't match the ID that's in the UserInfo list. Therefore, they're denied access to the site.

These issues might also occur during directory synchronization between an Active Directory organizational unit (OU) and SharePoint. If users have already logged in to SharePoint and are later moved to a different OU, they might experience these issues when the OU synchronizes with SharePoint.

## Resolution

To fix these issues, run the Site User Mismatch diagnostic by using a SharePoint administrator account.

> [!NOTE]
>
> - This diagnostic isn't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.
> - Before admins run the diagnostic to fix the issues for OneDrive sites, they must make sure that the UserName of the new user account matches the old account. Administrators are prohibited from connecting OneDrive sites that might have been owned previously by another user account. 
> - If the diagnostic has successfully resolved an issue that's related to a OneDrive site, the changes might take approximately 24 hours to occur. This period includes updating the OneDrive tile to point to the correct site and recycling any additional OneDrive sites.

Select the following **Run Tests** button to populate the diagnostic in the Microsoft 365 admin center. The diagnostic performs a large range of validations for internal users and guests who try to access SharePoint and OneDrive sites.

When prompted, provide the following information:

- The affected user account, such as UserA@contoso.com
- The original site URL, such as `https://contoso-my.sharepoint.com/personal/UserA_Contoso_com`

> [!div class="nextstepaction"]
> [Run Tests: Site User ID Mismatch](https://aka.ms/PillarSiteUserIDMismatch)

To get the original OneDrive site URL, follow these steps:

1. Sign in to the OneDrive site by using an administrator account.
1. Select the **Settings** (gear) icon in the upper-right corner.
1. Select **OneDrive Settings**, and then select **More Settings**.
1. From the **Diagnostic Information** section, copy the OneDrive Web URL.

To retrieve multiple OneDrive URLs, use one of the methods in [View OneDrive URLs for users in your organization](/sharepoint/list-onedrive-urls).

### Common scenarios

The Site User Mismatch diagnostic can fix the following common issues that can occur when a new account is created by using the UPN that was used by a deleted account.

#### A user is directed to a new OneDrive site that has a suffix appended to the expected URL

When a new user account is created, a new OneDrive site is assigned to it. When a user account is deleted, the OneDrive site assigned to the account is not deleted right away. So if a new user account is created by using the UPN of a deleted account, the new OneDrive site that's assigned to the new account has the same URL as the old OneDrive site together with an added suffix. This suffix is either a number or a GUID.

If you want the new user account to use the same OneDrive site that was assigned to the old account, the diagnostic will check whether the user can be assigned ownership of the original site. After successfully verifying the user's permissions, the diagnostic will offer to reconnect the user to their original site and recycle the new active site that has the suffix such as `https://contoso-my.sharepoint.com/personal/UserA_Contoso_com1`.

If you have to access content in the new OneDrive site at a later time, you can [restore the deleted OneDrive](/sharepoint/restore-deleted-onedrive).

#### Access denied to a OneDrive site

If a user is denied access to their old OneDrive site after a new account is created for them, the diagnostic will reconfigure the user's profile. Then it will reconnect the user to their old OneDrive site to fix the access issue.

> [!NOTE]  
> Administrators can't fix this issue by manually updating the owners of the OneDrive site or editing the user profile properties that are associated with the OneDrive site. The diagnostic is the only recommended solution to fix this issue.

#### User ID mismatch on SharePoint sites or OneDrive sites that don't belong to the user

When the diagnostic detects a user ID mismatch in the UserInfo list, it will offer to remove the old ID. After you accept the offer and the old ID is removed, assign the new user account the appropriate permissions to the SharePoint site.

**Note**: If you want to fix this issue manually, you must [remove the old user account from the UserInfo list](/sharepoint/remove-users#site-by-site-in-sharepoint), and then grant permissions to the new user account.

## More information

For more information about access issues in SharePoint and OneDrive, see ["Access Denied" or "You need permission" errors in SharePoint Online and OneDrive](../administration/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business.md).
