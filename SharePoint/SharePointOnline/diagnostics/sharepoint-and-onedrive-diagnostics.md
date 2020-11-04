---
title: Use diagnostics to troubleshoot issues in SharePoint Online and OneDrive
ms.author: v-todmc
author: mccoybot
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
description: Troubleshoot issues in SharePoint Online and OneDrive using diagnostics.
---

# How to troubleshoot issues in SharePoint Online and OneDrive using diagnostics

## Summary

It’s important that administrators be able to diagnose and resolve issues quickly in SharePoint Online and OneDrive. To support this effort, the SharePoint support team is releasing new features in the M365 Admin Center.

Currently, we provide diagnostics to our customers through text analytics. This will not change. However, we want to make it easier to find our diagnostics within the current experience. Therefore, we have created a new set of queries to help administrators.

## More information

Diagnostic capabilities first appeared within the M365 Admin Center support portal for certain text queries in December 2018.

:::image type="content" source="media/sharepoint-and-onedrive-diagnostics/sharepoint-and-onedrive-diagnostics-1.jpg" alt-text="Diagnostics screen in SharePoint Admin Cener.":::

### What scenarios are currently covered?

There are currently nine diagnostics covering various areas within Sharepoint and OneDrive. Each diagnostic is listed below with a brief description of its function.

1. **External sharing**. Diagnose issues with sharing, such as determining why external users are unable to access content.
2.	**OneDrive provisioning**. Diagnose issues that may occur during the provisioning of a OneDrive site collection.
3.	**Site and page performance**. Diagnose why a site or page may be loading slowly.
4.	**Sharepoint picture synchronization**. Diagnose why a picture may not be showing up in the user’s profile or via the People Web Part.
5.	**OneDrive storage quota**. Diagnose issues that may occur during a quota change for a OneDrive for Business site.
6.	**Site collection creation**. Diagnose issues that may occur during the creation of a site.
7.	**Site collection deletion**. Diagnose issues that may occur during the deletion of a site.
8.	**Modernization**. Evaluates whether a view can be rendered in Modern mode.
9.	**Access denied to a site or the web**. Diagnose permission-related issues when accessing a site or the web.
10. **Unable to synchronize OneDrive with a sync client**. Validates that the document library is configured properly to allow synchronization of files.
11. **Unable to synchornize a SharePoint Document Library with sync client**. Validates that the OneDrive library can be synchronized via the sync client.

### How do I run these diagnostics?

Currently, these diagnostics are only available for administrators and can be accessed through the service request section of the M365 Admin Center. To access this area, follow the steps below.

1. Go to https://admin.microsoft.com.
2. On the left navigation pane, select **Support**.
3. Select **New service request**.
 
    :::image type="content" source="media/sharepoint-and-onedrive-diagnostics/sharepoint-and-onedrive-diagnostics-2.jpg" alt-text="Select New service request. ":::
 
4. This will activate the “Need help?” pane on the right-hand side of your screen.
 
    :::image type="content" source="media/sharepoint-and-onedrive-diagnostics/sharepoint-and-onedrive-diagnostics-3.jpg" alt-text="The Need Help? screen.":::

    > [!NOTE]
    > Diagnostics can also be rendered in O365 assistant. However the queries may be different.
 
5.	If you would like to render one of our specific diagnostics, enter one of the queries listed below into the “Need help?” text box.

    - Diag: External Sharing
    - Diag: OneDrive Provisioning
    - Diag: OneDrive Storage Quota
    - Diag: SharePoint Site and Page Performance
    - Diag: Picture Synchronization to SharePoint
    - Diag: Site Collection Creation
    - Diag: Site Collection Deletion
    - Diag: Classic View to Modern
    - Diag: Access Denied to Site
    - Diag: OneDrive Sync
    - Diag: Library Sync

## Location of diagnostics 

Microsoft would like to store these diagnostics in a new area and realize that having them behind the “Service Request” section is not ideal. We look forward to any and all feedback regarding these scenarios. Feel free to leave a comment on the current state of these tools or any features you would like to see.


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
