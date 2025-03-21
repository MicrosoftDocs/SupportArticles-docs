---
title: You can't edit your files because your license to use OneDrive ended over a couple of months ago
description: Resolves an error that occurs when a unlicensed user account tries to access their OneDrive for work or school site.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OneDrive for Business\OneDrive Site
  - CI 4479
  - CSSTroubleshoot
ms.reviewer: salarson
appliesto: 
  - OneDrive for work or school
search.appverid: MET150
ms.date: 03/21/2025
---
# Error "You can't edit your files because your license to use OneDrive ended over a couple of months ago"

## Symptoms

When a user in your organization tries to access their OneDrive for work or school site, they receive the following error message:

> You can't edit your files because your license to use OneDrive ended over a month ago.

As a result, they can't edit or upload files to the site.

## Cause

This issue is caused by [enforcement of policy changes for unlicensed OneDrive accounts](/SharePoint/unlicensed-onedrive-accounts), which begins on January 27, 2025.

The following user accounts are considered unlicensed:

- The license that's assigned to the user doesn't include OneDrive.
- The OneDrive license that's assigned to the user has expired.

## Resolution

To resolve these issues, follow these steps:

1. Make sure that the user is assigned a valid license that includes [OneDrive](/office365/servicedescriptions/onedrive-for-business-service-description#available-plans).

   1. In the [Microsoft 365 admin center](https://go.microsoft.com/fwlink/p/?linkid=2024339), go to **Users** > **Active users**.
   1. Select the affected user account.
   1. In the detail pane, select **Licenses and apps**.
   1. Expand the **Licenses** section, check whether a valid license that includes OneDrive is assigned. If not, [assign](/microsoft-365/admin/manage/assign-licenses-to-users?view=o365-worldwide#use-the-active-users-page-to-assign-or-unassign-licenses&preserve-view=true) the required license to the user.

      > [!NOTE]
      > Changes may take up to 24 hours to take effect if the user account isn't archived, and up to 48 hours to take effect if the account is archived.
2. If the issue persists, make sure that the user is assigned as the primary site collection administrator of their OneDrive site. Use one of the following methods with an account that's assigned the SharePoint Administrator role.

   > [!IMPORTANT]
   > A user must be the Primary Site Collection Administrator of their OneDrive site, not a secondary owner or site collection administrator. If the primary owner is set to someone else, issues may still occur. Don't remove a user as the admin of their own OneDrive, as doing so can break many user experiences. 

   ### Method 1: Use the SharePoint admin center

   1. In the [SharePoint admin center](https://go.microsoft.com/fwlink/?linkid=2185219), select **More Features**.
   1. Under **User Profiles**, select **Open**.
   1. Under **People**, select **Manage User Profiles**.
   1. In the **Find profiles** search box, enter the affected user account, and select **Find**.
   1. Right-click the user and select **Manage site collection owners**.
   1. In the **Primary Site Collection Administrator** section, check whether the user account is displayed. If not, add the user account, and then select **OK**.

   ### Method 2: Use SharePoint Online Management Shell

   If you have the [SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online) installed, follow these steps:

   1. Run the following command to connect to the SharePoint Online Administration Center:

      ```powershell
      Connect-SPOService -Url https://<tenant name>-admin.sharepoint.com
      ```

     When you're prompted with the **Microsoft SharePoint Online Management Shell** dialog box, enter the account name and password for a SharePoint administrator account, and then select **Sign in**.
   1. Run the following command to retrieve the primary site collection administrator of the affected user's OneDrive site:

     ```powershell
     (Get-SPOSite -Identity <the user's OneDrive site URL>).Owner
     ```

     Typically, the URL for a user's OneDrive site is in the following format:

     `https://<tenant name>-my.sharepoint.com/personal/<user principal name>`
   1.If the affected user isn't the primary site collection administrator, run the following command to assign the user as the primary site collection administrator:

     ```powershell
     Set-SPOUser -Site <the user's OneDrive site URL> -LoginName <user name> -IsSiteCollectionAdmin $true
     ```
