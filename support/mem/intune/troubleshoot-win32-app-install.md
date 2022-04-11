---
title: Troubleshooting Win32 app installations with Intune
description: Troubleshooting guidance for Win32 app installation issues and failures using Microsoft Intune.
ms.date: 10/21/2021
ms.reviewer: mghadial
---
# Troubleshooting Win32 app installations with Intune

This article explains how to use diagnostic files and the Intune Management extension to help troubleshoot installation failures for Microsoft Intune-managed Win 32 apps. If a Win32 app installation fails, you will have the option to **Collect diagnostics** to further diagnose the issue. The **Collect diagnostics** option will not be enabled when the Win32 app has been successfully installed on the device.  

> [!IMPORTANT]
> Before you can collect Win32 app diagnostic information, the Intune management extension must be installed on the Windows client. The Intune management extension is installed when a PowerShell script or a Win32 app is deployed to a user or device security group. For more information, see [Intune Management extension - Prerequisites](/mem/intune/apps/intune-management-extension#prerequisites).

## Win32 app diagnostic requirements

There are specific requirements that must be followed to collect log files:

- You must specify the complete log file path. ​
- You can specify environment variables for log collection, such as the following:<br>
  *%PROGRAMFILES%, %PROGRAMDATA% %PUBLIC%, %WINDIR%, %TEMP%, %TMP%*
- Only exact file extensions are allowed, such as:<br>
  *.log,.txt,.dmp,.cab,.zip,.xml*
- The maximum log file to upload is 250 MB or 25 files, whichever occurs first.
- Win32 app install diagnostic collection is enabled for apps that meet the required, available, and uninstall app assignment intent.
- Stored diagnostics are encrypted to protect any personal identifiable information contained in the diagnostics​.

When opening support tickets for Win32 app failures, attach the related failure diagnostics using the steps in the following section.

## Collect diagnostic file

To collect Win32 app installation diagnostics, first complete the steps provided in the section [Get app troubleshooting details](troubleshoot-app-install.md#get-app-troubleshooting-details). 

Then, continue with the following steps.

1. Select the **Collect diagnostics** option on the **Installation details** pane.

    :::image type="content" source="media/troubleshoot-app-install/collect-logs.png" alt-text="Screenshot of the Collect log option in the Win32 app installation details pane." border="false":::

1. To begin the log file collection process, provide file paths with log file names and select **OK**.

    > [!NOTE]
    > Diagnostic collection will take approximately 15-20 minutes. Supported file types: *.log,.txt,.dmp,.cab,.zip,.xml,.evtx, and.evtl*. A maximum of 25 file paths are allowed.

1. Once the diagnostic files are collected, you can select the **Download diagnostics** link to download the log files.

    :::image type="content" source="media/troubleshoot-app-install/download-app-logs.png" alt-text="Screenshot of the Download app logs option in the Win32 installation details pane." border="false":::

    > [!NOTE]
    > A notification will be displayed indicating the success of the app log collection.

## More information

See [Troubleshooting packaging, deployment, and query of Windows apps](/windows/win32/appxpkg/troubleshooting) for additional guidance on troubleshooting Windows app installations.
