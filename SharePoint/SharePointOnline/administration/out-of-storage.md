---
title: SharePoint Online out of storage space
description: Run a diagnostic to solve storage space issues.
author: helenclu
ms.author: luche
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: prbalusu
ms.custom: 
  - CSSTroubleshoot
  - CI 157728
appliesto: 
  - SharePoint Online
ms.date: 09/15/2023
---

# SharePoint Online out of storage space

As a global admin, you might get an email with one of the following messages:

> SharePoint Online is out of storage space

> There is not enough storage space on SharePoint Online

The amount of Microsoft SharePoint storage for your organization is based on your number of licenses.

Your organization has total storage of 1 TB plus 10 GB per license of eligible plan purchased, plus any Microsoft 365 Extra File Storage add-on purchased.

If you suspect you should have more storage than is displayed in the Microsoft 365 admin center, Microsoft 365 admins can run the following diagnostic tool. It will identify any issues with your SharePoint Online tenant storage quota, and show how the quota is allocated.

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This diagnostic isn't currently supported for GCC High, DoD, or Microsoft 365 operated by 21Vianet.

> [!div class="nextstepaction"]
> [Run Tests: Tenant Storage](https://aka.ms/PillarTenantStorage)

To troubleshoot any issues with your storage limits, see [Manage site storage limits](/sharepoint/manage-site-collection-storage-limits).

## References

- [SharePoint limits](/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-limits)

- [Add storage space for your subscription](/microsoft-365/commerce/add-storage-space)
