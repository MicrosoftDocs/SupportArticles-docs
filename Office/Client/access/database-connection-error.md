---
title: Unable to open a database with connection error
description: Fixes an issue in which you receive an error Method 'Connection' of object '_Current Project' failed when you open a database in Access.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
search.appverid: MET150
ms.date: 05/26/2025
---
# Connection error when using CurrentProject.Connection or CurrentDB.Connection in Access

_Original KB number:_ &nbsp; 2459087

## Symptoms

When you open your database in Access, you receive the following error message:

> Method 'Connection' of object '_Current Project' failed.

This failure occurs when the VBA Application.CurrentProject.Connection or Application.CurrentDB.Connection is called.

## Cause

The Access Database Engine/Access Connectivity Engine (ACE) is included with a number of products other than Microsoft Access such as Microsoft Visio and Microsoft Project. If you install a version of ACE that's different than that of Access, the ACEOLEDB.DLL path in the registry may not point to the corresponding ACE version.

## Resolution

You should be able to resolve this issue by running a repair of the Office or Access installation.

Alternatively, you can modify the registry key changing the dll path to match that of your Access version.

> [!NOTE]
> Access 2007 - OFFICE12, Access 2010 - OFFICE14, Access 2013 - OFFICE15 and Access 2016 - OFFICE16.

### MSI installations

(OS: 64-bit and Office: 64-bit) or (OS: 32-bit and Office: 32-bit)

Key: `HKCR\CLSID\{3BE786A0-0366-4F5C-9434-25CF162E475E}\InprocServer32\`

Value Name: (Default)

Value Data: `C:\Program Files\Common Files\Microsoft Shared\OFFICE15\ACEOLEDB.DLL`

(OS: 64-bit and Office: 32-bit)

Key: `HKCR\Wow6432Node\CLSID\{3BE786A0-0366-4F5C-9434-25CF162E475E}\InprocServer32\`

Value Name: (Default)

Value Data: `C:\Program Files (x86)\Common Files\Microsoft Shared\OFFICE15\ACEOLEDB.DLL`

### Click-2-Run installations

(OS: 64-bit and Office: 64-bit) or (OS: 32-bit and Office: 32-bit)

Key:
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Classes\CLSID\{3BE786A0-0366-4F5C-9434-25CF162E475E}\InprocServer32`

Value Name: (Default)

Value Data: `C:\Program Files\Common Files\Microsoft Shared\OFFICE15\ACEOLEDB.DLL`

(OS: 64-bit and Office: 32-bit)

Key: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Classes\Wow6432Node\CLSID\{3BE786A0-0366-4F5C-9434-25CF162E475E}\InprocServer32`

Value Name: (Default)

Value Data: `C:\Program Files (x86)\Common Files\Microsoft Shared\OFFICE15\ACEOLEDB.DLL`
