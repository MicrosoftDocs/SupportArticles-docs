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

As a Global admin, you might get an email with one of the following messages:

- > SharePoint Online is out of storage space.
- > There is not enough storage space on SharePoint Online.

## Cause

The amount of Microsoft SharePoint storage for your organization is based on the number of licenses you have.

Your organization has a total storage of 1 TB plus 10 GB per license of eligible plan purchased, plus any Microsoft 365 Extra File Storage add-on purchased. For more information, see  [SharePoint limits](/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-limits).

## Resolution

If you suspect you should have more storage than is displayed in the Microsoft 365 admin center, Microsoft 365 admins can run the following diagnostic tool. It identifies any issues with your SharePoint tenant storage quota and shows how the quota is allocated.

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This diagnostic isn't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

> [!div class="nextstepaction"]
> [Run Tests: Tenant Storage](https://aka.ms/PillarTenantStorage)

To troubleshoot any issues with your storage limits, see [Manage site storage limits](/sharepoint/manage-site-collection-storage-limits).

When the SharePoint storage quota is exceeded, consider one of the following options: 

- Purchase [add-on storage](/microsoft-365/commerce/add-storage-space) or extra licenses.
- Archive inactive content that should be retained.
- Delete content that's no longer needed.

For more recommendations on how to manage SharePoint storage, see [SharePoint storage planning](/sharepoint/sharepoint-storage-planning).
