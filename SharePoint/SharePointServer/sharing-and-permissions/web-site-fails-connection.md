---
title: Access denied when connecting to a Windows SharePoint Services Web site
description: You cannot connect a Windows SharePoint Services 2.0 or a Windows SharePoint Services 3.0 Web site even though you are logged on by using a user account that's a member of the Domain Administration group.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
appliesto:
- SharePoint Online
---

# You receive an "Access denied" or a "Cannot complete this action" error message when you try to connect to a Windows SharePoint Services Web site

## Symptoms

When you try to connect a Microsoft Windows SharePoint Services 2.0 or a Microsoft Windows SharePoint Services 3.0 Web site, you may receive an error message that is similar to one of the following:

- **Access denied. You do not have permission to perform this action or access this resource. Access requests are not enabled.**
- **Cannot complete this action. Please try again.**

You may experience this symptom even though you are logged on by using a user account that is a member of the Domain Administration group and you are the site owner of the Windows SharePoint Services Web site.

## Cause

This issue occurs if you delete the user account in Microsoft Windows, and then re-create the user account by using the same user name. Windows generates a unique security identifier (SID) for each new user account that you create. In situations where you delete a user account in Windows, and then re-create it by using the same name, you must remove and then add the new user account to the site collection in Windows SharePoint Services before the user can view Web pages in that site collection.

## Resolution

To resolve this issue, use one of the following methods as appropriate to your situation.

### Method 1: If the User Is a Member of the Users Group

If the user is a member of the Users group in Windows, remove the existing user account from the site collection in Windows SharePoint Services, and then add the new user account that you re-created to the site collection. To do so, follow these steps:

#### Windows SharePoint Services 3.0

1. Connect to the Windows SharePoint Services 3.0 Web site by using a user account that has administrator permissions to the site collection.
1. Click **Site Actions**, and then click **Site Settings**.
1. On the Site Settings page, click **People and groups** under **Users and Permissions**.
1. Click to select the check box next to the user account that you want to remove from the site collection, and then click **Remove Users from Group** under **Actions**.
1. Click **OK** when you are prompted to confirm the removal.
1. Click **Site Actions**, and then click **Site Settings**.
1. On the Site Settings page, click **People and groups** under **Users and Permissions**.
1. On the People and Groups page, click **New**, and then click **Add Users**.
1. On the Add Users Central Administration page, type **DomainName\UserName** in the **Users/Groups** box, click **Check Names**, click to select the permissions that you want the user to have under **Give Permission**, and then click **OK**.

   > [!NOTE]
   > You may add a user to a SharePoint group by selecting a group from the **Add users to a SharePoint group** list under **Give Permission**.

#### Windows SharePoint Services 2.0

1. Connect to the Windows SharePoint Services 2.0 Web site by using a user account that has administrator permissions to the site collection.
1. Click **Site Settings**.
1. On the Site Settings page, under **Administration**, click Go to **Site Administration**.
1. On the Top-level Site Administration page, under **Site Collection Administration**, click **View site collection user information**.
1. Click to select the check box next to the user account that you want to remove from the site collection, and then click **Remove Selected Users**.
1. Click **Yes** when you are prompted to confirm the removal.
1. Click **Site Settings**.
1. On the Site Settings page, under **Administration**, click **Go to Site Administration**.
1. On the Top-level Site Administration page, under **Users and Permissions**, click **Manage Users**.
1. On the Manage Users page, click **Add Users**.
1. On the Add Users: **SiteName** page, in the **Step 1: Choose users** area, type the name of the user account that you want to add in the **Users** box.

   Make sure that you specify the name of the user by using the following format:

   **DomainName\UserName**

1. In the **Step 2: Choose Site Groups** area, click to select the check box next to the site group that you want to assign the user, and then click **Next**.
1. Confirm the user who you want to add to the site, specify the e-mail option that you want, and then click **Finish**.

### Method 2: If the user is member of the Domain Administration group and is site owner

If the user is a member of the Domain Administration group in Windows and is also listed as the site owner of the Windows SharePoint Services Web site, temporarily specify a different user account as the site owner, remove the temporary site owner, and then specify the new account that you re-created as the site owner. To do so, follow these steps:

1. Log on to Windows as an administrator with sufficient permissions to administer the site. 

   Make sure that you do not log on by using the user account that you re-created.

1. Start Windows SharePoint Services Central Administration.
1. Under **Security Configuration**, click **Manage site collection owners**.
1. In the **Site URL** area, type the URL of the site collection in the **Web Site URL** box, and then click **View**.
1. In the **Site Collection Owner** area, type a different user account in the **User name** box to temporarily configure a new site owner.

   Make sure that you specify the name of the user account by using the following format:

   **DomainName\UserName**
1. Click **OK**.
1. On the Windows SharePoint Services Central Administration page, under **Security Configuration**, click **Manage site collection owners**.
1. Under **Security Configuration**, click **Manage site collection owners**.
1. In the **Site URL** area, type the URL of the site collection in the **Web Site URL** box, and then click **View**.
1. In the **Site Collection Owner** area, type the user account that you created in the **User name** box.

   Make sure that you specify the name of the user account by using the following format:

   **DomainName\UserName**
1. Click **OK**.

### Method 3: If you use Microsoft Office Project Server 2003 features that rely on Windows SharePoint Services

If you are also using Microsoft Office Project Server 2003 features that rely on Windows SharePoint Services, following these steps to avoid receiving this error message when you access documents:

1. Log on to Project Web Access as an administrator.
1. Click the **Admin** tab, click **Manage SharePoint Service**, and then click **Manage SharePoint Sites**.
1. Click the Project name, and then click **Synchronize**.

Now, the new user profile that is updated in Windows is updated in Project Server. This new user profile is now synchronized with the Windows SharePoint Services profile.

## More Information

You may experience this problem if the user accounts are migrated by using the Active Directory Migration Tool. This tool creates a new account in the target domain. Therefore permissions will have to be re-applied for the user to gain access. Consider a scenario where a user is in a Child Domain in the forest, for example CHILD\cuser1. This account is then migrated to a parent domain by using the migration tool, and now becomes PARENT\cuser1. In this scenario, a new SID is applied to the migrated account, and the users old SID/user information still resides on the WSS/SharePoint site. You have to re-permission the site with the new account for the user to regain access.

For more information about Windows SharePoint Services, see [SharePoint Document](https://docs.microsoft.com/sharepoint/).