---
title: Access Denied or You need permission errors in SharePoint Online and OneDrive
description: Resolve common access and permission errors.
ms.author: meerak
author: Cloud-Writer
manager: dcscontentpm
ms.date: 05/15/2025
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Permissions\Errors
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

# Access Denied or You need permission errors in SharePoint Online and OneDrive

## Symptoms

When users try to access a SharePoint Online or OneDrive for Business site, they receive one of the following error messages:

- Access Denied
- You need permission to access this site
- User not found in the directory

When users try to access links to files or folders that are shared by other users from SharePoint Online or OneDrive sites, they receive the following error message:

> This link is not available to you.  
> Sorry, you are currently signed in as but that account is not on the list of people this is secured to. To try a different email please sign out and open the link again.

## Cause

These errors can occur for various reasons, such as:

- Permissions for the affected user aren't configured correctly.
- The account that's used to access the shared link is different from the account to which the sharing invitation was sent.
- [Site user ID mismatch](../sharing-and-permissions/fix-site-user-id-mismatch.md). The ID mismatch usually occurs if a user account is deleted from the Microsoft 365 admin center, and then a new account is created by using the user principal name (UPN) that was used by the deleted account. The new account is assigned a new ID value even though the UPN is the same. The mismatch can also occur during directory synchronization between an Active Directory organizational unit (OU) and SharePoint if users are already logged in to SharePoint and later moved to a different OU.

## Resolution

Use one of the following options.

**Option 1**: Run the "Check User Access" diagnostic

> [!NOTE]
> This diagnostic isn't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

Microsoft 365 administrators can run diagnostics within the tenant to identify possible issues that affect user access.

Select the following **Run Tests** button, which populates the diagnostic in the Microsoft 365 admin center.

> [!div class="nextstepaction"]
> [Run Tests: Check SharePoint User Access](https://aka.ms/PillarCheckUserAccess)

The diagnostic performs a large range of verifications for internal users and guests who try to access SharePoint and OneDrive sites.

**Option 2**: Manual fix

To fix the access issues manually, follow the steps for the relevant scenario.

### A user can't access a SharePoint site or another user's OneDrive site

1. Determine the [permission level](/sharepoint/understanding-permission-levels) that the user should have on the site.
1. Verify the permission by using the **Check Permissions** feature:

   1. For a SharePoint site, select **Settings** :::image type="icon" source="./media/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business/settings-icon.png"::: > **Site permissions**. For a OneDrive site, select **Settings** :::image type="icon" source="./media/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business/settings-icon.png"::: > **Site Settings** > **Site permissions**.
   1. In the ribbon, select **Check Permissions**.
   1. In the **User/Group** field, enter the user's name, and then select **Check Now**.
   1. Review the permissions that the user has on the site, and also check the related security group (if applicable).
1. If the user doesn't have appropriate permissions, grant the user permissions to the [file](https://support.office.com/article/1fe37332-0f9a-4719-970e-d2578da4941c) or [site](https://support.office.com/article/958771a8-d041-4eb8-b51c-afea2eae3658).
1. If the user continues to receive an error message, [remove the user from the site](/sharepoint/remove-users#site-by-site-in-sharepoint). Then, grant to the user permissions to the file or site.

   **Note:** If errors continue to affect a guest account, we recommend that you [remove the guest account from the Microsoft 365 admin center](/sharepoint/remove-users#delete-a-guest-from-the-microsoft-365-admin-center) completely. Make sure that [the user is removed from the site collection](/sharepoint/remove-users#site-by-site-in-sharepoint). Then, grant to the user permissions to the file or site.  

### A user can't access their own OneDrive site

This issue usually occurs when there's a site user ID mismatch.

To fix the issue, check whether a new UPN exists. If it does, [delete the new UPN](/azure/active-directory/fundamentals/add-users-azure-active-directory#delete-a-user), and then [restore the original UPN](/azure/active-directory/fundamentals/active-directory-users-restore).

If you're not comfortable with using this procedure, see [Fix site user ID mismatch in SharePoint or OneDrive](../sharing-and-permissions/fix-site-user-id-mismatch.md) for an automated solution to fix the issue.

### A user can't access a shared link

[Remove the affected user from the site](/sharepoint/remove-users), and then share the file or folder again.
