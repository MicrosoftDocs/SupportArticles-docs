---
title: Use diagnostics to troubleshoot issues in SharePoint Online and OneDrive
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 8/28/2020
audience: Admin
ms.topic: article
ms.service: sharepoint-online
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint Online
- OneDrive
ms.custom: 
- CI 122279
- CSSTroubleshoot 
ms.reviewer: salarson
description: SharePoint Online and OneDrive Diagnostics 
---

# How to troubleshoot issues in SharePoint Online and OneDrive using diagnostics

## Summary

It’s important that administrators can diagnose and resolve issues quickly in SharePoint Online and OneDrive. To support this effort, the SharePoint support team has released features in the Microsoft 365 admin center to resolve common issues. 

> [!NOTE]
> This feature is not available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

## More information

Diagnostic capabilities for a few text queries were first released within the Microsoft 365 admin center support portal in December 2018.

:::image type="content" source="media/sharepoint-and-onedrive-diagnostics/sharepoint-and-onedrive-diagnostics-1.jpg" alt-text="Diagnostics screen in SharePoint Admin Center.":::

### What scenarios are currently covered?

> [!note]
> You must be an Microsoft 365 administrator to run diagnostics.

There are currently diagnostics covering various areas within Sharepoint and OneDrive. Each diagnostic is listed here together with a brief description of its function and also a shortcut command:

| Diagnostic | Description | Shortcut cmd | Support Article |
| --- | --- | -- | -- |
| **External sharing** | Diagnose issues with sharing, such as determining why guests are unable to access content. |  > [!div class="nextstepaction"]
    > [Run Tests: External Sharing](https://aka.ms/PillarExternalSharing) |
| **OneDrive provisioning** | Diagnose issues that may occur during the provisioning of a OneDrive site collection. |  > [!div class="nextstepaction"]
    > [Run Tests: OneDrive Provisioning](https://aka.ms/PillarOneDriveProvisioning) | [OneDrive for Business stopped at "Setting up..."](/sharepoint/troubleshoot/setup/onedrive-stopped-at-setting-up-screen)
| **Site and page performance** | Diagnose why a site or page may be loading slowly. | > [!div class="nextstepaction"]
    > [Run Tests: Site and Page Performance](https://aka.ms/PillarSiteandPagePerf) |
| **Sharepoint picture synchronization** | Diagnose why a picture may not be showing up in the user’s profile or via the People Web Part. | > [!div class="nextstepaction"]
    > [Run Tests: Picture Sync](https://aka.ms/PillarPictureSync) |
| **OneDrive storage quota** | Diagnose issues that may occur during a quota change for a OneDrive for Business site. | > [!div class="nextstepaction"]
    > [Run Tests: OneDrive Storage Quota](https://aka.ms/PillarOneDriveQuota)  |
| **Site collection creation** | Diagnose issues that may occur during the creation of a site. | > [!div class="nextstepaction"]
    > [Run Tests: Site Creation](https://aka.ms/PillarSiteCreation) |
| **Site collection deletion** | Diagnose issues that may occur during the deletion of a site. | > [!div class="nextstepaction"]
    > [Run Tests: Site Deletion](https://aka.ms/PillarSiteDeletion) |
| **Modernization** | Evaluates whether a view can be rendered in Modern mode. | > [!div class="nextstepaction"]
    > [Run Tests: Modernization](https://aka.ms/PillarModernization) |
| **Access denied to a site or the web** |  Diagnose permission-related issues when accessing a site or the web. | > [!div class="nextstepaction"]
    > [Run Tests: Access Denied](https://aka.ms/PillarAccessDenied) |
| **Unable to synchronize OneDrive with a sync client** | Validates that the OneDrive library can be synchronized via the sync client. | > [!div class="nextstepaction"]
    > [Run Tests: OneDrive Sync](https://aka.ms/PillarOneDriveSync) |
| **Unable to synchronize a SharePoint Document Library with sync client** |  Validates that the SharePoint document library is configured properly to allow synchronization of files. | > [!div class="nextstepaction"]
    > [Run Tests: Library Sync](https://aka.ms/PillarLibrarySync) |
| **Access Denied due to organizational policies** | Unlocks administrators who are locked out of SharePoint and OneDrive because of a location-based policy. | > [!div class="nextstepaction"]
    > [Run Tests: Access Denied due to org policy](https://aka.ms/AccessDeniedduetoNetworkLocation) |[Access Denied due to organizational policies](../sharing-and-permissions/access-denied-due-to-org-policies.md)
| **Invalid retention hold** | Detects and removes an invalid retention hold blocking an administrator from deleting a site.  | > [!div class="nextstepaction"]
    > [Run Tests: Invalid Retention Hold](https://aka.ms/PillarInvalidRetention) |[A compliance policy is currently blocking this site deletion](../sites/compliance-policy-blocking-site-deletion.md)
| **OneDrive web access issue** | Detects and renames the OneDrive default document library back to 'Documents'  | > [!div class="nextstepaction"]
    > [Run Tests: OneDrive Library Path](https://aka.ms/PillarOneDriveLibraryPathModified) | [Error - This item might not exist](/sharepoint/troubleshoot/sharing-and-permissions/this-item-might-not-exist-error)
| **OneDrive Storage limited to 5 TB**| Verifies that a user’s OneDrive site storage is eligible for increased storage capacity beyond 5 TB | > [!div class="nextstepaction"]
    > [Run Tests: OneDrive Storage Limited to 5TB](https://aka.ms/PillarOneDriveStorageLimited)|[Check OneDrive site storage eligibility for storage beyond 5 TB](/sharepoint/troubleshoot/storage/check-storage-increase-eligibility)
| **SharePoint Tenant Storage**| Verifies any issues with your SharePoint Online tenant storage quota displayed in SharePoint admin center and shows how quota is allocated | > [!div class="nextstepaction"]
    > [Run Tests: Tenant Storage](https://aka.ms/PillarTenantStorage) |

> [!note]
> If a diagnostic detects an issue, and you've implemented a fix based on the results, consider rerunning the diagnostic to ensure the issue is completely resolved. 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
