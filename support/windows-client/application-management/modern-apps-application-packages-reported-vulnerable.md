---
title: Modern apps or application packages are reported as vulnerable
description: Provides resolutions for the issue in which modern apps or application packages are reported by vulnerability scanning due to multiple versions.
ms.date: 10/21/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, kimberj
ms.custom: sap:Windows Desktop and Shell Experience\Modern, Inbox and Microsoft Store Apps, csstroubleshoot
---
# Modern apps or application packages are reported as vulnerable due to multiple versions

This article provides troubleshooting suggestions when there are multiple versions of a modern app or application package on a computer. The app might be reported as vulnerable by system vulnerability scanning and can't be resolved by updating to the latest version.

*Original KB number:* &nbsp; 5011324

## Symptoms

In recent Windows versions, several parts of the shell have been moved to modern apps. Those apps are introduced as *.msix* or *.appx* files and need to be registered per user each time a user signs in to Windows for the first time or after an app update.

Those modern apps might be **SystemApps** (such as **StartMenuExperienceHost** and **ShellExperienceHost**) introduced within Windows Cumulative Updates or **WindowsApps** updated through Windows Update connecting to Windows Store endpoints.

Because of this inherent design, you might encounter one of the following issues:

### Multiple app folders in the system

If there are multiple user profiles in the system, apps installed per user might create multiple app folders because of the different versions. The folders are in the *C:\\Program Files\\WindowsApps* hidden folder.

### Multiple app versions in the system

Consider the following scenarios:

- Several users are signed in at the same time, and Microsoft Store is enabled. One user is using the app during a Microsoft Store background update.
- Some users don't sign in frequently, and Microsoft Store is disabled. The system administrator updates the app manually.

In these scenarios, there are multiple versions of the app per user in the system, which doesn't affect users. However, the app is reported as vulnerable if the app isn't updated for all users.

## Update the app for all users or remove the old packages

To resolve this issue, use one or more of the following methods:

### Method 1: Ensure that the app is updated for all users in the system by reconnecting to the machine with user profiles

1. Identify the user profiles in which the old Appx version package is installed by using the Appx cmdlet [Get-AppxPackage](/powershell/module/appx/get-appxpackage) from an elevated PowerShell window:

   ```powershell
   Get-AppxPackage <Application Name> -AllUsers
   ```

2. Reconnect to the machine with the identified user.

### Method 2: Remove the old packages (*.appx*)

1. Identify the user profiles in which the Appx package is installed with the Appx cmdlet [Get-AppxPackage](/powershell/module/appx/get-appxpackage) from an elevated PowerShell prompt:

   ```powershell
   Get-AppxPackage <Application Name> -AllUsers
   ```

2. Identify if the app is provisioned. To get a list of all provisioned apps, use [Get-AppxProvisionedPackage](/powershell/module/dism/get-appxprovisionedpackage):

   ```powershell
   Get-AppxProvisionedPackage -Online | Format-Table DisplayName, PackageName
   ```

3. Remove the Appx package for all users in the system:

   ```powershell
   Get-AppxPackage <Application Name> -AllUsers | Remove-AppxPackage -AllUsers
   ```

   > [!NOTE]
   > For more information and usage examples regarding the management of Appx packages via PowerShell cmdlets, see the following articles.
   >
   > - [Get-AppxPackage](/powershell/module/appx/get-appxpackage)
   > - [Get-AppxProvisionedPackage (DISM)](/powershell/module/dism/get-appxprovisionedpackage)
   > - [Remove-AppxPackage (Appx)](/powershell/module/appx/remove-appxpackage)
   > - [Remove-AppxProvisionedPackage](/powershell/module/dism/remove-appxprovisionedpackage)

### Method 3: Delete the user profiles pointing to the old version of the app

To do so, see the following articles:

- [Delete a user profile in Windows](../../windows-server/user-profiles-and-logon/delete-user-profile.md)  
- [Using Group Policy/CSP](/windows/client-management/mdm/policy-csp-admx-userprofiles#cleanupprofiles)

To confirm that the App is updated for all users and the old packages are removed, scan again or check the *C:\\Program Files\\WindowsApps* folder. If you don't have permission to check the folder, create a copy in another location and check inside.
