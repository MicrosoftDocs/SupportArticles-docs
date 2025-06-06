---
title: Can't Sign In to Microsoft 365 Desktop Applications
description: Resolves issues that occur when you try to sign in to Microsoft 365 desktop applications on devices that have security software installed.
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - CI 176805
  - CSSTroubleshoot
ms.reviewer: alextok,balram,naveerap
appliesto: 
  - Microsoft 365 Apps for Enterprise
ms.date: 06/06/2025
---

# Can't sign in to Microsoft 365 desktop applications

## Symptoms

On a Windows device that has security software installed, you might experience any of the following issues when you try to sign in to Microsoft 365 desktop applications:

- The sign-in prompts are intermittent.
- The sign-in window shows a blank authentication screen.
  
   :::image type="content" source="./media/cannot-sign-in-microsoft-365-desktop-apps/blank-authentication-screen.png" alt-text="Screenshot of a blank authentication screen.":::

- The sign-in window is stuck on authentication.

   :::image type="content" source="./media/cannot-sign-in-microsoft-365-desktop-apps/sign-in-hangs-on-authentication.png" alt-text="Screenshot of a sign-in window that gets stuck on authentication.":::
- The Outlook desktop client displays the message "Trying to connect…".
- The Teams desktop client displays the message "We weren't able to connect. Sign in and we'll try again."
- You open Event Viewer and select **Windows Logs** > **Application**. When you examine the details of the **AppModel-State** entries in the **Source** column of the table, you see one of the following event messages that end with a warning or error code `-2147xxxxxx`:

  - > Failure to load the application settings for package
  - > Repair of state locations for operation SettingsInitialize against package Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy with error
  - > Repair for operation LocalSettings against package Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy with error
  - > Triggered repair because operation LocalSettings against package Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy hit error
  - > Triggered repair of state locations because operation SettingsInitialize against package Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy hit error

    :::image type="content" source="./media/cannot-sign-in-microsoft-365-desktop-apps/event-viewer-warning.png" alt-text="Screenshot of the Event Viewer showing results filtered for the source entry appmodel-state, and an event message that has the error code which begins with 2147.":::

## Cause

The issue may be caused by existing or obsolete Windows Filtering Platform (WFP) drivers in the security software. In this situation, the security software prevents network communication from being established or maintaining the previous communication state. Additionally, the security software might block Web Account Manager (WAM) plug-ins, or remove the plug-ins as a side effect of its activity on the device.

If Event Viewer displays any of the event messages that are listed in the [Symptoms](#symptoms) section, the messages indicate that the WAM plug-ins are either broken or tampered with.

> [!NOTE]
>
> - The WAM plug-ins are used by Microsoft 365 apps for establishing and renewing sign-in sessions. The plug-ins are installed within the context of the user profile. This means that although one user might experience problems, another user on the same device might not. Therefore, any mitigation and diagnosis should be done within the context of the affected user, not at the device level or administrator level.
> - If the plug-ins are corrupted, tampered with, or removed from the user profile because of security software scanning activity, try to repeatedly install the plug-ins by using a background PowerShell script or Group Policy logon script. This action might temporarily mitigate the issue until the next antivirus scan.

## Resolution

> [!IMPORTANT]
> If the issue is caused by a broken or tampered WAM plug-in, skip to step 3 in the following procedure to reinstall the WAM plug-ins. If the issue reoccurs, work with your security software and WFP driver vendor to configure the appropriate exclusions that are listed in step 5.

To fix the issues, follow these steps on the device:

1. Sign in by using an administrator account, and then temporarily uninstall the security software and any standalone or obsolete WFP drivers from the device.
1. Sign in by using the affected user's credentials, and then check whether the WAM plug-ins are installed and can run successfully in the user's profile.

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
1. If step 2 isn't successful, reinstall the WAM plug-ins by using the following PowerShell cmdlets:

   ```powershell
   Add-AppxPackage -Register "$env:windir\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -ForceApplicationShutdown
   Add-AppxPackage -Register "$env:windir\SystemApps\Microsoft.Windows.CloudExperienceHost_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -ForceApplicationShutdown
   ```

1. Monitor for 48 hours. If the issue reoccurs, contact [Microsoft Support](https://support.microsoft.com/contactus). Otherwise, go to step 5.

   > [!NOTE]
   > For troubleshooting, we recommend that you collect the data from the [Process Monitor](/sysinternals/downloads/procmon) when you reproduce the issue. This information can help determine whether:
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
