---
title: Error occurs when accessing Project Web App
description: Provides resolutions for errors when accessing PWA Online
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Project Online
  - Project Server 2013
ms.date: 05/26/2025
---

# Error occurs when accessing Project Web App

## Symptoms

After you successfully sign in to your tenant, you either select the **Projects** link or navigate to a Project Web App (PWA) site. However, you receive one of the following error messages and can't access PWA:

"Sorry this site has not been shared with you."

Or

"Access denied"

Or

"Let us know why you need access to this site."

## Cause

1. You don't have permissions to the root PWA site or given group permissions.
2. Project Online was added to your tenant after SharePoint Online was already provisioned, so no one has access to PWA.

## Resolution

### Resolution for Cause 1

When using SharePoint Permissions mode:

1. Log in to the online tenant as the PWA admin.
2. Navigate to the PWA home page that the user needs access to.
3. In the upper right corner underneath the account name, select the **SHARE** icon.
4. Add the user (user@domain.com).

The user receives the **Contribute** permission and is added to the group named "Team Members for Project Web App" on the root PWA site. You can change the default by clicking the **SHOW OPTIONS** link in the dialog box.

Wait for about 2 minutes and then ask the user to test their access to the PWA site.

When using Project Server Permissions mode:

1. Log in to the online tenant as the PWA admin.
1. Navigate to the PWA home page that the user needs access to.
1. Navigate to **Server Settings** and select **Manage Groups**. Then select the group that you wish to add the user to.
1. Either synchronize the group with an Active Directory group or add the user manually from the available users' list.  

   For a user name to appear in the available users list, the user must already have permissions to the PWA root site. Share the root PWA site by using the steps for the SharePoint Permissions mode.

### Resolution for Cause 2

1. Log in to the online tenant as the tenant Administrator.
2. From the **Admin** menu drop-down list, select **SharePoint** to go to the SharePoint admin center.
3. Check the box next to the PWA site where you want to add an administrator.  
4. On the **Site Collections** ribbon, select **Owners** and then select "**Manage Administrators**.
5. In the **Site collection Administrators** dialog box, add the user and select **OK**.

## More Information

This behavior is by design for Project Online (and Project Server 2013) regardless of the permissions mode on the PWA site.

SharePoint Permissions mode details - The PWA Admin must share the root site with users. The user is given a specific set of permissions at the same time the root site is shared. These permissions determine what they can see and do within just the PWA site. Access to Project Sites is done in the same way, and individual sites must be shared with individual users.

Project Server Permissions mode details - Users are added manually or synchronized using Active Directory groups (not SharePoint groups). If users are added manually, the PWA root site must be shared for the users to be listed on the Available Users list in Manage Groups.  

When you use Active Directory group synchronization, users are added to the Project Server group and the root PWA site is shared with them.  

To check the permissions mode that your PWA site is using, use the following information:

Visual Check - When signed in as a PWA admin, select the gear icon in the upper right corner of the PWA home page and then select PWA Settings. If you see the **Security** section, then you are in Project Server permissions mode. If you don't see this section, then you are in SharePoint permissions mode.

SharePoint Admin Check - The SharePoint admin can go to the **Admin** menu and select **SharePoint**. Then select the check box to the left of the Project Web App instance you want to investigate. On the ribbon, select **Project Web App** and select **Settings**. The current permissions mode in use is displayed.

Project Web App can use either Project Server permission mode or SharePoint permission mode to control user access. New Project Web App instances use the SharePoint permission mode by default. SharePoint permissions mode doesn't synchronize users with the root site or the project sites. The synchronization occurs only when Project Server permissions mode is in use and configured to synchronize.

> [!WARNING]
> Switching between Project Server permission mode and SharePoint permission mode deletes all security-related settings.

Group Names:
When you use the SharePoint Permissions mode, "For Project Web App" is appended to the group name. When using Project Server permission mode, "(Project Web App Synchronized)" is appended to the group name.

Enterprise Resource Pool - User accounts added to the Enterprise Resource Pool aren't automatically given permissions to log in to the Project Web App home page. This behavior is new in the 2013 version compared to earlier versions of Project Server, regardless of the security mode. This behavior prevents users from having access to the Project Web App home page automatically. The PWA admin must "Share" the site with specific users or groups for users to have access.

To get more information and best practices see the following article:

[https://technet.microsoft.com/en-us/library/jj819449.aspx](https://technet.microsoft.com/library/jj819449.aspx)
