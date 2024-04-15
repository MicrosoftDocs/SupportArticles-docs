---
title: The installation hangs when you try to install a KB update
description: Provides resolutions for an issue where installation hangs when you try to install a KB update.
ms.date: 04/02/2022
author: jasonchlus
ms.author: jasonchlus
ms.reviewer: terry.g.lee
ms.custom: sap:Installation\Servicing updates and service packs
---
# The installation hangs when you try to install a KB update

This article provides resolutions for an issue where installation hangs when you try to install a KB update.  

_Applies to:_&nbsp;Visual Studio 2015

## Symptom

The installation hangs when you try to install a KB update.

## Resolution

To resolve the issue, stop the Visual Studio installer and ensure that Windows is up to date. In addition, confirm that any installed antivirus software is properly disabled.

### For Windows 7, 8, or 8.1

1. Enter _Control Panel_ in the search box of the taskbar to open **Control Panel**.
2. Select **System and Security** > **Windows Update**.
3. Select **Check for Updates** or view **Update History** for the last update.

### For Windows 10

1. Select **Start** > **Settings** > **Update & Security** > **Windows Update**.
1. Select **Check for updates** or view **Update history**.

If you experience issues when trying to update Windows, try the [Windows Update Troubleshooter](https://support.microsoft.com/windows/windows-update-troubleshooter-19bc41ca-ad72-ae67-af3c-89ce169755dd#WindowsVersion=Windows_10). The troubleshooter will scan your computer and fix any errors that it detects.

If you're still unable to update Windows after running the Windows Update Troubleshooter, contact [Windows Support](https://support.microsoft.com/contactus/) to get assistance with your issue.
