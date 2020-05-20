---
title: Troubleshoot OneDrive for Business sites that stop at provisioning stage
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 12/18/2019
audience: Admin
ms.topic: article
ms.prod: onedrive
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- OneDrive for Business
ms.custom: 
- CI 112027
- CSSTroubleshoot 
ms.reviewer: prbalusu 
description: Guide to troubleshooting provisioning issues in OneDrive for Business sites. 
---

# Troubleshooting guide to OneDrive for Business sites stopped at provisioning stage

## Summary

This article will help you troubleshoot user accounts whose OneDrive for Business sites have provisioning issues such as:

- Being unable to select a OneDrive tile stopped at the "Setting up" or "We're still working on getting files setup on SharePoint This should take us a few minutes" message.
- Selecting a OneDrive tile that redirects you to the **Delve** page. 
- Selecting a OneDrive tile redirects you to the **MyBraryFirstRun.aspx** page.


## More information

Listed below are some recommendations to help resolve the issue.

### If the user account is disabled on the tenant

1. Navigate to the [Office 365 Admin Center](https://admin.microsoft.com/AdminPortal/Home#/homepage). 
2. Under **Users**, select **Active users**.
3. Search for and select the user account experiencing the issue. Select **OK** in the dialog box that opens.  
4. If the message "Sign in blocked" is displayed, unblock the user by selecting the "blocked"  icon (![Blocked icon.](media/troubleshooting-guide-for-sites/blocked-icon.jpg)).
!["Sign in blocked" message.](media/troubleshooting-guide-for-sites/troubleshooting-sign-in-blocked.jpg)<br/>
   > [!NOTE]
   > If the user account is synced from the Local AD, the user will have to be enabled in the Local AD and wait for the AD sync to occur. 

### If the user account does not have an appropriate license assigned

1. Navigate to the [Office 365 Admin Center](https://admin.microsoft.com/AdminPortal/Home#/homepage). 
2. Under **Users**, select **Active users**.
3. Search for and select the user account experiencing the issue. Select **OK** in the dialog box that opens.  
4. Select **Licenses and Apps**.<br/>
5. Ensure that **SharePoint Online app** is selected from the available licenses that enable OneDrive.

### The user account is missing permissions to create Personal or OneDrive sites in user profiles

**Everyone except external users**: (EEEU) are provided with **Create Personal Site** permission by default. For any business reason, Create Personal Site is not selected, that user facing the issue should be added to any other Security group that has **Create Personal Site** selected or added individually.

To check whether **Create Personal Site** is selected:

1. Navigate to the **Modern SharePoint Admin Center**. 
2. Select **More features**. This will open a new tab.
3. In the new tab, select **Open** under **User profiles**. 
4. Select **Manage user permissions**.
5. Select the **Everyone except external users** permission group and check that **Create Personal Site** is selected.
![Create Personal Site permission dialog box.](media/troubleshooting-guide-for-sites/troubleshooting-create-personal-site.jpg)

For more information about this, see [Disable OneDrive creation for some users](https://docs.microsoft.com/sharepoint/manage-user-profiles#disable-onedrive-creation-for-some-users).

### The user account does not have a user profile in SharePoint Online

A profile **must** exist in the SharePoint Online profile database to provision a OneDrive site. A profile is created when a user account is created and synched to the Office 365 portal, or during ODB provisioning if one does not exist. 

It is a rare scenario that a profile does not exist. For any reason, a profile is taking longer than expected to create, wait at least two hours and then validate again.
   > [!NOTE]
   > For tenants with an EDU subscription, user profiles are not created until the user logs into SharePoint Online or an admin has processed the user account for [OneDrive pre-provisioning](https://docs.microsoft.com/onedrive/pre-provision-accounts).

To validate that a profile exists:

1. Navigate to the **Modern SharePoint Admin Center**. 
2. Select **More features**. This will open a new tab.
3. In the new tab, select **Open** under **User profiles**.
4. Select **Manage user profiles**.
5. In **Find profiles**, enter the user e-mail and select **Find**.


### The user profile is set as Guest.

To remove a guest attribute from a user profile:

1. Navigate to the **Modern SharePoint Admin Center**. 
2. Select **More features**. This will open a new tab.
3. In the new tab, select **Open** under **User profiles**.
4. Select **Manage user profiles**.
5. In **Find profiles**, enter the user e-mail and select **Find**.
6. In the results displayed, hover your cursor next to the name of the user. In  the drop-down box, select **Edit my profile**.
7. In the field **Personal site capabilities**, remove the value that has been set.
8. Select **Save and Close**.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
