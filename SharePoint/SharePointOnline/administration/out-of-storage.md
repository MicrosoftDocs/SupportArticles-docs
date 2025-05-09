---
title: SharePoint in Microsoft 365 Out of Storage Space
description: Run a diagnostic to solve SharePoint storage space issues.
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
ms.date: 05/08/2025
---

# SharePoint Online out of storage space

<!-- This article has been reviewed and approved for the specific use of global admin perms.  -->

## Symptoms

As a Global admin, you receive an email message that contains one of the following messages:

> SharePoint Online is out of storage space.
> 
> There is not enough storage space on SharePoint Online.

## Cause

The amount of Microsoft SharePoint storage for your organization is based on the number of licenses that you have.

Your organization has a total storage allowance of 1 TB plus 10 GB per license of eligible plan purchased, plus any Microsoft 365 Extra File Storage add-ons that you purchase. For more information, see  [SharePoint limits](/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-limits).

## Resolution

If you suspect that you should have more storage than the amount that you see in the Microsoft 365 admin center, Microsoft 365 admins can run the following diagnostic tool. The tool identifies any issues that affect your SharePoint tenant storage quota. It also shows how the quota is allocated.

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This diagnostic isn't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

> [!div class="nextstepaction"]
> [Run Tests: Tenant Storage](https://aka.ms/PillarTenantStorage)

To troubleshoot any issues that affect your storage limits, see [Manage site storage limits](/sharepoint/manage-site-collection-storage-limits).

If the SharePoint storage quota is exceeded, consider the following options: 

- Purchase [add-on storage](/microsoft-365/commerce/add-storage-space) or extra licenses.
- Archive inactive content that should be retained.
- Delete content that's no longer needed.

For more recommendations about how to manage SharePoint storage, see [SharePoint storage planning](/sharepoint/sharepoint-storage-planning).
