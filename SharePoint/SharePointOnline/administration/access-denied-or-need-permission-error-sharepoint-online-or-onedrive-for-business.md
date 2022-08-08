---
title: Access Denied or You need permission to access this site
ms.author: luche
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.date: 10/26/2021
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 153997
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
description: When you use SharePoint Online or OneDrive for Business, you may receive certain access or permission errors, such as   Access Denied, You need permission to access this site, or User not found in the directory.
appliesto: 
  - SharePoint Online
---

# "Access Denied" or "You need permission to access this site" errors in SharePoint Online and OneDrive for Business

## Symptoms

When you use SharePoint Online or OneDrive for Business, you may receive one of the following error messages:

- Access Denied
- You need permission to access this site
- User not found in the directory

## Cause

There are many scenarios that can prompt one of these messages. The most common cause is that permissions for the user or administrator are configured incorrectly or not configured at all.

## Resolution Option 1: Run the Check User Access Diagnostic

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Microsoft 365 admin users have access to diagnostics that can be run within the tenant to verify possible issues with user access.

Select **Run Tests** below, which will populate the diagnostic in the Microsoft 365 Admin Center.

> [!div class="nextstepaction"]
> [Run Tests: Check SharePoint User Access](https://aka.ms/PillarCheckUserAccess)

The diagnostic performs a large range of verifications for internal users or guests who try to access SharePoint and OneDrive sites.


## Resolution Option 2: Select the most relevant option and follow the steps to fix the issue

> [!NOTE]
> Many examples in this article use \<contoso> as a placeholder. In your scenario, replace \<contoso> with the domain that's used for your organization.

<details>
<summary><b>When accessing a SharePoint site</b></summary>

1. Determine the [permission level](/sharepoint/understanding-permission-levels) that the user should have on the site (member, owner, and so on).
1. Verify the permission by using the **Check Permissions** feature:

   1. On your site, select **Settings** :::image type="icon" source="./media/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business/settings-icon.png"::: > **Site permissions**.
   1. In the top ribbon, select **Check Permissions**.
   1. In the **User/Group** field, enter the user's name, and then select **Check Now**.
   1. Review the permissions the user has on the site, and through which security group (if applicable).
1. If the user doesn't have appropriate permissions, grant the user permissions to the [file](https://support.office.com/article/1fe37332-0f9a-4719-970e-d2578da4941c) or [site](https://support.office.com/article/958771a8-d041-4eb8-b51c-afea2eae3658).
1. If the user continues to receive an error message, [remove the user from the site](/sharepoint/remove-users#site-by-site-in-sharepoint). Then grant the user permissions back to the [file](https://support.office.com/article/1fe37332-0f9a-4719-970e-d2578da4941c) or [site](https://support.office.com/article/958771a8-d041-4eb8-b51c-afea2eae3658).

</details>

<details>
<summary><b>When accessing a OneDrive site</b></summary>

### If the user is the owner of the OneDrive site

This issue most frequently occurs when a user is deleted and re-created with the same user principal name (UPN). The new account is created by using a different Unique ID value. When the user tries to access a site collection or OneDrive, the user has an incorrect ID. A second scenario involves directory synchronization with an Active Directory organizational unit (OU). If users have already signed into SharePoint, are moved to a different OU that's not currently synchronized with Microsoft 365, and then resynced with SharePoint, they may experience this problem.

To fix this issue, [delete the new UPN](/azure/active-directory/fundamentals/add-users-azure-active-directory#delete-a-user) if it exists, and then [restore the original UPN](/azure/active-directory/fundamentals/active-directory-users-restore).

If you can't restore the original user and are still in this state, create a support request:

1. As an administrator, select [OneDrive Site User ID Mismatch](https://admin.microsoft.com/AdminPortal/?searchSolutions=OneDrive%20Site%20User%20ID%20Mismatch), it will populate a help query in the admin center.
1. At the bottom of the pane, select **Contact Support** > **New Service Request**.
1. Leave the description blank.
1. After the ticket is opened, provide the support agent with the UPN and OneDrive URL that's having the issue.

### If the user is trying to access another user's OneDrive site

1. Determine the [permission level](/sharepoint/understanding-permission-levels) that the user should have on the site (member, owner, and so on).
1. Verify the permissions by using the **Check Permissions** feature:
  
   1. On your site, select **Settings** :::image type="icon" source="./media/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business/settings-icon.png"::: > **Site Settings** > **Site permissions**.
   1. In the top ribbon, select **Check Permissions**.
   1. In the **User/Group** field, enter the user's name, and then select **Check Now**.
   1. Review the permissions the user has on the site, and through which security group (if applicable).
1. If the user doesn't have appropriate permissions, grant them permissions to the [file](https://support.office.com/article/1fe37332-0f9a-4719-970e-d2578da4941c) or [site](https://support.office.com/article/958771a8-d041-4eb8-b51c-afea2eae3658).
1. If the user continues to receive an error message, [remove the user from the site](/sharepoint/remove-users#site-by-site-in-sharepoint). Then grant the user permissions back to the [file](https://support.office.com/article/1fe37332-0f9a-4719-970e-d2578da4941c) or [site](https://support.office.com/article/958771a8-d041-4eb8-b51c-afea2eae3658).

</details>

<details>
<summary><b>When a guest is accessing a site</b></summary>

1. Determine the [permission level](/sharepoint/understanding-permission-levels) that the user should have on the site (member, owner, and so on).
1. Verify the permission by using the **Check Permissions** feature:

   1. On your site, select **Settings** :::image type="icon" source="./media/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business/settings-icon.png"::: > **Site permissions**.
   1. In the top ribbon, select **Check Permissions**.
   1. In the **User/Group** field, enter the user's name, and then select **Check Now**.
   1. Review the permissions the user has on the site, and through which security group (if applicable).
1. If the user doesn't have appropriate permissions, grant the user permissions to the [file](https://support.office.com/article/1fe37332-0f9a-4719-970e-d2578da4941c) or [site](https://support.office.com/article/958771a8-d041-4eb8-b51c-afea2eae3658).
1. If the user continues to receive an error message, [remove the user from the site](/sharepoint/remove-users#site-by-site-in-sharepoint). Then grant the user permissions back to the [file](https://support.office.com/article/1fe37332-0f9a-4719-970e-d2578da4941c) or [site](https://support.office.com/article/958771a8-d041-4eb8-b51c-afea2eae3658).
1. If there are still errors with the account, we recommend that you completely [remove the guest account from the Microsoft 365 admin center](/sharepoint/remove-users#delete-a-guest-from-the-microsoft-365-admin-center). Make sure that [the user is removed from the site collection](/sharepoint/remove-users#site-by-site-in-sharepoint). Then grant the user permissions back to the [file](https://support.office.com/article/1fe37332-0f9a-4719-970e-d2578da4941c) or [site](https://support.office.com/article/958771a8-d041-4eb8-b51c-afea2eae3658).

</details>

<details>
<summary><b>When a guest accepts a SharePoint Online invitation by using another account</b></summary>

To fix this issue, determine which account accepted the invitation, remove the incorrect account if necessary, and then reinvite the user to the resource.

### Step 1: Determine which account has access as a guest

If you can access the site as the incorrect guest, follow these steps:

1. Sign in as the guest account that you used to accept the invitation.
2. Select the profile image in the upper right corner, and then select **My Settings**.
3. In the **Account** field, review the email address. For example, i:0#.f|membership|JonDoe@contoso.com. In this example, JonDoe@contoso.com is the email account that accepted the invitation.
4. If the address is incorrect, go to **Step 2: Remove the incorrect guest account**.

If you can't access the site as the incorrect guest, follow these steps:

1. As a SharePoint Online administrator, sign in to the site collection that was shared with the guest.
2. Select **Settings** :::image type="icon" source="./media/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business/settings-icon.png"::: > **Site settings**.
3. In the **Users and Permissions** section, select **People and groups**.
4. At the end of the URL in your browser window, after the **people.aspx?** part of the URL, replace **MembershipGroupId=\<number\>** with **MembershipGroupId=0**, and then press Enter.
5. In the list of users, locate the name of the guest. Right-click the user name, and copy the shortcut.
6. In a new browser window or tab, paste the URL that's copied in step 5 into the address box. Add **&force=1** to the end of the URL, and then press Enter.
7. In the **Account** field, review the email address. For example, **i:0#.f|membership|JonDoe\@contoso.com**. In this example, **JonDoe\@contoso.com** is the email account that accepted the user invitation.
8. If the address is incorrect, go to **Step 2: Remove the incorrect guest account**.

### Step 2: Remove the incorrect guest account

External users are managed from a site collection by site collection basis. A guest account must be removed from each site collection to which the account was given access. You can do so from the SharePoint Online user interface, or through the SharePoint Online Management Shell, depending on your version of Microsoft 365.

For Microsoft 365 Business subscriptions, use the SharePoint Online UI:

1. Go to **Admin** > **Service Settings** > **sites and document sharing**.
2. Select **Remove individual external users**.
3. Select the users you want to remove, and then select **Delete** (the trash can icon).

All other subscriptions must use the SharePoint Online Management Shell:

> [!NOTE]
> This option doesn't apply to Office Small Business (P) organizations.

1. Download and install the [SharePoint Online Management Shell](https://go.microsoft.com/fwlink/p/?LinkId=255251). For more information, see [Introduction to the SharePoint Online Management Shell](https://support.office.com/article/c16941c3-19b4-4710-8056-34c034493429).
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
   > In this cmdlet, replace \<account@contoso.com\> with the affected account.
7. To remove the user, type the following cmdlet, and then press Enter:

   ```powershell
    Remove-SPOExternalUser -UniqueIDs @($ExtUser.UniqueId)
   ```

The steps above remove the external user's access to SharePoint Online. However, the user will still appear in people searches, and in the SharePoint Online Management Shell when you use the Get-SPOUser cmdlet. To completely remove the user from SharePoint Online, you must remove the user from the UserInfo list. There are two ways to achieve this.

- Use the SharePoint Online UI. To do so, browse to each site collection to which the user previously had access, and then follow these steps:

   1. At the site collection, edit the URL by adding the following string to the end of the URL:

      `_layouts/15/people.aspx/membershipGroupId=0`

      For example, the full URL will resemble `https://<contoso>.sharepoint.com/_layouts/15/people.aspx/membershipGroupId=0`.

   2. Select the user from the list.
   3. Select **Remove User Permissions** from the ribbon.

- Use the [SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

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

  4. Remove the user from each site collection. To do so, type the following cmdlet:
  
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

Next, remove the account from Azure Active Directory:

1. Download and install the [Azure Active Directory PowerShell Module](/previous-versions/azure/jj151815(v=azure.100)) and its prerequisites.
2. Open the Azure Active Directory PowerShell Module, and then run the following commands:

   ```powershell
   Connect-MSOLService
   ```

   Enter your administrator credentials in the dialog box:

   ```powershell
   Get-MsolUser -ReturnDeletedUsers -UnlicensedUsersOnly | ft -a
   ```

3. Locate the user that you deleted, and then confirm they're listed.

   ```powershell
   Remove-MsolUser -RemoveFromRecycleBin -UserPrincipalName 'jondoe_contoso.com#EXT#@yourdomaint.onmicrosoft.com'
   ```

   > [!NOTE]
   > Replace **jondoe_contoso.com#EXT#\@yourdomain.onmicrosoft.com** with the specific user in your scenario.

### Step 3: Clear the browser cache

SharePoint Online uses browser caching in several scenarios, including in the People Picker. Even though a user was fully removed, the user may still remain in the browser cache. Clearing the browser cache resolves this issue. For more information about how to do so in Edge, see [View and delete browser history in Microsoft Edge](https://support.microsoft.com/help/10607).

When you clear the cache, make sure that you also select the **Cookies and website data** option.

### Step 4: Reinvite the guest

After you follow the previous steps, reinvite the guest to the site by using the desired email address. To make sure that the end user accepts with the appropriate email address, it's a best practice to copy the link in the invitation and then paste it into an InPrivate Browsing session. It makes sure that no cached credentials are used to accept the invitation.

### More information

A guest invitation doesn't require it to be accepted by the email address to which it was first sent. It's a one-time invitation. If another user accepts the invitation, or if the user who accepts the invitation signs up by using an account other than the email address to which the invitation was sent, you may encounter an access denied message.

For example, a user is signed in through a browser by using a Microsoft account, and the user receives an email invitation to the user's external user account in the user's email application. Then, the user selects the link to accept the invitation. However, based on the user's browser cookies, the user accidentally accepts the invitation by using the incorrect identity.

When the user signs in to the resource by using the user's external user account, the user receives the error that the user isn't found in the directory.

</details>

<details>
<summary><b>When accessing the "Access Requests" list</b></summary>

To fix this issue, users must be either site collection administrators or members of the Owners group for the site. The Owners group must also have permissions to access the **Access Requests** list. Use the following solutions as appropriate for your specific configuration.

### Site collection administrator

If an affected user should be a site collection administrator, see [Manage site collection administrators](/sharepoint/manage-site-collection-administrators).

### Add the user to the Owners group for the site

If the user should be a site owner, add the user to the Owners group for the site:

1. As a user who can change site permissions, browse to the affected site or site collection. Select **Settings** :::image type="icon" source="./media/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business/settings-icon.png"::: > **Site settings**.
1. Select **Site permissions**.
1. Select the **Owners** group for the site.
1. Select **New**.
1. In the **Share** dialog box, enter the account of the user that you want to add to the group. Then, select **Share**.
1. Verify that the user can now access the list and approve or decline requests.

### Make sure that the Owners group has permissions to the Access Requests list

If the Owners group is changed or removed from the **Access requests** list, you must add the Owners group permissions for the list. Also make sure that the affected user is included in the Owners list. To do so, follow these steps:

1. As a user who has the **Manage Permissions Permission Level** on the affected site and who also has access to the **Access Requests** list (for example, a site collection administrator), browse to the **Access Requests** list in Internet Explorer.
1. Press F12 to open the Developer Tools window.
1. Select the **Network** tab, and then press F5 to enable network traffic capturing.
1. Refresh the Access Requests page. After the page has loaded, press Shift+F5 to stop capturing network traffic.
1. In the Developer Tools window, double-click the first result in the URL list. This URL ends in *pendingreq.aspx*.
1. In the Developer Tools window, select **Response body**.
1. In the search box, type **pagelistid:**, and then press Enter.

    > [!NOTE]
    > The search highlights the pageListId text.
1. Copy the GUID that follows the pageListId. The GUID is between an opening brace ( { ) character and a closing brace ( } ) character as follows:

    {GUID}

    > [!NOTE]
    > Include the opening and closing brace characters when you copy the GUID. This GUID is the identifier for the **SharePoint Online Access Requests** list for your organization.
1. In the browser address bar, enter `https://<URL of affected site, or site collection>/_layouts/15/ListEdit.aspx?List=<{GUID}>`, and then press Enter.

    > [!NOTE]
    > In this address, \<URL of affected site or site collection\> represents the URL for the site collection in which you want to change the access requests (for example, `https://contoso.sharepoint.com`). And \<{GUID}\> represents the GUID that you copied in step 8.
1. On the **Settings** page, select **Permissions for this list**.
1. Make sure that the Owners group for the site is included in the list of permissions for the Access Requests list. If the Owners group for the site collection doesn't exist, select **Grant Permissions**, enter the name of the Owners group for the site in the **Share** dialog box, and then select **Share**.
1. Follow the steps in the **Add the user to the Owners group for the site** section to make sure that the user is included in the Owners group.

### More information

This issue occurs because only site collection administrators or users who are members of the Owners group for the site collection have permission to approve or decline pending requests in the **Access Requests** list. For situations in which users are members of the Owners group for the site, the Owners group must also have Full Control permissions to be able to access the **Access Requests** list.

For more information about how to set up and manage access requests, see [Set up and manage access requests](https://support.office.com/article/set-up-and-manage-access-requests-94b26e0b-2822-49d4-929a-8455698654b3).

For more information about how to use the F12 developer tools, see [Using the F12 developer tools](/previous-versions/windows/internet-explorer/ie-developer/samples/bg182326(v=vs.85)).
</details>

<details>
<summary><b>When accessing a shared folder</b></summary>

To work around this issue, use one of the following workarounds as appropriate for your situation:

- Share individual files but not folders.
- Share a whole site collection or subsite.
- If your site doesn't require **Limited-access user permission lockdown mode**, deactivate this site collection feature.

    > [!NOTE]
    > Other features such as publishing may require this feature to work correctly.

When you share a folder with a user who can't access the parent folder or site, SharePoint assigns the user limited access to the parent items. Specifically, SharePoint allows the user to access the folder without obtaining permission to access the parent folder and other items (other than limited access). However, after **Limited-access user permission lockdown mode** is enabled, the user doesn't have access to the folder because the necessary limited access permission on other items no longer works correctly.

### What's "Limited Access" permission?

The **Limited Access** permission level is unusual. It lets a user or group browse to a site page or library to access a specific content item without seeing the whole list. For example, when you share a single item in a list or library with a user who doesn't have permission to open or edit any other items in the library, SharePoint automatically grants limited access to the parent list. It lets the user see the specific item that you shared. In other words, the **Limited Access** permission level includes all the permissions that the user must have to access the required item.

For more information about site collection features that includes **Limited-access user permission lockdown mode**, see [Enable or disable site collection features](https://support.office.microsoft.com/article/enable-or-disable-site-collection-features-a2f2a5c2-093d-4897-8b7f-37f86d83df04?correlationid=3fa0f19c-84e4-403d-9046-3c25d66fd867).

</details>

<details>
<summary><b>When a user tries to approve an Approval Workflow task</b></summary>

To fix this issue, grant **Edit** access to the specific task list for the workflow to the affected user.

Additionally, the user who is approving the item as part of the workflow must also have **Read** access to the item that's the target of the workflow.

This behavior is by design. Users who try to approve a SharePoint 2010 Approval Workflow task, but who have only **Edit** permissions to the task list item, can't view the task's form page. The user must have at least **Read** access to the workflow task list.

For more information about approval workflows, see [Understand approval workflows in SharePoint 2010](https://support.office.com/article/a24bcd14-0e3c-4449-b936-267d6c478579).

For more information about permission levels in SharePoint Online, see [Understanding permission levels](https://support.office.com/article/87ecbb0e-6550-491a-8826-c075e4859848).

</details>

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
