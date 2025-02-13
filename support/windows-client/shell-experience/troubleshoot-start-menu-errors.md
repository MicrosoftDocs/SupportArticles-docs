---
title: Troubleshoot Start menu errors
description: Learn how to troubleshoot common Start menu errors in Windows 10. For example, learn to troubleshoot errors related to deployment, crashes, and performance.
ms.date: 01/15/2025
manager: dcscontentpm
ms.topic: troubleshooting
ms.collection: highpri
ms.custom: sap:Windows Desktop and Shell Experience\Start Menu and Task Bar, csstroubleshoot
ms.reviewer: kaushika,lizlong
audience: itpro
---
# Start menu troubleshooting guidance

_Applies to:_ &nbsp; Windows 10

Categories of Issues with Start Menu:

- Issues related to Deployment or Installation.  
- Application getting Terminated or Crashed.  
- Issues related to Start Menu customization or other Policy/CSP.  
- Other issues

## Basic troubleshooting

When troubleshooting Start issues (and for the most part, all other Windows apps), there are a few things to check if they aren't working as expected. For issues where the Start menu or subcomponent isn't working, the following points can help you to narrow down where the issue may reside.

- Is the system running the latest Feature and Cumulative Monthly update?
- Did the issue start immediately after an update? Ways to check:
  - PowerShell: [System.Environment]::OSVersion.Version
  - CMD: winver
- Were there any recent changes to registry Keys or folders? 
- Where there any recent changes related to GPO /MDM Policies? 
  - Group policy settings that restrict access or permissions to folders or registry keys can impact Start menu performance.
  - Some Group Policies intended for older Operating System can cause issues with the Start menu.
  - Untested Start Menu customizations can lead to unexpected behaviour, though typically not complete Start failures.

## Issues related to Deployment or Installation

When troubleshooting basic Start issues (and for the most part, all other Windows apps), there are a few things to check if they aren't working as expected. For issues where the Start menu or subcomponent isn't working, you can do some quick tests to narrow down where the issue may reside. 
  
Check if Start Menu is installed:  

To see if an individual user has the Start Menu package installed, use the following cmdlet in a non-elevated Windows PowerShell prompt:

```powershell
Get-AppxPackage -Name Microsoft.Windows.StartMenuExperienceHost
```

If it's registered, the output looks like the following:

If you receive no response to the Get-AppxPackage cmdlet, you can still use the Add-AppxPackage cmdlet by using the family name or the path to the AppxManifest.xml file.
This is possible because although this user doesn't have the package registered, other users might. This means that the package will still exist on the machine.
To check this, add -AllUsers to the same Get-AppxPackage cmdlet we used earlier in an elevated PowerShell prompt:

```powershell
Get-AppxPackage *StartMenu* -AllUsers 
```

If there's a successful return of the app details, it means that the package exists.
The following cmdlet can be used to register the start menu if the package exists on the machine.  
Be sure not to use the elevated PowerShell prompt unless you wish to register the app to the administrator instead of the user.

```powershell
Add-AppxPackage -Path "C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\AppxManifest.xml" -Register –DisableDevelopmentMode
```

Note: Be sure to use the Add-AppxPackage cmdlet from a non-elevated prompt, or the package will be registered to the admin instead of the user.
Note: On older SKUs (version 1809 and prior) Appx package for Start Menu is different, check if Microsoft.Windows.ShellExperienceHost is registered for those SKUs.  
  
Warning: If StartMenuExperienceHost isn't installed for any user, then the fastest resolution is to revert to a known good configuration. This can be rolling back the update, resetting the PC to defaults or restoring from backup. No method is supported to install Start Appx files. The results are often problematic and unreliable.
  
The following Event Logs can be used to troubleshoot issues related to this.  

For deployment related issues: Microsoft-Windows-AppXDeployment*  
For Appx Activation related issues: Microsoft-Windows-TWinUI/Operational

For issues related to activation search for the following keywords in Microsoft-Windows-TWinUI/Operational for Microsoft.Windows.StartMenuExperienceHost or Microsoft.Windows.ShellExperienceHost depending on the OS version you are troubleshooting.

- "Package was not found"
- "Invalid value for registry"
- "Element not found"
- "Package could not be registered"

If these events are found, Start isn't activated correctly. Each event will have more detail in the description and should be investigated further. Event messages can vary.

## Application getting Crashed
  
If the application is installed for the user but does not work, please check if the process responsible for displaying the start menu is running for the user.  

From Powershell  

get-Process StartMenuExperienceHost -IncludeUserName 

Note: If there are multiple users logged into the machine, each user should have a StartMenuExperienceHost process in their session.  
Note: On older SKUs (version 1809 and prior) Appx package for Start Menu is different, check if ShellExperienceHost.exe is running.

If it's installed but not running for the user, test booting into safe mode or use MSCONFIG to eliminate third-party or additional drivers and applications.

To check if the application is getting crashed, please refer to Application Event Log, and look for Event ID 1000, 1001 for StartMenuExperienceHost.exe

The following tools can be used to troubleshoot these behaviours:

1. Windows Error Reporting to Generate Crash Dump.  
2. Procdump to generate Crash Dump.  
3. Procmon to investigate if the failures are related to permission or similar problems.  

Note: Refer this article to learn more about Application Crash Events: The application or service crashing behavior troubleshooting guidance - Windows Server | Microsoft Learn
and this article to learn about a using Procmon to troubleshoot failure at application start up: Troubleshoot Apps failing to start using Process Monitor - Windows Client | Microsoft Learn

Tip: Check for crashes that may be related to Start (explorer.exe, Search, ShellExperiencehost etc.)

The following Event Logs can be used to troubleshoot issues related to this.  
For deployment related issues: Application
For Appx Activation related issues: Microsoft-Windows-TWinUI/Operational
  
Issues related to Start Menu customization or other Policy / CSP  
  
These issues are generally related to configuration and customization to Start Menu and related components. For example, issues related to Start Layout, Start Menu Lockdown etc.  
Please refer these articles to get configuration and available Policies and CSPs related to Start Menu:  

- Start policy settings | Microsoft Learn
- Customize The Start Layout For Managed Windows Devices | Microsoft Learn
  
The following Logs can be used to troubleshoot issues related to this.

- For issues related to start layout: Microsoft-Windows-ShellCommon-StartLayoutPopulation*  
- gpresult
- MDM Report

## Other things to consider

### Check whether the system a clean install or upgrade

- Is this system an upgrade or clean install?
  - Run `test-path "$env:windir\panther\miglog.xml"`
  - If that file doesn't exist, the system is a clean install.
- Upgrade issues can be found by running `test-path "$env:windir\panther\miglog.xml"`

Resources for troubleshooting further

The following tools and logs can be useful when troubleshooting issues related to Start Menu.

Event Logs

- System Event log
- Application Event log
- Microsoft/Windows/Shell-Core*
- Microsoft-Windows-TWinUI*
- Microsoft/Windows/AppReadiness*
- Microsoft/Windows/AppXDeployment*
- Microsoft-Windows-PushNotification-Platform/Operational
- Microsoft-Windows-ShellCommon-StartLayoutPopulation*
- Microsoft-Windows-CloudStore*

The following logs when application is crashing

- Check for crashes that may be related to Start (explorer.exe, taskbar, and so on) Application log event 1000, 1001.
- Check WER reports
- C:\ProgramData\Microsoft\Windows\WER\ReportArchive\
- C:\ProgramData\Microsoft\Windows\WER\ReportQueue\

- If there is a component of Start that is consistently crashing, capture a dump that can be reviewed by Microsoft Support.
- Procdump to generate Crash Dump.  

Other useful tools to troubleshoot Start Menu issues

Procmon to investigate if the failures are related to permission or similar problems.  

## Common errors and mitigation

The following list provides information about common errors you might run into with Start Menu, as well as steps to help you mitigate them.

### Symptom: Apps using Office APIs with Office Click-to-Run installed may cause the Start Menu and other shell components to fail

You may experience various issues related to the Windows Shell on devices that are running Office Click-to-Run, along with some third party applications that use Office APIs:

- Event 1000 is logged in the Application event log. The event log reports that an application crashes for StartMenuExperienceHost.exe, ShellExperienceHost.exe, SearchUI.exe, with an error code 0xc000027b / -1073741189.
- Errors in the Microsoft-Windows-AppModel-State event log mentioning the following error with various package names:
  
  > Triggered repair of state locations because operation SettingsInitialize against package Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy hit error -2147024891.

- The Windows Start Menu does not respond to mouse clicks or the Windows key.
- Windows Search does not respond to mouse clicks on pressing the Search button or Windows+S key.

#### Cause

Affected devices may have damaged registry keys or data which might affect apps using Microsoft Office APIs to integrate with Windows, Microsoft Office, Microsoft Outlook, or Outlook Calendar. This may occur if application packages permissions are being removed from the following registry path:

`HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`

#### Workaround

> [!NOTE]
> Barco has reported to have fixed this issue starting their App version 4.27.2. However, the affected devices may need to follow the steps mentioned in the workaround section.
>
> For more information, see [Unresponsive Windows taskbar or user shell folder permissions issues with ClickShare App Calendar integration](https://www.barco.com/en/support/knowledge-base/6077-unresponsive-windows-taskbar-with-clickshare-app).

To workaround the issue, follow these steps:

1. Download the [scripts](https://cesdiagtools.blob.core.windows.net/windows/FixUserShellFolderPermissions.zip) to fix the issue when it happens, though the scripts cannot 
prevent the issue from re-occurring.

2. Open a Powershell prompt under the affected user identity, and run

```PowerShell
.\FixUserShellFolderPermissions.ps1
```

- If the script can't access the registry key because the registry permissions are wiped out, then open an elevated Powershell prompt and run the following command:

  - ```powershell
    FixUserShellFolderPermissions.ps1 -allprofiles
    ```
- If an application doesn't work, you may need to register the shell packages by running from the affected user the command 

  - ```powershell
    FixUserShellFolderPermissions.ps1 -register
    ```

#### Prevent the issue from reoccurring

- Ensure the ClickShare App is updated to version 4.27.2 or higher. 
- Ensure the Calendar integration is disabled (default disabled as of version 4.27.2).
- Prevent the applications from running at startup or configure the applications to Start on-demand.

#### Status

Microsoft is aware of this issue and is working to resolve it in an upcoming Office update. We will post more information in this article when it becomes available.

### Symptom: Start Menu doesn't respond on Windows 2012 R2, Windows 10, or Windows 2016

#### Cause

Background Tasks Infrastructure Service (BrokerInfrastructure) service isn't started.

#### Resolution

Ensure that Background Tasks Infrastructure Service is set to automatic startup in Services MMC.

If Background Tasks Infrastructure Service fails to start, verify that the Power Dependency Coordinator Driver (PDC) driver and registry key aren't disabled or deleted. If either are missing, restore from backup or the installation media.

To verify the PDC Service, run `C:\>sc query pdc` in a command prompt. The results will be similar to the following:

```output
SERVICE_NAME: pdc
TYPE          : 1 KERNEL_DRIVER
STATE          : 4 RUNNING
  (STOPPABLE, NOT_PAUSABLE, IGNORES_SHUTDOWN)
WIN32_EXIT_CODE     : 0 (0x0)
SERVICE_EXIT_CODE    : 0 (0x0)
CHECKPOINT       : 0x0
WAIT_HINT        : 0x0
```

The PDC service uses pdc.sys located in the *%WinDir%\\system32\\drivers*.

The PDC registry key is:
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\pdc`
Description="@%SystemRoot%\\system32\\drivers\\pdc.sys,-101"
DisplayName="@%SystemRoot%\\system32\\drivers\\pdc.sys,-100"
ErrorControl=dword:00000003
Group="Boot Bus Extender"
ImagePath=hex(2):73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,64,00,\
 72,00,69,00,76,00,65,00,72,00,73,00,5c,00,70,00,64,00,63,00,2e,00,73,00,79,\
 00,73,00,00,00  
Start=dword:00000000  
Type=dword:00000001

In addition to the listed dependencies for the service, Background Tasks Infrastructure Service requires the Power Dependency Coordinator Driver to be loaded. If the PDC doesn't load at boot, Background Tasks Infrastructure Service will fail and affect Start Menu.

Events for both PDC and Background Tasks Infrastructure Service will be recorded in the event logs. PDC shouldn't be disabled or deleted. BrokerInfrastructure is an automatic service. This Service is required for all these operating Systems as running to have a stable Start Menu.

> [!NOTE]
> You cannot stop this automatic service when machine is running (*C:\\windows\\system32\\svchost.exe -k DcomLaunch -p*).

### Symptom: After upgrading from 1511 to 1607 versions of Windows, the Group Policy "Remove All Programs list from the Start Menu" may not work

#### Cause

There was a change in the All Apps list between Windows 10, versions 1511 and 1607. These changes mean the original Group Policy and corresponding registry key no longer apply.

#### Resolution

This issue was resolved in the June 2017 updates. Update Windows 10, version 1607, to the latest cumulative or feature updates.

> [!NOTE]
> When the Group Policy is enabled, the desired behavior also needs to be selected. By default, it is set to **None**.

### Symptom: Application tiles like Alarm, Calculator, and Edge are missing from Start menu and the Settings app fails to open on Windows 10, version 1709 when a local user profile is deleted

:::image type="content" source="media/troubleshoot-start-menu-errors/application-tiles-missing.png" alt-text="Screenshots that show download icons on app tiles and missing app tiles." border="false":::

#### Cause

This issue is known. The first-time sign-in experience isn't detected and does not trigger the install of some apps.

#### Resolution

This issue has been fixed for Windows 10, version 1709 in [KB 4089848](https://support.microsoft.com/help/4089848) March 22, 2018—KB4089848 (OS Build 16299.334)

### Symptom: When attempting to customize Start Menu layout, the customizations do not apply or results are not expected

#### Cause

There are two main reasons for this issue:

- Incorrect format: Editing the xml file incorrectly by adding an extra space or spaces, entering a bad character, or saving in the wrong format.
  - To tell if the format is incorrect, check for "Event ID: 22" in the "*Applications and Services\\Microsoft\\Windows\\ShellCommon-StartLayoutPopulation\\Operational*" log.
  - Event ID 22 is logged when the xml is malformed, meaning the specified file simply isn't valid xml.
  - When editing the xml file, it should be saved in UTF-8 format.

- Unexpected information: This occurs when possibly trying to add a tile via an unexpected or undocumented method.
  - "Event ID: 64" is logged when the xml is valid but has unexpected values.
  - For example: The following error occurred while parsing a layout xml file:
    > The attribute 'LayoutCustomizationRestrictiontype' on the element '{http://schemas.microsoft.com/Start/2014/LayoutModification}DefaultLayoutOverride' is not defined in the DTD/Schema.

XML files can and should be tested locally on a Hyper-V or other virtual machine before deployment or application by Group Policy

### Symptom: Start menu no longer works after a PC is refreshed using F12 during startup

#### Description

If a user is having problems with a PC, it can be refreshed, reset, or restored. Refreshing the PC is a beneficial option because it maintains personal files and settings. When users have trouble starting the PC, "Change PC settings" in Settings isn't accessible. So, to access the System Refresh, users may use the F12 key at startup. Refreshing the PC finishes, but Start Menu is not accessible.

#### Cause

This issue is known and was resolved in a cumulative update released August 30, 2018.

#### Resolution

Install corrective updates; a fix is included in the [September 11, 2018-KB4457142 release](https://support.microsoft.com/help/4457142).

### Symptom: The All Apps list is missing from Start menu

#### Cause

"Remove All Programs list from the Start menu" Group Policy is enabled.

#### Resolution

Disable the "Remove All Programs list from the Start menu" Group Policy.

### Symptom: Tiles are missing from the Start Menu when using Windows 10, version 1703 or older, Windows Server 2016, and Roaming User Profiles with a Start layout

#### Description

There are two different Start Menu issues in Windows 10:

- Administrator configured tiles in the start layout fail to roam.
- User-initiated changes to the start layout are not roamed.

Specifically, behaviors include

- Applications (apps or icons) pinned to the start menu are missing.
- Entire tile window disappears.
- The start button fails to respond.
- If a new roaming user is created, the first sign-in appears normal, but on subsequent sign-ins, tiles are missing.

:::image type="content" source="media/troubleshoot-start-menu-errors/working-layout-first-sign-in.png" alt-text="Screenshot of an example of a working layout." border="false":::

Working layout on first sign-in of a new roaming user profile

:::image type="content" source="media/troubleshoot-start-menu-errors/failing-layout-subsequent-sign-in.png" alt-text="Screenshot of an example of a failing layout." border="false":::

Failing layout on subsequent sign-ins

#### Cause

A timing issue exists where the Start Menu is ready before the data is pulled locally from the Roaming User Profile. The issue doesn't occur on first logons of a new roaming user, as the code path is different and slower.

#### Resolution

This issue has been resolved in Windows 10, versions 1703 and 1607, cumulative updates [as of March 2017](https://support.microsoft.com/help/4013429).

### Symptom: Start Menu layout customizations are lost after upgrading to Windows 10, version 1703

#### Description

Before the upgrade:

:::image type="content" source="media/troubleshoot-start-menu-errors/user-pinned-before-upgrade.png" alt-text="Screenshot of an example of Start screen with customizations applied." border="false":::

> [!NOTE]
> In the screenshot, **Corporate Applications** and **Utilities** are group policy controlled, and the tiles under these items are user pinned.

After the upgrade the user pinned tiles are missing:

:::image type="content" source="media/troubleshoot-start-menu-errors/user-pinned-tiles-missing.png" alt-text="Screenshot of an example of Start screen with previously pinned tiles missing." border="false":::

Additionally, users may see blank tiles if sign-in was attempted without network connectivity.

:::image type="content" source="media/troubleshoot-start-menu-errors/blank-tiles-sign-in-without-network.png" alt-text="Screenshot of an example of blank tiles." border="false":::

#### Resolution

This issue was fixed in the [October 2017 update](https://support.microsoft.com/help/4041676).

### Symptom: Tiles are missing after upgrade from Windows 10, version 1607 to version 1709 for users with Roaming User Profiles (RUP) enabled and managed Start Menu layout with partial lockdown

#### Resolution

The April 2018 LCU must be applied to Windows 10, version 1709 before a user logs on.

### Symptom: Start Menu and/or Taskbar layout customizations are not applied if CopyProfile option is used in an answer file during Sysprep

#### Resolution

CopyProfile is no longer supported when attempting to customize Start Menu or taskbar with a layoutmodification.xml.

### Symptom: Start Menu issues with Tile Data Layer corruption

#### Cause

Windows 10, version 1507 through the release of version 1607 uses a database for the Tile image information. This is called the Tile Data Layer database. (The feature was deprecated in [Windows 10 1703](/windows/deployment/planning/windows-10-removed-features).)

#### Resolution

There are steps you can take to fix the icons, first is to confirm that is the issue that needs to be addressed.

1. The App or Apps work fine when you select the tiles.
2. The tiles are blank, have a generic placeholder icon, have the wrong or strange title information.
3. The app is missing, but listed as installed via PowerShell and works if you launch via URI.
   - Example: `windows-feedback://`
4. In some cases, Start can be blank, and Action Center and Cortana don't launch.

> [!NOTE]
> Corruption recovery removes any manual pins from Start. Apps should still be visible, but you'll need to re-pin any secondary tiles and/or pin app tiles to the main Start view. Aps that you have installed that are completely missing from "all apps" is unexpected, however. That implies the re-registration didn't work.

Open a command prompt, and run the following command:

```console
C:\Windows\System32\tdlrecover.exe -reregister -resetlayout -resetcache
```

Although a reboot isn't required, it may help clear up any residual issues after the command is run.

### Symptoms: Start Menu and Apps cannot start after upgrade to Windows 10 version 1809 when Symantec Endpoint Protection is installed

#### Description

Start menu, Search, and Apps do not start after you upgrade a computer running Windows 7 that has Symantec Endpoint Protection installed to Windows 10 version 1809.

#### Cause

This problem occurs because of a failure to load *sysfer.dll*.  During upgrade, the setup process doesn't set the privilege group "All Application Packages" on *sysfer.dll* and other Symantec modules.

#### Resolution

This issue was fixed by the Windows Cumulative Update that were released on December 5, 2018—KB4469342 (OS Build 17763.168).

If you've already encountered this issue, use one of the following two options to fix the issue:

Option 1: Remove *sysfer.dll* from system32 folder and copy it back. Windows will set privilege automatically.

Option 2:

1. Locate the directory *C:\\Windows\\system32*.
2. Right-click on *sysfer.dll* and choose **Properties**.
3. Switch to the **Security** tab.
4. Confirm that **All Application Packages** group is missing.
5. Select **Edit**, and then select **Add** to add the group.
6. Test Start and other Apps.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
