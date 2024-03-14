---
title: There is a problem with your account, please try again later
description: This article describes a There is a problem with your account, please try again later error when you try to open Office documents from OneDrive for Business or SharePoint Online, and provides solutions.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
  - OneDrive for Business
ms.date: 12/17/2023
---

# "There is a problem with your account, please try again later" when you open Office documents from OneDrive for Business or SharePoint Online

> [!NOTE]
> This article applies only to the previous OneDrive for Business sync client (groove.exe). In most cases, we recommend that you [use the newer OneDrive sync client](https://support.office.com/article/sync-files-with-the-onedrive-sync-client-in-windows-615391c4-2bd3-4aae-a42a-858262e42a49) (onedrive.exe) instead. [Which version of OneDrive am I using?](https://support.office.com/article/which-version-of-onedrive-am-i-using-19246eae-8a51-490a-8d97-a645c151f2ba)

## Problem

When you try to open Office documents that are stored on OneDrive for Business or SharePoint Online by using the Office client application, or when you sign in to the OneDrive for Business client (groove.exe), you receive the following error message:

**There is a problem with your account, please try again later.**

## Solution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, back up the registry for restoration in case problems occur.

To resolve this issue, follow these steps:

1. Back up the Windows registry. For information about how to do this, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Click **Start**, click **Run**, type regedit, and then press Enter.

1. Locate the following key:

    **HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common\Identity**

1. At this location, delete the following keys:

    - FederationCacheExpiration
    
    - FederationProvider

1. Restart the computer.

## Workaround

If you can't make the changes to the registry, use Office Online to open and work with Office documents.

## More information

By default, the registry keys that are listed in this article are set to update every three days. If you don't remove the keys, they will be refreshed after three days. After they are refreshed, this issue should resolve itself.

It's possible that your organization has overridden the default value for the key update to be more or less than three days. To determine whether your organization changed the default value for the keys to update, locate the following subkey in Registry Editor, and then check the FederationCacheLifetime key:

**HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common\Identity**

- If the FederationCacheLifetime key exists, the number of days for the keys to update was overridden to equal the value of this key. For example, if the value of this key is 5, the keys will be updated in five days.

- If the FederationCacheLifetime key doesn't exist, the default value for the keys to update is three (3) days.

Your organization may want to automate the removal of the registry key from computers programmatically. To remove the registry key, use this sample batch file code: 

> [!NOTE]
> Administrative privileges are required to run the batch file.

```bat
 @echo off
taskkill /f /im EXCEL.EXE 
taskkill /f /im ONENOTE.EXE 
taskkill /f /im OUTLOOK.EXE 
taskkill /f /im POWERPNT.EXE 
taskkill /f /im WINPROJ.EXE 
taskkill /f /im VISIO.EXE 
taskkill /f /im WINWORD.EXE 
taskkill /f /im MSACCESS.EXE 
taskkill /f /im MSPUB.EXE 
taskkill /f /im lync.exe 
taskkill /f /im groove.exe 
taskkill /f /im msosync.exe 

(

echo REGEDIT4 
echo [HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common\Identity] 
echo "FederationProvider"=- ) > %TEMP%\94cf28e9-3a0e-4d3d-8161-d4b1d7bc94c0.reg 

regedit /s %TEMP%\94cf28e9-3a0e-4d3d-8161-d4b1d7bc94c0.reg 

del %TEMP%\94cf28e9-3a0e-4d3d-8161-d4b1d7bc94c0.reg
```

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
