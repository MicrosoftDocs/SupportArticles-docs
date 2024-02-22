---
title: SharePoint or OneDrive read-only error messages
description: Provides solutions for error messages that indicate SharePoint sites in read-only mode. The most common cause is that the site has been locked or closed.
author: helenclu
ms.reviewer: salarson
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
  - CI 158141
appliesto: 
  - SharePoint Online
  - OneDrive for Business
ms.date: 12/17/2023
---

# SharePoint or OneDrive read-only error messages

When navigating to a SharePoint Online or OneDrive for Business site, you might encounter one of the following error messages when navigating to a site:

> This site is read only at the site collection administrator's request.

> SharePoint sites are read-only right now while we do some maintenance. We apologize for the inconvenience.  

> 403 Forbidden  

There are many scenarios that can cause one of these messages during SharePoint maintenance events, but the most frequent cause is that the site has been locked or closed.  

## Automated troubleshooting

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This diagnostic isn't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

Microsoft 365 admin users have access to diagnostics that can be run within the tenant to verify possible issues with sites that have the error messages mentioned above. To populate the diagnostic in the Microsoft 365 Admin Center and try to unlock the site, select Run Tests:

> [!div class="nextstepaction"]
> [Run Tests: Locked Site](https://aka.ms/PillarLockedSite)

## Troubleshoot “This site is read-only at the site collection administrator's request” yourself

This error usually means the site has been closed by a site policy and set to a read-only state. You can check to see if a site policy has been applied and unlock it using the steps in [Use policies for site closure and deletion](https://support.microsoft.com/office/use-policies-for-site-closure-and-deletion-a8280d82-27fd-48c5-9adf-8a5431208ba5).

If you are attempting to unarchive a group of closed sites, you can use PowerShell to run the following commands. 

**Note** You must have [Microsoft.SharePointOnline.CSOM](https://www.nuget.org/packages/Microsoft.SharePointOnline.CSOM) version 16.1.21714.12000 or later for these commands to execute.

```powershell

## DISCLAIMER: 
## Copyright (c) Microsoft Corporation. All rights reserved. This 
## script is made available to you without any express, implied or 
## statutory warranty, not even the implied warranty of 
## merchantability or fitness for a particular purpose, or the 
## warranty of title or non-infringement. The entire risk of the 
## use or the results from the use of this script remains with you. 
# 

#Load the client side object model assemblies  

$loadInfo1 = [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client") 

$loadInfo2 = [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.Runtime") 

$loadInfo2 = [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Office.Client.Policy") 

#Use this method if you need to manually load the assemblies  

#Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SharePointOnline.CSOM.16.1.21714.12000\lib\netstandard2.0\Microsoft.SharePoint.Client.dll" 

#Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SharePointOnline.CSOM.16.1.21714.12000\lib\netstandard2.0\Microsoft.SharePoint.Client.Runtime.dll" 

#Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SharePointOnline.CSOM.16.1.21714.12000\lib\netstandard2.0\Microsoft.Office.Client.Policy.dll" 

$RootSiteURL    = Read-Host -Prompt "Root Site URL" 

$SiteURL    = Read-Host -Prompt "URL" 

$Username   = Read-Host -Prompt "Admin Username" 

$Password   = Read-Host -Prompt "Password for $Username" -AsSecureString 

$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($RootSiteURL) 

$ctx.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Username, $Password) 

Write-Host $($SiteURL) archived state has been set to value below.  

# Calling the method to Unarchive a Closed Site 

[Microsoft.SharePoint.Client.CompliancePolicy.SPPolicyStoreProxy]::UnArchiveSite($ctx,$SiteURL) 

$ctx.ExecuteQuery() 

```

## Troubleshoot “SharePoint sites are read-only right now while we do some maintenance” yourself

This message can mean that your site has a lock state set and it needs to be unlocked. To change the lock state of a site, follow the steps in [Change the lock state for a site](/sharepoint/manage-lock-status#change-the-lock-state-for-a-site).

If the site isn't in a lock state, this message can also mean that there is maintenance occurring on your tenant. You should check your [Message center](https://admin.microsoft.com/#/MessageCenter) and [Service Health Dashboard](https://admin.microsoft.com/AdminPortal/Home#/servicehealth).

## Troubleshoot “Error: 403 Forbidden” yourself

This message can mean that your site has a [lock state](/sharepoint/manage-lock-status) set and it needs to be unlocked. To change the lock state of a site, follow the steps in [Change the lock state for a site](/sharepoint/manage-lock-status#change-the-lock-state-for-a-site).  

If the site isn't in a lock state, this message can also occur from other conditions. For more information, see ["403 Forbidden" error on OneDrive or SharePoint](../sharing-and-permissions/error-403-forbidden.md).
