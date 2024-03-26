---
title: Cannot Access Newly Purchased Project Online with License
description: If the Office365 Administrator has purchased just one license for you to access Project Online, you may have trouble gaining access until the site is properly configured.  Here are the steps to configure your new Project Online site.
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
ms.date: 03/31/2022
---

# Cannot Access Newly Purchased Project Online with One License

## Summary

Having a license to Project Online is just the first step in getting started with Project Web App (PWA). Next, your account needs to be given permissions to access the PWA Home page. This can be a bit tricky if your organization has only purchased one license for evaluation. Your Tenant Admin can assign you the license, but if the Tenant Admin has not first configured access for you to the default PWA site, you will receive some type of error message. The most common error would be "Access Denied".

To work around this issue the Tenant Admin can make you the PWA Admin and you can then manage the access for users to the PWA Home page.  

## More Information

To set a PWA Admin the Tenant Admin needs to follow these steps:

1. Log into Microsoft 365 as the Tenant Administrator, click Admin and select SharePoint   
2. Check the box to the left of the default PWA site   
3. Click the Owners dropdown menu and select Manage Administrators   
4. Enter the user account that will be the Site Collection Administrators and click OK 

Once you have been made PWA Administrator, you will be able to navigate to the Project Online by clicking the link that appears in the ribbon. You will either see Projects or an ellipsis menu that has the Projects link.

Your next step will be to configure PWA for your evaluation. Use the following link for [Getting Started with Project Online](https://office.microsoft.com/project-server-help/get-started-with-project-online-ha102858793.aspx).