---
title: Incorrect registry key for Access
description: Describes an issue in which Access may not detect/repair the registry key that specifies the configured version of Access. Provides a solution.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - Access 2010
  - Access 2013
  - Microsoft Office Access 2007
ms.date: 05/26/2025
---

# Access: Incorrect version registry key

## Symptoms

In some instances Access may not detect/repair the registry key that specifies the configured version of Access. In this scenario, when double-clicking on the database file, you receive the following error:

```adoc
Windows can't open this file: 

File: <DatabaseName>.accdb

To open this file, Windows needs to know what program you want to use to open it.
```

## Cause

The following registry key contains an invalid default value of accdb_auto_file:

**HKEY_CLASSES_ROOT\Access.Application\CurVer**

## Resolution

Modify the **HKEY_CLASSES_ROOT\Access.Application\CurVer** registry key to specify the appropriate default value for your version of Access.

Registry DISCLAIMER: Modifying REGISTRY settings incorrectly can cause serious problems that may prevent your computer from booting properly. Microsoft cannot guarantee that any problems resulting from the configuring of REGISTRY settings can be solved. Modifications of these settings are at your own risk. 

1. Click **Start** then **Run**, type **regedit** and then click **OK**.
2. Navigate to **HKEY_CLASSES_ROOT\Access.Application\CurVer**.
3. In the right pane, double-click on the default key.
4. Change the Value data from accdb_auto_file to the appropriate **Access.Application** item below based on your version of Access:

   Access 2007 - Access.Application.12

   Access 2010 - Access.Application.14

   Access 2013 - Access.Application.15
