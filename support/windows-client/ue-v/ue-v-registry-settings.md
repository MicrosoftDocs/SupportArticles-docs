---
title: UE-V registry settings
description: Describes UE-V registry settings.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jeffpatt
ms.custom: sap:user-experience-virtualization-ue-v, csstroubleshoot
---
# User Experience Virtualization (UE-V) registry settings

This article describes UE-V registry settings.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2770042

## Summary

Settings defined via group policy will take precedence over settings defined in the locations of this table. Group policy-defined settings are stored at:

- `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\UEV\Agent\Configuration`
- `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\UEV\Agent\Configuration\Applications`
- `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\UEV\Agent\Configuration\WindowsSettings`
- `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\UEV\Agent\Configuration\CustomerExperienceImprovementProgram`
- `HKEY_LOCAL_MACHINE \Software\Policies\Microsoft\UEV\Management\CustomerExperienceImprovementProgram`
- `HKEY_CURRENT_USER\Software\Policies\Microsoft\UEV\Agent\Configuration`
- `HKEY_CURRENT_USER\Software\Policies\Microsoft\UEV\Agent\Configuration\Applications`
- `HKEY_CURRENT_USER\Software\Policies\Microsoft\UEV\Agent\Configuration\WindowsSettings`

Order of precedence for UE-V settings:

1. User-targeted settings managed by group policy. These configuration settings are stored in the registry key by group policy under:

    - `HKEY_CURRENT_USER\Software\Policies\Microsoft\Uev\Agent\Configuration`
    - `HKEY_CURRENT_USER\Software\Policies\Microsoft\Uev\Management`
2. Computer-targeted settings managed by group policy. These configuration settings are stored in the registry key by group policy under:

    `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Uev\Agent\Configuration`
3. Configuration settings defined by the current user using PowerShell or WMI. These configuration settings are stored by the UE-V agent under:

    `HKEY_CURRENT_USER\Software\Microsoft\Uev\Agent\Configuration`
4. Configuration settings defined for the computer using PowerShell or WMI. These configuration settings are stored by the UE-V agent under:

    `HKEY_LOCAL_MACHINE\Software\Microsoft\Uev\Agent\Configuration`

## UE-V registry settings

The following table lists the registry settings that are used by the Microsoft User Experience Virtualization (UE-V) agent.

|Setting Name|Setting Description|Registry Location|Registry Key Path|Registry Value name|Type|Value Options|Default Value|
|---|---|---|---|---|---|---|---|
|Use User Experience Virtualization (UE-V)|Enables or disables User Experience Virtualization (UE-V) for applications and Windows settings.|`HKEY_LOCAL_MACHINE` and `HKEY_CURRENT_USER`|`\Software\Microsoft\UEV\Agent\Configuration`|SyncEnabled|REG_DWORD|Boolean: True, False<br/><br/>0 (False)<br/><br/>1 (True)|True|
|Settings storage path|Configures where the user settings will be stored.|`HKEY_LOCAL_MACHINE` and `HKEY_CURRENT_USER`|`\Software\Microsoft\UEV\Agent\Configuration`|SettingsStoragePath|REG_EXPAND_SZ|(UNC) path and variables<br/><br/>Example: \\\\Server\\SettingsShare\\%username%|Not Specified|
|Settings template catalog path|Configures where custom settings location templates are stored.|`HKEY_LOCAL_MACHINE`|`\Software\Microsoft\UEV\Agent\Configuration`|SettingsTemplateCatalogPath|REG_EXPAND_SZ| (UNC or local) path with or without environment variables<br/><br/>Example: \\\\Server\\TemplateShare or a folder location on the computer.|Not Specified|
|Override  Microsoft Templates|Configures whether the catalog is used to replace the default Microsoft templates installed with the UE-V agent. This setting is only applicable when a settings template catalog path is set.|`HKEY_LOCAL_MACHINE`|`\Software\Microsoft\UEV\Agent\Configuration`|OverrideMSTemplates|REG_DWORD|Boolean: True, False<br/><br/>0 (False)<br/><br/>1 (True)<br/>|False|
|Specify the Synchronization Method|Configures whether the agent uses the Windows offline files feature to synchronize settings. None is available for computers that are always online and can tolerate not synchronizing during network outages.|`HKEY_LOCAL_MACHINE` and `HKEY_CURRENT_USER`|`\Software\Microsoft\UEV\Agent\Configuration`|SyncMethod|REG-SZ|OfflineFiles, None|OfflineFiles|
|Enable Notification|Enables a notification message the import of application settings is delayed. This setting only applies with SyncMethod = None.|`HKEY_LOCAL_MACHINE` and `HKEY_CURRENT_USER`|`\Software\Microsoft\UEV\Agent\Configuration`|SettingsImportNotifyEnabled|REG_DWORD|Boolean: True, False<br/><br/>0 (False)<br/><br/>1 (True)<br/>|False|
|Notification Delay|The notification delay option specifies the delay before the notification appears. This setting only applies with SettingsImportNotifyEnabled = TRUE.|`HKEY_LOCAL_MACHINE` and `HKEY_CURRENT_USER`|`\Software\Microsoft\UEV\Agent\Configuration`|SettingsImportNotifyDelayInSeconds|REG_DWORD|Delay in seconds|10 Seconds|
|Settings Package Prefetch|Specifies the application and Windows settings the UE-V agent pre-caches before the applications are launched. If Windows Settings are included in the prefetch list, the settings are available for future logins.|`HKEY_LOCAL_MACHINE`|`\Software\Microsoft\UEV\Agent\Configuration`|PrefetchPackageList|REG_MULTI_SZ|Settings Package name without file extension for which settings packages the agent should prefetch|DesktopSettings|
|Synchronization timeout|Configures the number of milliseconds that the computer waits to retrieve settings before timeout.|`HKEY_LOCAL_MACHINE` and `HKEY_CURRENT_USER`|`\Software\Microsoft\UEV\Agent\Configuration`|SyncTimeoutInMilliseconds|REG_DWORD|Specify the preferred synchronization timeout in milliseconds.|2000 milliseconds (2 seconds)|
|Package size warning threshold|Configures the UE-V agent to report when a settings package file size reaches a defined threshold.|`HKEY_LOCAL_MACHINE` and `HKEY_CURRENT_USER`|`\Software\Microsoft\UEV\Agent\Configuration`|MaxPackageFileSizeInBytes|REG_DWORD|Specify the preferred threshold for settings package sizes in kilobytes|500 KB|
|Offline Threshold|Defines the offline threshold in days after which the UE-V agent will not export settings when it comes back online. See More Information section for additional info on this setting.|`HKEY_LOCAL_MACHINE` and `HKEY_CURRENT_USER`|`\Software\Microsoft\UEV\Agent\Configuration`|OfflineThreshold|REG_DWORD|Specify the desired threshold in days.|30 days|
|Preventing Overlapping Synchronization for Applications|Prevents the import of settings packages if an instance of the application is already open. This setting also prevents export at application shutdown if another instance of the application is open.|`HKEY_LOCAL_MACHINE` and `HKEY_CURRENT_USER`|`\Software\Microsoft\UEV\Agent\Configuration`|PreventOverlappingSynchronization|REG_DWORD|Boolean: True, False<br/><br/>0 (False)<br/><br/>1 (True)<br/>|True|
|Customer Experience Improvement Program|Specifies the setting for participation in the Customer Experience Improvement program. If set to true, then installer information is uploaded to the Microsoft Customer Experience improvement site.  If set to false, then no information is uploaded|`HKEY_LOCAL_MACHINE`|Agent: `HKEY_LOCAL_MACHINE\Software\Microsoft\UEV\Agent\Configuration`<br/><br/>Generator: `HKEY_LOCAL_MACHINE\Software\ Microsoft\UEV\Management`|CustomerExperienceImprovementProgram|REG_DWORD|Boolean: True, False<br/><br/>0 (False)<br/><br/>1 (True)<br/>|False|
|Hide Settings Package directory|Sets the visibility of the SettingsPackages folder created on the settings storage location. By default the folder is hidden and System. This setting must be defined before the folders are created.|`HKEY_LOCAL_MACHINE` and `HKEY_CURRENT_USER`|`\Software\Microsoft\UEV\Agent\Configuration`|HideSettingsPackagesFolder|REG_DWORD|Boolean: True, False<br/><br/>0 (False)<br/><br/>1 (True)<br/>|True|
|Roaming Windows settings|Configures the roaming of Windows settings.|`HKEY_LOCAL_MACHINE`|`\Software\Microsoft\UEV\Agent\Configuration\WindowsSettings`|ID of the settings location template|REG_DWORD|Boolean: True, False<br/><br/>0 (False)<br/><br/>1 (True)<br/>|DesktopSettings=False<br/><br/>EaseofAccess=False<br/><br/>(all other Windows settings templates default to true)|
|Roaming Application settings|Configures the roaming of user settings of applications.|`HKEY_LOCAL_MACHINE`|`\Software\Microsoft\UEV\Agent\Configuration\Applications`|ID of the settings location template|REG_DWORD|Boolean: True, False<br/><br/>0 (False)<br/><br/>1 (True)<br/>|Not Specified (all applications default to true)|
|Active Directory Settings Storage Path|Records the Active Directory Home Directory. This setting should not be manually edited.|`HKEY_CURRENT_USER`|`\Software\Microsoft\UEV\Agent\Configuration`|ADSettingsStoragePath|REG_EXPAND_SZ|UE-V Agent defined| |
|Install Time Stamp|Records installation data. This setting should not be manually edited.|`HKEY_LOCAL_MACHINE`|`\Software\Microsoft\UEV\Agent\Configuration`|InstallTimestamp|REG_QWORD|UE-V Agent defined| |
|Excluded FileTypes|Identifies file types that will be excluded from settings synchronization|`HKEY_LOCAL_MACHINE`|`\Software\Microsoft\UEV\Agent\Configuration`|ExcludedFileTypes|REG_MULTI_SZ|List of file extensions| |
|Logoff Sync timeout value|Configures the number of milliseconds that the computer waits to sync settings before timeout|`HKEY_LOCAL_MACHINE` and `HKEY_CURRENT_USER`|`\Software\Microsoft\UEV\Agent\Configuration`|LogOffWaitInterval|REG_DWORD| Specify the preferred logoff sync timeout in milliseconds|2000 milliseconds (2 seconds)|

## More information

Offline Threshold registry setting

This registry setting allows you to modify the offline threshold for the UE-V agent. By default the UE-V agent has an offline threshold of 30 days. If the computer has been offline for 30 consecutive days the UE-V agent will not synchronize settings changes that were made while offline to the settings storage location when the computer comes back on to the network. Instead the UE-V agent will import updated settings packages from the settings storage location first and then return to default synchronization behavior.
