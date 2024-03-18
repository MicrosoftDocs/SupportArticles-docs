---
title: Fix Windows Update issues on Teams Rooms Pro devices
description: Fix common Windows Update issues on a Microsoft Teams Rooms Pro device.
ms.reviewer: joolive
ms.topic: troubleshooting
ms.date: 10/30/2023
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - CI167275
---
# Resolve Windows Update issues on Teams Rooms Pro devices

You may experience one or more of the following Windows Update issues on Microsoft Teams Rooms Pro devices:

- Updates can't be installed successfully.
- The system isn't at the current update level, but Windows Update can't find available updates.
- If Microsoft Defender for Endpoint integration is enabled in the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **Security KBs** or **Vulnerabilities** signal of the device is shown as **Unhealthy**.

Windows Update issues can occur for different reasons. The following options can help you fix common issues that affect Windows Update.

## Free up drive space

There must be enough available space on your device to run updates. Devices that are enrolled in the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/) have an automatic remediation process to delete known cleanable files and optimize disk usage. If the remediation can't free up enough space to ease the problem, additional diagnostic insights are provided (as a list of the largest folders) to help you follow up.

You can also try the following options:

- Use the Disk Cleanup tool to delete unnecessary files.
- [Reduce the size of the WinSxS folder](/windows-hardware/manufacture/desktop/clean-up-the-winsxs-folder) by running the following command in an elevated Command Prompt window:

   ```console
   DISM /ONLINE /CLEANUP-IMAGE /STARTCOMPONENTCLEANUP /RESETBASE
   ```

## Verify date and time on the device

Make sure that the date and time settings are correct, and that the time offset is within two minutes. If you use an NTP server, select a reliable server.

## Check for policies that prevent update installations

Your organization might use Group Policy settings, mobile device management (MDM), or the registry to configure Windows client update experience.

For example, automatic restarts are prevented when a user is signed in if the `NoAutoRebootWithLoggedOnUsers` registry value under the `HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU` subkey is set to **1**. Because Teams Rooms Pro devices always have a *Skype* user signed in, such policies prevent the installation of updates that require an automatic restart, such as feature updates.

"Active hours" configuration might also affect update installation. It might take eight days or more to install the monthly cumulative updates, depending on active hours configuration and the level of activity on the device. If your device is two or more cumulative update levels behind, you might experience other issues that prevent updates from being installed.

In this situation, work with your organization administrator for appropriate solutions. For more information about these settings, see [Manage device restarts after updates](/windows/deployment/update/waas-restart).

## Check connection with Windows Update servers

Verify that your devices have access to Windows Update servers, and that multipart downloads are allowed and configured correctly through a proxy, firewall, web filters, and so on.

If Windows Update works correctly for smaller updates, but larger updates (such as cumulative updates and feature updates) fail frequently, verify that the following conditions are met:

- Your proxy supports the Content-Range header.
- Your antivirus software doesn't block HTTP-range requests.

If this function is blocked, the connection to the servers will time out. The Windows Update service uses the Background Intelligent Transfer Service (BITS) client. When the BITS client tries to reconnect for the next part of the download, the connection closes and the download starts over. Eventually, the BITS service might resume and piece together a large download. The result will be a complete installer that might not work.

For more information, see [Issues related to HTTP/Proxy](/windows/deployment/update/windows-update-troubleshooting#issues-related-to-httpproxy).

## Fix update error 0x800f0831 or 0x80073701

1. Open the *%Windir%\logs\CBS\CBS.log* file, look for entries that contain either of the error codes, 0x800f0831 and 0x80073701. Usually, the entry contains a missing package reference that's associated with orphaned language pack files.
2. You might see an entry that resembles one of the following entries:

   - Failed to pin deployment while resolving Update: Microsoft-Client-License-Platform-Upgrade-Subscription-Package~31bf3856ad364e35~amd64~ar-SA~10.0.19041.1.32a8fd17d1cd1fd6bf373b77ccc23825 from file: (null) [HRESULT = 0x80073701 - ERROR_SXS_ASSEMBLY_MISSING]
   - Failed to resolve package 'Microsoft-Windows-Printing-PrintToPDFServices-Package~31bf3856ad364e35~amd64~it-IT~10.0.18362.1' [HRESULT = 0x800f0831 - CBS_E_STORE_CORRUPTION]
3. In the log entry, if the referenced package version ends in "*.1*", such as *it-IT~10.0.18362.1*, you can restore the missing language files by using DISM and the language pack .cab file for the language that's referenced in the package.

   1. Download the [language pack ISO](/azure/virtual-desktop/language-packs#prerequisites) for your current Windows version.
   1. Go to the *x64\langpacks* folder within the downloaded ISO, copy the *.cab* file for the language that's referenced in the missing package to the local device. For example, copy *D:\x64\langpacks\Microsoft-Windows-Client-Language-Pack_x64_it-it.cab* to *C:\temp\\*.
   1. Run a command that resembles the following example in an elevated Command Prompt window to restore all files that are associated with the missing language:

      ```console
      DISM /ONLINE /ADD-PACKAGE /PACKAGEPATH:"C:\temp\Microsoft-Windows-Client-Language-Pack_x64_it-it.cab"
      ```

   1. Restart Windows, and then try again to run Windows Update.

4. If the referenced package version doesn't end in "*.1*", or the reference isn't associated with a language, use DISM to restore the files from a known good image that contains the missing packages. For more information, see [Repair a Windows Image](/windows-hardware/manufacture/desktop/repair-a-windows-image?view=windows-10&preserve-view=true).

## Fix other Windows Update error codes

If Windows Update fails and returns other error codes, follow the instructions in [Windows Update common errors and mitigation](/windows/deployment/update/windows-update-errors).

## Install the latest version of Teams Rooms app

Each Teams Rooms app version supports only a set of specific Windows feature updates. New Windows feature updates are prevented until there is no compatibility issue. This is usually when a new version of Teams Rooms app is available. For more information, see [Windows 10 release support](/microsoftteams/rooms/rooms-lifecycle-support#windows-10-release-support).

To check the Teams Rooms app version, run the following cmdlet in an elevated PowerShell prompt window:

```console
Get-AppxPackage -AllUsers Microsoft.SkypeRoomSystem
```

Compare the version with the latest version in [Microsoft Teams Rooms Release Notes](/microsoftteams/rooms/rooms-release-note). If an old version is installed, use the [Remove-AppxPackage](/powershell/module/appx/remove-appxpackage?view=windowsserver2019-ps&preserve-view=true) cmdlet to remove the old version. Then, install the latest version.

## References

- [Windows Update troubleshooting](/windows/deployment/update/windows-update-troubleshooting)
- [Resolve Windows 10 upgrade errors](/windows/deployment/upgrade/resolve-windows-10-upgrade-errors)
- [Windows 10 release information](/windows/release-health/release-information)
- [Manage connection endpoints for Windows 10 Enterprise](/windows/privacy/manage-windows-21h2-endpoints)
- [Windows Update error codes by component](/windows/deployment/update/windows-update-error-reference)
- [WUA Networking Error Codes](/previous-versions/windows/desktop/aa387293(v=vs.85))
