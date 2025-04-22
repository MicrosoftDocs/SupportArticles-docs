---
title: SharePoint Online out of storage space
description: Run a diagnostic to solve storage space issues.
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: prbalusu
ms.custom: 
  - sap:Storage\Tenant Storage
  - CSSTroubleshoot
  - CI 157728
appliesto: 
  - SharePoint Online
ms.date: 08/09/2024
---

# SharePoint Online out of storage space

<!-- This article has been reviewed and approved for the specific use of global admin perms.  -->

As a Global admin, you might get an email with one of the following messages:

> SharePoint Online is out of storage space.
> There is not enough storage space on SharePoint Online.

The amount of Microsoft SharePoint storage for your organization is based on the number of licenses you have.

Your organization has a total storage of 1 TB plus 10 GB per license of eligible plan purchased, plus any Microsoft 365 Extra File Storage add-on purchased.

If you suspect you should have more storage than is displayed in the Microsoft 365 admin center, Microsoft 365 admins can run the following diagnostic tool. It identifies any issues with your SharePoint tenant storage quota, and shows how the quota is allocated.

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This diagnostic isn't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

> [!div class="nextstepaction"]
> [Run Tests: Tenant Storage](https://aka.ms/PillarTenantStorage)

To troubleshoot any issues with your storage limits, see [Manage site storage limits](/sharepoint/manage-site-collection-storage-limits).

When the SharePoint storage quota is exceeded, here are some options to consider: 

1. Purchase add-on storage or additional licenses

1. Archive inactive content that needs be retained

1. Delete content that is no longer needed 

For more recommendations on how to manage SharePoint storage, see <u>[Plan for SharePoint storage - SharePoint in Microsoft 365 | Microsoft Learn](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flearn.microsoft.com%2Fen-us%2Fsharepoint%2Fsharepoint-storage-planning&data=05%7C02%7Csharonyam%40microsoft.com%7C6a7359f972ef4da446a408dd811cdc22%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638808683174454264%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=p6KOqwlec4YzrebIqkIG40%2BrkNugyk5%2BPo%2BELlHiNrg%3D&reserved=0"Original URL: https://learn.microsoft.com/en-us/sharepoint/sharepoint-storage-planning. Click or tap if you trust this link.")</u>. 

 

> [!TIP]
> While the tenant is over-quota, new sites cannot be created through PowerShell. Please note that it is a violation of the [Product Terms](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.microsoft.com%2Flicensing%2Fterms%2Fen-US%2Fproductoffering%2FSharePointOnline%2FMCA%3Fmsockid%3D24d26293f5aa60550ff1771bf487610c&data=05%7C02%7Csharonyam%40microsoft.com%7C6a7359f972ef4da446a408dd811cdc22%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638808683174366595%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=9z%2Bu%2FryaZV19BhzYF1QphQ9zJjCN6aTj6yqN1AKJwGE%3D&reserved=0"Original URL: https://www.microsoft.com/licensing/terms/en-US/productoffering/SharePointOnline/MCA?msockid=24d26293f5aa60550ff1771bf487610c. Click or tap if you trust this link.") to remain over-quota. 

> [!NOTE]
> Education tenants will have a different experience with pooled storage. For what happens when pooled storage is exceeded, please see: [pooled storage management](/microsoft-365/education/deploy/pooled-storage-management).

## References

- [SharePoint limits](/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-limits)
- [Add storage space for your subscription](/microsoft-365/commerce/add-storage-space)
- [SharePoint storage planning](/sharepoint/sharepoint-storage-planning)
