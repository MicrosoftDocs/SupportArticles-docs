---
title: Troubleshooting Microsoft Store Apps download failure
description: Provides guidance to troubleshooting Microsoft Store Apps download and update failure.
ms.date: 08/15/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom: sap:Windows Desktop and Shell Experience\Modern, Inbox and Microsoft Store Apps, csstroubleshoot
ms.reviewer: winciccore, warrenw
localization_priority: medium
---
# Troubleshooting Microsoft Store Apps download failure

This article provides guidance on troubleshoot failures of downloading or updating Apps from Microsoft Store.

## Troubleshooting checklist

1. Verify Microsoft Store is registered or registered for your user.
2. Verify you can launch Microsoft Store, and Microsoft Store isn't blocked from downloading updates.
3. Use `winget` to install packages.
4. Verify that firewall or proxy doesn't block required endpoints.

See the following sections for detail steps.

## Verify Microsoft Store is registered or not for the user account

To check whether the user has Microsoft Store installed, run the following cmdlet from a nonelevated PowerShell Prompt.

```powershell
Get-AppxPackage *Microsoft.WindowsStore*
```

If Microsoft Store is registered, the output looks like the following.

```output
Name              : Microsoft.WindowsStore
Publisher         : CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US
Architecture      : X64
ResourceId        :
Version           : 22405.1401.9.0
PackageFullName   : Microsoft.WindowsStore_22405.1401.9.0_x64__8wekyb3d8bbwe
InstallLocation   : C:\Program Files\WindowsApps\Microsoft.WindowsStore_22405.1401.9.0_x64__8wekyb3d8bbwe
IsFramework       : False
PackageFamilyName : Microsoft.WindowsStore_8wekyb3d8bbwe
PublisherId       : 8wekyb3d8bbwe
IsResourcePackage : False
IsBundle          : False
IsDevelopmentMode : False
NonRemovable      : False
Dependencies      : {Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x64__8wekyb3d8bbwe,
                    Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x64__8wekyb3d8bbwe,
                    Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64__8wekyb3d8bbwe,
                    Microsoft.VCLibs.140.00_14.0.33519.0_x64__8wekyb3d8bbwe...}
IsPartiallyStaged : False
SignatureKind     : Store
Status            : Ok
```

If the output indicates Microsoft Store isn't installed, you can try re-registering Microsoft Store.

To do this, first check if other users on the machine have Microsoft Store registered. Run the cmdlet from an elevated PowerShell prompt:

```powershell
Get-AppxPackage *Microsoft.WindowsStore* -AllUsers
```

If there's a successful return of the Appx package details, it means that the package exists.

> [!NOTE]
> Warning: Completely uninstalling Microsoft Store is not Supported, read this [article](cannot-remove-uninstall-or-reinstall-microsoft-store-app.md) if you are facing this problem.

Once you determine that the Appx package exists on the machine, the following command can be used to register the Appx package for the user.

> [!IMPORTANT]
> Be sure not to use the elevated PowerShell prompt unless you wish to register the app to the administrator instead of the user.

```powershell
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.WindowsStore_8wekyb3d8bbwe
```

## Verify that you can launch Microsoft Store, and Microsoft Store isn't blocked from downloading updates

Administrators can block Microsoft Store for end users. In such case, Microsoft Store isn't accessible for end users. When Microsoft Store is turned off from Policy or Configuration Service Provider (CSP), the following message is displayed upon launching Microsoft Store App.

The usual policy to disable the Microsoft Store is **RemoveWindowsStore**. This policy blocks users from opening Microsoft Store, however Microsoft Store Apps aren't restricted from updating.

If the issue is about Microsoft Store Apps packages not getting updated automatically, check [Verify required endpoints aren't blocked from firewall or proxy](#verify-required-endpoints-arent-blocked-from-firewall-or-proxy).

## Using `winget` to install packages

The `winget` (Windows Package Manager) command can be used to install or manage Microsoft Store Apps. See [Use the winget tool to install and manage applications](/windows/package-manager/winget/) for a complete usage instruction for `winget`.

The following guide is about typical situations associated with using `winget` to install Microsoft Store Apps.

1. Search for the Application you want to install.

   ```powershell
   winget search <App name>
   ```

2. Install the application.

   ```powershell
   winget install <App name>
   ```

## Verify required endpoints aren't blocked from firewall or proxy

Microsoft Store requires specific endpoints to be accessible to install or update Apps. Microsoft Store uses Windows Update endpoints to be accessible to install and update Apps.

1. See [Manage connection endpoints for Windows 11 Enterprise](/windows/privacy/manage-windows-11-endpoints) for required endpoints and other system components.
2. See [Issues related to HTTP/Proxy](../installing-updates-features-roles/windows-update-issues-troubleshooting.md#issues-related-to-httpproxy) for required Windows Update and related troubleshooting guide.
