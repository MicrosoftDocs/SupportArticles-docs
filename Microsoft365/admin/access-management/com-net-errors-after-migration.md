---
title: COM and .NET errors after Office architecture migration
description: Describes an issue in which you experience errors after you migrate Office to 64-bit architecture if COM or .NET is used.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - CSSTroubleshoot
  - CI 146798
ms.reviewer: roclemen, mattphil, micsmith
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 05/28/2025
---

# COM and .NET errors after Office architecture migration

## Symptoms

After you migrate Microsoft Office architecture from 32-bit to 64-bit, you experience errors if a COM application or a .NET Framework client is used. These possible errors include, but are not limited to, the following:

- TYPE_E_CANTLOADLIBRARY

- TYPE_E_LIBNOTREGISTERED

- TYPE_E_ELEMENTNOTFOUND

The errors usually occur if the COM application or .NET client is running as a 32-bit process.

**Example**

These errors might occur when the following code is run in 86-bit PowerShell:
```powershell
$xl = New-Object -ComObject Excel.Application

$xl.Visible = $True
```

## Cause

The errors are caused by orphaned registry subkeys that are created by the migration.

## Resolution

To fix this problem, use either of the following methods.

### Method 1: Delete orphaned subkeys automatically

To detect and remove the orphaned subkeys, run this script from the following GitHub location:

[Office TypeLib Remediation](https://github.com/bobclements-msft/Office-TypeLib-Remediation)

### Method 2: Delete orphaned subkeys manually

If the PowerShell script from Step 1 doesn't delete the orphaned subkeys, you can also check for orphaned entries manually. The affected device might have orphaned subkeys that resemble the following example:

>*HKEY_CLASSES_ROOT\WOW6432Node\TypeLib\GUID\1.9\0\Win32*

Note: In this example, *:::no-loc text="GUID":::* is a string that is specific to the subkey.

The subkey will have a value that points to a missing Office executable in the Program Files (x86) file path. For example:

> *C:\Program Files (x86)\Microsoft Office\Root\Office16\EXCEL.EXE*

There should also be an adjacent subkey that points to the correct 64-bit Program Files location.
