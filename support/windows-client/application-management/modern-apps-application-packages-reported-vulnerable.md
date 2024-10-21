---
title: Modern apps or application packages are reported as vulnerable
description: Provides resolutions for the issue in which modern apps or application packages are reported by vulnerability scanning due to multiple versions.
ms.date: 10/21/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, kimberj
ms.custom: sap:Windows Desktop and Shell Experience\Modern, Inbox and Microsoft Store Apps, csstroubleshoot
---
# Modern apps or application packages are reported as vulnerable due to multiple versions

This article provides troubleshooting suggestions when there are multiple versions of one modern app (also known as application package) on a computer. The app could be reported as vulnerable by system vulnerability scanning and can't be resolved by updating to the latest version.

*Original KB number:* &nbsp; 5011324

## Issue symptoms

On recent Windows versions, several parts of the shell are moved to modern apps. Those apps are brought as .msix or .appx files and need to be registered per-user at every first user sign-in to Windows or after an app update.

Those apps might be **SystemApps** (such as **StartMenuExperienceHost**, **ShellExperienceHost** and so on) brought within Windows Cumulative Updates, or **WindowsApps** which are updated through Windows Update connecting to Windows Store endpoints.

Because of this inherent design, you might encounter one of the following issues:

### Multiple app folders in the system

If there are multiple user profiles in the system, Apps installed per users might create multiple app folders because of the different versions. The folders are in the *C:\\Program Files\\WindowsApps* hidden folder.

### Multiple app versions in the system

Consider the following scenarios:

- Several users are signed in at the same time and Microsoft Store is enabled. One user is using the app during a Microsoft Store background update.
- Some users don't sign in frequently and Microsoft Store is disabled. The system administrator updates the app manually.

In these scenarios, there are multiple versions of the app per users in the system, which doesn't affect users. However, the app is reported as vulnerable if the app isn't updated for all users.

## Update the app for all users or remove the old packages

To resolve this issue, use one or more of the following methods:

1. Ensure that the app is updated for all users in the system by reconnecting to the machine with user profiles.

   1. Identify the user profiles in which the old Appx version package is installed by using the Appx cmdlet [Get-AppxPackage](/powershell/module/appx/get-appxpackage) from an elevated PowerShell window.

      ```powershell
      Get-AppxPackage <app_name> -AllUsers
      ```

   2. Reconnect to the machine with the identified user.

2. Remove the old packages (.appx)

   1. Identify the User Profiles in which the Appx package is installed with Appx cmdlet [Get-AppxPackage](/powershell/module/appx/get-appxpackage) from an elevated PowerShell prompt.

      ```powershell
      Get-AppxPackage <app_name> -AllUsers
      ```

   2. Identify if the app is provisioned. To get a list of all provisioned apps, use [Get-AppxProvisionedPackage](/powershell/module/dism/get-appxprovisionedpackage).

      ```powershell
      Get-AppxProvisionedPackage -Online | Format-Table DisplayName, PackageName
      ```

   3. To remove the Appx Package for All Users in the System.

      ```powershell
      Get-AppxPackage <app_name> -AllUsers | Remove-AppxPackage -AllUsers
      ```

   > [!NOTE]
   > For more information and usage examples regarding the management of Appx packages via Powershell cmdlets, see the following articles.
   >
   > - [Get-AppxPackage](/powershell/module/appx/get-appxpackage)
   > - [Get-AppxProvisionedPackage (DISM) | Microsoft Learn](/powershell/module/dism/get-appxprovisionedpackage)
   > - [Remove-AppxPackage (Appx)](/powershell/module/appx/remove-appxpackage)
   > - [Remove-AppxProvisionedPackage](/powershell/module/dism/remove-appxprovisionedpackage)

3. Delete the user profiles pointing to the old version of the app. To do so, see the following articles:  
   [Delete a user profile in Windows](../../windows-server/user-profiles-and-logon/delete-user-profile.md)  
   [Using Group Policy/CSP](/windows/client-management/mdm/policy-csp-admx-userprofiles#cleanupprofiles)

To confirm that the app is updated for all users and the old packages are removed, scan again or check the *C:\\Program Files\\WindowsApps* folder. If you don't have the permission to check the folder, create a copy in another location and check inside.
