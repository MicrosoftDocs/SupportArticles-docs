---
title: Can't permanently delete a site when it's connected to a Microsoft 365 group
description: Describes the error This site can't be permanently deleted because it's connected to a Microsoft 365 group.
author: helenclu
ms.reviewer: salarson
manager: dcscontentpm
localization_priority: Normal
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
ms.date: 12/17/2023
---

# Can't permanently delete a site when it's connected to a Microsoft 365 group

## Symptoms

When you try to permanently delete a Microsoft 365 group site from the SharePoint Admin center, you receive the following error message:

> This site can't be permanently deleted because it's connected to a Microsoft 365 group.

## Cause

To delete a team site that's connected to a Microsoft 365 group, you have to also delete all the group’s resources.

## Resolution

To permanently delete a Microsoft 365 group-connected team site, follow these steps:

1. Install the latest SharePoint Online Management Shell. If the shell is already installed, make sure that it's up-to-date. For the steps to do this, see [Getting started with SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

1. Connect to SharePoint as a global admin or SharePoint admin in Microsoft 365. To learn how, see [Getting started with SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online).

1. Run the following command:

    `Remove-SPODeletedSite -Identity https://contoso.sharepoint.com/sites/sitetoremove`

    **Note:** In this command, replace `https://contoso.sharepoint.com/sites/sitetoremove` with the URL of the site that you want to permanently delete.

For more information about how to use this command, see [Remove-SPODeletedSite](/powershell/module/sharepoint-online/remove-spodeletedsite).

## More information

For more information about how to permanently delete sites, see [Permanently delete a site](/sharepoint/delete-site-collection#permanently-delete-a-site).
