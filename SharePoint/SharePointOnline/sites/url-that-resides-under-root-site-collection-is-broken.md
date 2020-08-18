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

## Summary

The root site URL for SharePoint Online is provisioned based off your input when setting up your Office 365 subscription. For example, if your organization name is Contoso, the root site for SharePoint Online will be `https://contoso.sharepoint.com`. The remainder of this document will utilize Contoso as the organization name for all examples.

## More information

To address issues caused by deleting a root site, and to continue to allow the admins to manage what site is at the root, Microsoft has introduced the following conditions: 

- The root (top-level) site for your organization can't be deleted. Admins are no longer able to delete the root site from the SharePoint Modern Admin Center or the Manage Site Collections page in the SharePoint Admin Center. After selecting the site from the SharePoint Modern Admin Active Sites, Admins will see the **Delete** button greyed out, and hovering over the **Delete** button will inform the admin that **"The root site can't be deleted."** If you're a global or SharePoint admin in Microsoft 365, you can replace the root site with a different site.

- To allow admins to manage which site is at the root, [Site Swap](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fsharepoint%2Fmodern-root-site%23swap-your-root-site&data=04%7c01%7cClaudia.Lake%40microsoft.com%7cefd613f51010438115e308d75703cf7e%7c72f988bf86f141af91ab2d7cd011db47%7c1%7c0%7c637073546195921169%7cUnknown%7cTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7c-1&sdata=GQPve6lSCJukoFM5UsAdYG22lNEsQzsrhci02YnHIyE%3D&reserved=0) has been introduced. Site Swap will allow admins to replace the root site with either a modern communication site or a classic team site. 
   > [!IMPORTANT]
   > Site Swap is available as a PowerShell cmdlet only. For more info about using this cmdlet and what happens with the previous root site, see [Invoke-SPOSiteSwap](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fpowershell%2Fmodule%2Fsharepoint-online%2Finvoke-spositeswap&data=02%7C01%7Cv-todmc%40microsoft.com%7Cb838e9fa97e44029b75208d758b1e83f%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637075393627150492&sdata=613RMNKp7kmUyftj4VYvzZ1vEbgEuFPQNxh6cY96oKc%3D&reserved=0). Site Swap will be available in the Modern SharePoint Admin Center as a **Replace** button in future versions. 

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
