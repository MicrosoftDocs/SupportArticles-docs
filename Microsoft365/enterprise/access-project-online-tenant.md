---
title: Access Project Online Tenant
description: Describes that how to access Project Online Tenant.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
search.appverid: 
- MET150
appliesto:
- Office 365
---

# How do I Access my Project Online Tenant

## Summary

When you log into Office 365 there is a menu bar across the top of the page.  If you have been assigned a license to Project Online then you will see a **Projects** link either on the menu bar or in the ellipsis menu (...) that displays between **Sites** and **Admin**. Clicking the **Projects** link will take you to the default Project Web App (PWA) site created by Microsoft when your organization first added Project Online to your tenant.  

If your Tenant Administrator has created additional PWA sites, you will not be able to navigate to those sites via this link.  The **Projects** link only goes to the first PWA site setup online.  The address of this default site is [https://<your_tenant>.sharepoint.com/sites/PWA](https://%3cyour_tenant%3e.sharepoint.com/sites/PWA). If your tenant admin deletes the default site for some reason then this link will be bad and you may recieve and error: a 404 – webpage cannot be found. The link actually goes to [-my.sharepoint.com/_layouts/15/MyProjects.aspx">https://<your_tenant>-my.sharepoint.com/_layouts/15/MyProjects.aspx](https://%3cyour_tenant%3e-my.sharepoint.com/_layouts/15/MyProjects.aspx) – which redirects to the default site. 

Having a license to Project Online is just the first step in getting started with Project Web App (PWA).  Next, your account needs to be given permissions to access the PWA Home page.  This can be a bit tricky if your organization has only purchased one Project Online license. The Tenant Admin can assign you a license, but if you are not the PWA Admin you will not be able to access the PWA Home page. See the steps below to correctly configure your tenant to use Project Online.

To set a PWA Admin the Tenant Admin needs to follow these steps: 

1. Log into Office 365 as the Tenant Administrator, click **Admin** and select **SharePoint**.   
2. Check the box to the left of the PWA site you want administer.   
3. Click the **Owners** dropdown menu and select **Manage Administrators**.   
4. Enter the user account for the **Site Collection Administrators** and click **OK**.   

Next, the PWA Administrator will add users with licenses to Project Online to the appropriate groups on the PWA home page in order for them to access the site.  To do this follow these steps:

1. Navigate to the PWA site you want to add users too.   
2. Click the **SHARE** link in the upper right of the page under your user name.   
3. Add the user account here.  The user will receive the default permissions of Contribute when you click **Share**.    
4. If you want to assign a different level or permissions, click **SHOW OPTIONS** to **Select a group or permission level**.  Then click **Share**.    

Alternate method to Share the site: 

1. Click the gear in the upper right of the page at the right of your user name and click **Shared with...**   
2. You can use **INVITE PEOPLE** which is the same as using the **SHARE** link above or click **ADVANCED**   

**ADVANCED** takes you to a list of all the groups available on the site, you can add user directly to groups. You alos have access to **Grant Permissions**, **Check Permissions** as well as other permission related tasks. 

## More Information

**Navigating to other PWA sites in your Tenant**

To get to the other PWA sites, there is no link in the menu so you will have to navigate to those sites manually. One way to get to a site is by entering the full URL to the site in the address bar.  Then click the **Follow** icon to add a link for this PWA site to your **Sites** page. Once you are following the site you can click **Sites** to see links to all the sites you are following.  

Additionally, the Tenant Admin can promote the site so that the site will automatically be available to all tenant user son their **Sites** page. To do this follow these steps:

1. Log into Office 365 as the Tenant Administrator, click **Admin** and select **SharePoint**.   
2. Click the hyperlink for the PWA site you wish to setup an icon for.  When the "site collection properties" dialog displays, click the web site address link again, this will take you to the site.   
3. Click the **FOLLOW** link in the upper right of the page under your name.  Now that you are following the site you can promote it for all your tenant users.   
4. Click **Sites** on the menu bar and click **Manage** the promoted site below.   
5. Click **Add a promoted site**.  In this dialog enter a **Title** and the **Link Location** for the site.  Click **Save changes**.   

A tile icon is added to the top of the page for all tenant users.  When the tile is clicked they are taken to the site.

**Additional Related Articles:**

- PJO - A user gets an access denied error when trying to open the project tab - KB 2837932   
- PJO - When you click Projects link you receive "An unexpected error has occurred." - KB 2852211   
- PJO - Unable to access PWA \ Approvals page - 2845774   
- PJO - "The site is read only at the moment" message when accessing PWA - 2812372   
- PJO or PSVR 2013 Security to View and/or Edit specific plans - 2860324   
- Project Online:  Getting to Project Web App - [https://blogs.technet.com/b/projectsupport/archive/2013/05/15/project-online-getting-to-project-web-app.aspx](https://blogs.technet.com/b/projectsupport/archive/2013/05/15/project-online-getting-to-project-web-app.aspx)   
