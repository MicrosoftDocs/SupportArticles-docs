---
title: Modern, Inbox, and Microsoft Store Apps troubleshooting guidance
description: Provides guidance to troubleshoot Modern, Inbox, and Microsoft Store Apps.
ms.date: 04/16/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.technology: windows-client-shell-experience
ms.custom: sap:Windows Desktop and Shell Experience\Modern, Inbox and Microsoft Store Apps, csstroubleshoot
ms.reviewer: kaushika, warrenw, traceytu, iovoicul, kimberj, v-lianna
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

    Here's an example of a WinGet script.

    ```powershell
    <# 
    EXAMPLE WINGET SCRIPT

    We could use this script to install/reinstall applications using WinGet:
    
    ### Install Applications from a list (can be replaced with a CSV or Interactively ### 
     
    $Application_List = @( 
     
        "9WZDNCRFHVN5"  ### Microsoft Windows Calculator 
        "9NBLGGH5R558"  ### Microsoft To Do: Lists, Tasks & Reminders 
     
    ); 
     
    ### Install Application_List ### 
     
    function Application_install { 
        Clear-Host 
        Write-Host -ForegroundColor Cyan "Starting application install" 
        Foreach ($AppX in $Application_List) { 
            $listApp = winget list --exact --accept-source-agreements -q $AppX 
            if (![String]::Join("", $listApp).Contains($AppX)) { 
                Write-Host -ForegroundColor Yellow  "Installing..." $AppX 
                # MS Store repository Application_List 
                if ((winget search --exact -q $AppX) -match "msstore") { 
                    winget install --exact --silent --accept-source-agreements --accept-package-agreements $AppX --source msstore 
                } 
                # All other repos Application_List 
                else { 
                    winget install --exact --silent --scope machine --accept-source-agreements --accept-package-agreements $AppX 
                } 
                if ($LASTEXITCODE -eq 0) { 
                    Write-Host -ForegroundColor Green "Application $AppX was successfully installed." 
                } 
                else { 
                    "Application $AppX couldn't be installed." | Add-Content $errorlog 
                    Write-Warning "Application $AppX encountered an error and could not be installed." 
                    Write-Hos -ForegroundColor Red "Write in $errorlog" 
                   
                }   
            } 
            else { 
                Write-Host -ForegroundColor Yellow "Application $AppX is already installed." 
            } 
        } 
     
    } 
    ```

7. <a id="checklist-7"></a>Check if the system setup has appropriate settings to download and install AppX packages.

    Use the following script to check more common Store configuration settings to see if downloads are possible.

    ```powershell

    ### STORECHECKCONFIG SCRIPT

    function CheckAppxStoreConfiguration() 
    { 
      "Checking Store and Windows Update configuration for Appx repair:" 
      "------------------------------------------------" 
     
      $privatestore = $false  
      $nostoreaccess = $false 
     
      "Current context:" 
      $winVer = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion") 
      "   - OS".PadRight($CONFIG_COLUMN_PAD," ") + $winVer.ProductName + " " + $winVer.ReleaseId + " (build " + $winVer.CurrentBuildNumber + ")" 
      "   - UserName".PadRight($CONFIG_COLUMN_PAD," ") + [System.Security.Principal.WindowsIdentity]::GetCurrent().Name 
      "   - ComputerName".PadRight($CONFIG_COLUMN_PAD," ") + $env:ComputerName 
      "   - Security".PadRight($CONFIG_COLUMN_PAD," ") + $global:userRights 
       
      "" 
        
      " AppManager properties:" 
      if ($global:canInstallForAllUsers -eq $true) { $val = "Yes" } elseif ($global:canInstallForAllUsers -eq $false) { $val = "No" } else { $val = $global:canInstallForAllUsers } 
      if ($global:allUsersSwitch -ne '') { $val += " (will use '$allUsersSwitch')"} 
      "   - CanInstallForAllUsers".PadRight($CONFIG_COLUMN_PAD," ") + $val 
     
      try { 
        $val = $appInstallManager.AutoUpdateSetting  
        } 
      catch { 
        $val = "N/A"     
      } 
      "   - AutoUpdateSetting".PadRight($CONFIG_COLUMN_PAD," ") + $val 
        
      try { 
        if (Await ($appInstallManager.IsStoreBlockedByPolicyAsync("Microsoft.WindowsStore", "CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US")) ([bool])) 
        { 
          $nostoreaccess = true 
          $val = "blocked" 
        } 
        else { 
          $val = "NOT blocked" 
        } 
      } 
      catch { 
        $val = "N/A"     
      } 
      "   - IsStoreBlockedByPolicy".PadRight($CONFIG_COLUMN_PAD," ") + $val 
     
      "" 
      " Services:" 
     
    <# 
     
    Service name: AppXSVC 
     
    Display Name: AppX Deployment Service (AppXSVC) 
     
    Description: Provides infrastructure support for deploying Store applications. This service is started on demand and if disabled Store applications will not be deployed to the system, and may not function properly. 
     
    Start Type: Manual (Trigger Start)  
     
    #> 
     
      $service = Get-Service -Name "AppxSvc" 
      "   - $($service.Name) ($($service.DisplayName))".PadRight($CONFIG_COLUMN_PAD," ") + $($service.Status) 
      $key = "Start" 
      $val = (Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\AppXSvc -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val -eq 3) {$msg = "AppX Deployment Service has the default value." } else {$msg = "AppX Deployment Service is not set with the default value. Please check the settings." } 
      "$msg" 
      " "  
     
    <#  
     
    Service name: AppReadiness  
     
    Display name: App Readiness 
     
    Description: Gets apps ready for use the first time a user signs in to this PC and when adding new apps. 
     
    Start Type: Manual  
     
    #> 
     
      $service = Get-Service -Name "AppReadiness" 
      "   - $($service.Name) ($($service.DisplayName))".PadRight($CONFIG_COLUMN_PAD," ") + $($service.Status) 
      $key = "Start" 
      $val = (Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\AppReadiness -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val -eq 3) {$msg = "App Readiness Service has the default value." } else {$msg = "App Readiness Service is not set with the default value. Please check the settings." } 
      "$msg" 
      " "  
    <#  
     
    Service name: StoreSvc  
     
    Display name: Storage Service 
     
    Description: Provides enabling services for storage settings and external storage expansion. 
     
    Start Type: Automatic (Delayed Start / Triggered Start) 
     
    #> 
     
      $service = Get-Service -Name "StorSvc" 
      "   - $($service.Name) ($($service.DisplayName))".PadRight($CONFIG_COLUMN_PAD," ") + $($service.Status) 
      $key = "Start" 
      $val = (Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\storsvc -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val -eq 2) {$msg = "Storage Service has the default value." } else {$msg = "Storage Service is not set with the default value. Please check the settings." } 
      "$msg" 
      " "  
      "" 
    <# 
        https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.Appx::AllowDeploymentInSpecialProfiles  
     
    Allow deployment operations in special profiles  
     
        This policy setting allows you to manage the deployment of Windows Store apps when the user is signed in using a special profile. Special profiles are the following user profiles, where changes are discarded after the user signs off: 
     
        Roaming user profiles to which the "Delete cached copies of roaming profiles" Group Policy setting applies 
     
        Mandatory user profiles and super-mandatory profiles, which are created by an administrator 
     
        Temporary user profiles, which are created when an error prevents the correct profile from loading 
     
        User profiles for the Guest account and members of the Guests group 
     
        If you enable this policy setting, Group Policy allows deployment operations (adding, registering, staging, updating, or removing an app package) of Windows Store apps when using a special profile. 
     
        If you disable or do not configure this policy setting, Group Policy blocks deployment operations of Windows Store apps when using a special profile. 
     
    #> 
     
      " User Profile:" 
      $key = "AllowDeploymentInSpecialProfiles" 
      $val = (Get-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\Appx -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val) {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is set to $($val)"; $nostoreaccess = true} else {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is not set"} 
      "$msg" 
     
        ### https://learn.microsoft.com/en-us/windows-server/storage/folder-redirection/deploy-roaming-user-profiles  
     
      $key = "SpecialRoamingOverrideAllowed" 
      $val = (Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val) {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is set to $($val)"; $nostoreaccess = true} else {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is not set"} 
      "$msg" 
     
      "" 
     
      " Group Policies:" 
     
    <# 
     
        https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsStore::RemoveWindowsStore_2 
     
    Turn off the Store application 
     
        Denies or allows access to the Store application. 
     
        If you enable this setting, access to the Store application is denied. Access to the Store is required for installing app updates. 
     
        If you disable or don't configure this setting, access to the Store application is allowed. 
     
     #> 
     
      $key = "RemoveWindowsStore" 
       
      $val = (Get-ItemProperty -Path HKLM:\Software\Policies\Microsoft\WindowsStore\ -Name $key -ErrorAction SilentlyContinue).$key 
       
      if ($val)  
        {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is set to $($val) in HKLM"}  
      else  
        {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is not set in HKLM"} 
       
      $msg = $msg.PadRight($CONFIG_COLUMN_PAD+19," ") 
       
      $val = (Get-ItemProperty -Path HKCU:\Software\Policies\Microsoft\WindowsStore\ -Name $key -ErrorAction SilentlyContinue).$key 
       
      if ($val)  
        {$msg += "and is set to $($val) in HKCU"}  
      else  
        {$msg += "and is not set in HKCU"} 
     
      "$msg" 
       
     
    <# 
     
        https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsStore::RequirePrivateStoreOnly_2 
     
    Only display the private store within the Microsoft Store 
     
        Denies access to the retail catalog in the Microsoft Store, but displays the private store. 
     
        If you enable this setting, users will not be able to view the retail catalog in the Microsoft Store, but they will be able to view apps in the private store. 
     
        If you disable or don't configure this setting, users can access the retail catalog in the Microsoft Store. 
     
    #> 
     
      $key = "RequirePrivateStoreOnly" 
      $val = (Get-ItemProperty -Path HKLM:\Software\Policies\Microsoft\WindowsStore\ -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val) {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is set to $($val) in HKLM"} else {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is not set in HKLM"} 
      $msg = $msg.PadRight($CONFIG_COLUMN_PAD+19," ") 
      $val = (Get-ItemProperty -Path HKCU:\Software\Policies\Microsoft\WindowsStore\ -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val) {$msg += "and is set to $($val) in HKCU"; $privatestore = $true} else {$msg += "and is not set in HKCU"} 
      "$msg" 
     
    <# 
     
        https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsStore::DisableStoreApps 
     
    Disable all apps from Microsoft Store 
         
        Disable turns off the launch of all apps from the Microsoft Store that came pre-installed or were downloaded. Apps will not be updated. Your Store will also be disabled. Enable turns all of it back on. This setting applies only to Enterprise and Education editions of Windows. 
     
    #> 
     
      $key = "DisableStoreApps" 
      $val = (Get-ItemProperty -Path HKLM:\Software\Policies\Microsoft\WindowsStore\ -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val) {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is set to $($val) in HKLM"} else {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is not set in HKLM"} 
      $msg = $msg.PadRight($CONFIG_COLUMN_PAD+19," ") 
      $val = (Get-ItemProperty -Path HKCU:\Software\Policies\Microsoft\WindowsStore\ -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val) {$msg += "and is set to $($val) in HKCU"} else {$msg += "and is not set in HKCU"} 
      "$msg"  
     
    <# 
     
        https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.InternetCommunicationManagement::ShellNoUseStoreOpenWith_1 
     
    Turn off access to the Store 
     
        This policy setting specifies whether to use the Store service for finding an application to open a file with an unhandled file type or protocol association. 
     
        When a user opens a file type or protocol that is not associated with any applications on the computer, the user is given the choice to select a local application or use the Store service to find an application. 
     
        If you enable this policy setting, the "Look for an app in the Store" item in the Open With dialog is removed. 
     
        If you disable or do not configure this policy setting, the user is allowed to use the Store service and the Store item is available in the Open With dialog. 
     
    #> 
     
      $key = "NoUseStoreOpenWith" 
      $val = (Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer\ -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val) {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is set to $($val) in HKLM"} else {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is not set in HKLM"} 
      $msg = $msg.PadRight($CONFIG_COLUMN_PAD+19," ") 
      $val = (Get-ItemProperty -Path HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer\ -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val) {$msg += "and is set to $($val) in HKCU"} else {$msg += "and is not set in HKCU"} 
      "$msg" 
     
    <# 
     
        https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsStore::DisableAutoDownloadWin8 
     
    Turn off Automatic Download of updates on Win8 machines 
     
        Enables or disables the automatic download of app updates on PCs running Windows 8. 
     
        If you enable this setting, the automatic download of app updates is turned off. 
     
        If you disable this setting, the automatic download of app updates is turned on. 
     
        If you don't configure this setting, the automatic download of app updates is determined by a registry setting that the user can change using Settings in the Microsoft Store. 
     
    #> 
       
      $key = "AutoDownload" 
      $val = (Get-ItemProperty -Path HKLM:\Software\Policies\Microsoft\WindowsStore\ -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val) {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is set to $($val) in HKLM"} else {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + " is not set in HKLM"} 
      $msg = $msg.PadRight($CONFIG_COLUMN_PAD+19," ") 
      $val = (Get-ItemProperty -Path HKCU:\Software\Policies\Microsoft\WindowsStore\ -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val) {$msg += "and is set to $($val) in HKCU"} else {$msg += " and is not set in HKCU"} 
      "$msg" 
       
    <# 
     
        https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsUpdate::DisableUXWUAccess 
     
    Remove access to use all Windows Update features 
     
        This setting allows you to remove access to scan Windows Update. 
     
        If you enable this setting user access to Windows Update scan, download and install is removed. 
     
    #> 
     
      $key = "SetDisableUXWUAccess" 
      $val = (Get-ItemProperty -Path HKLM:\Software\Policies\Microsoft\WindowsStore\ -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val) {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is set to $($val) in HKLM"} else {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is not set in HKLM"} 
      $msg = $msg.PadRight($CONFIG_COLUMN_PAD+19," ") 
      $val = (Get-ItemProperty -Path HKCU:\Software\Policies\Microsoft\WindowsStore\ -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val) {$msg += "and is set to $($val) in HKCU"} else {$msg += "and is not set in HKCU"} 
      "$msg" 
       
    <# 
     
        https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsUpdate::DoNotConnectToWindowsUpdateInternetLocations 
     
    Do not connect to any Windows Update Internet locations 
     
        Even when Windows Update is configured to receive updates from an intranet update service, it will periodically retrieve information from the public Windows Update service to enable future connections to Windows Update, and other services like Microsoft Update or the Windows Store. 
     
        Enabling this policy will disable that functionality and may cause connection to public services such as the Windows Store to stop working. 
     
        Note: This policy applies only when this PC is configured to connect to an intranet update service using the "Specify intranet Microsoft update service location" policy. 
     
    #> 
     
      $key = "DoNotConnectToWindowsUpdateInternetLocations" 
      $val = (Get-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val) {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is set to $($val) in HKLM"} else {$msg = "   - $key".PadRight($CONFIG_COLUMN_PAD," ") + "is not set in HKLM"} 
      $msg = $msg.PadRight($CONFIG_COLUMN_PAD+19," ") 
      $val = (Get-ItemProperty -Path HKCU:\Software\Policies\Microsoft\Windows\WindowsUpdate -Name $key -ErrorAction SilentlyContinue).$key 
      if ($val) {$msg += "and is set to $($val) in HKCU"; $nostoreaccess = true} else {$msg += "and is not set in HKCU"} 
      "$msg" 
     
      "" 
     
    ### Checking Windows Update Settings 
     
      " Windows Update:" 
      $MUSM = New-Object -ComObject "Microsoft.Update.ServiceManager" 
      $val = ($MUSM.Services | Where-Object IsDefaultAUService | Select-Object Name).Name 
      "   - Default Update Service".PadRight($CONFIG_COLUMN_PAD," ") + $val 
     
      $val = ($MUSM.Services | Where-Object ServiceId -Match "855e8a7c-ecb4-4ca3-b045-1dfa50104289").ServiceUrl 
      $response = try { (Invoke-WebRequest -UseDefaultCredentials -URI $val -ErrorAction Stop).BaseRequest } catch { $_.Exception.Response } 
      "   - WU Test ($val)".PadRight($CONFIG_COLUMN_PAD," ") + "$(if (!@(200, 403) -contains ([int]$response.StatusCode)) {'DOES NOT '; $nostoreaccess = $true})look reachable" 
      "" 
      if ($privatestore)   
      {  
        "WARNING: You use the private store, please ensure you have added the apps there for the repair to work."; ### Only display the private store within the Microsoft Store GPO - https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsStore::RequirePrivateStoreOnly_2 
        ""  
      } 
     
      if ($nostoreaccess)  
      {  
        "WARNING: Your settings block Windows Update from accessing internet, the script will likely not be able to re-download apps and fix file corruptions."; 
        ""  
      } 
     
    } 
     
    CheckAppxStoreConfiguration;

    ```

8. <a id="checklist-8"></a>If Microsoft Store has issues starting or was previously removed, try reinstalling it.

    > [!NOTE]
    > Removing Microsoft Store is not supported. For more information, see [Removing, uninstalling, or reinstalling Microsoft Store app isn't supported](cannot-remove-uninstall-or-reinstall-microsoft-store-app.md).

    If you have problems with Microsoft Store, the following script may help to reinstall it from scratch if it was removed or broken:

    ```powershell
    
    ### REPAIRSTORE SCRIPT

    Add-Type -AssemblyName System.ServiceModel 
    $BindingFlags = [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Static 
    [Windows.Management.Deployment.PackageManager,Windows.Management.Deployment,ContentType=WindowsRuntime] | Out-Null 
    [Windows.ApplicationModel.Store.Preview.InstallControl.AppInstallManager,Windows.ApplicationModel.Store.Preview.InstallControl,ContentType=WindowsRuntime] | Out-Null 
     
    # Credits for using IAsyncOperation from PS go to https://fleexlab.blogspot.com/2018/02/using-winrts-iasyncoperation-in.html 
     
    Add-Type -AssemblyName System.Runtime.WindowsRuntime 
    $asTaskGeneric = ([System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1' })[0] 
     
    $appInstallManager = New-Object Windows.ApplicationModel.Store.Preview.InstallControl.AppInstallManager 
     
    Function Await($WinRtTask, $ResultType) { 
      try { 
        $asTask = $asTaskGeneric.MakeGenericMethod($ResultType) 
        $netTask = $asTask.Invoke($null, @($WinRtTask)) 
        $netTask.Wait(-1) | Out-Null 
        $netTask.Result 
      } 
      catch { 
        $savedForegroundColor = $host.ui.RawUI.ForegroundColor 
        $savedBackgroundColor = $host.ui.RawUI.BackgroundColor 
        $host.ui.RawUI.ForegroundColor = "Red" 
        $host.ui.RawUI.BackgroundColor = "Black" 
     
        "Async call failed with:"     
        "  Exception Type: $($_.Exception.GetType().FullName)" 
        "    Exception Message: $($_.Exception.Message)" 
     
        "" 
        $host.ui.RawUI.ForegroundColor = $savedForegroundColor 
        $host.ui.RawUI.BackgroundColor = $savedBackgroundColor 
      } 
    } 
     
    function ReinstallStore() 
    { 
     
    $SLEEP_DELAY =  1000 
     
      try { 
        $appinstalls = Await ($appInstallManager.StartAppInstallAsync("9WZDNCRFJBMP", "", $true, $true)) ([Windows.ApplicationModel.Store.Preview.InstallControl.AppInstallItem]) 
        if ($appinstalls.Length -eq 0)  
        {  
          "Package Manager didn't return any package to download for this reinstall." 
          "" 
        } 
        else 
        { 
          foreach($appinstall in $appinstalls) 
          { 
            if ($appinstall.PackageFamilyName) 
            { 
              try { $appstoreaction = "to " + ([Windows.ApplicationModel.Store.Preview.InstallControl.AppInstallType]$appinstall.InstallType) } catch { $appstoreaction = "" } 
              "  - Requesting $($appinstall.PackageFamilyName) $appstoreaction" 
              Start-Sleep -Milliseconds $SLEEP_DELAY 
              $finished = $false 
            } 
          } 
           
          "" 
          "Running the update process:" 
          "---------------------------" 
          while (!$finished) 
          { 
            $finished = $true         
            for ($index=0; $index -lt $appinstalls.Length; $index++) 
            { 
              $appUpdate = $appinstalls[$index] 
              $packageFamilyName = $appUpdate.PackageFamilyName 
              $status = $appUpdate.GetCurrentStatus() 
              $currentstate = [Windows.ApplicationModel.Store.Preview.InstallControl.AppInstallState]$status.InstallState 
     
              if (!($status.PercentComplete -eq 100) -and !($status.ErrorCode)) 
              { 
                Write-Progress -Id $index -Activity $packageFamilyName -status ("$currentstate $([Math]::Round($status.BytesDownloaded/1024).ToString('N0'))kb ($($status.PercentComplete)%)") -percentComplete $status.PercentComplete 
     
                if ($finished) 
                { 
                  $finished = $false 
                } 
              } 
            } 
            Start-Sleep -Milliseconds $SLEEP_DELAY 
          } 
          for ($index=0; $index -lt $appinstalls.Length; $index++) 
          { 
            $appUpdate = $appinstalls[$index] 
            $packageFamilyName = $appUpdate.PackageFamilyName 
            $status = $appUpdate.GetCurrentStatus() 
            $currentstate = [Windows.ApplicationModel.Store.Preview.InstallControl.AppInstallState]$status.InstallState 
     
            if ($status.PercentComplete -eq 100) 
            { 
              Write-Progress -Id $index -Activity $packageFamilyName -Status "Completed" -Completed 
              "  -> $packageFamilyName ended as $currentstate $(if ($status.ReadyForLaunch) {"and reports now to be READY FOR LAUNCH!"} Else {"and is NOT READY for launch."})" 
              $global:repairSucceeded = $true 
            } 
            elseif ($status.ErrorCode) 
            { 
              "  -> $packageFamilyName failed with Error $status.ErrorCode / $currentstate" 
              Write-Progress -Id $index -Activity $packageFamilyName -Status $msg -Completed 
            } 
          } 
          "" 
          "The store apps update process ended for $packageFamilyName package." 
          "" 
        } 
      } 
      catch 
      { 
          $savedForegroundColor = $host.ui.RawUI.ForegroundColor 
          $savedBackgroundColor = $host.ui.RawUI.BackgroundColor 
          $host.ui.RawUI.ForegroundColor = "Red" 
          $host.ui.RawUI.BackgroundColor = "Black" 
     
          "Exception Type: $($_.Exception.GetType().FullName)" 
          "    Exception Message: $($_.Exception.Message)" 
     
          "" 
          "Going to reset package status to get back to a normal state" 
          $host.ui.RawUI.ForegroundColor = $savedForegroundColor 
          $host.ui.RawUI.BackgroundColor = $savedBackgroundColor 
          "" 
        } 
    } 
     
    ReinstallStore

    ```

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
