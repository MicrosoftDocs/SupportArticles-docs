---
title: Can't permanently delete a site when it's connected to a Microsoft 365 group 
description: Describes the error - This site can't be permanently deleted because it's connected to a Microsoft 365 group. 
author: salarson
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.custom: 
- CSSTroubleshoot
- CI 149203
ms.author: v-matham
appliesto:
- SharePoint Online
---

# Can't permanently delete a site when it's connected to a Microsoft 365 group

## Symptom

When you try to permanently delete a Microsoft 365 group site from the SharePoint Admin center, you get the following error:

> This site can't be permanently deleted because it's connected to a Microsoft 365 group.

## Cause

To delete a Microsoft 365 group-connected team site, you need to delete the site and all of the group’s resources.

## Resolution

To permanently delete a Microsoft 365 group-connected team site, use the following steps:

1. Install the latest SharePoint Online Management Shell, or if it is already installed, make sure it is up to date. For instructions to do this, see [Getting started with SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online?view=sharepoint-ps.md).

1. Connect to SharePoint as a global admin or SharePoint admin in Microsoft 365. To learn how, see [Getting started with SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online?view=sharepoint-ps.md).

1. Run the following command:

    ```Remove-SPODeletedSite -Identity https://contoso.sharepoint.com/sites/sitetoremove```

    (Where https://contoso.sharepoint.com/sites/sitetoremove is the URL of the site you want to permanently delete)

For more information about using this command, see [Remove-SPODeletedSite](/powershell/module/sharepoint-online/remove-spodeletedsite.md).

## More information

For more information about permanently deleting sites, see [Permanently delete a site](/sharepoint/delete-site-collection#permanently-delete-a-site.md).