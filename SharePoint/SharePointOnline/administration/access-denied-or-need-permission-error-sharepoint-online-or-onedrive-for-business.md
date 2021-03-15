---
title: Access Denied, You need permission to access this site, or User not found in the directory errors in SharePoint Online and OneDrive for Business
ms.author: luche
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.date: 7/18/2019
ms.audience: Admin
ms.topic: article
ms.service: sharepoint-online
ms.custom: CSSTroubleshoot
search.appverid:
- SPO160
- MET150
ms.assetid: 
description: Outlines resolutions to error messages received when using SharePoint Online or OneDrive for Business such as Access Denied, You need permission to access this site and User not found in directory errors
appliesto:
- SharePoint Online
---

# "Access Denied", "You need permission to access this site", or "User not found in the directory" errors in SharePoint Online and OneDrive for Business

## Symptoms

When using SharePoint Online or OneDrive for Business, you receive one of the following error messages:

- Access Denied
- You need permission to access this site
- User not found in the directory

## Cause

There are many scenarios which can prompt one of these messages. The most frequent cause is that permissions for the user or administrator are configured incorrectly or not configured at all. 

## Resolution

Follow the steps below depending on which area you are receiving the error:

[When accessing a SharePoint site](#when-accessing-a-sharepoint-site)

[When accessing a OneDrive site](#when-accessing-a-onedrive-site)

[When an external user is accessing a site](#if-an-external-user-is-accessing-a-site)

[When an external user accepts a SharePoint Online invitation by using another account](#when-an-external-user-accepts-a-sharepoint-online-invitation-by-using-another-account)

[When accessing the "Access Requests" list](#when-accessing-the-access-requests-list)

[When accessing a shared folder](#when-accessing-a-shared-folder)

[When a user tries to approve an Approval Workflow task](#when-a-user-tries-to-approve-an-approval-workflow-task)

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
  - This issue most frequently occurs when a user is deleted and re-created with the same user principal name (UPN). The new account is created by using a different Unique ID value. When the user tries to access a site collection or their OneDrive, the user has an incorrect ID. A second scenario involves directory synchronization with an Active Directory organizational unit (OU). If users have already signed into SharePoint, are moved to a different OU that is not currently synchronized with Office365 and then resynced with SharePoint, they may experience this problem.
    - To resolve this issue, you will need to delete the new UPN (if it exists) and restore the original UPN.
      - To delete the new UPN, follow the steps in [this article](https://docs.microsoft.com/azure/active-directory/fundamentals/add-users-azure-active-directory#delete-a-user).
      - Once the new user has been deleted, you can restore the original user using [these steps](https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-users-restore).

    - If you cannot restore the original user and are still in this state,  create a support request using the following steps:
      - Navigate to <a href="https://admin.microsoft.com" target="_blank">https://admin.microsoft.com</a>.
      - In the left navigation pane, select **Support** and then **New Service Request**. This will activate the **Need Help?** pane on the right-hand side of your screen.
      - In the **Briefly describe your issue** area, enter **"OneDrive Site User ID Mismatch"**.
      - Select **Contact Support**.

        > [!NOTE]
        > If you are using the old M365 admin center, you can skip the "Description" step listed below as that field will not exist.

      - Under **Description** enter **"OneDrive Site User ID Mismatch"**. Fill out the remaining information and select **Contact me**.
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

### If an external user is accessing a site

1. Determine what <a href="https://docs.microsoft.com/sharepoint/understanding-permission-levels" target="_blank">permission level</a> the user should have to the site (member, owner, etc.) and verify the permission via the **Check Permissions** feature.

   1. To use the **Check Permissions** feature, navigate to the User.aspx page by selecting the gear icon in the upper right corner and then **Site Settings** Under **Users and Permissions**, select **Site Permissions**.

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
   1. Select the user, then **Select**, and then select **Delete**. Once the above action has been completed,  ensure the account is completely removed from the site collection you are sharing with the user.
   1. Browse to the site and edit the URL by adding the following string to the end of it: `/_layouts/15/people.aspx?MembershipGroupId=0`

      For example, the full URL will resemble the following: `https://contoso.sharepoint.com/_layouts/15/people.aspx/membershipGroupId=0`
   1. Select the person from the list, and then on the **Actions** menu, select **Delete Users from Site Collection**.
   1. Grant the user permissions back to the <a href="https://support.office.com/en-us/article/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c" target="_blank">file</a> or <a href="https://support.office.com/en-us/article/share-a-site-958771a8-d041-4eb8-b51c-afea2eae3658?ui=en-US&rs=en-US&ad=US" target="_blank">site</a>.


### When an external user accepts a SharePoint Online invitation by using another account

To resolve this issue, determine which account accepted the invitation, remove the incorrect account if this is necessary, and then re-invite the user to the resource.

Note Many examples in this article use \<contoso> as a placeholder. In your scenario, replace \<contoso> with the domain that you use for your organization.

#### Determine which account has access as an external user

If you can access the site as the incorrect external user, follow these steps:

1. Sign in as the external user account that you used to accept the invite.

2. Select the profile image in the upper-right corner, and then select My Settings.

3. In the Account field, review the email address. For example, i:0#.f|membership|JonDoe@contoso.com.

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

1. Browse to the Office 365 admin center at `https://portal.office.com`.

2. In **service settings**, select **Manage Organization-wide settings**.

3. Select **sites and document sharing** from the left-side menu, and then select **Remove individual external users**.

4. Select the external user who has to be removed, and then select the **Delete** icon.

All other subscriptions must use the SharePoint Online Management Shell by following these steps:

> [!NOTE]
> This option doesn't apply to Office Small Business (P) organizations.

1. Download and install the SharePoint Online Management Shell. For more information, go to [Introduction to the SharePoint Online Management Shell](https://support.office.com/article/introduction-to-the-sharepoint-online-management-shell-c16941c3-19b4-4710-8056-34c034493429?ocmsassetID=HA102915057&CorrelationId=6f224f8f-1905-463f-8999-9dc7feec8d8a&ui=en-US&rs=en-US&ad=US).

2. Start the SharePoint Online Management Shell.

3. Type the following cmdlet:

   ```powershell
   $cred = Get-Credential
   ```

4. In the **Windows PowerShell Credential required** dialog box, type your admin account and password, and then select **OK**.

5. Connect to SharePoint Online, and then type the following cmdlet:

   ```powershell
   Connect-SPOService -Url https://<contoso>-admin.sharepoint.com -Credential $cred
   ```

6. Remove the user from each site collection. Type the following cmdlet, and then press Enter:

   ```powershell
   $ExtUser = Get-SPOExternalUser -filter <account@contoso.com>
   ```

> [!NOTE]
> In this cmdlet, replace <account@contoso.com> with the affected account. Then, to remove the user, type the following cmdlet, and then press Enter:

   ```powershell
    Remove-SPOExternalUser -UniqueIDs @($ExtUser.UniqueId)
   ```

The steps below remove the external user's ability to access SharePoint Online. However, the user will still appear in any people searches and within the SharePoint Online Management Shell Get-SPOUser cmdlet. To remove the user completely from SharePoint Online, you'll have to remove the user from the UserInfo list. There are two ways to achieve this.

1. Use the SharePoint Online UI. To do this, browse to each site collection to which the user previously had access, and then follow these steps:

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

2. Use the SharePoint Online Management Shell. For more information about how to use the SharePoint Online Management Shell, go to [Introduction to the SharePoint Online Management Shell](https://support.office.com/article/introduction-to-the-sharepoint-online-management-shell-c16941c3-19b4-4710-8056-34c034493429).
> [!NOTE]
> This option doesn't apply to Small Business subscriptions.

   1. Start the SharePoint Online Management Shell.

   2. Type the following cmdlet:
 
      ```powershell
      $cred = Get-Credential
      ```

      In the Windows PowerShell Credential required window, type your admin account and password, then select OK.

   3. Connect to SharePoint Online, and then type the following cmdlet:

      ```powershell
      Connect-SPOService -Url https://<contoso>-admin.sharepoint.com -Credential $cred
      ```

   4. Remove the user from each site collection. To do this, type the following cmdlet:
  
      ```powershell
      Get-SPOUser -Site https://<contoso>.sharepoint.com | FT –a
      ```

      Notice the external user's Login Name in the returned results. As an external user, it might have a "live.com#" prefix if it's a Microsoft Account.

      Type the following cmdlet:

      ```powershell
      Remove-SPOUser -Site https://<contoso>.sharepoint.com -LoginName live.com#jondoe@company.com
      ```

> [!NOTE]
> Replace live.com#jondoe@company.com with the user in your scenario.

Next, you have to remove the account from Azure Active Directory. To do this, follow these steps:

1. Download and install the Azure Active Directory PowerShell Module and its prerequisites. To this, go to [Manage Azure AD using Windows PowerShell](https://technet.microsoft.com/library/jj151815.aspx).

2. Open the Azure Active Directory PowerShell Module, and then run the following commands:

   ```powershell
   Connect-MSOLService
   ```

   Enter your administrator credentials in the dialog box:

   ```powershell
   Get-MsolUser -ReturnDeletedUsers -UnlicensedUsersOnly | ft -a
   ```

3. Locate the external user who you just deleted, and then confirm they're listed.

   ```powershell
   Remove-MsolUser -RemoveFromRecycleBin -UserPrincipalName 'jondoe_contoso.com#EXT#@yourdomaint.onmicrosoft.com'
   ```

> [!NOTE]
> Replace **jondoe_contoso.com#EXT#\@yourdomain.onmicrosoft.com** with the specific user in your scenario.

#### Clear the browser cache

SharePoint Online uses browser caching in several scenarios, including the in the People Picker. Even though a user was fully removed from the system, he or she may still remain in the browser cache. Clearing the browser cache resolves this issue. To do this for Internet Explorer, follow the steps given in [Viewing and deleting your browsing history](https://support.microsoft.com/help/17438).

When you clear the cache, make sure that you also select the **Cookies and website data** option.

#### Re-invite the external user

After you follow these steps, re-invite the external user to the site by using the desired email address. To make sure that the end-user accepts with the appropriate email address, it is a best practice to copy the link in the invitation and then paste it into an InPrivate Browsing session. This makes sure that no cached credentials are used to accept the invitation.

#### More information

An external user invitation doesn't require that it be accepted by the email address to which it was first sent. It is a one-time invite. If another user accepts the invitation, or if the user who accepts the invitation signs up by using an account other than the email address to which the invitation was sent, you may encounter an access denied message.

For example, a user is signed in through a browser by using a Microsoft account, and the user receives an email invitation to the user's external user account in the user's email application. Then, the user selects the link to accept the invite. However, based on the user's browser cookies, the user accidentally accepts the invite by using the incorrect identity.

When the user signs in to the resource by using the user's external user account, the user receives the error that the user isn't found in the directory.

### When accessing the "Access Requests" list

To resolve this issue, users must be either site collection administrators or be members of the Owners group for the site. The Owners group must also have permissions to access the **Access Requests** list. Use the following solutions as appropriate for your specific configuration.

#### Site collection administrator

If an affected user should be a site collection administrator, go to the following Microsoft website for more information about how to manage administrators for your sites:

[Manage site collection administrators](https://docs.microsoft.com/sharepoint/manage-site-collection-administrators)

#### Add the user to the Owners group for the site

If the user should be a site owner, you must add the user to the Owners group for the site. To do this, follow these steps:

1. As a user who can change site permissions, browse to the affected site or site collection. Select the gear icon for the **Settings** menu, and then select **Site settings**.

1. Select **Site permissions**.

1. Select the **Owners** group for the site.

1. Select **New**.

1. In the **Share** dialog box, enter the user account of the user who you want to add to the group. Then, select **Share**.

1. Test to verify that the user can now access the list and approve or decline requests.

#### Make sure that the Owners group has permissions to the Access Requests list

If the Owners group is changed or was removed from the **Access requests** list, you must add the Owners group permissions for the list. You must also make sure that the affected user is included in the Owners list. To do this, follow these steps:

1. As a user who has the **Manage Permissions Permission Level** on the affected site and who also has access to the **Access Requests** list (for example, a Site Collection administrator), browse to the **Access Requests** list in Internet Explorer.

1. Press F12 to open the F12 Developer Tools window.

1. Select the **Network** tab, and then press F5 to enable network traffic capturing.

1. Refresh the Access Requests page in Internet Explorer. After the page has loaded, press Shift+F5 to stop capturing network traffic.

1. In the Developer Tools window, double-select the first result in the URL list. This URL ends in "pendingreq.aspx."

1. In the Developer Tools window, select **Response body**.

1. In the search box, type **pagelistid:**, and then press Enter.

    > [!NOTE]
    > The search highlights the pageListId text.

1. Copy the GUID that follows the pageListId. The GUID will be between an opening brace ( { ) character and a closing brace ( } ) character as follows:

    {GUID}

    > [!NOTE]
    > Include the opening and closing brace characters when you copy the GUID. This GUID is the identifier for the **SharePoint Online Access Requests** list for your organization.

1. In the browser address bar, enter `https://<URL of affected site, or site collection>/_layouts/15/ListEdit.aspx?List=<{GUID}>`, and then press Enter.

    > [!NOTE]
    > In this address, \<URL of affected site or site collection> represents the URL for the site collection in which you want to change the access requests (for example, `https://contoso.sharepoint.com`). And <{GUID}> represents the GUID that you copied in step 8.

1. On the **Settings** page, select **Permissions for this list**.

1. Make sure that the Owners group for the site is included in the list of permissions for the Access Requests list. If the Owners group for the site collection does not exist, select **Grant Permissions**, enter the name of the Owners group for the site in the **Share** dialog box, and then select **Share**.

1. Follow the steps in the "Add the user to the Owners group for the site" section to make sure that the user is included in the Owners group.

#### More information

This issue occurs because only site collection administrators or users who are members of the Owners group for the site collection have permission to approve or decline pending requests in the **Access Requests** list. For situations in which users are members of the Owners group for the site, the Owners group must also have Full Control permissions to be able to access the **Access Requests** list.

For more information about how to set up and manage access requests, go to [Set up and manage access requests](https://support.office.com/article/set-up-and-manage-access-requests-94b26e0b-2822-49d4-929a-8455698654b3).

For more information about how to use the F12 developer tools, go to [Using the F12 developer tools](https://docs.microsoft.com/previous-versions/windows/internet-explorer/ie-developer/samples/bg182326(v=vs.85)).

### When accessing a shared folder

To work around this issue, use one of the following workarounds as appropriate for your situation:

- Share individual files but not folders.
- Share a whole site collection or subsite.
- If your site doesn't require **Limited-access user permission lockdown mode**, deactivate this site collection feature.

    > [!NOTE]
    > Other features such as publishing may require this feature to work correctly.

#### More information

When you share a folder with a user who can't access the parent folder or site, SharePoint assigns the user limited access to the parent items. Specifically, SharePoint lets the user access the folder without obtaining permission to access the parent folder and other items (other than limited access). However, after **Limited-access user permission lockdown mode** is enabled, the user doesn't have access to the folder because the necessary limited access permission on other items no longer works correctly. 

#### What is "Limited Access" permission?

The **Limited Access** permission level is unusual. It lets a user or group browse to a site page or library to access a specific content item without seeing the whole list. For example, when you share a single item in a list or library with a user who doesn't have permission to open or edit any other items in the library, SharePoint automatically grants limited access to the parent list. This lets the user see the specific item that you shared. In other words, the **Limited Access** permission level includes all the permissions that the user must have to access the required item.

For more information about site collection features that includes **Limited-access user permission lockdown mode**, see [Enable or disable site collection features](https://support.office.microsoft.com/article/enable-or-disable-site-collection-features-a2f2a5c2-093d-4897-8b7f-37f86d83df04?correlationid=3fa0f19c-84e4-403d-9046-3c25d66fd867).

### When a user tries to approve an Approval Workflow task

To resolve this issue, grant **Edit** access to the specific task list for the workflow to the affected user.

Additionally, the user who is approving the item as part of the workflow is also required to have **Read** access to the item that's the target of the workflow.

#### More information

This behavior is by design. Users who try to approve a SharePoint 2010 Approval Workflow task, but who have only **Edit** permissions to the task list item, can't view the task's form page. The user must have at least **Read** access to the workflow task list.

For more information about approval workflows, go to [Understand approval workflows in SharePoint 2010](https://support.office.com/article/understand-approval-workflows-in-sharepoint-server-a24bcd14-0e3c-4449-b936-267d6c478579?ocmsassetID=HA101857172&CorrelationId=41ffeb3a-fdca-4c19-a471-5cd02c4525ea&ui=en-US&rs=en-US&ad=US).

For more information about permission levels in SharePoint Online, go to [Understanding permission levels](https://support.office.com/article/understanding-permission-levels-in-sharepoint-87ecbb0e-6550-491a-8826-c075e4859848?ocmsassetID=HA102772294&CorrelationId=8cb2ee53-10d3-48ec-baee-588885e94ba3&ui=en-US&rs=en-US&ad=US).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
