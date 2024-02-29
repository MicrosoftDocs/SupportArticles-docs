---
title: Troubleshooting Win32 app installations with Intune
description: Troubleshooting guidance for Win32 app installation issues and failures using Microsoft Intune.
ms.date: 12/05/2023
ms.reviewer: kaushika, mghadial
search.appverid: MET150
---
# Troubleshooting Win32 app installations with Intune

This article explains how to use diagnostic files to help troubleshoot installation failures for Microsoft Intune-managed Win 32 apps. If a Win32 app installation fails, you will have the option to **Collect diagnostics** to further diagnose the issue. The **Collect diagnostics** option will not be enabled when the Win32 app has been successfully installed on the device.  

Win32 app log collection is now contained in the Windows 10 device diagnostic platform, reducing time to collect logs from 1-2 hours to 15 minutes. The log size is 250 MB. The app logs are available under the **Device diagnostics monitor** action for each device, as well as the managed app monitor. For more information about how to collect diagnostics, see [Collect diagnostics from a Windows device](/mem/intune/remote-actions/collect-diagnostics).

## Win32 app diagnostic requirements

There are specific requirements that must be followed to collect diagnostic files:

- You're running Windows 11, or Windows 10 version 1909 or later.
- You must specify the complete diagnostic file path.
- You can specify environment variables for diagnostic collection, such as the following:
  *%PROGRAMFILES%, %PROGRAMDATA% %PUBLIC%, %WINDIR%, %TEMP%, %TMP%*
- Only exact file extensions are allowed, such as:
  *.log, .txt, .dmp, .cab, .zip, .xml*
- The maximum diagnostic file to upload is 250 MB or 25 files, whichever occurs first.
- Win32 app install diagnostic collection is enabled for apps that meet the required, available, and uninstall app assignment intent.
- Stored diagnostics are encrypted to protect any personal identifiable information contained in the diagnostics.

When opening support tickets for Win32 app failures, attach the related failure diagnostics using the steps in the following section.

## Collect diagnostic file

To collect Win32 app installation diagnostics, first complete the steps provided in the section [Get app troubleshooting details](troubleshoot-app-install.md#get-app-troubleshooting-details). 

Then, continue with the following steps.

1. Select the **Collect diagnostics** option on the **Installation details** pane.

1. To begin the diagnostic file collection process, provide file paths with log file names and select **OK**.

    > [!NOTE]
    > Diagnostic collection will take approximately 15 to 20 minutes. Supported file types: *.log, .txt, .dmp, .cab, .zip, .xml, .evtx, and .evtl*. A maximum of 25 file paths are allowed.

1. Once the diagnostic files are collected, you can select the **Download diagnostics** link to download the diagnostic files.

    > [!NOTE]
    > A notification will be displayed indicating the success of the app diagnostic collection.

## More information

See [Troubleshooting packaging, deployment, and query of Windows apps](/windows/win32/appxpkg/troubleshooting) for additional guidance on troubleshooting Windows app installations.
