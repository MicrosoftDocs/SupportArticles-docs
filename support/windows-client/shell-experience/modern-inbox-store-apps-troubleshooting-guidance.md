---
title: Modern, Inbox, and Microsoft Store Apps troubleshooting guidance
description: Provides guidance to troubleshoot Modern, Inbox, and Microsoft Store Apps.
ms.date: 04/17/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom: sap:Windows Desktop and Shell Experience\Modern, Inbox and Microsoft Store Apps, csstroubleshoot
ms.reviewer: kaushika, warrenw, traceytu, iovoicul, kimberj, raviks, v-lianna
localization_priority: medium
---
# Modern, Inbox, and Microsoft Store Apps troubleshooting guidance

> [!NOTE]
> This article is intended for use by support agents and IT professionals. If you're looking for more general information, see [Repair apps and programs in Windows](https://support.microsoft.com/windows/repair-apps-and-programs-in-windows-e90eefe4-d0a2-7c1b-dd59-949a9030f317).

Modern Apps or Microsoft Store Apps can sometimes fail to start or launch and then stop responding. This guide discusses troubleshooting techniques that you can use to troubleshoot such issues.

## Troubleshooting checklist

1. [Verify if the application is registered or installed for your user.](#checklist-1)
2. [Re-register the application for the user may resolve activation issues.](#checklist-2)
3. [If you receive no response to the Get-AppxPackage cmdlet, you can still use the Add-AppxPackage cmdlet.](#checklist-3)
4. [For the XML path, you need to check which version you have installed.](#checklist-4)
5. [If the application still fails to start after re-registration, perhaps the package for the application is corrupted or missing some components.](#checklist-5)
6. [For a single application, you can use the winget command.](#checklist-6)
7. [Check if the system setup has appropriate settings to download and install AppX packages.](#checklist-7)
8. [If Microsoft Store has issues starting or was previously removed, try reinstalling it.](#checklist-8)
9. [If the application still fails, some event logs might be helpful.](#checklist-9)

Here's the detailed troubleshooting checklist:

1. <a id="checklist-1"></a>Verify if the application is registered or installed for your user.

    Modern Apps are deployed as a package onto a machine and then need to register individually for each user that logs in. A record is kept on each machine for every application and which users have it registered. For example, to see if an individual user has the Calculator application installed, use the following cmdlet in a nonelevated Windows PowerShell prompt:

    ```powershell
    Get-AppxPackage *calculator*
    ```

    If it's registered, the output looks like the following:

    ```output
    Name              : Microsoft.WindowsCalculator 
    Publisher         : CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US 
    Architecture      : X64 
    ResourceId        : 
    Version           : 11.2210.0.0 
    PackageFullName   : Microsoft.WindowsCalculator_11.2210.0.0_x64__8wekyb3d8bbwe 
    InstallLocation   : C:\Program Files\WindowsApps\Microsoft.WindowsCalculator_11.2210.0.0_x64__8wekyb3d8bbwe 
    IsFramework       : False 
    PackageFamilyName : Microsoft.WindowsCalculator_8wekyb3d8bbwe 
    PublisherId       : 8wekyb3d8bbwe 
    IsResourcePackage : False 
    IsBundle          : False 
    IsDevelopmentMode : False 
    NonRemovable      : False 
    Dependencies      : {Microsoft.UI.Xaml.2.8_8.2212.15002.0_x64__8wekyb3d8bbwe, 
                        Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x64__8wekyb3d8bbwe, 
                        Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x64__8wekyb3d8bbwe, 
                        Microsoft.VCLibs.140.00_14.0.30704.0_x64__8wekyb3d8bbwe...} 
    IsPartiallyStaged : False 
    SignatureKind     : Store 
    Status            : Ok 
    ```

2. <a id="checklist-2"></a>Even if the application is shown as registered for your user, sometimes re-registering the application for the user can resolve activation issues because it repairs any missing entries for the package. Use the following cmdlet at the same nonelevated PowerShell prompt (this example is for the Calculator application):

    ```powershell
    Get-AppxPackage *calculator*| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"} 
    ```

    > [!NOTE]
    > Notice how we return the output from the `Get-AppxPackage` cmdlet to feed into the `Add-AppxPackage` cmdlet using the pipe `|` cmdlet. This only works if the package is already registered.

3. <a id="checklist-3"></a>If you receive no response to the `Get-AppxPackage` cmdlet, you can still use the `Add-AppxPackage` cmdlet by using the family name or the path to the *AppxManifest.xml* file.

    This is possible because although this user doesn't have the package registered, other users might. This means that the package will still exist on the machine.

    To check this, add `-AllUsers` to the same `Get-AppxPackage` cmdlet we used earlier in an elevated PowerShell prompt:

    ```powershell
    Get-AppxPackage *calculator* -AllUsers
    ```

    If there's a successful return of the app details, it means that the package exists.

    Use one of the following cmdlets to try to register the app for this user.

    Be sure not to use the elevated PowerShell prompt unless you wish to register the app to the administrator instead of the user.

    ```powershell
    Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.WindowsCalculator_8wekyb3d8bbwe
    ```

    ```powershell
    Add-AppxPackage -path "c:\Program Files\WindowsApps\Microsoft.WindowsCalculator_11.2210.0.0_x64__8wekyb3d8bbwe\AppxManifest.xml" -DisableDevelopmentMode -Register
    ```

    For a System Application, the XML path is slightly different:

    ```powershell
    Add-AppxPackage -Path "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\AppXManifest.xml" -DisableDevelopmentMode -Register
    ```

    > [!NOTE]
    > Be sure to use the `Add-AppxPackage` cmdlet from a non-elevated prompt, or the package will be registered to the admin instead of the user.

4. <a id="checklist-4"></a>For the XML path, you need to check which version you have installed. You can do this from an elevated PowerShell prompt with a `dir` cmdlet:

    ```powershell
    dir "c:\Program Files\WindowsApps\Microsoft.WindowsCalculator*"
    ```

    The output looks like the following:

    ```output
    Directory: C:\Program Files\WindowsApps
    
    Mode                 LastWriteTime         Length Name 
    d-----        <Date>     <Time>                Microsoft.WindowsCalculator_11.2210.0.0_x64__8wekyb3d8bbwe
    ```

5. <a id="checklist-5"></a>If the application still fails to start after basic re-registration, try using the [Reset-AppxPackage](/powershell/module/appx/reset-appxpackage) cmdlet to restore the app to the original configuration. If the app is still not working, perhaps the package for the application is corrupted or missing some components. Get a new package for the machine by using Microsoft Store (public or private) or Windows Package Manager (winget). For more information, see [Troubleshoot Apps failing to start using Windows Package Manager](troubleshoot-apps-start-failure-use-windows-package-manager.md).

6. <a id="checklist-6"></a>For a single application, you can use the `winget` command. To search for an application, use the following command:

    ```console
    winget search <AppName>
    ```

    After you have confirmed that the application you want is available, you can install it by using the following command:

    ```console
    winget install <AppName>
    ```

    The winget tool will launch the installer and install the application on your computer. For example:

    :::image type="content" source="media/modern-inbox-store-apps-troubleshooting-guidance/search-powertoys.png" alt-text="Screenshot that shows the result of searching Microsoft PowerToys.":::

    To avoid the license prompts, you can use a small, scripted command:

    ```console
    winget install --exact --silent --accept-source-agreements --accept-package-agreements XP89DCGQ3K6VLD --source msstore
    ```

    You can search for available applications using [winget search](/windows/package-manager/winget/search). The application ID can be pulled from the search.

7. <a id="checklist-7"></a>Check if the system setup has appropriate settings to download and install AppX packages.

8. <a id="checklist-8"></a>If Microsoft Store has issues starting or was previously removed, try reinstalling it.

    > [!NOTE]
    > Removing Microsoft Store is not supported. For more information, see [Removing, uninstalling, or reinstalling Microsoft Store app isn't supported](cannot-remove-uninstall-or-reinstall-microsoft-store-app.md).

9. <a id="checklist-9"></a>If the application still fails, the following event logs might be helpful.

    - Application Event Log
    - System Event Log
    - Microsoft-Windows-AppXDeploymentServer/Operational (*Applications and Services\\Microsoft\\Windows\\AppXDeployment-Server*)
    - Microsoft-Windows-TWinUI/Operational (*Applications and Services\\Microsoft\\Windows\\Apps*)
    - Admin (*Applications and Services\\Microsoft\\Windows\\AppModel-Runtime*)

## Common issues and solutions

### Application is blocked

You receive the following logs:

```output
Log Name: Microsoft-Windows-AppXDeploymentServer/Operational 
Source: Microsoft-Windows-AppXDeployment-Server 
Event ID: 404 
Level: Error 
Keywords: AppXDeploymentServer Keyword 
Description: 
AppX Deployment operation failed for package Microsoft.Windows.StartMenuExperienceHost_10.0.22621.1_neutral_neutral_cw5n1h2txyewy with error 0x80073D01. The specific error text for this failure is: error 0x800704EC: Deployment of package Microsoft.Windows.StartMenuExperienceHost_10.0.22621.1_neutral_neutral_cw5n1h2txyewy **was blocked by AppLocker**. 
```

```output
Log Name: Microsoft-Windows-AppLocker/Packaged app-Execution 
Source: Microsoft-Windows-AppLocker 
Event ID: 8022 
Level: Error 
Description: 
MICROSOFT.WINDOWS.SEARCH was prevented from running. 
```

```output
Log Name: Microsoft-Windows-TWinUI/Operational 
Source: Microsoft-Windows-Immersive-Shell 
Event ID: 5961 
Level: Error 
Description: 
Activation for MicrosoftWindows.Client.CBS_cw5n1h2txyewy!FESearchUI failed. Error code: **This program is blocked by group policy**. For more information, contact your system administrator. Activation phase: Deployment
```

You need to remove AppLocker restrictions. For AppLocker to stop enforcing its rules, two things need to happen in sequence:

1. The effective policy on the client computer is emptied.
2. The AppLocker service is disabled.

The AppLocker rules remain enforced even though the service has been stopped and the rules have been deleted from the user interface. This can occur when a Group Policy administrator deletes all AppLocker rules and disables the AppLocker service in a single Group Policy update. The effect of this is that the AppLocker service is disabled before it can update the effective policy on the client computer. As a result, AppLocker rules continue to be enforced.

#### Solution

To resolve this condition, remove all AppLocker rules and stop the service. That is, delete all the AppLocker rules in the Group Policy Object (GPO), push out that update to allow the empty AppLocker policy to be applied on the client computers, and then separately disable the service on those client computers. For more information, see
[AppLocker Rules Still Enforced After the Service is Stopped](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/hh310286(v=ws.10)).

To terminate AppLocker rule enforcement, follow these steps:

1. Back up the GPO that contains the currently applied AppLocker rules.
2. Delete all the AppLocker rules on that GPO. For detailed steps, see [AppLocker Policy Procedures](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee791822(v=ws.10)).
3. Push out the GPO that contains the empty AppLocker policy to the affected client computers. For detailed steps, see [Refresh an AppLocker Policy](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee791751(v=ws.10)).
4. Disable the AppLocker service (appidsvc) on all the affected client computers. Optionally, you can restart the service. For detailed steps, see [Configure the Application Identity Service](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee791779(v=ws.10)). Alternatively, you can disable the AppLocker service using Group Policy instead of disabling locally.
5. Optionally, if you want to update the computers with another set of AppLocker rules (and the service has been enabled), you can force a Group Policy update for the revised AppLocker policy. For detailed steps, see [Refresh an AppLocker Policy](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee791751(v=ws.10)).

### Bad permissions being set on registry keys or folders

The general rule isn't to modify the permissions from registry keys owned by the operating system. Even for hardening purposes, we don't recommend changing the permissions or the ownership from the registry key, files, or folders from Windows. That action might break your system and possibly require a rebuild to fix.

The applications are installed to run in the user context and require the correct permission for the user and **All Application Packages** to be able to launch.

Permission problems often happen on folders or registry hives, including:

- *C:\\Program Files\\WindowsApps*
- *C:\\ProgramData\\Microsoft\\Windows\\AppRepository*
- *C:\\Users*
- `HKCU\Software\Classes`
- `HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`
- `HKLM\SOFTWARE\Microsoft\OLE`

You can use the following `Get-Acl` cmdlet in PowerShell to check folder permissions:

```powershell
Get-Acl -Path HKLM:\SOFTWARE\Microsoft\OLE | Format-List
```

```powershell
Get-Acl C:\ProgramData\Microsoft\Windows\AppRepository
```

You can also use the Process Monitor tool to trace the app failing to start. See [Troubleshoot Apps Failing to Start Using Process Monitor](troubleshoot-apps-start-failure-use-process-monitor.md).

If using the Process Monitor tool isn't an option, you can check the above folders against a working machine. Start from a new machine in an Organizational Unit (OU) without policies, and add them one by one until the applications break.

Once you find the incorrect permissions, try to fix the permissions to avoid the possibility of a complete rebuild of the system. Take care in making corrective changes and notice the source of the permission change. A policy reapplication might wipe out all your hard work if the incorrect policy isn't identified before making the changes. Perhaps move into a separate OU or block policy application when doing the investigation.

Remember that moving a machine from an OU doesn't automatically reset all the permissions to default. They must be explicitly turned off, not set to **Not configured**. It's similar to a policy where "turn tap on" isn't changed until "turn tap off" is set. **Not configured** doesn't change the "on" status.

If you aren't sure which GPO is affecting the system and have many GPOs applied, try to reset the Local Group Policy settings using a command prompt as a test. This action only sets the values to default, so if a policy was set to **Enabled** previously and the default setting is **Not configured** with a **Disabled** state, it doesn't actually disable the corresponding registry setting, as explained above.

To reset the Group Policy settings with a command prompt, use these steps:

1. Open a command prompt window as an administrator.
2. Enter the following command to reset all the Group Policy settings and press <kbd>Enter</kbd>:

    ```console
    RD /S /Q "%WinDir%\System32\GroupPolicyUsers" && RD /S /Q "%WinDir%\System32\GroupPolicy" 
    ```

3. Enter the following command to update the changes in the Local Group Policy console and press <kbd>Enter</kbd>:

    ```console
    gpupdate /force
    ```

4. Restart your computer (not required but recommended).

Once you complete the steps, the command deletes the folders that store the Group Policy settings on your device. Then Windows 10 or Windows 11 should reapply the default values.

These instructions are also not meant to reset the objects under the "Windows Security" (Local Security Policy) section since they're stored in a different location.

If the permissions are incorrect, always apply from the highest level and allow down inheritance to your target directory.

If the **Bypass traverse checking** user right is missing, the permissions on the directory might be correct, but the user is unable to make use of any inherited permissions. Check that you aren't missing anyone in [Bypass traverse checking (Windows 10)](/windows/security/threat-protection/security-policy-settings/bypass-traverse-checking).

:::image type="content" source="media/modern-inbox-store-apps-troubleshooting-guidance/bypass-traverse-checking-properties.png" alt-text="Screenshot that shows the bypass traverse checking properties.":::

Finally, if you can't locate the permission issue causing the problem and only a few machines are involved, recovering the machine and refreshing it to a clean image may solve the problem.

## Data collection

Before contacting Microsoft support, you can gather information about your issue.

### Prerequisites

Refer to [Introduction to TroubleShootingScript toolset (TSSv2)](../windows-troubleshooters/introduction-to-troubleshootingscript-toolset-tssv2.md#prerequisites) for prerequisites for the toolset to run properly.

### Gather key information before contacting Microsoft support

1. Download [TSSv2](https://aka.ms/getTSSv2) and extract it in the *C:\\tss_tool* folder. If you've downloaded this tool previously, we recommend downloading the latest version. It doesn't automatically update when running.
2. Open the *C:\\tss_tool* folder from an elevated PowerShell command prompt.
    > [!NOTE]
    > Don't use the Windows PowerShell Integrated Scripting Environment (ISE).
3. Run the following cmdlet and enter *A* for "Yes to All" for the execution policy change.

    ```powershell
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    ```

4. Run the following cmdlets to start tracing and collect the event logs.

    ```powershell
    .\tss.ps1 -scenario PRF_UWP
    ```

    ```powershell
    .\tss.ps1 -CollectLog PRF_AppX
    ```

The traces are stored in a compressed file in the *C:\\MSDATA* folder. After a support case is created, this file can be uploaded to the secure workspace for analysis.
