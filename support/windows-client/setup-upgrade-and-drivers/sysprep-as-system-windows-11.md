---
title: Fix black screen and missing GUI elements after running sysprep as System in Windows 11
description: Users may experience a black screen (explorer.exe crashes,) or certain GUI elements in the modern Settings App may fail to render.
ms.date: 05/27/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:windows setup,upgrade and deployment\installing or upgrading windows
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Fix black screen and missing GUI elements after running sysprep as System in Windows 11

Users may experience a black screen (explorer.exe crashes,) or certain GUI elements in the modern Settings App may fail to render

Applies to: Windows 11 24H2, Windows 11 25H2, Windows Server 2025

When a Windows image has been deployed using sysprep.exe (System Preparation Tool), and sysprep.exe was run under the context of the Local System (SYSTEM) account, the user may experience a black screen when they log on due to Explorer.exe crashing. Alternatively, the user may experience certain GUI elements not rendering in modern apps, such as the Settings App (the modern replacement for the Control Panel.)

Running sysprep.exe under the context of the SYSTEM account is not currently supported and may lead to these symptoms. This is documented here: [Sysprep (System Preparation) Overview | Microsoft Learn](https://learn.microsoft.com/windows-hardware/manufacture/desktop/sysprep--system-preparation--overview?view=windows-11)

> "Sysprep cannot be run under the context of a System account. Running Sysprep under the context of System account by using Task Scheduler or PSExec, for example, is not supported."

These symptoms may manifest immediately when logging onto the system for the first time after sysprep was run as System. The symptoms can also emerge at a later date after any Windows Updates have been applied. 

This occurs because of an AppX registration of certain XAML packages that does not occur when sysprep is run as System. Therefore, any application on the system that depends on these XAML AppX packages will fail. (Explorer.exe, Settings App, etc.) As a consequence of this, any future Windows Update that makes updates to these XAML AppX packages and requires making modifications to these XAML packages may cause the issue to surface.

This was not an issue in older versions of Windows because older versions of Windows did not depend on these XAML AppX packages. But the versions of Windows listed in the "Applies to" section above, do.

Certain third-party products such as VMware/Broadcom automation, have been known to run sysprep as System and cause this issue.

Running sysprep as System is not the only possible reason why the user might experience a black screen on logon or have the problem of missing AppX XAML packages. But it is one of the most commonly observed reasons.

There is another Microsoft KB that discusses some other possible reasons why you might be seeing these same symptoms: [KB5072911: Explorer, the Start menu, and other XAML-dependent apps might not start or close unexpectedly on some enterprise devices - Microsoft Support](https://support.microsoft.com/en-us/topic/kb5072911-explorer-the-start-menu-and-other-xaml-dependent-apps-might-not-start-or-close-unexpectedly-on-some-enterprise-devices-d2d30684-4e2b-47f5-9899-a00a8e0acb09)

In both instances, the symptoms and the workaround are the same:

## Workarounds

Manual registration of the missing packages 

IT administrators managing enterprise or virtualized environments should register the missing packages in the user session and restart SiHost to allow Immersive Shell and related components to pick them up. To do this, run the following commands to register each of the missing packages:

```
Add-AppxPackage -Register -Path "C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\appxmanifest.xml" -DisableDevelopmentMode 

Add-AppxPackage -Register -Path "C:\Windows\SystemApps\Microsoft.UI.Xaml.CBS_8wekyb3d8bbwe\appxmanifest.xml" -DisableDevelopmentMode 

Add-AppxPackage -Register -Path "C:\Windows\SystemApps\MicrosoftWindows.Client.Core_cw5n1h2txyewy\appxmanifest.xml" -DisableDevelopmentMode 
```

Run this sample PowerShell script on non-persistent OS installations

For non-persistent environments, a logon script approach remains the best option for IT administrators. Create a batch file wrapper to execute synchronously before Explorer launches.

Note This approach ensures the script runs synchronously, effectively blocking explorer.exe from launching prematurely until the required packages are fully provisioned.

```
@echo off 
REM Register MicrosoftWindows.Client.CBS 

powershell.exe -ExecutionPolicy Bypass -Command "Add-AppxPackage -Register -Path 'C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\appxmanifest.xml' -DisableDevelopmentMode" 

REM Register Microsoft.UI.Xaml.CBS 

powershell.exe -ExecutionPolicy Bypass -Command "Add-AppxPackage -Register -Path 'C:\Windows\SystemApps\Microsoft.UI.Xaml.CBS_8wekyb3d8bbwe\appxmanifest.xml' -DisableDevelopmentMode" 

REM Register MicrosoftWindows.Client.Core 

powershell.exe -ExecutionPolicy Bypass -Command "Add-AppxPackage -Register -Path 'C:\Windows\SystemApps\MicrosoftWindows.Client.Core_cw5n1h2txyewy\appxmanifest.xml' -DisableDevelopmentMode" 
```


If you are using a third-party product that runs sysprep.exe as System, it is incumbent upon that third-party product to adjust their behavior so that it no longer runs sysprep.exe as System.

If you are confident sysprep is not being run as System in your environment, but you are still experiencing these symptoms, please see [KB5072911: Explorer, the Start menu, and other XAML-dependent apps might not start or close unexpectedly on some enterprise devices - Microsoft Support](https://support.microsoft.com/en-us/topic/kb5072911-explorer-the-start-menu-and-other-xaml-dependent-apps-might-not-start-or-close-unexpectedly-on-some-enterprise-devices-d2d30684-4e2b-47f5-9899-a00a8e0acb09) for other possible causes and resolutions.
