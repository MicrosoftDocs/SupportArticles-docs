---
title: System Center Service Manager build versions
description: Lists the update rollups and build versions of System Center 2016 Service Manager and System Center 2012 R2 Service Manager.
ms.date: 04/08/2024
ms.reviewer: luche, khusmeno
---
# System Center Service Manager build versions

This article lists the update rollups and build versions of Microsoft System Center 2016 Service Manager and Microsoft System Center 2012 R2 Service Manager.

_Original product version:_ &nbsp; System Center 2016 Service Manager, System Center 2012 R2 Service Manager  
_Original KB number:_ &nbsp; 4043302

## System Center 2016 Service Manager

[System Center 2016 Service Manager build versions](/system-center/scsm/release-build-versions)

For in-place upgrade to self-service portal in System Center 2016 Service Manager, download the [Service Manager 2016 Self-Service Portal upgrade fix](https://www.microsoft.com/download/details.aspx?id=54060).

## System Center 2012 R2 Service Manager

System Center 2012 R2 Service Manager update rollups are cumulative. The latest update contains the fixes from all previously released cumulative updates (except [Update Rollup 8](https://support.microsoft.com/help/3124091), which contains the new HTML-based self-service portal and requires separate installation).

|Build version|Update article|Description|
|---|---|---|
|7.5.3079.0|Not available|RTM|
|7.5.3079.61| [2904710](https://support.microsoft.com/help/2904710)|Update Rollup 2 for System Center 2012 R2 Service Manager|
|7.5.3079.148| [2962041](https://support.microsoft.com/help/2962041)|Update Rollup 3 for System Center 2012 R2 Service Manager|
|7.5.3079.236| [2989601](https://support.microsoft.com/help/2989601)|Update Rollup 4 for System Center 2012 R2 Service Manager|
|7.5.3079.315| [3009517](https://support.microsoft.com/help/3009517)|Update Rollup 5 for System Center 2012 R2 Service Manager|
|7.5.3079.367| [3039363](https://support.microsoft.com/help/3039363)|Update Rollup 6 for System Center 2012 R2 Service Manager <br/><br/>**Note** You must install SCSM2012R2_OD_KB3064088_AMD64_7.5.3079.402.exe on your primary management server after you deploy this update.|
|7.5.3079.402| [3039363](https://support.microsoft.com/help/3039363)|Hotfix for Update Rollup 6 for System Center 2012 R2 Service Manager <br/><br/> **Note** Don't install if you didn't install version 7.5.3079.367.|
|7.5.3079.442| [3063263](https://support.microsoft.com/help/3063263)|Update Rollup 7 for System Center 2012 R2 Service Manager <br/><br/> **Note** You must install SCSM2012R2_OD_KB3099983_AMD64_7.5.3079.504.exe on your primary management server after you deploy this update.|
|7.5.3079.504| [3063263](https://support.microsoft.com/help/3063263)|Hotfix for Update Rollup 7 for System Center 2012 R2 Service Manager <br/><br/> **Note** Don't install if you didn't install version 7.5.3079.442.|
|7.5.3079.571| [3129780](https://support.microsoft.com/help/3129780)|Update Rollup 9 for System Center 2012 R2 Service Manager <br/><br/> **Note** This version was withdrawn and replaced by 7.5.3079.607.|
|7.5.3079.601| [3129780](https://support.microsoft.com/help/3129780)|Rerelease of Update Rollup 9 for System Center 2012 R2 Service Manager <br/><br/> **Note** This version was withdrawn and replaced by 7.5.3079.607.|
|7.5.3079.607| [3129780](https://support.microsoft.com/help/3129780)|Supported release of Update Rollup 9 for System Center 2012 R2 Service Manager|
  
## System Center 2012 R2 Service Manager self-service portal

|Build version|Update article|Description|
|---|---|---|
|7.5.3079.507| [3096383](https://support.microsoft.com/help/3096383)|Update Rollup 8 for System Center 2012 R2 Service Manager|
|7.5.3079.523| [3124091](https://support.microsoft.com/help/3124091)|Update 1 for System Center 2012 R2 Service Manager Self-Service Portal|
|7.5.3079.548| [3134286](https://support.microsoft.com/help/3134286)|Update 2 for System Center 2012 R2 Service Manager Self-Service Portal|
|7.5.3079.572| [3144617](https://support.microsoft.com/help/3144617)|Update 3 for System Center 2012 R2 Service Manager Self-Service Portal|
  
## Determine the build version of a Service Manager update

To determine the build version of an installed Service Manager update, use one of the following methods:

- Method 1: Use Control Panel

  1. Open **Control Panel**, go to **Programs and Features**, and then select **View installed updates**.
  2. In the search box, type **System Center 2016 Service Manager** or **System Center 2012 R2 Service Manager**.

- Method 2: Use PowerShell

  1. Open a PowerShell command prompt window.
  2. Type the following command:

     ```powershell
     GP HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*  | ?{$_.DisplayName -like "*System Center*"} | FT DisplayName, DisplayVersion, InstallDate
     ```
