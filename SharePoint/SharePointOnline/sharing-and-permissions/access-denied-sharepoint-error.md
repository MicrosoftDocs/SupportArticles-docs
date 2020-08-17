---
title: SharePoint Online or OneDrive for Business access denied error message 
ms.author: v-todmc
author: McCoyBot
manager: dcscontentpm
localization_priority: Normal
ms.date: 8/5/2020
ms.audience: Admin
ms.topic: article
ms.service: sharepoint-online
ms.custom: CSSTroubleshoot
search.appverid:
- SPO160
- MET150
ms.assetid: 
description: Outlines resolutions to error messages received when using SharePoint Online or OneDrive for Business such as Access Denied, You need permission to access this site and User not found in directory errors.
appliesto:
- SharePoint Online
- OneDrive for Business
---

# Error message when trying to access SharePoint Online or OneDrive for Business

## Symptoms

When accessing SharePoint Online or OneDrive for Business, you receive one of the following error messages:

- Access Denied
- You need permission to access this site
- User not found in the directory

## Cause

There are many scenarios which can prompt one of these messages. The most frequent cause is that permissions for the user or administrator are configured incorrectly or not configured at all. 

## Resolution
Follow the steps below depending on which area you are receiving the error:

[When accessing a SharePoint site](#when-accessing-a-sharepoint-site)

[When accessing a OneDrive site ](#when-accessing-a-onedrive-site)

### When accessing a SharePoint site

1. Determine what <a href="https://docs.microsoft.com/sharepoint/understanding-permission-levels" target="_blank">permission level</a> the user should have to the site (member, owner, etc.) and verify the permission via the **Check Permissions** feature.

   1. To use the **Check Permissions** feature, navigate to the User.aspx page by selecting the gear icon in the upper right corner, then **Site Permissions**. In the flyout, select **Advanced permissions settings**.

      For example, the full URL will resemble the following: `https://contoso.sharepoint.com/_layouts/15/user.aspx`
   1. In the top ribbon, choose **Check Permissions**.
   1. In the **User/Group** field, type the user's name and select **Check Now**.
   1. The type of permissions the user has on a site and which security group it is derived from (if applicable) will be displayed.

1. If the user does not have appropriate permissions, grant them permissions to the <a href="https://support.office.com/en-us/article/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c" target="_blank">file</a> or <a href="https://support.office.com/en-us/article/share-a-site-958771a8-d041-4eb8-b51c-afea2eae3658?ui=en-US&rs=en-US&ad=US" target="_blank">site</a>.
1. If the user continues to receive an error message, remove them from the site using the following steps:

   > [!NOTE]
   > This option is available only if the user previously browsed to the site collection. They won't be listed if they were granted access but never visited the site.

   1. Browse to the site and edit the URL by adding the following string to the end of it: `/_layouts/15/people.aspx?MembershipGroupId=0`

      For example, the full URL will resemble the following: `https://contoso.sharepoint.com/_layouts/15/people.aspx/membershipGroupId=0`
   1. Select the person from the list, and then on the **Actions** menu, select **Delete Users from Site Collection**.
   1. Grant the user permissions back to the <a href="https://support.office.com/en-us/article/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c" target="_blank">file</a> or <a href="https://support.office.com/en-us/article/share-a-site-958771a8-d041-4eb8-b51c-afea2eae3658?ui=en-US&rs=en-US&ad=US" target="_blank">site</a>.

### When accessing a OneDrive site 

- **If the user is the owner of the OneDrive site:**
  - This issue most frequently occurs when a user is deleted and re-created with the same user principal name (UPN). The new account is created by using a different Passport Unique ID (PUID) value. When the user tries to access a site collection or their OneDrive, the user has an incorrect PUID. A second scenario involves directory synchronization with an Active Directory organizational unit (OU). If users have already signed into SharePoint, are moved to a different OU that is not currently synchronized with Office365 and then resynced with SharePoint, they may experience this problem.
    - To resolve this issue, you will need to delete the new UPN (if it exists) and restore the original UPN.
      - To delete the new UPN, follow the steps in [this article](https://docs.microsoft.com/azure/active-directory/fundamentals/add-users-azure-active-directory#delete-a-user).
      - Once the new user has been deleted, you can restore the original user using [these steps](https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-users-restore).

    - If you cannot restore the original user and are still in this state,  create a support request using the following steps:
      - Navigate to <a href="https://admin.microsoft.com" target="_blank">https://admin.microsoft.com</a>.
      - In the left navigation pane, select **Support** and then **New Service Request**. This will activate the **Need Help?** pane on the right-hand side of your screen.
      - In the **Briefly describe your issue** area, enter **"PUID Mismatch on OneDrive Site"**.
      - Select **Contact Support**.

        > [!NOTE]
        > If you are using the old M365 admin center, you can skip the "Description" step listed below as that field will not exist.

      - Under **Description** enter **"PUID Mismatch on OneDrive Site"**. Fill out the remaining information and select **Contact me**.
      - Once the ticket has been opened please provide the support agent with the UPN and OneDrive URL that is having the issue.

- **If the user is attempting to access another user's OneDrive site:**

  - Determine what <a href="https://docs.microsoft.com/sharepoint/understanding-permission-levels" target="_blank">permission level</a> the user should have to the site (member, owner, etc.) and then verify the permissions via the **Check Permissions** feature.
    - To use the **Check Permissions** feature, navigate to the User.aspx. For example, the full URL will resemble the following: `https://contoso-my.sharepoint.com/personal/admin_contoso_onmicrosoft_com/_layouts/15/user.aspx`.
    - In the top ribbon, choose **Check Permissions**.
    - In the **User/Group** field, type the user's name and select **Check Now**.
    - The kind of permissions that the user has on a site and which security group it is derived from (if applicable) will be displayed.

   - If the user does not have appropriate permissions, grant them permissions to the <a href="https://support.office.com/en-us/article/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c" target="_blank">file</a> or <a href="https://support.office.com/en-us/article/share-a-site-958771a8-d041-4eb8-b51c-afea2eae3658?ui=en-US&rs=en-US&ad=US" target="_blank">site</a>.
   - If the user continues to receive an error message, remove them from the site using the following steps:<br/>

     >[!NOTE] 
     >This option is available only if the user previously browsed to the site collection. They won't be listed if they were granted access but never visited the site.
     - Browse to the site and edit the URL by adding the following string to the end of it: `/_layouts/15/people.aspx?MembershipGroupId=0`<br/>
For example, the full URL will resemble the following: `https://contoso-my.sharepoint.com/personal/admin_contoso_onmicrosoft_com/_layouts/15/people.aspx/membershipGroupId=0`
     - Select the person from the list, and then on the **Actions** menu, select **Delete Users from Site Collection**. 
     - Grant the user permissions back to the <a href="https://support.office.com/en-us/article/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c" target="_blank">file</a> or <a href="https://support.office.com/en-us/article/share-a-site-958771a8-d041-4eb8-b51c-afea2eae3658?ui=en-US&rs=en-US&ad=US" target="_blank">site</a>.

## More information

For more information about permission levels in SharePoint Online, go to [Understanding permission levels](https://support.office.com/article/understanding-permission-levels-in-sharepoint-87ecbb0e-6550-491a-8826-c075e4859848?ocmsassetID=HA102772294&CorrelationId=8cb2ee53-10d3-48ec-baee-588885e94ba3&ui=en-US&rs=en-US&ad=US).

For more information about "Access Denied" errors in SharePoint or OneDrive for Business, see the following articles: 

- [Error message when an external user tries to access SharePoint Online or OneDrive for Business](error-when-external-user-tries-to-access-sharepoint-onedrive.md)
- [Access Denied error when trying to approve a SharePoint Approval Workflow task](approval-workflow-access-denied-error.md)
- [Access Denied error when trying to access a shared folder or "Access Requests" list](access-requests-list-error-access-denied.md)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
