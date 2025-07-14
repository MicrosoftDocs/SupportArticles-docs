---
title: Unable to delete items in SharePoint and OneDrive
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: ITPro
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
ms.custom: 
  - sap:Lists and Libraries\Other
  - CI 113501
  - CI 161519
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
- Always make sure you have the [appropriate permissions](/sharepoint/default-sharepoint-groups) to delete the item or have a [site collection administrator](/sharepoint/customize-sharepoint-site-permissions#add-change-or-remove-a-site-collection-administrator) attempt remove the item.
- Retention label policies can cause this. For more information about the restrictions on which actions are allowed or blocked, see this [comparison table](/microsoft-365/compliance/records-management?view=o365-worldwide&preserve-view=true#compare-restrictions-for-what-actions-are-allowed-or-blocked).

   **Note** Folder deletion can be prevented due to retention policies. In this situation, first move or delete any files in the folder that are subject to retention.   
- The site might have exceeded its storage limit. [Increase the site quota](/powershell/module/sharepoint-online/set-sposite) and delete the item.
- Administrators can use [SharePoint Patterns and Practices](/powershell/sharepoint/sharepoint-pnp/sharepoint-pnp-cmdlets#installation) (PnP), which contains a library of PowerShell commands that allows you to perform complex management actions such as force the deletion of items you cannot otherwise delete.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
