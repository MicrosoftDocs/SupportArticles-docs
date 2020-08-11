﻿---
title: Anonymous Users cannot open XLSX files from a SharePoint document library
description: Anonymous users receive an error opening XLSX documents. Resolution is to break inheritance on the document library OR to give them "OpenItems" permission on the site.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-powershell
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft SharePoint
---

# Anonymous Users cannot open XLSX files from a document library  

## Symptoms  

Consider the following scenario:  

- A publishing site or a site that has the 'ViewFormPagesLockDown' feature enabled    
- The site is configured for anonymous access   
- The site contains a document library    
- The document library contains a file with extension .XLSX (Excel 2007 or higher format)   
- An anonymous user double-clicks on the .XLSX to open it     

Sharepoint tries to open the file using XL Web Service. The user sees the message "Operation in Progress", and then receive the following error:

**Excel Web Access An error has occured.**  
**Access Denied**

## Cause  

Anonymous users do not have "OpenItems" rights on the Document Library.  

## Resolution  

Three different resolutions can be implemented to resolve this issue.  

### Resolution 1   

Break permission inheritance on the Document Library.  

### Resolution 2  

> [!NOTE]
> Disabling the "ViewFormPagesLockDown" feature allows anonymous users to have view source rights to certain files that could potentially contain sensitive info.  

Disable the "ViewFormPagesLockDown" feature on the site collection using stsadm:  

```
stsadm -o deactivatefeature -url <site collection url> -filename ViewFormPagesLockDown\feature.xml
```

### Resolution 3

> [!NOTE]
> Giving anonymous "OpenItems" permission allows anonymous users to have view source rights to certain files that could potentially contain sensitive info.  

Programmatically give "OpenItems" permission to the SPWeb to anonymous users. Note that you should only do this if you understand & accept the security implications. The sample script below can be used to add the "Open Items" permission:  

```
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")  

$siteUrl = "[http://URL_of_your_SITE](http://url_of_your_site/)";  
$site = New-Object Microsoft.SharePoint.SPSite($siteurl);  
$web = $site.OpenWeb();  

$enumPerms = [Microsoft.SharePoint.SPBasePermissions];  

Write-Host $web.AnonymousPermMask64;  
$web.AnonymousPermMask64 = $web.AnonymousPermMask64 -bor $enumPerms::OpenItems  
$web.Update();  
Write-Host $web.AnonymousPermMask64;  

$web.Dispose();  
$site.Dispose();  
```

## More Information  

[Plan security for an external anonymous access environment (Office SharePoint Server)](https://technet.microsoft.com/library/cc263468%28office.12%29.aspx)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
