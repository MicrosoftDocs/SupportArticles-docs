---
title: Modern apps or application packages are reported as vulnerable
description: Provides resolutions for the issue in which modern apps or application packages are reported by vulnerability scanning due to multiple versions.
ms.date: 09/26/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, kimberj
ms.custom: sap:Windows Desktop and Shell Experience\Modern, Inbox and Microsoft Store Apps, csstroubleshoot
---
# Packaged applications are reported as vulnerable due to multiple versions

This article provides troubleshooting suggestions when there are multiple versions of one packaged application (also known as Microsoft Store App or WindowsApp) on a computer. The application could be reported as vulnerable by system vulnerability scanning and can't be resolved by updating to the latest version.

*Original KB number:* &nbsp; 5011324

## Issue symptoms

On recent Windows versions, several parts of the shell are moved to **Packaged applications**. Those applications are brought as .msix or .appx files and need to be registered per-user at every first user logon on Windows or after an App update.

Those packaged applications may be **SystemApps** (such as **StartMenuExperienceHost**, **ShellExperienceHost** and so on) brought within Windows Cumulative Updates, or **WindowsApps** which are updated through Windows Update connecting to Windows Store endpoints.

Because of this inherent design, you might encounter one of the following issues:

### Multiple App folders in the system

If there are multiple user profiles in the system, Apps installed per users may create multiple App folders because of the different versions. The folders are in the *C:\\Program Files\\WindowsApps* hidden folder.

### Multiple App versions in the system

Consider the following scenarios:

- Several users are signed in at the same time and Microsoft Store is enabled. One user is using the App during a Microsoft Store background update.
- Some users don't sign in frequently and Microsoft Store is disabled. The system administrator updates the App manually.

In these scenarios, there are multiple versions of the App per users in the system, which doesn't affect users. However, the App or application package is reported as vulnerable if the App isn't updated for all users.

## Update the App for all users or remove the old packages

To resolve this issue, use one or more of the following methods:

1. Ensure that the App is updated for all users in the system by reconnecting to the machine with user Profiles, who don't frequently log in.

   1. Identify the User Profiles in which the old Appx version package is installed with Appx cmdlet [Get-AppxPackage](/powershell/module/appx/get-appxpackage) from an elevated Powershell prompt.

      ```powershell
      Get-AppxPackage <Application Name> -AllUsers
      ```

   2. Reconnect to the machine with the identified user.

2. Remove the old packages (.appx)

   1. Identify the User Profiles in which the Appx package is installed with Appx cmdlet [Get-AppxPackage](/powershell/module/appx/get-appxpackage) from an elevated Powershell prompt.

      ```powershell
      Get-AppxPackage <Application Name> -AllUsers
      ```

   2. Identify if the application is provisioned. To get a list of all provisioned Apps, use [Get-AppxProvisionedPackage](/powershell/module/dism/get-appxprovisionedpackage).

      ```powershell
      Get-AppxProvisionedPackage -Online | Format-Table DisplayName, PackageName
      ```

   3. To remove the Appx Package for All Users in the System.

      ```powershell
      Get-AppxPackage <Application Name> -AllUsers | Remove-AppxPackage -AllUsers
      ```

   > [!NOTE]
   > For further information and usage examples regarding the management of Appx packages via Powershell cmdlets, please refer to the articles below.
   >
   > - [Get-AppxPackage](/powershell/module/appx/get-appxpackage)
   > - [Get-AppxProvisionedPackage (DISM) | Microsoft Learn](/powershell/module/dism/get-appxprovisionedpackage)
   > - [Remove-AppxPackage (Appx)](/powershell/module/appx/remove-appxpackage)
   > - [Remove-AppxProvisionedPackage](/powershell/module/dism/remove-appxprovisionedpackage)

3. Delete the user profiles pointing to the old version of the app. To do so, see the following articles:  
   [Delete a user profile in Windows](../../windows-server/user-profiles-and-logon/delete-user-profile.md)  
   [Using Group Policy/CSP](/windows/client-management/mdm/policy-csp-admx-userprofiles#cleanupprofiles)

To confirm that the App is updated for all users and the old packages are removed, scan again or check the *C:\\Program Files\\WindowsApps* folder. If you don't have the permission to check the folder, create a copy in another location and check inside.
