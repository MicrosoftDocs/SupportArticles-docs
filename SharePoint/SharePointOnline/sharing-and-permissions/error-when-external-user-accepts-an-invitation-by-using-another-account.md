---
title: Error when an external user accepts a SharePoint Online invitation by using another account
description: Describes an issue in which you receive an error message when an external user accepts a SharePoint Online invitation by using another account.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Sharing\Sharing with external
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
appliesto: 
  - SharePoint Online
ms.date: 04/29/2025
ms.reviewer: salarson, prbalusu
---

# Error when an external user accepts a SharePoint Online invitation by using another account

## Symptoms

You receive one of the following error messages when trying to access an externally shared resource:

- Access Denied
- Let us know why you need access to this site.
- User is not found in the directory
- You need permission to access this site.

## Resolution

To resolve this issue, follow these steps:

1. Determine which account accepted the invitation.
1. Remove the incorrect account and the correct account.
1. Reinvite the user to the resource.

> **Note**:
> Many examples in this article use \<contoso\> as a placeholder. In your scenario, replace \<contoso\> with the domain that you use for your organization.

### Determine which account has access as an external user

If you can access the site as the incorrect external user, follow these steps:

1. Sign in as the external user account that you used to accept the invite.

2. Click the profile image in the upper-right corner, and then click My Settings.

3. In the Account field, review the email address. For example, i:0#.f|membership|JonDoe@contoso.com.

   > **Note**:
   > In this example, JonDoe@contoso.com is the email account that accepted the user invitation.

4. If the address is incorrect, go to the "Remove the incorrect external user account" section.

If you can't access the site as the incorrect external user, follow these steps:

1. As a SharePoint Online administrator, sign in to the site collection that was shared with the external user.

2. Click the gear icon for the **Settings** menu, and then click **Site settings**.

3. In the **Users and Permissions** section, click **People and groups**.

4. At the end of the URL in your browser window, after the **people.aspx?** part of the URL, replace **MembershipGroupId=\<number>** with **MembershipGroupId=0**, and then press Enter.

5. In the list of users, locate the name of the external user. Right-click the user name, and copy the shortcut.

6. In a new browser window or tab, paste the URL that you copied in the previous step into the address box. Add **&force=1** to the end of the URL, and then press Enter.

7. In the **Account** field, review the email address. For example, **i:0#.f|membership|JonDoe\@contoso.com**.

   > **Note**:
   > In this example, **JonDoe\@contoso.com** is the email account that accepted the user invitation.

8. If the address is incorrect, go to the "Remove the incorrect external user account" section.

### Remove the incorrect external user account

External users are managed from a site collection by site collection basis. An external user account will have to be removed from each site collection to which the account was given access. You can do so from the SharePoint Online user interface or through the SharePoint Online Management Shell, depending on your version of Microsoft 365.

For Microsoft 365 for Business subscriptions, use the SharePoint Online UI:

1. Browse to the Microsoft 365 admin center at https://portal.office.com.

2. In **service settings**, click **Manage Organization-wide settings**.

3. Click **sites and document sharing** from the left-side menu, and then click **Remove individual external users**.

4. Select the external user who has to be removed, and then click the **Delete** icon.

All other subscriptions must use the SharePoint Online Management Shell by following these steps:

> [!NOTE]
> This option doesn't apply to Office Small Business (P) organizations.

1. Download and install the SharePoint Online Management Shell. For more information, go to [Introduction to the SharePoint Online Management Shell](https://support.office.com/article/introduction-to-the-sharepoint-online-management-shell-c16941c3-19b4-4710-8056-34c034493429?ocmsassetID=HA102915057&CorrelationId=6f224f8f-1905-463f-8999-9dc7feec8d8a&ui=en-US&rs=en-US&ad=US).

2. Start the SharePoint Online Management Shell.

3. Type the following cmdlet:

   ```powershell
   $cred = Get-Credential
   ```

4. In the **Windows PowerShell Credential required** dialog box, type your admin account and password, and then click **OK**.

5. Connect to SharePoint Online, and then type the following cmdlet:

   ```powershell
   Connect-SPOService -Url https://-admin.sharepoint.com -Credential $cred
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

The steps below remove the external user's ability to access SharePoint Online. However, the user will still appear in any people searches and within the SharePoint Online Management Shell Get-SPOUser cmdlet. To remove the user completely from SharePoint Online, you'll have to remove the user from the UserInfo list. There are two ways.

1. Use the SharePoint Online UI. To do so, browse to each site collection to which the user previously had access, and then follow these steps:

   1. At the site collection, edit the URL by adding the following string to the end of the URL:

      ```powershell
      _layouts/15/people.aspx/membershipGroupId=0
      ```

      For example, the full URL will resemble the following:

      ```powershell
      https://<contoso>.sharepoint.com/_layouts/15/people.aspx/membershipGroupId=0
      ```

   2. Select the user from the list.

   3. Click **Remove User Permissions** from the ribbon.

2. Use the SharePoint Online Management Shell. For more information about how to use the SharePoint Online Management Shell, go to [Introduction to the SharePoint Online Management Shell](https://support.office.com/article/introduction-to-the-sharepoint-online-management-shell-c16941c3-19b4-4710-8056-34c034493429).

   > [!NOTE]
   > This option doesn't apply to Small Business subscriptions.

   1. Start SharePoint Online Management Shell.

   2. Run the following cmdlet:
 
      ```powershell
      $cred = Get-Credential
      ```

      In the Windows PowerShell Credential required window, type your admin account and password, then click OK.

   3. Connect to SharePoint Online, and then run the following cmdlet:

      ```powershell
      Connect-SPOService -Url https://<contoso>-admin.sharepoint.com -Credential $cred
      ```

   4. Remove the user from each site collection.

      Run the following cmdlet:
  
      ```powershell
      Get-SPOUser -Site https://<contoso>.sharepoint.com | FT –a
      ```

    Notice the external user's Login Name in the returned results. As an external user, it might have a "live.com#" prefix if it's a Microsoft account.

    Type the following cmdlet:

     ```powershell
     Remove-SPOUser -Site https://<contoso>.sharepoint.com -LoginName live.com#jondoe@company.com
     ```

   > [!NOTE]
   > Replace live.com#jondoe@company.com with the user's login name in your scenario.

Next, you have to remove the account from Microsoft Entra ID:

 1. Download and install the Microsoft Graph PowerShell SDK by running the following command:

    ```powershell
    Install-Module Microsoft.Graph -Scope CurrentUser -Repository PSGallery 
    ```

1. Open PowerShell and connect to Microsoft Graph by running the following command:

   ```powershell
   Connect-MgGraph -Scopes "User.ReadWrite.All","Directory.ReadWrite.All"
   ```

1. Enter your administrator credentials in the dialog box.
   
1. Locate the external (guest) user by running the following command. This command filters for the guest account by UPN and displays the ID, UPN, and UserType of the account. 
   Replace `jondoe_contoso.com#EXT#@yourdomain.onmicrosoft.com` with the specific user in your scenario.

   ```powershell
   $guestUpn = 'jondoe_contoso.com#EXT#@yourdomain.onmicrosoft.com'
   Get-MgUser -Filter "UserPrincipalName eq '$guestUpn'" -Property Id,UserPrincipalName,UserType | Format-Table -AutoSize
   ```
   
1. Remove (soft-delete) the guest user by running the following command:

   ```powershell
   Remove-MgUser -UserId <user-id> -Confirm:$false
   ```
   
1. (Optional) Delete the guest user from the recycle bin permanenetly by running the following command:

   ```powershell
   $deleted = Get-MgDirectoryDeletedItem -Filter "Id eq '<user-id>'" -All
   Remove-MgDirectoryDeletedItem -DirectoryObjectId $deleted.Id -Confirm:$false
   ```
      
### Clear the browser cache

SharePoint Online uses browser caching in several scenarios, including the People Picker. Even though a user was fully removed from the system, the user may still remain in the browser cache. Clearing the browser cache resolves this issue. To do so for Internet Explorer, follow the steps given in [Viewing and deleting your browsing history](https://support.microsoft.com/help/17438).

When you clear the cache, make sure that you also select the **Cookies and website data** option.

### Reinvite the external user

After you follow these steps, reinvite the external user to the site by using the desired email address. To make sure that the end-user accepts with the appropriate email address, it's a best practice to copy the link in the invitation and then paste it into an InPrivate Browsing session. Doing so makes sure that no cached credentials are used to accept the invitation.

## More information

An external user invitation isn't required to be accepted by the email address to which it was first sent. It's a one-time invitation. If another user accepts the invitation, or if the user who accepts the invitation signs up by using an account other than the email address to which the invitation was sent, you may encounter an access denied message.

For example, a user is signed in through a browser by using a Microsoft account, and the user receives an email invitation to the user's external user account in the user's email application. Then, the user selects the link to accept the invite. However, based on the user's browser cookies, the user accidentally accepts the invite by using the incorrect identity.

When the user signs in to the resource by using the user's external user account, the user receives the error that the user isn't found in the directory.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
