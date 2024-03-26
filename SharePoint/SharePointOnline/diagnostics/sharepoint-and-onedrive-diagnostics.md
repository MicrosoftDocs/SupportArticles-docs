---
title: Self-help diagnostics for SharePoint Online and OneDrive administrators
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
  - OneDrive
ms.custom: 
  - sap:Lists and Libraries\Other
  - CI 122279
  - CSSTroubleshoot
ms.reviewer: salarson
description: List of SharePoint Online and OneDrive diagnostics
---

# Self-help diagnostics for SharePoint Online and OneDrive administrators

It's important that administrators are able to diagnose and resolve issues quickly in SharePoint Online and OneDrive. To support this effort, the SharePoint support team has released diagnostics in the Microsoft 365 admin center to resolve common issues.

> [!NOTE]
> These diagnostics aren't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

Diagnostic capabilities for a few text queries were first released within the Microsoft 365 admin center support portal in December 2018.

:::image type="content" source="media/sharepoint-and-onedrive-diagnostics/run-diagnostics.png" alt-text="Screenshot of the Run diagnostics page in the Microsoft 365 admin center.":::

When IT admins run customer diagnostics in the Microsoft 365 admin center to resolve issues without logging support requests, Microsoft makes a donation to global nonprofit organizations.

For more information, see [Diagnostics for Social Good](https://aka.ms/DiagnosticsforSocialGood)

## Scenarios covered by diagnostics

> [!NOTE]
> You must be a Microsoft 365 administrator to run diagnostics.

There are currently diagnostics covering various areas within SharePoint and OneDrive. Each diagnostic is listed below together with a brief description of its function, and a shortcut link:

| Diagnostic | Description | Shortcut Link | Support Article |
| --- | --- | -- | -- |
| **OneDrive provisioning** | Diagnose issues that may occur during the provisioning of a OneDrive site collection. | [Run Tests: OneDrive Provisioning](https://aka.ms/PillarOneDriveProvisioning) | [OneDrive for Business stopped at "Setting up..."](/sharepoint/troubleshoot/setup/onedrive-stopped-at-setting-up-screen) |
| **Site and page performance** | Diagnose why a site or page may be loading slowly. | [Run Tests: Site and Page Performance](https://aka.ms/PillarSiteandPagePerf) | [Diagnosing performance issues with SharePoint Online](/microsoft-365/enterprise/diagnosing-performance-issues-with-sharepoint-online)
| **SharePoint picture synchronization** | Diagnose why a picture may not be showing up in the user’s profile or via the People Web Part. | [Run Tests: Picture Sync](https://aka.ms/PillarPictureSync) | [Profile picture not showing in SharePoint Online](/sharepoint/troubleshoot/administration/profile-picture-not-showing) |
| **OneDrive storage quota** | Diagnose issues that may occur during a quota change for a OneDrive for Business site. | [Run Tests: OneDrive Storage Quota](https://aka.ms/PillarOneDriveQuota) | [Change a specific user's OneDrive storage space](/onedrive/change-user-storage)
| **Site collection deletion** | Diagnose issues that may occur during the deletion of a site. | [Run Tests: Site Deletion](https://aka.ms/PillarSiteDeletion) | [Unable to delete a sharepoint site](/sharepoint/troubleshoot/sites/unable-to-delete-site) |
| **Unable to synchronize OneDrive with a sync client** | Validates that the OneDrive library can be synchronized via the sync client. | [Run Tests: OneDrive Sync](https://aka.ms/PillarOneDriveSync) |
| **Unable to synchronize a SharePoint Document Library with sync client** |  Validates that the SharePoint document library is configured properly to allow synchronization of files. | [Run Tests: Library Sync](https://aka.ms/PillarLibrarySync) |
| **Access Denied due to organizational policies** | Unlocks administrators who are locked out of SharePoint and OneDrive because of a location-based policy. | [Run Tests: Access Denied due to org policy](https://aka.ms/AccessDeniedduetoNetworkLocation) |[Access Denied due to organizational policies](../sharing-and-permissions/access-denied-due-to-org-policies.md) |
| **Invalid retention or grace eDiscovery hold** | Detects and removes an invalid retention or grace eDiscovery hold blocking an administrator from deleting a site.  | [Run Tests: Invalid Retention Hold](https://aka.ms/PillarInvalidRetention) | [A compliance policy is currently blocking this site deletion](../sites/compliance-policy-blocking-site-deletion.md) |
| **OneDrive web access issue** | Detects and renames the OneDrive default document library back to 'Documents'  | [Run Tests: OneDrive Library Path](https://aka.ms/PillarOneDriveLibraryPathModified) | [Error - This item might not exist](/sharepoint/troubleshoot/sharing-and-permissions/this-item-might-not-exist-error) |
| **OneDrive Storage limited to 5 TB**| Verifies that a user’s OneDrive site storage is eligible for increased storage capacity beyond 5 TB | [Run Tests: OneDrive Storage Limited to 5TB](https://aka.ms/PillarOneDriveStorageLimited)|[Check OneDrive site storage eligibility for storage beyond 5 TB](/sharepoint/troubleshoot/storage/check-storage-increase-eligibility) |
| **SharePoint Tenant Storage**| Verifies any issues with your SharePoint Online tenant storage quota displayed in SharePoint admin center and shows how quota is allocated | [Run Tests: Tenant Storage](https://aka.ms/PillarTenantStorage) | [SharePoint Online out of storage space](/sharepoint/troubleshoot/administration/out-of-storage) |
| **Check User Access**| Validates that the internal/external user has access to the site and checks for known issues that can prevent access. | [Run Tests: Check User Access](https://aka.ms/PillarCheckUserAccess) |[Permission errors when accessing SharePoint or OneDrive](/sharepoint/troubleshoot/administration/access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business) |
| **Locked Site**| Validates that the user's OneDrive or SharePoint site exists, and there are no known issues accessing the site due to lock or archived state. | [Run Tests: Locked Site](https://aka.ms/PillarLockedSite) | [SharePoint or OneDrive read-only error messages](/sharepoint/troubleshoot/sites/site-is-read-only)
| **Site User ID Mismatch**| Detects ID mismatches for users on OneDrive or SharePoint sites and offers to fix the issue. | [Run Tests: Site User ID Mismatch](https://aka.ms/PillarSiteUserIDMismatch) | [Fix site user ID mismatch in SharePoint or OneDrive](../sharing-and-permissions/fix-site-user-id-mismatch.md)

> [!NOTE]
> If a diagnostic detects an issue, and you've implemented a fix based on the results, consider rerunning the diagnostic to ensure the issue is completely resolved.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
