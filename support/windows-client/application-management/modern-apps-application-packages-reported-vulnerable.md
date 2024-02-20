---
title: Modern apps or application packages are reported as vulnerable
description: Provides resolutions for the issue in which modern apps or application packages are reported by vulnerability scanning.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, kimberj
ms.custom: sap:modern-inbox-and-microsoft-store-apps, csstroubleshoot
---
# Modern apps or application packages are reported as vulnerable

This article provides resolutions for the issue in which modern apps or application packages are reported by vulnerability scanning.

_Original KB number:_ &nbsp; 5011324

Some modern apps or application packages are reported as vulnerable by system vulnerability scanning, and can't be resolved by updating to the latest version.

## Multiple app folders in the system

If there are multiple user profiles in the system, apps installed per users may create multiple app folders because of different versions. The folders are in the *C:\\Program Files\\WindowsApps* hidden folder.

## Multiple app versions in the system

Consider the following scenarios:

- Several users are signed in at the same time and Microsoft Store is enabled. One user is using the app during a Microsoft Store background update.
- Some users don't sign in frequently and Microsoft Store is disabled. The system administrator updates the app manually.

In these scenarios, there are multiple versions of the app per users in the system, which doesn't affect users. However, the app or application package is reported as vulnerable if the app isn't updated for all users.

## Update the app for all users or remove the old packages

To resolve this issue, use one or more of the following methods:

- Ensure that the app is updated for all users in the system.
- Remove the old packages (`.appx`) by using one of the following cmdlets:
  - The Deployment Image Servicing and Management (DISM) cmdlet [Remove-AppxProvisionedPackage](/powershell/module/dism/remove-appxprovisionedpackage):

    ```powershell
    Remove-AppxProvisionedPackage  -PackageName <Application Name>
    ```

  - The Appx cmdlets ([Get-AppxPackage](/powershell/module/appx/get-appxpackage) and [Remove-AppxPackage](/powershell/module/appx/remove-appxpackage)):

    ```powershell
    Get-AppxPackage <Application Name> -AllUsers | Remove-AppxPackage -Allusers
    ```

- Delete the user profiles pointing to the old version of the app.

To confirm that the app is updated for all users and the old packages are removed, scan again or check the *C:\\Program Files\\WindowsApps* folder. If you don't have the permission to check the folder, create a copy in another location and check inside.
