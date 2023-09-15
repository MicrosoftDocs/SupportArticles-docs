---
title: SharePoint site collection admins can't register apps or update permissions
description: SharePoint site collection admins can no longer register apps or update app permissions unless explicitly authorized by the SharePoint admin after an enhancement change.
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI181229
appliesto: 
  - SharePoint Online
ms.date: 09/15/2023
---
# SharePoint site collection admins can't register apps or update permissions

## Symptoms

You experience the following issues in SharePoint:

- When you try to register an app on the AppRegNew.aspx page (such as `https://contoso.sharepoint.com/_layouts/15/appregnew.aspx`), you receive the following error message:

   > Your SharePoint admin doesn't allow site owners to create an Azure Access Control (ACS) principal. Please contact your SharePoint administrator.
- When you try to update app permissions on the AppInv.aspx page (such as `https://contoso-admin.sharepoint.com/_layouts/15/appinv.aspx`), you receive the following error message:

   > Your SharePoint admin doesn't allow site owners to update app permissions. Please contact your SharePoint administrator."

## Cause

These errors occur because of enhancements that have been made to the security measures for administrative governance. The enhancements have changed the default procedures for app registration through AppRegNew.aspx and permission updates through AppInv.aspx. Because of this change, site collection admins can no longer register apps or update app permissions unless explicitly authorized by the SharePoint admin.

## Resolution

To change the new default behavior, the SharePoint admin must run the following [Set-SPOTenant](/powershell/module/sharepoint-online/set-spotenant?view=sharepoint-ps&preserve-view=true#-siteownermanagelegacyserviceprincipalenabled) cmdlet to also allow site collection admins to manage the Azure Access Control (ACS) service principal:

```powershell
Set-SPOTenant -SiteOwnerManageLegacyServicePrincipalEnabled $true
``````

> [!NOTE]
> The `SiteOwnerManageLegacyServicePrincipalEnabled` property becomes visible in tenant settings in SharePoint Online Management Shell version 16.0.23710.12000 or later. Its new default value is **FALSE**. Before the enhancements were made, its value was always **TRUE** and couldn't be changed.
