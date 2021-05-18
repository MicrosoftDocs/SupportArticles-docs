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

It’s important that administrators can diagnose and resolve issues quickly in SharePoint Online and OneDrive. To support this effort, the SharePoint support team has released new features in the Microsoft 365 admin center.

Currently we provide diagnostics through text analytics. This feature will remain. However, we want to make it easier to find the diagnostics within the current experience. So we have created a new set of queries to help administrators.

> [!NOTE]
> This feature is not available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

## More information

Diagnostic capabilities for a few text queries were first released within the Microsoft 365 admin center support portal in December 2018.

:::image type="content" source="media/sharepoint-and-onedrive-diagnostics/sharepoint-and-onedrive-diagnostics-1.jpg" alt-text="Diagnostics screen in SharePoint Admin Center.":::

### What scenarios are currently covered?

There are currently nine diagnostics covering various areas within Sharepoint and OneDrive. Each diagnostic is listed here together with a brief description of its function and also a shortcut command:

| Diagnostic | Description | Shortcut cmd | Support Article |
| --- | --- | -- | -- |
| **External sharing** | Diagnose issues with sharing, such as determining why guests are unable to access content. | Diag: External Sharing |
| **OneDrive provisioning** | Diagnose issues that may occur during the provisioning of a OneDrive site collection. | Diag: OneDrive Provisioning |
| **Site and page performance** | Diagnose why a site or page may be loading slowly. | Diag: SharePoint Site and Page Performance |
| **Sharepoint picture synchronization** | Diagnose why a picture may not be showing up in the user’s profile or via the People Web Part. | Diag: Picture Synchronization to SharePoint |
| **OneDrive storage quota** | Diagnose issues that may occur during a quota change for a OneDrive for Business site. | Diag: OneDrive Storage Quota  |
| **Site collection creation** | Diagnose issues that may occur during the creation of a site. | Diag: Site Collection Creation |
| **Site collection deletion** | Diagnose issues that may occur during the deletion of a site. | Diag: Site Collection Deletion |
| **Modernization** | Evaluates whether a view can be rendered in Modern mode. | Diag: Classic View to Modern |
| **Access denied to a site or the web** |  Diagnose permission-related issues when accessing a site or the web. | Diag: Access Denied to Site |
| **Unable to synchronize OneDrive with a sync client** | Validates that the OneDrive library can be synchronized via the sync client. | Diag: OneDrive Sync |
| **Unable to synchronize a SharePoint Document Library with sync client** |  Validates that the SharePoint document library is configured properly to allow synchronization of files. | Diag: Library Sync |
| **Access Denied due to organizational policies** | Unlocks administrators who are locked out of SharePoint and OneDrive because of a location-based policy. | Diag: Access Denied due to Network Location Restriction |[Access Denied due to organizational policies](../sharing-and-permissions/access-denied-due-to-org-policies.md)
| **Invalid retention hold** | Detects and removes an invalid retention hold blocking an administrator from deleting a site.  | Diag: Invalid retention policy |[A compliance policy is currently blocking this site deletion](../sites/compliance-policy-blocking-site-deletion.md)
| **OneDrive web access issue** | Detects and renames the OneDrive default document library back to 'Documents'  | Diag: OneDrive Document Library Path Modified | [Error - This item might not exist](/sharepoint/troubleshoot/sharing-and-permissions/this-item-might-not-exist-error)
| **OneDrive Storage limited to 5 TB**| Verifies that a user’s OneDrive site storage is eligible for increased storage capacity beyond 5 TB | Diag: OneDrive Storage limited to 5TB |[Check OneDrive site storage eligibility for storage beyond 5 TB](/sharepoint/troubleshoot/storage/check-storage-increase-eligibility)

### How do I run these diagnostics?

> [!note]
> You must be an Microsoft 365 administrator to run diagnostics.


Currently, these diagnostics are available only for administrators. They can be accessed through the service request section of the M365 Admin Center. To access this area, follow these steps:

1. Go to https://admin.microsoft.com.
2. In the left pane, select **Support**.
3. Select **New service request**.

    :::image type="content" source="media/sharepoint-and-onedrive-diagnostics/sharepoint-and-onedrive-diagnostics-2.jpg" alt-text="Select New service request. ":::

 
4. This activates the “Need help?” pane on the right side of the screen.
 
    :::image type="content" source="media/sharepoint-and-onedrive-diagnostics/sharepoint-and-onedrive-diagnostics-3.jpg" alt-text="The Need Help? screen.":::
 
5.	If you want to render one of our specific diagnostics, enter one of the queries from the scenario table under "Shortcut cmd" into the “Need help?” text box.

4. To access a specific diagnostic, enter the corresponding shortcut command from the table above into the “Need help?” text box.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
