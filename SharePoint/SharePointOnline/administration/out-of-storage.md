---
title: SharePoint in Microsoft 365 Out of Storage Space
description: Run a diagnostic to solve SharePoint storage space issues.
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: prbalusu, trgreen
ms.custom: 
  - sap:Storage\Tenant Storage
  - CSSTroubleshoot
  - CI 157728
appliesto: 
  - SharePoint Online
ms.date: 05/12/2026
---

# SharePoint Online out of storage space

<!-- This article has been reviewed and approved for the specific use of global admin perms.  -->

## Symptoms

As a Global or SharePoint admin, you receive an email message that contains one of the following messages:

> SharePoint Online is out of storage space. Sites are in read-only mode and changes can't be saved. 
> 
> There is not enough storage space on SharePoint Online.
> Your storage is full. You can buy more storage or use Microsoft 365 Archive to free up storage space without deleting any data.

## Cause

The Microsoft SharePoint storage quota for your organization is based on the number of licenses that you have. The total storage quota for every non-EDU organization is 1 TB plus 10 GB per license for the eligible plan that you purchase, plus any Microsoft 365 Extra File Storage add-ons that you purchase. For more information, see [SharePoint limits](/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-limits).

Although archived data is also a type of storage that's held within SharePoint, it doesn't count toward your organization's active storage quota. Your organization is considered to be out of storage space if your total SharePoint storage usage exceeds the allocated storage quota.

## Resolution

For ways to identify what’s consuming storage and reduce usage, see [SharePoint storage planning](/sharepoint/sharepoint-storage-planning).

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
