---
title: Error message when an external user tries to access SharePoint Online or OneDrive for Business
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
description: Describes a resolution to an issue where an external user is denied access to a SharePoint or OneDrive for Business site, or when an external user accepts an invitation by using another account. 
appliesto:
- SharePoint Online
- OneDrive for Business
---

# Access Denied error when an external user tries to access SharePoint Online or OneDrive for Business 

## Symptoms

When you try to access SharePoint Online or OneDrive for Business as an external user, you receive one of the following error messages:

- Access Denied
- You need permission to access this site
- User not found in the directory

## Cause
There are many scenarios which can prompt one of these messages. The most frequent cause is that permissions for the user or administrator are configured incorrectly or not configured at all. 

## Resolution

Follow the steps below depending on which area you are receiving the error:

[When an external user is accessing a site](#if-an-external-user-is-accessing-a-site)

[When an external user accepts a SharePoint Online invitation by using another account](#when-an-external-user-accepts-a-sharepoint-online-invitation-by-using-another-account)

### If an external user is accessing a site

1. Determine what <a href="https://docs.microsoft.com/sharepoint/understanding-permission-levels" target="_blank">permission level</a> the user should have to the site (member, owner, etc.) and verify the permission via the **Check Permissions** feature. 
   1. To use the **Check Permissions** feature, navigate to the User.aspx page by selecting the gear icon in the upper right corner and then **Site Settings**  Under **Users and Permissions**, select **Site Permissions**. <br/>
For example, the full URL will resemble the following: `https://contoso.sharepoint.com/_layouts/15/user.aspx`
   1. In the top ribbon, choose **Check Permissions**.
   1. In the **User/Group** field, type the user's name and select **Check Now**.
   1. You will now see what kind of permissions the user has on a site and via which security group (if applicable).
1. If the user does not have appropriate permissions, grant them permissions to the <a href="https://support.office.com/en-us/article/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c" target="_blank">file</a> or <a href="https://support.office.com/en-us/article/share-a-site-958771a8-d041-4eb8-b51c-afea2eae3658?ui=en-US&rs=en-US&ad=US" target="_blank">site</a>.
1. If the user still receiving an error message, please remove them from the site using the following steps:

   > [!NOTE]
   > This option is available only if the user previously browsed to the site collection. They won't be listed if they were granted access but never visited the site.

   1. Browse to the site and edit the URL by adding the following string to the end of it: `/_layouts/15/people.aspx?MembershipGroupId=0`

      For example, the full URL will resemble the following: `https://contoso.sharepoint.com/_layouts/15/people.aspx/membershipGroupId=0`
   1. Select the person from the list, and then on the Actions menu, select **Delete Users from Site Collection**.
   1. Grant the user permissions back to the <a href="https://support.office.com/en-us/article/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c" target="_blank">file</a> or <a href="https://support.office.com/en-us/article/share-a-site-958771a8-d041-4eb8-b51c-afea2eae3658?ui=en-US&rs=en-US&ad=US" target="_blank">site</a>.

1. If there are still errors with the account after the previous steps, we recommend that you completely remove the guest account from M365:
   1. Sign in to https://admin.microsoft.com as a global or SharePoint admin.
   1. In the left pane, select **Users** > **Guest users**. 
   1. Select **Delete a user**. 
   1. Select the user, then **Select**, and then select **Delete**. <br/>
      Once the above action has been completed,  ensure the account is completely removed from the site collection you are sharing with the user.
   1. Browse to the site and edit the URL by adding the following string to the end of it: `/_layouts/15/people.aspx?MembershipGroupId=0`<br/>
      For example, the full URL will resemble the following: `https://contoso.sharepoint.com/_layouts/15/people.aspx/membershipGroupId=0`
   1. Select the person from the list, and then on the **Actions** menu, select **Delete Users from Site Collection**. 
   1. Grant the user permissions back to the <a href="https://support.office.com/en-us/article/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c" target="_blank">file</a> or <a href="https://support.office.com/en-us/article/share-a-site-958771a8-d041-4eb8-b51c-afea2eae3658?ui=en-US&rs=en-US&ad=US" target="_blank">site</a>.


### When an external user accepts a SharePoint Online invitation by using another account

To resolve this issue, determine which account accepted the invitation, remove the incorrect account if this is necessary, and then re-invite the user to the resource.

> [!IMPORTANT]
> Many examples in this article use \<contoso> as a placeholder. In your scenario, replace \<contoso> with the domain that you use for your organization.

#### Determine which account has access as an external user

If you can access the site as the incorrect external user, follow these steps:

1. Sign in as the external user account that you used to accept the invite.

2. Select the profile image in the upper-right corner, and then select My Settings.

3. In the Account field, review the email address. For example, i:0#.f|membership|JonDoe@contoso.com.<br/>
   > [!NOTE]
   > In this example, JonDoe@contoso.com is the email account that accepted the user invitation.

4. If the address is incorrect, go to the "Remove the incorrect external user account" section.

If you can't access the site as the incorrect external user, follow these steps:

1. As a SharePoint Online administrator, sign in to the site collection that was shared with the external user.

2. Select the gear icon for the **Settings** menu, and then select **Site settings**.

3. In the **Users and Permissions** section, select **People and groups**.

4. At the end of the URL in your browser window, after the **people.aspx?** part of the URL, replace **MembershipGroupId=\<number>** with **MembershipGroupId=0**, and then press Enter.

5. In the list of users, locate the name of the external user. Right-click the user name, and copy the shortcut.

6. In a new browser window or tab, paste the URL that you copied in the previous step into the address box. Add **&force=1** to the end of the URL, and then press Enter.

7. In the **Account** field, review the email address. For example, **i:0#.f|membership|JonDoe\@contoso.com**.

    > [!NOTE]
    > In this example, **JonDoe\@contoso.com** is the email account that accepted the user invitation.

8. If the address is incorrect, go to the "Remove the incorrect external user account" section.

#### Remove the incorrect external user account

External users are managed from a site collection by site collection basis. An external user account will have to be removed from each site collection to which the account was given access. You can do this from the SharePoint Online user interface or through the SharePoint Online Management Shell, depending on your version of Office 365.

For Office 365 Small Business subscriptions, use the SharePoint Online UI. To do this, follow these steps:

1. Browse to the Office 365 admin center at https://portal.office.com.

2. In **service settings**, select **Manage Organization-wide settings**.

3. Select **sites and document sharing** from the left-side menu, and then select **Remove individual external users**.

4. Select the external user who has to be removed, and then select the **Delete** icon.

All other subscriptions must use the SharePoint Online Management Shell by following these steps:<br/>
> [!NOTE]
> This option doesn't apply to Office Small Business (P) organizations.

1. Download and install the SharePoint Online Management Shell. For more information, go to [Introduction to the SharePoint Online Management Shell](https://support.office.com/article/introduction-to-the-sharepoint-online-management-shell-c16941c3-19b4-4710-8056-34c034493429?ocmsassetID=HA102915057&CorrelationId=6f224f8f-1905-463f-8999-9dc7feec8d8a&ui=en-US&rs=en-US&ad=US).

2. Start the SharePoint Online Management Shell.

3. Type the following cmdlet:

   ```
   $cred = Get-Credential
   ```

4. In the **Windows PowerShell Credential required** dialog box, type your admin account and password, and then select **OK**.

5. Connect to SharePoint Online, and then type the following cmdlet:

   ```
   Connect-SPOService -Url https://<contoso>-admin.sharepoint.com -Credential $cred
   ```

6. Remove the user from each site collection. Type the following cmdlet, and then press **Enter**:

   ```
   $ExtUser = Get-SPOExternalUser -filter <account@contoso.com>
   ```

    > [!NOTE]
    > In this cmdlet, replace <account@contoso.com> with the affected account. 

7. Then, to remove the user, type the following cmdlet, and then press **Enter**:

   ```
    Remove-SPOExternalUser -UniqueIDs @($ExtUser.UniqueId)
   ```

The steps below remove the external user's ability to access SharePoint Online. However, the user will still appear in any people searches and within the SharePoint Online Management Shell Get-SPOUser cmdlet. To remove the user completely from SharePoint Online, you'll have to remove the user from the UserInfo list. There are two ways to achieve this.

1. **Use the SharePoint Online UI.** To do this, browse to each site collection to which the user previously had access, and then follow these steps:

   1. At the site collection, edit the URL by adding the following string to the end of the URL:

      ```
      _layouts/15/people.aspx/membershipGroupId=0
      ```

      For example, the full URL will resemble the following:

      ```
      https://<contoso>.sharepoint.com/_layouts/15/people.aspx/membershipGroupId=0
      ```

   2. Select the user from the list.

   3. Select **Remove User Permissions** from the ribbon.

2. **Use the SharePoint Online Management Shell.** For more information about how to use the SharePoint Online Management Shell, go to [Introduction to the SharePoint Online Management Shell](https://support.office.com/article/introduction-to-the-sharepoint-online-management-shell-c16941c3-19b4-4710-8056-34c034493429).

    > [!NOTE]
    > This option doesn't apply to Small Business subscriptions.

    1. Start the SharePoint Online Management Shell.

    2. Type the following cmdlet:
 
      ```
      $cred = Get-Credential
      ```

      In the Windows PowerShell Credential required window, type your admin account and password, then select OK.

    3. Connect to SharePoint Online, and then type the following cmdlet:

      ```
      Connect-SPOService -Url https://<contoso>-admin.sharepoint.com -Credential $cred
      ```

    4. Remove the user from each site collection. To do this, type the following cmdlet:
  
      ```
      Get-SPOUser -Site https://<contoso>.sharepoint.com | FT –a
      ```

      Notice the external user's Login Name in the returned results. As an external user, it might have a "live.com#" prefix if it's a Microsoft Account.

      Type the following cmdlet:

      ```
      Remove-SPOUser -Site https://<contoso>.sharepoint.com -LoginName live.com#jondoe@company.com
      ```

      > [!NOTE]
      > Replace live.com#jondoe@company.com with the user in your scenario.

Next, you have to remove the account from Azure Active Directory. To do this, follow these steps:

1. Download and install the Azure Active Directory PowerShell Module and its prerequisites. To this, go to [Manage Azure AD using Windows PowerShell](https://technet.microsoft.com/library/jj151815.aspx).

2. Open the Azure Active Directory PowerShell Module, and then run the following commands:

   ```
   Connect-MSOLService
   ```

   Enter your administrator credentials in the dialog box:

   ```
   Get-MsolUser -ReturnDeletedUsers -UnlicensedUsersOnly | ft -a
   ```

3. Locate the external user who you just deleted, and then confirm they're listed.

   ```
   Remove-MsolUser -RemoveFromRecycleBin -UserPrincipalName 'jondoe_contoso.com#EXT#@yourdomaint.onmicrosoft.com'
   ```

    > [!NOTE]
    > Replace **jondoe_contoso.com#EXT#\@yourdomain.onmicrosoft.com** with the specific user in your scenario.

#### Clear the browser cache

SharePoint Online uses browser caching in several scenarios, including the in the People Picker. Even though a user was fully removed from the system, he or she may still remain in the browser cache. Clearing the browser cache resolves this issue. To do this for Internet Explorer, follow the steps given in [Viewing and deleting your browsing history](https://support.microsoft.com/help/17438).

When you clear the cache, make sure that you also select the **Cookies and website data** option.

#### Re-invite the external user

After you follow these steps, re-invite the external user to the site by using the desired email address. To make sure that the end-user accepts with the appropriate email address, it is a best practice to copy the link in the invitation and then paste it into an InPrivate Browsing session. This makes sure that no cached credentials are used to accept the invitation.

## More information

An external user invitation doesn't require that it be accepted by the email address to which it was first sent. It is a one-time invite. If another user accepts the invitation, or if the user who accepts the invitation signs up by using an account other than the email address to which the invitation was sent, you may encounter an access denied message.

For example, a user is signed in through a browser by using a Microsoft account, and the user receives an email invitation to the user's external user account in the user's email application. Then, the user selects the link to accept the invite. However, based on the user's browser cookies, the user accidentally accepts the invite by using the incorrect identity.

When the user signs in to the resource by using the user's external user account, the user receives the error that the user isn't found in the directory.

For more information about permission levels in SharePoint Online, go to [Understanding permission levels](https://support.office.com/article/understanding-permission-levels-in-sharepoint-87ecbb0e-6550-491a-8826-c075e4859848?ocmsassetID=HA102772294&CorrelationId=8cb2ee53-10d3-48ec-baee-588885e94ba3&ui=en-US&rs=en-US&ad=US).

For more information about "Access Denied" errors in SharePoint or OneDrive for Business, see the following articles: 

- [Error message when trying to access SharePoint Online or OneDrive for Business](access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business.md)
- [Access Denied error when trying to approve a SharePoint Approval Workflow task](approval-workflow-access-denied-error.md)
- [Access Denied error when trying to access a shared folder or "Access Requests" list](access-requests-list-shared-folder-error-access-denied.md)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).