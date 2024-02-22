---
title: Can't open OneDrive on images using Sysprep
description: Describes how to deploy OneDrive for Windows 10 images using SysPrep.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - OneDrive for Business
search.appverid: MET150
ms.date: 12/17/2023
---
# Unable to open OneDrive on images using Sysprep

_Original KB number:_ &nbsp; 4459304

## Symptoms

Users are unable to open OneDrive after joining a domain with Win10 images using SysPrep.

## How to fix devices with OneDrive incorrectly deployed

To fix devices that have OneDrive deployed incorrectly using a **syspreped** image:

1. Sign in to the machine as the user that's unable to start OneDrive.
2. [Download the latest build](https://go.microsoft.com/fwlink/p/?linkid=844652) of OneDrive and reinstall it.

## How to correctly deploy OneDrive via sysprep

After you have completed all of your system prep activities but **before** actually running sysprep on the profile, complete the following steps:

1. Uninstall OneDrive `onedrivesetup.exe /uninstall`.
2. Add the following registry key:

    `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce`  
    `OneDriveSetup`=**C:\\\Windows\\\SysWOW64\\\OneDriveSetup.exe /thfirstsetup**

3. Run **sysprep**.

## Deployment

For more information, see [Deploy OneDrive apps using Microsoft Endpoint Configuration Manager](/onedrive/deploy-on-windows).

## See also

[OneDrive won't start](https://support.microsoft.com/office/onedrive-won-t-start-0c158fa6-0cd8-4373-98c8-9179e24f10f2).
