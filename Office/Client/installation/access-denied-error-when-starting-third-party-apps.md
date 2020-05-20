---
title: Starting third-party add-in causes "Access Denied" error
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 4/29/2020
audience: Admin
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
ms.reviewer: rycarter
description: What to do if you get an "Access Denied" error when starting third-party add-ins, which rely on .NET framework. 
---

# Error message when starting a Microsoft Office third-party add-in that relies on .NET binaries

## Symptoms

You receive one of the following kinds of error messages when attempting to start a third-party Office add-in that relies on .NET framework Office binaries:

- "Access Denied"
- "File not found or no read permission"
- "Could not load file or assembly…"


## Cause

Devices affected by this issue were sold with Windows 10 **RS5**, release **17763**, which came bundled with Centennial Office, a version of Office once available through the Windows Store. Even if Centennial Office has never been activated, Windows Store continues to update the associated installation packages on the affected device, a process which changes and severely restricts permissions on ".DLLs" located in subfolders of the Office Primary Interop Assembly (PIA) library folder, C:\Windows\assembly\GAC_MSIL.

The restricted permissions on the PIA files prevent many third-party add-ins from operating. The most common add-ins affected are those for Excel, which often use files in the folder: 

```
C:\Windows\assembly\GAC_MSIL\Policy.14.0.Microsoft.Office.Interop.Excel\15.0.0.0__71e9bce111e9429c 
```

If the Centennial Office package files are not removed from the affected computer, the issue will reoccur when Centennial Office receives an update from the Microsoft Store. 


## Resolution

Users should run the [Online Repair tool](https://support.office.com/Article/Repair-an-Office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b) on the affected device. The Online Repair Tool will remove the Centennial Office packages and reestablish the permissions on the affected PIA files.

## More information

Still need help? Go to [Microsoft Community](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fanswers.microsoft.com%2F&data=02%7C01%7Cv-todmc%40microsoft.com%7C98910814456c474880f108d7cf62d97d%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637205895885805857&sdata=9%2FYStDGvrU5ZIYXB7guowmaPlKazab0U%2BTpiBIItDaQ%3D&reserved=0).
