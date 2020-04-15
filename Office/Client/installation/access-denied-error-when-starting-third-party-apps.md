---
title: Starting third-party apps cause "Access Denied" error
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 2/5/2019
audience: Admin|ITPro|Developer
ms.topic: article
ms.prod: office
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Office
ms.custom: 
- CI 115993
- CSSTroubleshoot 
ms.reviewer: MS aliases for tech reviewers and CI requestor, without "@microsoft.com".  
description: What to do if you get an "Access Denied" error when starting third-party add-ins which rely on .NET framework. 
---

# "Access Denied" error when starting Microsoft Office third-party add-ins 

## Symptoms

You see an "Access Denied" error when starting third-party Office add-ins that rely on .NET framework Office binaries.

## Cause

The add-ins fail to load due to restrictive permissions on the .dlls located in the following folder:
```
C:\Windows\assembly\GAC_MSIL\Policy.14.0.Microsoft.Office.Interop.Excel\15.0.0.0__71e9bce111e9429c
```

The devices affected by this issue were originally sold with the **RS5** release **17763** of the pre-installed version of Project Centennial for Office. If a user installs a different version of Office (such as Office 2019, Office 2016, or Office Professional Plus), the new version will de-register the Project Centennial Office package but will not completely remove the package from the machine.

The Project Centennial version of Office will then be in a "staged" state and will continue to receive Office updates, which will cause it to set strict Access Control Lists (ACL) on the .NET Framework and Office primary interop assembly (PIA) library directories, regardless of which licensed version of Office has been installed.

## Resolution

Once the permissions have been stripped, the only way to correct the issue on the computer is to uninstall and reinstall the Office product to replace the ACLs or by running a PowerShell script to reset the ACLs. See [Repair an Office application](https://support.office.com/Article/Repair-an-Office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b) for more information. 

## More information

- The issue will reoccur if the provisioned appx package receives an update from the Microsoft Store.
- New Office installations will run additional checks to confirm the presence and removal of the Centennial Office packages.
- Affected users can run the Online Repair tool from Apps & Features that has additional checks to remove the Centennial Office package and repair the restricted ACLs on the affected .dlls.

Still need help? Go to [Microsoft Community](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fanswers.microsoft.com%2F&data=02%7C01%7Cv-todmc%40microsoft.com%7C98910814456c474880f108d7cf62d97d%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637205895885805857&sdata=9%2FYStDGvrU5ZIYXB7guowmaPlKazab0U%2BTpiBIItDaQ%3D&reserved=0).
