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

In this article:

> Understanding SharePoint storage
> 
> Over quota experience
> 
> Managing an over quota tenant 
> References

### Understanding SharePoint storage

As a Global admin, you might get an email with one of the following messages:

> SharePoint Online is out of storage space.
> There is not enough storage space on SharePoint Online.

The amount of Microsoft SharePoint storage for your organization is based on the number of licenses you have.

Your organization has a total storage of 1 TB plus 10 GB per license of eligible plan purchased, plus any Microsoft 365 Extra File Storage add-on purchased.

If you suspect you should have more storage than is displayed in the Microsoft 365 admin center, Microsoft 365 admins can run the following diagnostic tool. It identifies any issues with your SharePoint tenant storage quota and shows how the quota is allocated.

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This diagnostic isn't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

> [!div class="nextstepaction"]
> [Run Tests: Tenant Storage](https://aka.ms/PillarTenantStorage)

To troubleshoot any issues with your storage limits, see [Manage site storage limits](/sharepoint/manage-site-collection-storage-limits).

### Over quota experience 

The over quota experience differs depending on the type of licenses in your tenant.  

1. For developer tenants with only Microsoft 365 E3 or E5 Developer SKU:

   1. During the first 30 days of being over quota, banner and email notifications will be sent.  
      
   1. After 30 days of being over quota, the tenant will go into read-only.  
      
   1. After 60 days of being over quota, the tenant data will be deleted.  
      
   1. After 90 days of being over quota, tenant admin loses access to tenant. The tenant admin is blocked from rejoining or creating a new account. 
      
   1. After 120 days of being over quota, the subscription is deactivated.  
      
1. For education tenants that are subject to pooled storage policy:  

   1. After the 30-day grace period, all OneDrive accounts and SharePoint sites will go into read-only. Learn more: [pooled storage management](/microsoft-365/education/deploy/pooled-storage-management). 
      
1. For commercial tenants (not developer and not education):  

   1. New sites can't be created through PowerShell.
      
> [!NOTE]
> It's a violation of the [Product Terms](https://www.microsoft.com/licensing/terms/en-US/productoffering/SharePointOnline/MCA?msockid=24d26293f5aa60550ff1771bf487610c) to remain over quota.

### Managing an over quota tenant 

When the SharePoint storage quota is exceeded, here are some options to consider: 

1. Purchase add-on storage or extra licenses

1. Archive inactive content that should be retained

1. Delete content that is no longer needed 

For more recommendations on how to manage SharePoint storage, see [SharePoint storage planning](/sharepoint/sharepoint-storage-planning). 

### References

- [SharePoint limits](/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-limits)
- [Add storage space for your subscription](/microsoft-365/commerce/add-storage-space)
- [SharePoint storage planning](/sharepoint/sharepoint-storage-planning)
