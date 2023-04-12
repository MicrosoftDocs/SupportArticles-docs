---
title: Access Denied or permission errors in SharePoint Online or OneDrive
description: Resolve access and permission errors, such as Access Denied, You need permission to access this site, User not found in the directory, or This link is not available to you.
ms.author: luche
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.date: 4/11/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 153997
  - CI 174347
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
ms.reviewer: salarson, prbalusu
appliesto: 
  - SharePoint Online
  - OneDrive for Business
---

# "Access Denied" or "You need permission" errors in SharePoint Online and OneDrive

## Symptoms

When users try to access a SharePoint Online or OneDrive for Business site, they receive one of the following error messages:

- Access Denied
- You need permission to access this site
- User not found in the directory

When users try to access links to files or folders that are shared by other users from SharePoint Online or OneDrive sites, they receive the following error message:

> This link is not available to you. Sorry, you are currently signed in as but that account is not on the list of people this is secured to. To try a different email please sign out and open the link again.

## Cause

These errors can occur for different reasons, such as:

- Permissions for the affected user aren't configured correctly.
- The account that's used to access the shared link is different from the account to which the sharing invitation was sent.
- [Site user ID mismatch](../sharing-and-permissions/fix-site-user-id-mismatch.md), which usually occurs when an account is deleted from the Microsoft 365 admin center and then a new account is created with the same user principal name (UPN) but with a different ID value. It also occurs during directory synchronization between an Active Directory organizational unit (OU) and SharePoint if users have already logged into SharePoint and are later moved to a different OU.

## Resolution option 1: Run the Check User Access diagnostic

> [!NOTE]
> This diagnostic isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Microsoft 365 administrators can run diagnostics within the tenant to identify possible issues with user access.

Select **Run Tests** below, which will populate the diagnostic in the Microsoft 365 admin center.

> [!div class="nextstepaction"]
> [Run Tests: Check SharePoint User Access](https://aka.ms/PillarCheckUserAccess)

The diagnostic performs a large range of verifications for internal users and guests who try to access SharePoint and OneDrive sites.

## Resolution option 2: Manual fix

To fix the access issues manually, follow the steps for the relevant scenario.

### A user can't access a SharePoint site or another user's OneDrive site

1. Determine the [permission level](/sharepoint/understanding-permission-levels) that the user should have on the site.
1. Verify the permission by using the **Check Permissions** feature:

   1. For a SharePoint site, select **Settings** :::image type="icon" source="./media/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business/settings-icon.png"::: > **Site permissions**. For a OneDrive site, select **Settings** :::image type="icon" source="./media/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business/settings-icon.png"::: > **Site Settings** > **Site permissions**.
   1. In the top ribbon, select **Check Permissions**.
   1. In the **User/Group** field, enter the user's name, and then select **Check Now**.
   1. Review the permissions that the user has on the site, and through which security group (if applicable).
1. If the user doesn't have appropriate permissions, grant the user permissions to the [file](https://support.office.com/article/1fe37332-0f9a-4719-970e-d2578da4941c) or [site](https://support.office.com/article/958771a8-d041-4eb8-b51c-afea2eae3658).
1. If the user continues to receive an error message, [remove the user from the site](/sharepoint/remove-users#site-by-site-in-sharepoint). Then grant the user permissions back to the file or site.

   **Note:** For a guest account, if there are still errors with the account, we recommend that you [remove the guest account from the Microsoft 365 admin center](/sharepoint/remove-users#delete-a-guest-from-the-microsoft-365-admin-center) completely. Make sure that [the user is removed from the site collection](/sharepoint/remove-users#site-by-site-in-sharepoint). Then grant the user permissions to the file or site again.  

### A user can't access their own OneDrive site

This issue is usually caused by site user ID mismatch. For more information, see [Fix site user ID mismatch issues in SharePoint or OneDrive](../sharing-and-permissions/fix-site-user-id-mismatch.md).

In this situation, check whether a new UPN exists. If it does, [delete the new UPN](/azure/active-directory/fundamentals/add-users-azure-active-directory#delete-a-user), and then [restore the original UPN](/azure/active-directory/fundamentals/active-directory-users-restore).

### A user can't access a shared link

[Remove the affected user from the site](/sharepoint/remove-users), and then share the file or folder again.
