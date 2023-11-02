---
title: Can't sign in to Microsoft 365 Windows desktop applications
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
ms.date: 11/02/2023
---

# Can't sign in to Microsoft 365 desktop applications

## Symptoms

On a device that has security software installed, users might experience any of the following issues when they try to sign in to Microsoft 365 desktop applications:

- The sign-in prompts are intermittent.
- The sign-in window shows a blank authentication screen.
  
   :::image type="content" source="./media/cannot-sign-in-microsoft-365-desktop-apps/blank-authentication-screen.png" alt-text="Screenshot of a blank authentication screen.":::

- The sign-in window is stuck on authentication.

   :::image type="content" source="./media/cannot-sign-in-microsoft-365-desktop-apps/sign-in-hangs-on-authentication.png" alt-text="Screenshot of a sign-in window that gets stuck on authentication.":::
- The Outlook desktop client displays "Trying to connect…".
- The Teams desktop client displays "We weren't able to connect. Sign in and we'll try again."
- Open Event Viewer, navigate to **Windows Logs** > **Application**. When you check the details displayed for the “AppModel-State” entries in the Source column of the table in the top part of the middle pane, you see one of the following event messages that end with the warning or error code "-2147xxxxxx":

    - Failure to load the application settings for package
    - Repair of state locations for operation SettingsInitialize against package Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy with error
    - Repair for operation LocalSettings against package Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy with error
    - Triggered repair because operation LocalSettings against package Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy hit error
    - Triggered repair of state locations because operation SettingsInitialize against package Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy hit error
       
       :::image type="content" source="./media/cannot-sign-in-microsoft-365-desktop-apps/event-viewer-warning.png" alt-text="Screenshot of the Event Viewer showing results filtered for the source entry appmodel-state, and an event message that has the error code which begins with 2147.":::

## Cause

The security software on the device is preventing network communication from being established or maintaining the previous communication state. This problem might occur because of existing or obsolete Windows Filtering Platform (WFP) drivers in the security software. Additionally, the security software might be preventing the Web Account Manager (WAM) plug-ins from running, or it might remove the plug-ins as a side effect of its activity on the device.<br/><br/>In the Event Viewer, if you see any of the event messages that are listed in the “Symptoms” section, they indicate that the WAM plug-ins are either broken or tampered with.  

> [!NOTE]
>
> - The WAM plug-ins are used by Microsoft 365 apps for establishing and renewing sign-in sessions. The plug-ins are installed within the context of the user profile. This means that although one user might experience problems, another user on the same device might not. Therefore, any mitigation and diagnosis should be done within the context of the affected user, not at the device level or administrator level.
> - If the plug-ins are corrupted, tampered with, or removed from the user profile because of security software scanning activity, repeatedly installing the plug-ins by using background PowerShell script or Group Policy logon script can temporarily mitigate the issue until the next antivirus scan.

## Resolution

> [!IMPORTANT]
>
> If the issue is caused by a broken WAM plug-in, skip to step 3 in the following procedure to re-install the WAM plug-ins. If the issue reoccurs, then work with your security software and WFP driver vendor to configure the appropriate exclusions that are listed in step 5.

To fix the other issues, follow these steps on the device:

1. Sign in by using an administrator account, and temporarily uninstall the security software and any standalone or obsolete WFP drivers from the device.
1. Sign in by using the affected user's credentials, and check whether the WAM plug-ins are installed and can run successfully in the user's profile.

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

       If either the **Work or school account** or **Microsoft account** window doesn't open, go to step 3. Otherwise, go to step 4.
1. Reinstall the WAM plug-ins if step 2 isn't successful. To do this, run the following PowerShell cmdlets:

   ```powershell
   Add-AppxPackage -Register "$env:windir\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -ForceApplicationShutdown
   Add-AppxPackage -Register "$env:windir\SystemApps\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -ForceApplicationShutdown
   ```

1. Monitor for 48 hours. If the issue doesn't reoccur, go to step 5. Otherwise, [contact Microsoft Support](https://support.microsoft.com/contactus).

   > [!NOTE]
   > For troubleshooting, we recommend that you collect the data from the [Process Monitor](/sysinternals/downloads/procmon) when you reproduce the issue. This can help determine whether:
   >
   > - Third-party modules are being loaded together with the WAM plug-ins.
   > - Third-party modules are holding the file or registry lock and preventing the sign-in process.
   > - Obsolete WFP or security software drivers are installed in the system.

1. Sign in by using an administrator account, and reinstall the security software and standalone WFP drivers that were uninstalled in step 1. Then, work with your security software and WFP driver vendor to configure the following package, folder, and process exclusions in the security software and WFP drivers.

   **Package family names to exclude**

   - `Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy`
   - `Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy`

   **Folder locations to exclude**

   - `%windir%\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy`
   - `%localappdata%\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy`
   - `%windir%\SystemApps\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy`
   - `%localappdata%\Packages\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy`
   - `%localappdata%\Microsoft\TokenBroker`
   - `%localappdata%\Microsoft\OneAuth`
   - `%localappdata%\Microsoft\IdentityCache`

   **Processes to exclude**
  
   - `%windir%\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\Microsoft.AAD.BrokerPlugin.exe`
   - `%windir%\System32\backgroundTaskHost.exe` for the following package names:
       - `Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy`
       - `Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy`
   - `%windir%\System32\svchost.exe` loading NT service `TokenBroker` as TokenBroker.dll
