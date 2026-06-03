---
title: Fix Black Screen After Running Sysprep as System on Windows 11 or Windows Server 2025
description: Resolve black screen and missing GUI elements after running sysprep as System on Windows 11. Learn workarounds to register missing XAML packages.
ms.date: 05/28/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:windows setup,upgrade and deployment\installing or upgrading windows
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Fix black screen after running Sysprep as system on Windows 11

## Summary

This article applies to Windows 11 version 24H2 and 25H2, and Windows Server 2025. It describes a black screen problem or missing graphical user interface (GUI) elements in modern apps after running the System Preparation Tool (`sysprep.exe`) under the Local System account context. You often see the problem immediately after sign-in or after applying Windows updates.

## Symptoms

You might encounter one or more of the following symptoms after deploying a Windows image and running `sysprep.exe` under the Local System account:

*   Black screen appears when signing in due to `explorer.exe` crashing.
*   Certain GUI elements in modern apps, such as the Settings app, fail to render.
*   The Start menu or other XAML-based apps close unexpectedly or fail to start.

These symptoms can occur immediately after first sign-in or later following Windows updates.

For documented conditions, see [Sysprep (System Preparation) Overview | Microsoft Learn](/windows-hardware/manufacture/desktop/sysprep--system-preparation--overview?view=windows-11).


## Cause: Running Sysprep as system

Running `sysprep.exe` under the Local System account isn't supported. This process skips AppX registration for certain XAML packages, causing failures in apps that depend on them, such as `explorer.exe` and the Settings app. Future Windows updates that modify these packages can also trigger the problem.

Older Windows versions aren't affected because they don't rely on these XAML AppX packages. Known cases include third-party automation solutions, such as VMware/Broadcom automation, that run Sysprep as system.

If you don't run Sysprep as system but the symptoms occur, other causes might be responsible. For additional causes and solutions, see [KB5072911](https://support.microsoft.com/topic/kb5072911-explorer-the-start-menu-and-other-xaml-dependent-apps-might-not-start-or-close-unexpectedly-on-some-enterprise-devices-d2d30684-4e2b-47f5-9899-a00a8e0acb09).



## Solution 1: Manually register missing packages

IT administrators can manually register the missing packages in the user session and restart `SiHost` so Immersive Shell and related components recognize them. Run the following PowerShell commands:

Run the following PowerShell commands:

```powershell  
Add-AppxPackage -Register -Path "C:\\Windows\\SystemApps\\MicrosoftWindows.Client.CBS\_cw5n1h2txyewy\\appxmanifest.xml" -DisableDevelopmentMode
```

```powershell  
Add-AppxPackage -Register -Path "C:\\Windows\\SystemApps\\Microsoft.UI.Xaml.CBS\_8wekyb3d8bbwe\\appxmanifest.xml" -DisableDevelopmentMode
```

```powershell  

Add-AppxPackage -Register -Path "C:\\Windows\\SystemApps\\MicrosoftWindows.Client.Core\_cw5n1h2txyewy\\appxmanifest.xml" -DisableDevelopmentMode
```

After running these commands, restart `SiHost` or restart the device.


## Solution 2: Logon script for non-persistent OS installations

For non-persistent environments, use a logon script to register the packages before `explorer.exe` launches. This approach ensures that the required packages are provisioned before the desktop loads.

Create a batch file wrapper with the following commands:


### Run the sample PowerShell script on non-persistent OS installations

For non-persistent environments, a logon script approach remains the best option for IT administrators. Create a batch file wrapper to execute synchronously before Explorer launches.

> [!NOTE]
> Deploy this script to run synchronously during user logon, blocking `explorer.exe` from starting until package registration completes.

```powershell
@echo off 
REM Register MicrosoftWindows.Client.CBS 

powershell.exe -ExecutionPolicy Bypass -Command "Add-AppxPackage -Register -Path 'C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\appxmanifest.xml' -DisableDevelopmentMode" 

REM Register Microsoft.UI.Xaml.CBS 

powershell.exe -ExecutionPolicy Bypass -Command "Add-AppxPackage -Register -Path 'C:\Windows\SystemApps\Microsoft.UI.Xaml.CBS_8wekyb3d8bbwe\appxmanifest.xml' -DisableDevelopmentMode" 

REM Register MicrosoftWindows.Client.Core 

powershell.exe -ExecutionPolicy Bypass -Command "Add-AppxPackage -Register -Path 'C:\Windows\SystemApps\MicrosoftWindows.Client.Core_cw5n1h2txyewy\appxmanifest.xml' -DisableDevelopmentMode" 
```

## Determine the cause of the black screen problem

- If you use a third-party product that runs `sysprep.exe` as System, contact the vendor to adjust their process. 

- If Sysprep isn't running as System and symptoms persist, see [KB5072911](https://support.microsoft.com/topic/kb5072911-explorer-the-start-menu-and-other-xaml-dependent-apps-might-not-start-or-close-unexpectedly-on-some-enterprise-devices-d2d30684-4e2b-47f5-9899-a00a8e0acb09) for other possible causes and solutions.
