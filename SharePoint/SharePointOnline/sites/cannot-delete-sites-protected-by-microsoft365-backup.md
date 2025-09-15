---
title: Site is protected by Microsoft 365 Backup and can't be deleted
manager: dcscontentpm
ms.date: 07/31/2024
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft 365 Backup
  - SharePoint Online
  - OneDrive for Business
ms.custom: 
  - sap:Microsoft 365 Backup\ODSP
  - CI 193688
  - CSSTroubleshoot
ms.reviewer: salarson
description: Describes an error that occurs when you try to delete a SharePoint or OneDrive for Business site that's protected by Microsoft 365 Backup. Provides steps to submit a service request to Microsoft.
---

# "Site is protected by Microsoft 365 Backup and cannot be deleted" error

## Symptoms

You try to permanently delete a site from the [SharePoint admin center](https://go.microsoft.com/fwlink/?linkid=2185219) or by using the [SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online). In this scenario, you receive the following error message:

> Site is protected by Microsoft 365 Backup and cannot be deleted.  

## Cause  

This error occurs because the site is actively protected or was protected in the past 365 days by [Microsoft 365 Backup](/microsoft-365/backup/?view=o365-worldwide&preserve-view=true). To be able to delete a site, the site backup has to be deleted. However, Microsoft 365 Backup can't delete the backups of specific SharePoint or OneDrive for Business sites. This behavior is designed to prevent malicious actors from deleting backups that are intended to quickly restore data if it's compromised.

## Resolution  

If you want to delete backups of specific sites, mailboxes, or oneDrive to comply with GDPR regulations, you can do so using **Admin PowerShell cmdlets.**

> [!NOTE]
> For you to be able to offboard a site, mailbox, or oneDrive, it should be removed from policy first. That is, its **policy-id** should be empty and state as "unprotected".

Here's the steps you can follow:

1. Get the **protection unit-id** for the site, user, or mailbox you would like to offboard using the [List driveProtectionUnits PowerShell cmdlet](/graph/api/backuprestoreroot-list-driveprotectionunits).

1. To initiate the offboarding progress, use the [protectionUnitBase: offboard PowerShell cmdlet](/graph/api/protectionunitbase-offboard).

1. If you want to cancel the offboarding within the 90-day grace period, use the [protectionUnitBase: cancelOffboard PowerShell cmdlet](/graph/api/protectionunitbase-canceloffboard).

Learn more about the entire offboarding cycle, cancellation and grace period [here](/microsoft-365/backup/backup-offboarding?view=o365-worldwide).
