---
title: Site is protected by Microsoft 365 Backup and can't be deleted
manager: dcscontentpm
ms.date: 10/23/2025
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft 365 Backup
  - SharePoint Online
  - OneDrive
ms.custom: 
  - sap:Microsoft 365 Backup\ODSP
  - CI 193688
  - CSSTroubleshoot
ms.reviewer: salarson
description: Provides a resolution for an error that occurs when you try to delete a SharePoint or OneDrive site that's protected by Microsoft 365 Backup. 

# "Site is protected by Microsoft 365 Backup and cannot be deleted" error

## Symptoms

You try to permanently delete a site from the [SharePoint admin center](https://go.microsoft.com/fwlink/?linkid=2185219) or by using the [SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online). In this scenario, you receive the following error message:

> Site is protected by Microsoft 365 Backup and cannot be deleted.  

## Cause  

This error occurs because the site is actively protected or was protected in the past 365 days by [Microsoft 365 Backup](/microsoft-365/backup/?view=o365-worldwide&preserve-view=true). To be able to delete a site, the site backup has to be deleted. However, Microsoft 365 Backup can't delete the backups of specific SharePoint or OneDrive sites. This behavior is designed to prevent malicious actors from deleting backups that are intended to quickly restore data if it's compromised.

## Resolution  

To delete backups of specific SharePoint sites, mailboxes, or OneDrive sites, use the steps listed in [Offboarding specific sites, mailboxes, or users](/microsoft-365/backup/backup-offboarding#offboarding-specific-sites-mailboxes-or-users&preserve-view=true).
