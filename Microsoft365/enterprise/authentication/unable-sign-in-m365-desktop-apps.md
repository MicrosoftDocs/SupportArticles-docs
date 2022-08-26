---
title: Unable to sign in to Microsoft 365 desktop applications
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
localization_priority: Normal
ms.custom: CI166563, CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
description: Describes an issue when you can't sign in to Microsoft 365 desktop applications and provides options to resolve it.
appliesto: 
  - Microsoft 365
ms.date: 8/25/2022
---

# Unable to sign in to Microsoft 365 desktop applications

## Symptoms

You might experience any of the following behaviors with Microsoft 365 desktop applications on your device:

- An open application’s window closes abruptly.
- An application doesn’t open when you launch it. No error message is displayed but entries are logged in the event log.
- Unable to sign in to a desktop application. You see either the **Need Password** prompt or the **There is a problem with your account** message when you try to sign in.
- Unable to connect to the desktop application even after you log in by using a credential prompt, exit and launch the application again, or restart the device.

This issue also affects other Azure AD-integrated applications that get their tokens from WAM.

However, Microsoft 365 applications on the web and their mobile versions aren't affected by this issue.

## Cause

The Microsoft Azure AD WAM plugin is removed as a side effect of a remote scan performed by a vulnerability assessment software provided by Tenable, a third party provider. The plugin facilitates the authentication of desktop applications. For more information, see [this post](https://community.tenable.com/s/article/Plugin-Updates-to-Address-Windows-Scan-Targets-being-left-unable-to-connect-to-Azure-Active-Directory-AAD).

## Resolution

To resolve the issue, use one of the following options.

### Option 1: Fix a single affected device

To fix the issue on a single device, run the following [Add-AppxPackage](/powershell/module/appx/add-appxpackage?view=windowsserver2022-ps&preserve-view=true) cmdlet:

```powershell
Add-AppxPackage -Register "$env:windir\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -ForceApplicationShutdown
```

### Option 2: Fix multiple devices simultaneously by using Microsoft Endpoint Manager

You can use either the Configuration Manager or Intune component in Microsoft Endpoint Manager to automate a fix for multiple devices. Use the component that works best for you.

#### Use Configuration Manager

1. In the Configuration Manager console, navigate to the **Assets and Compliance** workspace, expand **Compliance Settings**, and then select **Configuration Items**.
1. On the **Home** tab of the ribbon, in the **Create** group, select **Create Configuration Item**.
1. On the **General** page of the **Create Configuration Item Wizard**, enter a name for the new configuration item.
1. Under **Specify the type of configuration item that you want to create**, select **Windows Desktops and Servers (custom)**, and then select **Next**.
1. On the **Settings** page of the **Create Configuration Item Wizard**, select **New**.
1. On the **General** tab of the **Create Setting** dialog box, select **Script** as the **Setting type** and **String** as the **Data type**.
1. In the **Discovery script** section, select **Add Script**.
1. Copy and paste the following script in the **Edit Discovery Script** dialog box and select **OK**:

   ```powershell
   $broker = Get-AppxPackage -Name "Microsoft.AAD.BrokerPlugin"
     if ($broker -match "Microsoft.AAD.BrokerPlugin") {
       "Compliant"
     } else {
       "Non-Compliant"
     }
   ```

1. In the **Remediation script (optional)**, select **Add Script**.
1. Copy and paste the following script in the **Create Remediation Script** dialog box and select **OK**:

   ```powershell
   Add-AppxPackage -Register "$env:windir\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -ForceApplicationShutdown
   ```

1. Select the **Run scripts by using the logged on user credentials** option.
1. On the **Compliance Rules** page of the **Create Configuration Item Wizard**, select **New**.
1. In the **Create Rule** dialog box, enter a name for the compliance rule.
1. In the **For the following values** field, enter _**Compliant**_.
1. Select the **Remediate noncompliant rules when supported** option, and then select **OK**.
1. Select **Next** in each subsequent page of the **Create Configuration Item Wizard** until the configuration item is created, and then select **Close** to exit the wizard.
1. In the Configuration Manager console, select **Compliance Settings** > **Configuration Baselines**.
1. On the **Home** tab, in the **Create** group, select **Create Configuration Baseline**.
1. In the **Create Configuration Baseline** dialog box, select **Add** > **Configuration Item**.
1. In the **Add Configuration Items** dialog box, select the configuration item you created in step 3 and select **Add**, and then select **OK**.
1. In the **Create Configuration Baseline** dialog box, select **Always apply this baseline even for co-managed clients** if your organization uses Intune, and then select **OK**.
1. In the **Configuration Baselines** list, select the configuration baseline you created in step 17, and then in the **Home** tab, in the **Deployment** group, select **Deploy**.
1. In the **Deploy Configuration Baselines** dialog box, select **Remediate noncompliant rules when supported** and **Allow remediation outside the maintenance window**.
1. Select **Browse**, select the affected device collection where you want to deploy the configuration baseline, and then select **OK**.

**Note** Make sure that in the **Administration** workspace, under **Client Settings** > **Default Client Settings** > **Computer Agent**, the value of **PowerShell execution policy** is set to **Bypass**.

#### Use Intune

To use this method, Endpoint analytics and Proactive remediations must be enabled in Microsoft Endpoint Manager.

1. Open the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
1. Select **Reports** > **Endpoint analytics** > **Proactive remediations**, and then select the **Create script package** button.
1. In the **Basics** step, enter a name for the script package.
1. Save the following detection script as a .ps1 UTF-8 file:

   ```powershell
   $broker = Get-AppxPackage -Name "Microsoft.AAD.Broker Plugin"
   if ($broker -match "Microsoft.AAD.BrokerPlugin") { exit 0 } else { exit 1 }
   ```

1. Save the following remediation script as a .ps1 UTF-8 file:

   ```powershell
    Add-AppxPackage -Register "$env:windir\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -ForceApplicationShutdown
   ```

1. In the **Settings** step, select the folder icon next to the **Detection script file** field. Browse to the location of the detection script file saved in step 4, select it, and then select **Open** to upload it.
1. Select the folder icon next to the **Remediation script file** field. Browse to the location of the remediation script file saved in step 5, select it, and then select **Open** to upload it.
1. Set the **Run this script using the logged-on credentials** option to **Yes** and the **Enforce script signature check** option to **No**.
1. In the **Assignments** step, select the device groups to which you want to deploy the script package.
1. In the **Review + Create** step, review the information to deploy the scripts and then select **Create** to proceed.
