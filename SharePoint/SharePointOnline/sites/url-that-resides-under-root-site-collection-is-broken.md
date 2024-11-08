---
title: How to replace the root site in SharePoint Online
description: Provides steps about how to replace the root site in SharePoint Online.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:SharePoint Admin Center\Deleted Sites
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# How to replace the root site in SharePoint Online

> [!IMPORTANT]
> Although the SharePoint Admin Center warns Admins of the consequences of deleting the root site, some Admins may still accidently delete the site or intentionally delete the site because they want to start over with the site. If the root site is deleted, users will experience the following problems immediately:
>
> - Users will receive an error 404 when trying to access the root site because the root site (`https://contoso.sharepoint.com`) is no longer available.  
> - All sites (`https://contoso.sharepoint.com/sites` or `https://contoso.sharepoint.com/teams`) that reside under the root site will be inaccessible for all users. 
Custom applications accessing sites or content may fail.
>
> **If you delete this site, all SharePoint sites in your organization will be inaccessible until you either restore the site or create a new site at \<Root URL>.**
>
> If users are experiencing any of these issues, the fastest resolution is to restore the root site from Deleted Sites (Recycle Bin). For more info about how to restore a root site, see [Restore a deleted site collection](/sharepoint/restore-deleted-site-collection).

## Summary

The root site URL for SharePoint Online is provisioned based off your input when setting up your Microsoft 365 subscription. For example, if your organization name is Contoso, the root site for SharePoint Online will be `https://contoso.sharepoint.com`. The remainder of this document will utilize Contoso as the organization name for all examples.

## More information

To address issues caused by deleting a root site, and to continue to allow the admins to manage what site is at the root, Microsoft has introduced the following conditions: 

- The root (top-level) site for your organization can't be deleted. Admins are no longer able to delete the root site from the SharePoint Modern Admin Center or the Manage Site Collections page in the SharePoint Admin Center. After selecting the site from the SharePoint Modern Admin Active Sites, Admins will see the **Delete** button greyed out, and hovering over the **Delete** button will inform the admin that **"The root site can't be deleted."** If you're a global or SharePoint admin in Microsoft 365, you can replace the root site with a different site.

- To allow admins to manage which site is at the root, [Site Swap](/sharepoint/modern-root-site#swap-your-root-site) has been introduced. Site Swap will allow admins to replace the root site with a modern communication site. 

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
