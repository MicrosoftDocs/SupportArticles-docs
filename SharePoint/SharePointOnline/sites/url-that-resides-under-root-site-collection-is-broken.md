---
title: How to replace the root site in SharePoint Online 
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# How to replace the root site in SharePoint Online 

> [!IMPORTANT]
> Although the SharePoint Admin Center warns Admins of the consequences of deleting the root site, some Admins may still accidently delete the site or intentionally delete the site because they want to start over with the site. If the root site is deleted, users will experience the following problems immediately:
> - Users will receive an error 404 when trying to access the root site because the root site (https://contoso.sharepoint.com) is no longer available.  
> - All sites (https://contoso.sharepoint.com/sites or https://contoso.sharepoint.com/teams) that reside under the root site will be inaccessible for all users. 
Custom applications accessing sites or content may fail. 
> 
> **If you delete this site, all SharePoint sites in your organization will be inaccessible until you either restore the site or create a new site at \<Root URL>.**
>
> If users are experiencing any of these issues, the fastest resolution is to restore the root site from Deleted Sites (Recycle Bin). For more info about how to restore a root site, see [Restore a deleted site collection](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fsharepoint%2Frestore-deleted-site-collection%3FredirectSourcePath%3D%25252fen-us%25252farticle%25252frestore-a-deleted-site-collection-91c18651-c017-47d1-9c27-3a22f325d6f1&data=04%7c01%7cClaudia.Lake%40microsoft.com%7cefd613f51010438115e308d75703cf7e%7c72f988bf86f141af91ab2d7cd011db47%7c1%7c0%7c637073546195911174%7cUnknown%7cTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7c-1&sdata=6dAtTbo6%2FsxXD6DRhDkKR%2Fn82%2BuylVCE8%2FtADjnqcg4%3D&reserved=0).

## Summary

The root site URL for SharePoint Online is provisioned based off your input when setting up your Office 365 subscription. For example, if your organization name is Contoso, the root site for SharePoint Online will be https://contoso.sharepoint.com. The remainder of this document will utilize Contoso as the organization name for all examples.


## More information

To address issues caused by deleting a root site, and to continue to allow the admins to manage what site is at the root, Microsoft has introduced the following conditions: 

- Admins are no longer able to delete the root site from the SharePoint Modern Admin Center or the Manage Site Collections page in the SharePoint Admin Center. After selecting the site from the SharePoint Modern Admin Active Sites, Admins will see the **Delete** button greyed out, and hovering over the **Delete** button will inform the admin that **“The root site can’t be deleted.”** 
   > [!IMPORTANT]
   > Additional changes will soon be introduced to further prevent the root site from being deleted. This will include turning off the capability from PowerShell, Classic Admin Center, and Site Information. 

- To allow admins to manage which site is at the root, [Site Swap](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fsharepoint%2Fmodern-root-site%23swap-your-root-site&data=04%7c01%7cClaudia.Lake%40microsoft.com%7cefd613f51010438115e308d75703cf7e%7c72f988bf86f141af91ab2d7cd011db47%7c1%7c0%7c637073546195921169%7cUnknown%7cTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7c-1&sdata=GQPve6lSCJukoFM5UsAdYG22lNEsQzsrhci02YnHIyE%3D&reserved=0) has been introduced. Site Swap will allow admins to replace the root site with either a modern communication site or a classic team site. 
   > [!IMPORTANT]
   > Site Swap is available as a PowerShell cmdlet only. For more info about using this cmdlet and what happens with the previous root site, see [Invoke-SPOSiteSwap](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fpowershell%2Fmodule%2Fsharepoint-online%2Finvoke-spositeswap&data=02%7C01%7Cv-todmc%40microsoft.com%7Cb838e9fa97e44029b75208d758b1e83f%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637075393627150492&sdata=613RMNKp7kmUyftj4VYvzZ1vEbgEuFPQNxh6cY96oKc%3D&reserved=0). Site Swap will be available in the Modern SharePoint Admin Center as a **Replace** button in future versions. 



Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
