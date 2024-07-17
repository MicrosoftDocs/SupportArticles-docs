---
title: Teams meeting add-in missing from Outlook and new Teams
description: Resolves an issue in which the Teams meeting add-in doesn't load in new Teams and is removed from Microsoft Outlook.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Teams Meetings\Meetings Other
  - CI 191699
  - CSSTroubleshoot
ms.reviewer: mfoland; shmurth; wayvad
appliesto: 
  - New Microsoft Teams
search.appverid: 
  - MET150
ms.date: 06/25/2024
---
# Teams meeting add-in missing from Outlook and new Teams

## Symptoms

Either you or your organization uninstalls classic Microsoft Teams and then updates to new Teams. The classic Teams version is earlier than 1.7.00.6058. You uninstall the program by using one of the following methods:

- Any of the available options to [uninstall programs](https://support.microsoft.com/windows/4b55f974-2cc6-2d2b-d092-5905080eaf98) in Windows 11 and Windows 10.

- An administrative policy that triggers the removal of classic Teams. For example, organizations might choose to remove older versions of classic Teams from user computers to make sure that most users are on the same version.

- The "new Teams only" policy setting to upgrade to new Teams. When a user is assigned this Teams upgrade policy, the new Teams app removes the classic Teams app from the user's computer after a set time. The default setting is 14 days.

After the update, the Teams meeting add-in doesn't load in new Teams. Additionally, the add-in is removed from Microsoft Outlook.

## Cause

When a version of classic Teams that is earlier than 1.7.00.6058 is uninstalled, the Teams meeting add-in is also uninstalled. The uninstallation process removes the registry keys that are shared across all versions of the Teams meeting add-in. Therefore, when new Teams and Outlook start, the computer doesn't find the installed add-in to load.

## Resolution

For non-VDI environments, follow these steps to reinstall the Teams meeting add-in.

1. Use the following PowerShell script to verify that classic Teams was uninstalled correctly:

    ```powershell
    $userLocalAppData = [Environment]::GetFolderPath("LocalApplicationData")
    $teamsUpdater = Join-Path -Path $userLocalAppData -ChildPath 'Microsoft\Teams\Update.exe'
    
    if (Test-Path -Path $teamsUpdater)
    {
        $process = Start-Process -Filepath $teamsUpdater -ArgumentList "--uninstall -s" -PassThru
        $handle = $process.Handle;
        $process.WaitForExit();
        $exitCode = $process.ExitCode;
    
        if ($exitCode -ne 0) 
        {
            Write-Warning "classic Teams uninstallation failed with $($exitCode)"
        }
        else
        {
            Write-Output "classic Teams uninstallation was successful."
        }
    }
    else
    {
        Write-Output "Could not find a classic Teams installation, could it already have been uninstalled?"
    }
    ```

1. Use the following PowerShell script to verify that the Teams meeting add-in was uninstalled correctly:

    ```powershell
    try {  
       $tmaMsiPath = "{0}\MicrosoftTeamsMeetingAddinInstaller.msi" -f (get-appxpackage -name MSTeams).InstallLocation  
       $process = Start-Process -FilePath "msiexec.exe" -ArgumentList "/x `"$tmaMsiPath`" InstallerVersion=v3 /quiet /l `"$env:USERPROFILE\Downloads\tma-uninstall.log`"" -PassThru -Wait -ErrorAction Stop
      
       if ($process.ExitCode -ne 0) {  
          throw "msiexec.exe exited with code $($process.ExitCode)"  
       }  
       else  
       {  
          Write-Host "Successfully uninstalled teams meeting addin." -ForegroundColor Green  
       }  
    }  
    catch {  
       Write-Error "Failed to uninstall: $_. We'll try repairing MSI"   
       $process = Start-Process -FilePath "msiexec.exe" -ArgumentList "/fav `"$tmaMsiPath`" /quiet /l `"$env:USERPROFILE\Downloads\tma-uninstall-repair.log`"" -PassThru -Wait -ErrorAction Stop  

       if ($process.ExitCode -ne 0) {    
          Write-Error "Repair failed with code $($process.ExitCode)"  
       }  
       else  
       {  
          Write-Output "Repair succeeded! We'll try to uninstall again"          
          $process = Start-Process -FilePath "msiexec.exe" -ArgumentList "/x `"$tmaMsiPath`" /quiet InstallerVersion=v3 /l `"$env:USERPROFILE\Downloads\tma-uninstall-retry.log`"" -PassThru -Wait -ErrorAction Stop  

          if ($process.ExitCode -eq 0) {  
             Write-Host "Successfully uninstalled teams meeting addin." -ForegroundColor Green  
          }
          else  
          {  
             Write-Error "Could not uninstall teams meeting addin"  
          }  
       } 
    }  
    ```

1. Close the new Teams app.
1. Close the Outlook app.
1. Start the new Teams app.
1. Wait until the Teams meeting add-in appears in the list in **Start** > **Settings** > **Apps** > **Installed apps**.
1. Restart the Outlook app.

## More information

The following sections list registry entries for different versions of the Outlook app. These entries are necessary for the Teams meeting add-in to load.

### Outlook 64-bit

- Registry subkey: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\office\Outlook\Addins\TeamsAddin.FastConnect`

  This key provides Outlook with the ProgID value of the add-in to load. If this value is missing, Outlook won't search for the add-in.

  |Registry entry name|Description|
  |---------|---------|
  |FriendlyName|Display name of the add-in in Outlook.|
  |Description|Description of the add-in.|
  |LoadBehavior|Determines when Outlook should try to load the add-in. "3" is the default value of this entry. This value tells Outlook to load the add-in at startup.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.FastConnect\CurVer`

  This key provides details about the ProgID value so that programs can find the correct libraries.

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|Name and version for ProgId.|

- Registry subkey: `HKEY_CURRENT_USER\SOFTWARE\Classes\CLSID\{19A6E644-14E6-4A60-B8D7-DD20610A871D}`

  Registration for COM Class.

- Registry subkey: `HKEY_CURRENT_USER\SOFTWARE\Classes\CLSID\{19A6E644-14E6-4A60-B8D7-DD20610A871D}\InprocServer32`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|Path to the 64-bit version of *Microsoft.Teams.AddinLodaer.dll*.|
  |ThreadingModel|Definition of the threading model that's to be used by the class. Its value should be **Apartment**.|

- Registry subkey: `HKEY_CURRENT_USER\SOFTWARE\Classes\CLSID\{19A6E644-14E6-4A60-B8D7-DD20610A871D}\ProgID`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|ProgID with version of the class. Its value should be **TeamsAddin.FastConnect.1**.|

- Registry subkey: `HKEY_CURRENT_USER\SOFTWARE\Classes\CLSID\{19A6E644-14E6-4A60-B8D7-DD20610A871D}\VersionIndependentProgID`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|ProgId of the class without version information. Its value should be **TeamsAddin.FastConnect**.|

- Registry subkey: `HKEY_CURRENT_USER\SOFTWARE\Classes\CLSID\{19A6E644-14E6-4A60-B8D7-DD20610A871D}\TypeLib`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|Class ID of the type lib that's associated with this class. Its value should be **{C0529B10-073A-4754-9BB0-72325D80D122}**.|

- Registry subkey: `HKEY_CURRENT_USER\SOFTWARE\Classes\CLSID\{19A6E644-14E6-4A60-B8D7-DD20610A871D}\Version`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|Version of the class to be used. Its value should be **1.0**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.Connect.1`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **Connect Class**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.Connect.1\CLSID`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **{CB965DF1-B8EA-49C7-BDAD-5457FDC1BF92}**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.Connect`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **Connect Class**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.Connect\CurVer`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **TeamsAddin.Connect.1**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.FastConnect.1`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **FastConnect Class**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.FastConnect.1\CLSID`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **{19A6E644-14E6-4A60-B8D7-DD20610A871D}**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.FastConnect`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **FastConnect Class**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.FastConnect\CurVer`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **TeamsAddin.FastConnect.1**.|
  |Description|Microsoft Teams Meeting Add-in for Microsoft Office.|
  |FriendlyName|Microsoft Teams Meeting Add-in for Microsoft Office.|

### Outlook 32-bit

- Registry subkey: `HKEY_CURRENT_USER\SOFTWARE\Wow6432Node\Microsoft\office\Outlook\Addins\TeamsAddin.FastConnect`

  This key provides Outlook with the ProgID value of the add-in to load. If the value is missing, Outlook won't try to look for the add-in.

  |Registry entry name|Description|
  |---------|---------|
  |FriendlyName|Display name of the add-in in Outlook.|
  |Description|Description of the add-in.|
  |LoadBehavior|Determines when Outlook should try to load the add-in. "3" is the default value of this entry. This value tells Outlook to load the add-in at startup.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.FastConnect\CurVer`

  Provides details about the ProgID value so that programs can find the correct libraries.

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|Name and version for the ProgId.|

- Registry subkey: `HKEY_CURRENT_USER\SOFTWARE\Classes\Wow6432Node\CLSID\{19A6E644-14E6-4A60-B8D7-DD20610A871D}`

  Registration for COM Class.

- Registry subkey: `HKEY_CURRENT_USER\SOFTWARE\Classes\Wow6432Node\CLSID\{19A6E644-14E6-4A60-B8D7-DD20610A871D}\InprocServer32`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|Path to the 32-bit version of *Microsoft.Teams.AddinLodaer.dll*.|
  |ThreadingModel|Definition of the threading model to be used by the class. Its value should be **Apartment**.|

- Registry subkey: `HKEY_CURRENT_USER\SOFTWARE\Classes\Wow6432Node\CLSID\{19A6E644-14E6-4A60-B8D7-DD20610A871D}\ProgID`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|ProgID together with the version of the class. Its value should be **TeamsAddin.FastConnect.1**.|

- Registry subkey: `HKEY_CURRENT_USER\SOFTWARE\Classes\Wow6432Node\CLSID\{19A6E644-14E6-4A60-B8D7-DD20610A871D}\VersionIndependentProgID`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|ProgId of the class without version information. Its value should be **TeamsAddin.FastConnect**.|

- Registry subkey: `HKEY_CURRENT_USER\SOFTWARE\Classes\Wow6432Node\CLSID\{19A6E644-14E6-4A60-B8D7-DD20610A871D}\TypeLib`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|Class ID of the type lib that's associated with this class. Its value should be **{C0529B10-073A-4754-9BB0-72325D80D122}**.|

- Registry subkey: `HKEY_CURRENT_USER\SOFTWARE\Classes\Wow6432Node\CLSID\{19A6E644-14E6-4A60-B8D7-DD20610A871D}\Version`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|Version of the class to be used. Its value should be **1.0**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.Connect.1`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **Connect Class**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.Connect.1\CLSID`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **{CB965DF1-B8EA-49C7-BDAD-5457FDC1BF92}**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.Connect`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **Connect Class**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.Connect\CurVer`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **TeamsAddin.Connect.1**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.FastConnect.1`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **FastConnect Class**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.FastConnect.1\CLSID`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **{19A6E644-14E6-4A60-B8D7-DD20610A871D}**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.FastConnect`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **FastConnect Class**.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.FastConnect\CurVer`

  |Registry entry name|Description|
  |---------|---------|
  |(Default)|The default value should be **TeamsAddin.FastConnect.1**.|
  |Description|Microsoft Teams Meeting Add-in for Microsoft Office|
  |FriendlyName|Microsoft Teams Meeting Add-in for Microsoft Office|
