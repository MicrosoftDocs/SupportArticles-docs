---
title: Per-location view settings don't work at the folder level
description: Folders are not displayed in each other when using Per-location view settings in SharePoint 2013, SharePoint 2010, and SharePoint Online.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Foundation 2013
  - SharePoint Server 2013
  - SharePoint Foundation 2010
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# Per-location view settings don't work at the folder level in SharePoint 2013, SharePoint 2010, and SharePoint Online

## Symptoms

Consider the following scenario:

- You create two standard views (View 1 and View 2) in Microsoft SharePoint or SharePoint Online.
- You create a folder (Folder 1) and a subfolder (Folder 2) in a document library.
- You click the **Per-location view settings** option on the Library Settings page.
- You select View 1 as the default view for Folder 1, and you select View 2 as the default view for Folder 2.
You open Folder 1 and Folder 2 from the list view web part.

In this scenario, Folder 1 is not displayed in View 1, and Folder 2 is not displayed in View 2.

> [!NOTE]
> - SharePoint 2013 and SharePoint 2010 provide per-location view settings that let you configure which views will be available for specific folders in a site hierarchy. These settings are for large document libraries in which documents are classified in a folder hierarchy.
> - This issue does not occur if you open the folders from the tree view.

## Resolution

To resolve this issue, follow these steps:

1. On the SharePoint site, click the **Settings** button (Gear icon), and then click **Site Settings**.
1. Under **Site Actions**, click **Manage Site Features**.
1. Activate the **Metadata Navigation and Filtering** feature.
1. Locate the **Library Settings** of the document library in question.
1. Click **Per-Location View Settings**.
1. Change the folders to have the default views that you want.
1. Go back to **Library Settings** for that library, and then click **Metadata navigation settings**.
1. Add **Folders** and **Content Type** to the **Selected Hierarchy Fields** box, and then click **OK**.

Now, when you locate the document library, you see a tree view on the left. You can see the views based on locations by clicking the folders from the tree view only. These views will not show when you click the items in the library view on the main part of the page.

To activate the tree view for the whole site collection (so that it's always displayed in the left navigation), follow these steps:

1. Locate **Site Settings**.
1. Click **Navigation Elements**, and then select the **Enable Tree View** check box.

## More Information

For more information about how to configure the views that are available for specific folders in a site hierarchy, go to the following Microsoft website:

[Configure the availability of views for a location in the site hierarchy](https://support.office.com/article/configure-the-availability-of-views-for-a-location-in-the-site-hierarchy-7930b539-55af-4b2f-8d6e-4e0cf263193c)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
