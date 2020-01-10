---
title: Access to this web site has been blocked in a SharePoint tenant
description: You see a blank page in SharePoint admin center. Additionally SharePoint site collections display an "Access to this web site has been blocked" error message or a blank page. 
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-solutions
ms.topic: article
ms.author: v-maqiu
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# "Access to this web site has been blocked" error or a blank page in a SharePoint tenant

## Symptoms

When you browse to the Microsoft SharePoint admin center, you see a blank page. Additionally, some SharePoint site collections display an "Access to this web site has been blocked" error message together with a correlation ID, and other site collections display only a blank page.

## Cause

The issue occurs if the App Catalog site collection in the SharePoint tenant is locked.

## Resolution

To resolve the issue, unlock the App Catalog site collection. To do this, follow these steps:

1. Open SharePoint Online Management Shell.
1. Connect to SharePoint Online tenant. To do this, run the following command:
   
   ```powershell
   $cred = Get-Credential #pass in the SPO admin credentials
   Connect-SPOService -Credential $cred
   ```

1. Get the App Catalog site collection in the tenant. To do this, run the following command:

   ```powershell
   Get-SPOSite -Limit All | where {$_.Template -eq 'APPCATALOG#0'}
   ```

1. Check the lock state of the site collection. To do this, run the following command:

   ```powershell
   Get-SPOSite -Identity <SiteCollectionURL> | select LockState
   ```

1. If the command result is NoAccess, run the following command:

   ```powershell
   Set-SPOSite -Identity <SiteCollectionURL> -LockState Unlock
   ```
