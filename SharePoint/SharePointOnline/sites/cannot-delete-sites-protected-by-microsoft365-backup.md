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

To delete the backup of the site that you want to delete, use the following steps to submit a support request to Microsoft:

1. Sign in to the Microsoft 365 admin center by using your administrator credentials.
1. Navigate to the following URL:  

   [https://aka.ms/ProtectedSiteDeletion](https://aka.ms/ProtectedSiteDeletion)

   This link populates the "Microsoft 365 Backup Protected Site" query in the Microsoft 365 admin center.
1. Select **Contact support**, and then select a contact method.
1. Leave the prepopulated **Title** field as is and the **Description** field blank.
1. Fill in the other required fields, and then select **Contact me**.

When Microsoft Support contacts you about the service request, provide the site URL and other relevant information. After the site's backup is deleted, you can delete the site.
