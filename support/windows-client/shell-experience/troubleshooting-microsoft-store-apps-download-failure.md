---
title: Troubleshoot Microsoft Store app download failures
description: Provides guidance for troubleshooting Microsoft Store app download and update failures.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom: sap:Windows Desktop and Shell Experience\Modern, Inbox and Microsoft Store Apps, csstroubleshoot
ms.reviewer: winciccore, warrenw
---
# Troubleshoot Microsoft Store app download failures

This article provides guidance for troubleshooting failures in downloading or updating apps from Microsoft Store.

> [!NOTE]
> If you're not a support agent or IT professional, you can find more helpful information about Microsoft Store problems in [Fix problems with apps from Microsoft Store](https://support.microsoft.com/account-billing/fix-problems-with-apps-from-microsoft-store-93ed0bcf-9c12-3df6-6dda-92ec5d0415ac).

## Troubleshooting checklist

1. Verify that Microsoft Store is registered for your user.
2. Verify that you can launch Microsoft Store and that Microsoft Store isn't blocked from downloading updates.
3. Use `winget` to install packages.
4. Verify that the firewall or proxy doesn't block the required endpoints.

For detailed steps, see the following sections.

## Verify that Microsoft Store is registered for the user account

To check whether the user has Microsoft Store installed, run the following cmdlet from a nonelevated PowerShell prompt:

```powershell
Get-AppxPackage *Microsoft.WindowsStore*
```

If Microsoft Store is registered, the output looks like the following example:

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

To do so, first check if other users on the machine have Microsoft Store registered. Then, run the following cmdlet from an elevated PowerShell prompt:

```powershell
Get-AppxPackage *Microsoft.WindowsStore* -AllUsers
```

If the Appx package details are successfully returned, it means that the package exists.

> [!NOTE]
> Completely uninstalling Microsoft Store isn't supported. If you encounter this problem, see [Removing, uninstalling, or reinstalling Microsoft Store app isn't supported](cannot-remove-uninstall-or-reinstall-microsoft-store-app.md).

Once you determine that the Appx package exists on the machine, you can use the following command to register the Appx package for the user.

> [!IMPORTANT]
> Be sure not to use an elevated PowerShell prompt unless you want to register the app to the administrator instead of the user.

```powershell
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.WindowsStore_8wekyb3d8bbwe
```

## Verify that you can launch Microsoft Store and that Microsoft Store isn't blocked from downloading updates

Administrators can block end users from using Microsoft Store. In this case, Microsoft Store isn't accessible to end users. When Microsoft Store is turned off from a policy or configuration service provider (CSP), the following message is displayed upon launching the Microsoft Store app:

:::image type="content" source="media/troubleshooting-microsoft-store-apps-download-failure/microsoft-store-startup-error.png" alt-text="Screenshot of the Microsoft Store startup error." border="false":::

A common policy to disable Microsoft Store is **RemoveWindowsStore**. This policy blocks users from opening Microsoft Store. However, Microsoft Store apps aren't restricted from updating.

If the issue is that Microsoft Store app packages aren't updated automatically, check and [verify that the required endpoints aren't blocked by the firewall or proxy](#verify-that-the-required-endpoints-arent-blocked-by-the-firewall-or-proxy).

## Use winget to install packages

The `winget` (Windows Package Manager) command can be used to install or manage Microsoft Store apps. For complete instruction for using `winget`, see [Use the WinGet tool to install and manage applications](/windows/package-manager/winget/).

Here are the steps for typical situations associated with using `winget` to install Microsoft Store apps.

1. Search for the application you want to install:

   ```powershell
   winget search <App name>
   ```

2. Install the application:

   ```powershell
   winget install <App name>
   ```

## Verify that the required endpoints aren't blocked by the firewall or proxy

Microsoft Store requires specific endpoints to be accessible to install or update apps. For example, Microsoft Store needs Windows Update endpoints to be accessible to install and update apps.

1. See [Manage connection endpoints for Windows 11 Enterprise](/windows/privacy/manage-windows-11-endpoints) for information about the required endpoints and other system components.
2. See [Issues related to HTTP/Proxy](../installing-updates-features-roles/windows-update-issues-troubleshooting.md#issues-related-to-httpproxy) for information about the required Windows updates and related troubleshooting guidance.
