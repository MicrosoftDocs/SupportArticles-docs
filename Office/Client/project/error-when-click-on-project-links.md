---
title: Error when you click on the Projects link in the top navigation bar in Project Online
description: Provides a fix for an error that occurs when you select the Project link.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Project Online
ms.date: 8/10/2024
---

# Error when you click on the Projects link in the top navigation bar in Project Online

## Symptoms

When you click the Projects link from the Microsoft 365 ribbon to get to Project Web Access, you receive one of the following errors:

> Error  
> An unexpected error has occurred.  
> Troubleshoot issues with Microsoft SharePoint Foundation.  
> Correlation ID: ########-####-####-############  
> Date and Time: \<date and time>

Or

> Sorry, this site isn't available right now.  
> Give us a few minutes and try again. If it still doesn't work, contact your administrator.  
> \-------------------------------------------------------------------------------  
> GO BACK TO SITE

You can still navigate to Project Web App by manually entering the URL in the address bar or with admin permissions go to SharePoint admin center, click the link to the PWA site collection once, when the dialog comes up click the link again.

## Cause

This issue occurs in the following scenarios:

### Cause 1

Your Office365 tenant was recently upgraded and your Tenant Admin has not yet manually upgraded the My Site collection for your tenant.

### Cause 2

The default PWA site with the suffix "/sites/PWA" e.g. `https://domainname.sharepoint.com/sites/PWA` has been renamed or deleted.

## Resolution

### Resolution steps for Cause 1

1. Log into your online tenant with a SharePoint admin account.

2. Select the drop-down list for **Admin** and then select SharePoint to open the SharePoint admin center.

3. Check the box next to the URL for your My Site collection, for example `https://domainname-my.sharepoint.com`.

4. On the ribbon, select **Upgrade** and then select **Site collection upgrade settings**.

5. In the Site collection upgrade settings dialog, select the **Link to upgrade** page.

6. Select the link to **REVIEW SITE COLLECTION UPGRADE STATUS** and upgrade the site.

The My Site collection will be upgraded for all users in your tenant and the Projects link will now navigate to the default web site which ends in PWA, for example `https://domainname.sharepoint.com/sites/PWA`.

### Resolution steps for Cause 2

The Project link in the top navigation bar requires a default PWA site which has the following suffix "/sites/PWA" for the link to work, for example `https://domainname.sharepoint.com/sites/PWA`.

You can either restore the default PWA site that may have been deleted but is still in the Recycle bin, or create a new PWA site in the Sharepoint admin center and name the new site as "PWA".
