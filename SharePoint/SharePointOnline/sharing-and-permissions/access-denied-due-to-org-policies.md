---
title: SharePoint Online or OneDrive for Business access denied due to organizational policies error message 
ms.author: v-todmc
author: McCoyBot
manager: dcscontentpm
localization_priority: Normal
ms.date: 11/24/2020
ms.audience: Admin
ms.topic: article
ms.service: sharepoint-online
ms.custom: 
- CSSTroubleshoot
- CI 125266
search.appverid:
- SPO160
- MET150
ms.assetid: 
description: 'Describe a resolution to an "Access Denied due to organizational policies" error in SharePoint and OneDrive'
appliesto:
- SharePoint Online
- OneDrive for Business
---

# (Access Denied due to organizational policies) error in SharePoint or OneDrive

## Symptoms

Users receive the following error message when they try to sign in to SharePoint or OneDrive:

> **Access Denied**<br/>
> Due to organizational policies, you can't access this resource from this network location.

## Cause

This error might occur for administrators or users because of the implementation of a location-based policy. 

## Resolution

To resolve this issue, try the following method, depending on your level of permissions.

### Non-administrators
If you receive this error message, contact your [Microsoft 365 Administrator](https://docs.microsoft.com/microsoft-365/admin/add-users/about-admin-roles?view=o365-worldwide). 

### Administrators

If you are an administrator, and you have locked yourself out of SharePoint and OneDrive because of a location-based policy, follow these steps to unlock the tenant:
1.	Go to [https://admin.microsoft.com](https://admin.microsoft.com/).
2.	In the navigation pane, select **Support**, and then select **New Service Request**.

> [!note]
> This activates the **Need Help?** pane on the right side of the screen.

3.	In the **Briefly describe your issue** area, enter **Access Denied due to Network Location Restriction**, and then select **Enter**. 
 
4.	Select **Contact Support**.
5.	Under **Description**, enter **Access Denied due to Network Location Restriction**.
6.	Follow the steps in the following diagnostic.
 
## More information

For more information about location-based policies, see [Control access to SharePoint and OneDrive data based on network location](https://docs.microsoft.com/sharepoint/control-access-based-on-network-location).
