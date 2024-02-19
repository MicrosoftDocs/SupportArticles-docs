---
title: Active and retired troubleshooters for Windows 10 and Windows 11
description: Introduce active and retired troubleshooters for Windows 10 and Windows 11.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, fangmikko
ms.custom: sap:windows-troubleshooters, csstroubleshoot
---
# Active and retired troubleshooters for Windows 10 and Windows 11

This article provides a list of active and retired troubleshooters for Windows 10 and Windows 11, including a description of what the troubleshooter does, the problem that it addresses, and which devices it applies to. To learn more about troubleshooters, see [keep your device running smoothly with recommended troubleshooting](https://support.microsoft.com/help/4487232/).

_Applies to:_ &nbsp; Windows 10, Windows 11

## ELAN fingerprint driver troubleshooter for devices upgrading from Windows 10 to Windows 11

The text displayed in **Settings**:  
The troubleshooter performs the `sfc /scannow` command. This command repairs the corrupted *onnxruntime.dll* file to match the build version of Windows the device is currently running.

### Description

Some user machines that have upgraded from Windows 10 and are now running Windows 11, version 21H2 (OS build 22000) or later, which have a fingerprint sensor with certain ELAN fingerprint drivers, could encounter a failure or crash when using applications that rely on related DLLs.

This troubleshooter runs automatically on devices to meet the following criteria:

- Runs Windows desktop operating system.
- Runs Windows 11, version 21H2 (OS build 22000) or later.
- The *onnxruntime.dll* file has either no version number or a version number of 0.0.0.0. 
- The ELAN fingerprint driver version is 3.10.11001.10606, 3.10.11001.10502, or 3.10.11001.10801.

|Activation date|Retirement date|More information|
|---|---|---|
|3/15/2023||[https://aka.ms/AAhdpvb](https://aka.ms/AAhdpvb)|


## Access work or school troubleshooter for restoring access to M365 desktop applications

Th text displayed in **Settings**:  
The troubleshooter checks if the `Microsoft.AAD.BrokerPlugin` package is missing. If so, it installs the package.

### Description

Some users are unable to sign-in to Microsoft 365 desktop applications. This includes: Teams, Outlook, OneDrive for Business, Excel, PowerPoint, and Word.

This troubleshooter runs automatically on devices to meet the following criteria:

- Runs Windows 10, 20H1
- Enterprise and Pro SKUs of Microsoft 365
- Missing the package `Microsoft.AAD.BrokerPlugin`

|Activation date|Retirement date|More information|
|---|---|---|
|8/24/2022||[https://aka.ms/AAhs34y](https://aka.ms/AAhs34y)|

## Windows Update troubleshooter for repairing .NET framework components

The text displayed in **Settings**:  
Automatically repair system files and settings to fix a problem on your device

### Description

Some devices that installed the April 25, 2022, update KB5012643 for Windows 11, version 21H2, are unable to run .NET Framework applications. This troubleshooter repairs the device by restoring the needed .NET Framework components and re-establishes the ability to run .NET Framework applications.

This troubleshooter runs automatically on devices that meet the following criteria:

- Runs Windows 10, version 21H2 and Windows 11, version 21H2
- This issue has been detected

|Activation date|Retirement date|More information|
|---|---|---|
|5/31/2022||[https://go.microsoft.com/fwlink/?linkid=2196115&clcid=0x409](https://go.microsoft.com/fwlink/?linkid=2196115&clcid=0x409)|

## Windows Update troubleshooter for file or metadata corruption

The text displayed in **Settings**:  
Automatically targets the device for an In-Place Upgrade due to recurring installation issues

### Description

Some devices that are running Windows 10, version 1903 and later versions can't install monthly security updates because of file or metadata corruption within the servicing stack. This troubleshooter marks the device in preparation for an In-Place Upgrade.

This troubleshooter runs automatically on devices that meet the following criteria:

- Runs one of these operating systems: Windows 10, versions 1903, Windows 10, version 1909, Windows 10, version 2004 or Windows 10, version 20H2
- Runs a revision below the December 2020 Security Update (12B)
- Failed a Quality Update installation multiple times

|Activation date|Retirement date|More information|
|---|---|---|
|4/19/2021||[aka.ms/IPUTroubleshooter](https://aka.ms/IPUTroubleshooter)|

## Windows Update troubleshooter for repairing system files

The text displayed in **Settings**:  
Automatically repair system files and settings to improve device security

### Description

Some devices running Windows 10, version 1903 or 1909 are not scanning for updates. This troubleshooter resets the update scanning process, which prompts the device to start a new scan.

This troubleshooter runs automatically on devices running Windows 10, version 1903 or 1909 and that have reported the error to the sediment infrastructure.

|Activation date|Retirement date|More information|
|---|---|---|
|4/15/2021|11/2/2021|[https://aka.ms/AAbk72i](https://aka.ms/AAbk72i)|

## Files On-Demand troubleshooter

The text displayed in **Settings**:  
You may have lost access to your Files On-Demand. This troubleshooter restores access or prevents the loss of access from happening in the near future. Important: Please reboot your device once the troubleshooter is finished.

### Description

After updating to Windows 10, version 2004, some older devices or devices that have certain older apps installed that use legacy [file system filter drivers](/windows-hardware/drivers/ifs/about-file-system-filter-drivers) might be unable to connect to OneDrive through the OneDrive app. Affected devices might not be able to download new Files On-Demand content or open previously synced or downloaded files. This troubleshooter mitigates the issue.

Devices that successfully ran the "Hardware and Devices" troubleshooter will be notified and asked to run this troubleshooter.

|Activation date|Retirement date|More information|
|---|---|---|
|6/30/2020|9/30/2020|[https://aka.ms/AA8vtwr](https://aka.ms/AA8vtwr)|

## Hardware and Devices troubleshooter for OneDrive

The text displayed in **Settings**:  
Automatically repair system files and settings to fix a problem on your device.

### Description

After updating to Windows 10, version 2004, some older devices or devices that have certain older apps installed that use legacy [file system filter drivers](/windows-hardware/drivers/ifs/about-file-system-filter-drivers) might be unable to connect to OneDrive through the OneDrive app. Affected devices might not be able to download new Files On-Demand content or open previously synced or downloaded files. This troubleshooter detects the presence of this issue.

This troubleshooter runs automatically on devices that meet the following criteria:

- Runs on Windows 10, version 2004
- Uses a Cloud files filter (OneDrive, iCloud, Workfolders)

|Activation date|Retirement date|More information|
|---|---|---|
|6/30/2020|9/30/2020|[https://aka.ms/AA8vtwr](https://aka.ms/AA8vtwr)|

## Storage Spaces cleanup troubleshooter

The text displayed in **Settings**:  
Automatically restore your previous settings and environment for Storage Spaces.

### Description

Devices that use Parity Storage Spaces might not be able to use or access their Storage Spaces after you update to Windows 10, version 2004 (the May 2020 update) or Windows Server, version 2004. After [KB4568831](https://support.microsoft.com/help/4568831) has been applied to your device, this troubleshooter restores your previous Storage Spaces settings.

This troubleshooter runs automatically on devices that meet the following criteria:

Successfully ran the "Hardware and Devices" or "Storage Spaces" troubleshooter

|Activation date|Retirement date|More information|
|---|---|---|
|7/30/2020|10/30/2020|[https://aka.ms/AA8uojg](https://aka.ms/AA8uojg)|

## Storage space troubleshooter

The text displayed in **Settings**:  
Data corruption was detected on your parity storage space. This troubleshooter takes actions to prevent further corruption. It also restores write access if the space was previously marked read-only. For more information and recommended actions, please see the link below.

### Description

Devices that use Parity Storage Spaces might experience issues when they try to use or access their Storage Spaces after they update to Windows 10, version 2004 (the May 2020 Update) or Windows Server, version 2004. This troubleshooter mitigates the issue for some users and restores read and write access to your Parity Storage Spaces.

This troubleshooter runs automatically on devices that meet the following criteria.

Successfully ran the "Hardware and Devices" or "Storage Spaces" troubleshooter.

|Activation date|Retirement date|More information|
|---|---|---|
|7/2/2020|10/2/2020|[https://aka.ms/AA8uojg](https://aka.ms/AA8uojg)|

## Hardware and Devices troubleshooter for Parity Storage Spaces

The text displayed in **Settings**:  
Automatically change system settings to fix a problem on your device.

### Description

Devices that use Parity Storage Spaces might experience issues when they try to use or access their Storage Spaces after they are updated to Windows 10, version 2004 (the May 2020 Update) or Windows Server, version 2004. This troubleshooter helps prevent issues that affect the data on your Storage Spaces. After the troubleshooter runs, you will not be able to write to your Storage Spaces.

This troubleshooter runs two times on devices that meet the following criteria:

- Runs Windows 10, version 2004
- Uses Storage Spaces

The first time, the troubleshooter runs automatically. The second time, it notifies the user.

|Activation date|Retirement date|More information|
|---|---|---|
|6/26/2020|9/26/2020|[https://aka.ms/AA8uojg](https://aka.ms/AA8uojg)|

## Windows Update troubleshooter for Disk Cleanup

The text displayed in **Settings**:  
Automatically change system settings to fix a problem on your device.

### Description

Some devices might not start if Disk Cleanup runs after you install the Windows version 19041.21 update. This troubleshooter temporarily disables the feature to automatically run Disk Cleanup until devices install the Windows 10, version 19041.84 update.

This troubleshooter automatically runs two times. It runs the first time on all devices on Windows 10, version 19041.21. It then runs again after devices are upgraded to Windows 10, version 19041.84.  
  
|Activation date|Retirement date|More information|
|---|---|---|
|2/7/2020|\-|[https://aka.ms/AA7afc1](https://aka.ms/AA7afc1)|
