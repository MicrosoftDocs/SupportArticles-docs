---
title: Resolve Installation Issues in the New Outlook for Windows
description: Provides instructions to resolve installation issues with the new Outlook for Windows.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.collection:
- administer-new-outlook
ms.custom: 
  - sap:Install, Update, Activate, and Deploy
  - intro-overview
  - CI 5977
  - CSSTroubleshoot
ms.reviewer: janellem
appliesto: 
  - Outlook for Windows
search.appverid: MET150
ms.date: 05/23/2025
---
# Resolve installation issues in the new Outlook for Windows

Admins whose users encountered difficulties in installing the new Outlook might have policies in place that prevent app download and installation.

Common scenarios include users attempting to switch from Desktop Outlook but finding the toggle reverts and the new Outlook doesn't launch.

## Policy restrictions

Registry keys set by Group Policy or non-Microsoft tools could block the MSIX package installation. For a complete list of registry keys: [How Group Policy works with packaged apps - MSIX](/windows/msix/group-policy-msix)

The notable registry keys impacting the installation of the new Outlook's MSIX package include:

- `BlockNonAdminUserInstall`
- `AllowAllTrustedApps`
- `AllowDevelopmentWithoutDevLicense`

> [!IMPORTANT]
> If `AllowAllTrustedApps` is disabled, the new Outlook app (MSIX) installation fails. This issue has been fixed in the Windows October cumulative update KB5031455 for [Windows 11](https://support.microsoft.com/topic/6513c5ec-c5a2-4aaf-97f5-44c13d29e0d4) and [Windows 10](https://support.microsoft.com/topic/03f350cb-57f9-45e6-bfd7-438895d3c7fa). If this optional October update isn't available for your OS build, the November security update will include the fix.

The registry keys can be found at one of these locations:

- `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock`
- `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Appx`

There are a few policies that could alter these registry keys and block app installation in your organization due to restricted policy set by the admins. Some of the known group policies that could prevent installation include:

- Prevent non-admin users from installing packaged Windows apps
- Allow all trusted apps to install (disabled)

To check this setting for your computer:

1. In Windows, search for **Edit Group Policy** or right-click the Windows Key and select **Run** > **gpedit.msc**.
1. This command opens the **Local Group Policy Editor** screen.
1. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **App package Deployment** to check settings for these policies:

    - Prevent non-admin users from installing packaged Windows apps
    - Allow all trusted apps to install

1. Make sure that value for these settings is set as follows:

    |Setting  |Value  |
    |---------|---------|
    |Prevent non-admin users from installing packaged Windows apps|Not configured|
    |Allow all trusted apps to install|Not configured|

## Check firewalls

To download, install and get continuous updates for the new Outlook, make sure proxy and firewall isn't blocking access to the Microsoft Store

- `https://res.cdn.office.net`
- `https://res.cdn.office.net/nativehost/5mttl/installer/`

## Check executables

Ensure there are no security policies or software blocking executables from running in the user's temp directory.

- Examples of security programs include: AppLocker, Anti-Virus, Group Policy, non-Microsoft security software.
- Classic Outlook downloads the installer to %TEMP%, which is almost always inside of the C:\Users\ directory unless explicitly configured otherwise. If they're blocking exes in that directory, Desktop Outlook fails to start the installer.
- **NewOutlookInstaller.exe** is the filename that needs to execute.

## Check Download mode

Download mode dictates which download sources clients are allowed to use when downloading Windows updates in addition to Windows Update servers. [Reset delivery optimization key](/windows/deployment/do/waas-delivery-optimization-reference#download-mode):

# [Windows 11](#tab/windows11)
- `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization`
- Setting the value for `DODownloadMode` to **100** (bypass) may cause installation to fail, as the bypass (**100**) setting is deprecated. Set this value to **0** instead.

# [Windows 10](#tab/windows10)
- `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization`
- Modify the value: `DODownloadMode` to **0**
---

## Other deployment options

### Microsoft store is blocked

For organizations that disable access to the Windows Store, the installer can be directly accessed from the Office CDN. To install the new Outlook on a single computer with many users, follow these steps:

1. Download the [.exe installer](https://go.microsoft.com/fwlink/?linkid=2207851).
1. Launch PowerShell 7 as an administrator: Right-click the PowerShell icon and choose Run as Administrator.
1. Navigate to where the Setup.exe file is located.
1. Run the following command:

    ```powershell
    .\Setup.exe --provision true --quiet --start-*
    ```

### Microsoft Store isn't blocked

Install the new Outlook via Windows Package Manager (winget), when Microsoft Store isn't blocked:

1. Open PowerShell by pressing Windows + X and select Terminal (Windows 10 users select PowerShell).
1. Enter the following command to install the Microsoft Store version of the new Outlook:

    ```powershell
    winget install -i -e --id=9NRX63209R7B --source=msstore --accept-package-agreements
    ```
