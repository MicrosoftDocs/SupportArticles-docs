---
title: COM and .NET errors after Office architecture migration
description: Describes an issue where you might get an error when COM or .NET is used, after migrating Office to 64-bit architecture.
author: v-matham
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-matham
ms.custom: 
- CSSTroubleshoot
- CI 146798
ms.reviewer: roclemen, mattphil, micsmith
search.appverid: 
- MET150
appliesto:
- Office 365
---

# COM and .NET errors after Office architecture migration

## Symptoms

After migrating Microsoft Office architecture from 32-bit to 64-bit, you might encounter an error when COM or .NET is used. The errors encountered include, but are not limited to, the following:

- TYPE_E_CANTLOADLIBRARY

- TYPE_E_LIBNOTREGISTERED

- TYPE_E_ELEMENTNOTFOUND

The errors usually occur when the COM or .NET client is running as a 32-bit process.

**Example**

The errors could occur when the following code is executed in using PowerShell (x86):
```
$xl = New-Object -ComObject Excel.Application

$xl.Visible = $True
```

## Cause

The errors are caused by orphaned registry subkeys left after the migration.

## Resolution

### Step 1: Check for orphaned subkeys

You can run the scripts found at the following GitHub location to detect and remove orphaned subkeys:

[Office TypeLib Remediation](https://github.com/bobclements-msft/Office-TypeLib-Remediation)

You can also check for orphaned entries manually. The affected device might have orphaned subkeys like the following:

*:::no-loc text="HKEY_CLASSES_ROOT\WOW6432Node\TypeLib\GUID\1.9\0\Win32":::* (where ":::no-loc text="GUID":::" is a string specific to the subkey)

The subkey will have a value that points to a missing Office executable in the Program Files (x86) file path, such as *:::no-loc text="C:\Program Files (x86)\Microsoft Office\Root\Office16\EXCEL.EXE":::*. There should also be an adjacent subkey that points to the correct 64-bit Program Files location.

### Step 2: Delete orphaned subkeys

If you ran the PowerShell script in Step 1, it should delete the orphaned subkeys. If you didn’t run the script, delete the orphaned subkeys (*:::no-loc text="HKEY_CLASSES_ROOT\WOW6432Node\TypeLib\GUID\1.9\0\Win32":::*) manually.