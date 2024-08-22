---
title: Can't delete a site connected to a Microsoft 365 group permanently
description: Provides a resolution to delete a site from the SharePoint admin center permanently.
author: helenclu
ms.reviewer: salarson
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sites\Delete Site
  - CSSTroubleshoot
  - CI 149203
  - CI 150314
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 08/09/2024
---

# Can't delete a site connected to a Microsoft 365 group permanently

## Symptoms

You try to permanently delete a site that is connected to a Microsoft 365 group by using the SharePoint admin center. However, you receive the following error message:

> This site can't be permanently deleted because it's connected to a Microsoft 365 group.

## Cause

To delete a team site that is connected to a Microsoft 365 group, you must also delete all the group’s resources.

## Resolution

To permanently delete a Microsoft 365 group-connected team site, follow these steps:

1. Install the latest SharePoint Online Management Shell. If the shell is already installed, make sure that it's up-to-date. For more information, see [Getting started with SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

1. Connect to SharePoint as a SharePoint admin in Microsoft 365. To learn how, see [Getting started with SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

1. Run the following command:

    `Remove-SPODeletedSite -Identity https://contoso.sharepoint.com/sites/sitetoremove`

    **Note:** In this command, replace `https://contoso.sharepoint.com/sites/sitetoremove` with the URL of the site that you want to delete permanently.

For more information about how to use this command, see [Remove-SPODeletedSite](/powershell/module/sharepoint-online/remove-spodeletedsite).

## More information

For more information about how to permanently delete sites, see [Permanently delete a site](/sharepoint/delete-site-collection#permanently-delete-a-site).
