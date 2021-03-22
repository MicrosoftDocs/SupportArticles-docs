---
title: SharePoint Online or OneDrive for Business access denied error message 
ms.author: luche
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.date: 8/5/2020
audience: Admin
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

# Error when trying to access SharePoint Online or OneDrive for Business

## Symptoms

When users try to access SharePoint Online or OneDrive for Business, they receive one of the following error messages:

- Access Denied
- You need permission to access this site
- User not found in the directory

## Cause

Many scenarios can generate these error messages. The most frequent cause is that permissions for the user or administrator are configured incorrectly or not configured at all. 

## Resolution

Use the appropriate method for the [SharePoint](#accessing-a-sharepoint-site) or [OneDrive](#accessing-a-onedrive-site) site on which the user receives the error message.

### Accessing a SharePoint site

1. Determine which <a href="/sharepoint/understanding-permission-levels" target="_blank">permission level</a> (member, owner, and so on) the user should have to the site. Then, verify the permissions through the **Check Permissions** feature, as follows:

   1. Navigate to the User.aspx page. To do this, select the gear icon in the upper-right corner, select **Site Permissions**, and then select **Advanced permissions settings**.

        For example, the full URL will resemble the following: `https://contoso.sharepoint.com/_layouts/15/user.aspx`

    2.	On the ribbon, select **Check Permissions**.
    3.	In the **User** or **Group** field, type the user's name, and then select **Check Now**.

        > [!NOTE]
        > This command displays the type of permissions that the user has on a site and which security group is the permissions are derived from (if applicable).
2.	If the user does not have appropriate permissions, grant the permissions to the <a href="https://support.office.com/article/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c" target="_blank">file</a> or <a href="https://support.office.com/article/share-a-site-958771a8-d041-4eb8-b51c-afea2eae3658?ui=en-US&rs=en-US&ad=US" target="_blank">site</a> for the user.
3. If the user continues to receive an error message, remove the user from the site by using the following steps.

   > [!NOTE]
   > This option is available only if the user previously browsed to the site collection. Users are not listed if they are granted access but never visit the site.

   1. Browse to the site, and edit the URL by adding the following string to the end of it: `/_layouts/15/people.aspx?MembershipGroupId=0`

      For example, the full URL resembles the following: `https://contoso.sharepoint.com/_layouts/15/people.aspx/membershipGroupId=0`
   1. On the list, select the user, open the Actions menu, and then select **Delete Users from Site Collection**.
   1. Grant the permissions to the <a href="https://support.office.com/en-us/article/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c" target="_blank">file</a> or <a href="https://support.office.com/en-us/article/share-a-site-958771a8-d041-4eb8-b51c-afea2eae3658?ui=en-US&rs=en-US&ad=US" target="_blank">site for the user</a>.

### Accessing a OneDrive site 

- **If the user is the owner of the OneDrive site**

    This issue most frequently occurs if a user is deleted and re-created by having the same user principal name (UPN). The new account is created by using a different Passport Unique ID (PUID) value. When the user tries to access a site collection or their OneDrive site, the user has an incorrect PUID. A second scenario involves directory synchronization with an Active Directory organizational unit (OU). Users may experience this issue if they have already signed in to SharePoint, are moved to a different OU that is not currently synchronized with Office365, and are then resynced with SharePoint.

    1.	To resolve this issue, delete the new UPN (if it exists), and restore the original UPN.

        1. To delete the new UPN, follow the steps in  [Add or delete users using Azure Active Directory](/azure/active-directory/fundamentals/add-users-azure-active-directory#delete-a-user).
        2. After the new user is deleted, restore the original user by following the steps in [Restore or remove a recently deleted user using Azure Active Directory](/azure/active-directory/fundamentals/active-directory-users-restore).

    2. If you cannot restore the original user, and the issue persists, create a support request, as follows:
    
       1. Navigate to <a href="https://admin.microsoft.com" target="_blank">https://admin.microsoft.com</a>.
       2. In the navigation pane, select **Support** > **New Service Request**.
          > [!NOTE]
          > This activates the **Need Help?** pane on the right side of the screen.

        3. In the **Briefly describe your issue** area, enter **PUID Mismatch on OneDrive Site**.
        4. Select **Contact Support**.

           > [!NOTE]
           > If you are using the old M365 admin center, you can skip the next step because the **Description** field will not exist.

        5. In the **Description** field, enter **PUID Mismatch on OneDrive Site**. 
        6. Complete the remaining information, and then select **Contact me**.
        7. After the ticket is opened, provide for the support agent the UPN and OneDrive URL that is experiencing the issue.

- **If the user is trying to access another user's OneDrive site**

  1. Determine which <a href="/sharepoint/understanding-permission-levels" target="_blank">permission level</a> (member, owner, and so on) the user should have to the site. Then, verify the permissions through the Check Permissions feature, as follows:
  
     1. Navigate to the User.aspx page. For example, the full URL will resemble the following: 
     
          `https://contoso-my.sharepoint.com/personal/admin_contoso_onmicrosoft_com/_layouts/15/user.aspx`.

      2. On the ribbon, select **Check Permissions**.
      3. In the **User** or **Group** field, type the user's name, and then select **Check Now**.

          > [!NOTE]
          > This command displays the type of permissions that the user has on a site and which security group the permissions are derived from (if applicable).
    2.	If the user does not have appropriate permissions, grant the permissions to the 
 <a href="https://support.office.com/en-us/article/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c" target="_blank">file</a> or <a href="https://support.office.com/en-us/article/share-a-site-958771a8-d041-4eb8-b51c-afea2eae3658?ui=en-US&rs=en-US&ad=US" target="_blank">site for the usre</a>.

    3. If the user continues to receive an error message, remove the user from the site by using the following steps.<br/>

        > [!NOTE] 
        > This option is available only if the user previously browsed to the site collection. Users are not listed if they are granted access but never visit the site.
        
        1.	Browse to the site, and edit the URL by adding the following string to the end of it:

            ` /_layouts/15/people.aspx?MembershipGroupId=0`

            For example, the full URL will resemble the following: 

            `https://contoso-my.sharepoint.com/personal/admin_contoso_onmicrosoft_com/_layouts/15/people.aspx/membershipGroupId=0`

        2. On the list, select the user, open the **Actions** menu, and then select **Delete Users from Site Collection**.
        3. Grant the permissions to the 
 <a href="https://support.office.com/en-us/article/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c" target="_blank">file</a> or <a href="https://support.office.com/en-us/article/share-a-site-958771a8-d041-4eb8-b51c-afea2eae3658?ui=en-US&rs=en-US&ad=US" target="_blank">site for the user</a>.

## More information

For more information about permission levels in SharePoint Online, see [Understanding permission levels](https://support.office.com/article/understanding-permission-levels-in-sharepoint-87ecbb0e-6550-491a-8826-c075e4859848?ocmsassetID=HA102772294&CorrelationId=8cb2ee53-10d3-48ec-baee-588885e94ba3&ui=en-US&rs=en-US&ad=US).

For more information about "Access Denied" errors in SharePoint or OneDrive for Business, see the following articles: 

- [Error when an external user tries to access SharePoint Online or OneDrive for Business](error-when-external-user-tries-to-access-sharepoint-onedrive.md)
- [Error when trying to approve a SharePoint Approval Workflow task](approval-workflow-access-denied-error.md)
- [Error when trying to access a shared folder or "Access Requests" list](access-requests-list-error-access-denied.md)
- [Users can't access a shared folder in SharePoint Online](cannot-access-shared-folder.md)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).