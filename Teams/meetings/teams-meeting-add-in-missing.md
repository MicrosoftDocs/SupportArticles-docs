---
title: Teams meeting add-in missing from Outlook and new Teams
description: Resolves an issue in which the Teams meeting add-in doesn't load in new Teams and is removed from Microsoft Outlook.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Meetings\Meetings Other
  - CI 191699
  - CI 193233
  - CSSTroubleshoot
ms.reviewer: mfoland; shmurth; wayvad; ktakanishi
appliesto: 
  - New Microsoft Teams
search.appverid: 
  - MET150
ms.date: 03/26/2025
---
# Teams meeting add-in missing from Outlook and new Teams

## Symptoms

Either you or your organization uninstalls classic Microsoft Teams and then upgrades to new Teams. You uninstall the program by using one of the following methods:

- Any of the available options to [uninstall programs](https://support.microsoft.com/windows/4b55f974-2cc6-2d2b-d092-5905080eaf98) in Windows 11 and Windows 10.
- An administrative policy that triggers the removal of classic Teams. For example, organizations might choose to remove older versions of classic Teams from user computers to make sure that most users are on the same version.
- The "new Teams only" policy setting to upgrade to new Teams. When a user is assigned this Teams upgrade policy, the new Teams app removes the classic Teams app from the user's computer after a set time.

After the upgrade, the Teams meeting add-in doesn't load in new Teams. Additionally, the add-in is removed from Microsoft Outlook.

## Cause

When a version of classic Teams is uninstalled, the Teams meeting add-in is also uninstalled. The uninstallation process removes the registry keys that are shared across all versions of the Teams meeting add-in. Therefore, when new Teams and Outlook start, the computer doesn't find the installed add-in to load.

## Resolution

For non-VDI environments, follow these steps to reinstall the Teams meeting add-in:

1. Quit Teams.
1. Close the Outlook app.
1. Check the version of the Teams meeting add-in.

   To check the Teams meeting add-in version, select **Start** > **Settings** > **Apps** > **Installed apps**, and then enter *Teams Meeting Add-in* in the search box.

     - If no result is found, or the version of **Microsoft Teams Meeting Add-in for Microsoft Office** starts with *1.23*, follow these steps:
       
         1. Download the [UninstallOldTMA.ps1](https://aka.ms/TMARepair) PowerShell script.
         1. Open an elevated PowerShell window. To open the window, enter *powershell* in the search box. In the results, right-click **Windows PowerShell**, and then select **Run as administrator**.
         1. At the elevated PowerShell prompt, run the UninstallOldTMA.ps1 script to uninstall the Teams meeting add-in.
     - If the version of **Microsoft Teams Meeting Add-in for Microsoft Office** doesn't start with *1.23*, follow these steps:

         1. Download the [UninstallTMA.ps1](https://aka.ms/AAsllbb) PowerShell script.
         1. Open a PowerShell window. To open the window, enter *powershell* in the search box. In the results, select **Windows PowerShell**.
         1. At the PowerShell prompt, run the UninstallTMA.ps1 script to uninstall the Teams meeting add-in. 
1. Start the new Teams app.
1. Wait until the Teams meeting add-in appears in the list in **Start** > **Settings** > **Apps** > **Installed apps**.
1. Restart the Outlook app.

## More information

The following sections list registry entries for different versions of the Outlook app. These entries are necessary for the Teams meeting add-in to load.

### Outlook 64-bit

- Registry subkey: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\office\Outlook\Addins\TeamsAddin.FastConnect`

  The `TeamsAddin.FastConnect` key provides Outlook with the ProgID value of the add-in to load. If this value is missing, Outlook doesn't search for the add-in.

  |Registry entry name|Description|
  |---------|---------|
  |FriendlyName|Display name of the add-in in Outlook.|
  |Description|Description of the add-in.|
  |LoadBehavior|Determines when Outlook should try to load the add-in. The default value is "3" for this entry. This value tells Outlook to load the add-in at startup.|

- Registry subkey: `HKEY_CLASSES_ROOT\TeamsAddin.FastConnect\CurVer`

  The `CurVer` key provides details about the ProgID value so that programs can find the correct libraries.

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

  This key provides Outlook with the ProgID value of the add-in to load. If the value is missing, Outlook doesn't try to look for the add-in.

  |Registry entry name|Description|
  |---------|---------|
  |FriendlyName|Display name of the add-in in Outlook.|
  |Description|Description of the add-in.|
  |LoadBehavior|Determines when Outlook should try to load the add-in. The default value is "3" for this entry. This value tells Outlook to load the add-in at startup.|

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
