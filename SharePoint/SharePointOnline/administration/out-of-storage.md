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

For more recommendations on how to manage SharePoint storage, see [SharePoint storage planning](/sharepoint/sharepoint-storage-planning). 

 

> [!TIP]
> While the tenant is over-quota, new sites cannot be created through PowerShell. Please note that it is a violation of the [Product Terms](https://www.microsoft.com/licensing/terms/en-US/productoffering/SharePointOnline/MCA?msockid=24d26293f5aa60550ff1771bf487610c) to remain over-quota. 

> [!NOTE]
> Education tenants will have a different experience with pooled storage. For what happens when pooled storage is exceeded, please see: [pooled storage management](/microsoft-365/education/deploy/pooled-storage-management).

## References

- [SharePoint limits](/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-limits)
- [Add storage space for your subscription](/microsoft-365/commerce/add-storage-space)
- [SharePoint storage planning](/sharepoint/sharepoint-storage-planning)
