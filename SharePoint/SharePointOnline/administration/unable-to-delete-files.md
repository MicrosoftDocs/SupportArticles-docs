---
title: Unable to delete items in SharePoint and OneDrive
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 02/10/2020
audience: ITPro
ms.topic: article
ms.prod: sharepoint
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint Online 
ms.custom: 
- CI 113501
- CSSTroubleshoot 
ms.reviewer: prbalusu 
description: If you're unable to delete files from SharePoint or OneDrive, this article lists ways you might be able to resolve the issue. 
---

# Unable to delete items in SharePoint and OneDrive

## Summary

You may find that you are unable to delete files in SharePoint or OneDrive. This article describes ways to narrow down the issue and find a solution. 

## More information

There are several reasons why you may be unable to delete a file. Try each of these until you find one that resolves your issue.

- Ensure the item is not [checked out](https://support.office.com/article/check-out-check-in-or-discard-changes-to-files-in-a-library-7e2c12a9-a874-4393-9511-1378a700f6de) to another user.
- Always make sure you have the [appropriate permissions](https://docs.microsoft.com/sharepoint/default-sharepoint-groups) to delete the item or have a [site collection administrator](https://docs.microsoft.com/sharepoint/customize-sharepoint-site-permissions#add-change-or-remove-a-site-collection-administrator) attempt remove the item.
- Retention policies can cause this. You might have to either disable or exclude the respective hold policy that's causing the issue. After a retention policy or hold is removed, it may take up to 24 hours for the change to take effect. Ensure that there is not a [retention policy](https://docs.microsoft.com/office365/securitycompliance/retention-policies) set up on the item.
- The site might have exceeded its storage limit. [Increase the site quota](https://docs.microsoft.com/powershell/module/sharepoint-online/set-sposite) and delete the item.
- Administrators can use [SharePoint Patterns and Practices](https://docs.microsoft.com/powershell/sharepoint/sharepoint-pnp/sharepoint-pnp-cmdlets#installation) (PnP), which contains a library of PowerShell commands that allows you to perform complex management actions such as force the deletion of items you cannot otherwise delete.

For more information on PowerShell commands, see the following articles:
   - [Remove PNP File](https://docs.microsoft.com/powershell/module/sharepoint-pnp/remove-pnpfile)
   - [Remove PNP Folder](https://docs.microsoft.com/powershell/module/sharepoint-pnp/remove-pnpfolder)
   - [Remove PNP List Item](https://docs.microsoft.com/powershell/module/sharepoint-pnp/remove-pnplistitem)
   - [Remove PNP List](https://docs.microsoft.com/powershell/module/sharepoint-pnp/remove-pnplist)
   - [Remove PNP Field (Column)](https://docs.microsoft.com/powershell/module/sharepoint-pnp/remove-pnpfield)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
