---
title: Unable to sign in to Microsoft 365 desktop applications
description: Describes issues that occur when users try to sign in to Microsoft 365 desktop applications on devices that have security software installed.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CI 176805
  - CSSTroubleshoot
ms.reviewer: alextok,balram,naveerap
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.date: 7/5/2023
---

# Unable to sign in to Microsoft 365 desktop applications

## Symptoms

On a device that has security software installed, users might experience any of the following issues when they try to sign into Microsoft 365 desktop applications:

- The sign-in prompts are intermittent.
- The sign-in window shows a blank authentication screen.
  
   :::image type="content" source="./media/cannot-sign-in-microsoft-365-desktop-apps/blank-authentication-screen.png" alt-text="Screenshot of a blank authentication screen.":::

- The sign-in window is stuck on authentication.

   :::image type="content" source="./media/cannot-sign-in-microsoft-365-desktop-apps/sign-in-hangs-on-authentication.png" alt-text="Screenshot of a sign-in window that gets stuck on authentication.":::
- The Outlook desktop client displays "Trying to connect…".
- The Teams desktop client displays "We weren't able to connect. Sign in and we'll try again".

## Cause

The security software on the device is preventing network communication from being established or maintaining the previous communication state. This problem may be due to existing or obsolete Windows Filtering Platform (WFP) drivers in the security software. In addition, the security software may be blocking the Web Account Manager (WAM) plug-ins from running or may remove the plug-ins as a side effect of its activity on the device.

> [!NOTE]
>
> - The WAM plug-ins are used by Microsoft 365 apps for establishing and renewing sign-in sessions. The plug-ins are installed within the context of the user profile. This means that while one user may experience problems, another user on the same device may not. Therefore, any mitigation and diagnosis should be done within the context of the affected user, not at the machine level or administrator level.
> - If the plug-ins are corrupted, tampered with, or removed from the user profile due to security software scanning activity, repeatedly installing the plug-ins by using background PowerShell script or Group Policy logon script can temporarily mitigate the issue until the next antivirus scan.

## Resolution

To fix the issues, follow these steps on the device:

1. Sign in by using an administrator account, and uninstall the security software and any standalone or obsolete WFP drivers from the device **temporarily**.
1. Sign in by using the affected user's credentials, check if the WAM plug-ins are installed and can run successfully in the user's profile.

   1. Run the following PowerShell cmdlets:

       ```powershell
       Get-AppxPackage Microsoft.AAD.BrokerPlugin
       Get-AppxPackage Microsoft.Windows.CloudExperienceHost 
       ```

   1. If either cmdlet doesn't return anything, go to step 3. Otherwise, run the following commands at a command prompt:

       ```console
       explorer.exe shell:appsFolder\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy!App
       explorer.exe shell:appsFolder\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy!App
       ```

       If either the **Work or school account** or **Microsoft account** window doesn't pop up, go to step 3. Otherwise, go to step 4.
1. Reinstall the WAM plug-ins if step 2 isn't successful. To do so, run the following PowerShell cmdlets:

   ```powershell
   Add-AppxPackage -Register "$env:windir\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -ForceApplicationShutdown
   Add-AppxPackage -Register "$env:windir\SystemApps\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -ForceApplicationShutdown
   ```

1. Monitor for 48 hours. If the issue doesn't recur, go to step 5. Otherwise, [contact Microsoft Support](https://support.microsoft.com/contactus).

   > [!NOTE]
   > For troubleshooting purposes, we recommend that you collect the data from the [Process Monitor](/sysinternals/downloads/procmon) when you reproduce the issue. This can help determine whether:
   >
   > - Third-party modules are being loaded along with the WAM plug-ins.
   > - Third-party modules are holding the file or registry lock and preventing the sign-in process.
   > - Obsolete WFP or security software drivers are installed in the system.

1. Sign in by using an administrator account, reinstall the security software and standalone WFP drivers that were uninstalled in step 1. Then, work with your security software and WFP driver vendor to configure the following package, folder, and process exclusions in the security software and WFP drivers.

   **Package family names to exclude**

   - `Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy`
   - `Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy`

   **Folder locations to exclude**

   - `%windir%\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy`
   - `%localappdata%\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy`
   - `%windir%\SystemApps\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy`
   - `%localappdata%\Packages\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy`

   **Processes to exclude**
  
   - `%windir%\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\Microsoft.AAD.BrokerPlugin.exe`
   - `%windir%\System32\backgroundTaskHost.exe` for the following package names:
       - `Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy`
       - `Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy`
