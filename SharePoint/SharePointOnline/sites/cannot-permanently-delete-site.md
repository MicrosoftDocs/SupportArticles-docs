---
title: "Fix: Can't Delete Microsoft 365 Group Site"
description: "Can't permanently delete a Microsoft 365 group-connected site in SharePoint? Learn how to fix the error using PowerShell and clear orphaned group IDs."
ms.reviewer: salarson, nirupme
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sites\Delete Site
  - CSSTroubleshoot
  - CI 149203
  - CI 150314
appliesto: 
  - SharePoint Online
ms.date: 07/09/2026
ai-usage: ai-assisted
---

# Can't delete a site connected to a Microsoft 365 group permanently

## Summary

When you try to permanently delete a Microsoft 365 group-connected team site in the SharePoint admin center, you get an error that says the site can't be deleted because it's connected to a Microsoft 365 group. This article explains why the error occurs and how to permanently delete the site by using the SharePoint Online Management Shell, including how to clear an orphaned group ID when the associated Microsoft 365 group no longer exists.

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

   > [!NOTE]
   > In this command, replace `https://contoso.sharepoint.com/sites/sitetoremove` with the URL of the site that you want to delete permanently.

## Clear an orphaned Microsoft 365 group ID

Often, the Microsoft 365 group associated with a site is deleted and it doesn't exist in Entra or within Deleted groups. However, since the disassociation never happened, the SharePoint site is still connected to an orphaned Microsoft 365 group and running `Remove-SPODeletedSite` fails with the error "This site can't be permanently deleted because it's connected to a Microsoft 365 group" while the SharePoint Admin Centre reports the group can't be found.

 To resolve this error, run the following command for all affected sites.

`Set-SPOSite -Identity https://contoso.sharepoint.com/sites/sitetoremove -ClearGroupId`

> [!NOTE]
> In this command, replace `https://contoso.sharepoint.com/sites/sitetoremove` with the URL of the site that you want to delete permanently.

This command resets the Group Id to `00000000-0000-0000-0000-000000000000`. Then, remove all affected sites by using `Remove-SPOSite` and permanently delete them by using `Remove-SPODeletedSite`.

For more information about how to use this command, see [Remove-SPODeletedSite](/powershell/module/sharepoint-online/remove-spodeletedsite).

## More information

For more information about how to permanently delete sites, see [Permanently delete a site](/sharepoint/delete-site-collection#permanently-delete-a-site).
