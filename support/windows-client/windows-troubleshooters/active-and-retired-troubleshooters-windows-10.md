---
title: Active and retired troubleshooters for Windows 10
description: Introduce active and retired troubleshooters for Windows 10.
ms.date: 10/16/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Windows Troubleshooters
ms.technology: windows-troubleshooters
---
# Active and retired troubleshooters for Windows 10

This article provides a list of active and retired troubleshooters for Windows 10, including a description of what the troubleshooter does, the problem that it addresses, and which devices it applies to. To learn more about troubleshooters, see [keep your device running smoothly with recommended troubleshooting](https://support.microsoft.com/help/4487232/).

## Files On-Demand troubleshooter

Text displayed in Settings:  
You may have lost access to your Files On-Demand. This troubleshooter restores access or prevents the loss of access from happening in the near future. Important: Please reboot your device once the troubleshooter is finished.

### Description

After updating to Windows 10, version 2004, some older devices or devices that have certain older apps installed that use legacy [file system filter drivers](/windows-hardware/drivers/ifs/about-file-system-filter-drivers) might be unable to connect to OneDrive through the OneDrive app. Affected devices might not be able to download new Files On-Demand content or open previously synced or downloaded files. This troubleshooter mitigates the issue.

Devices that successfully ran the "Hardware and Devices" troubleshooter will be notified and asked to run this troubleshooter.

|Activation date|Retirement date|More information|
|---|---|---|
|6/30/2020|9/30/2020|[https://aka.ms/AA8vtwr](https://aka.ms/AA8vtwr)|

## Hardware and Devices troubleshooter

Text displayed in Settings:  
Automatically repair system files and settings to fix a problem on your device.

### Description

After updating to Windows 10, version 2004, some older devices or devices that have certain older apps installed that use legacy [file system filter drivers](/windows-hardware/drivers/ifs/about-file-system-filter-drivers) might be unable to connect to OneDrive through the OneDrive app. Affected devices might not be able to download new Files On-Demand content or open previously synced or downloaded files. This troubleshooter detects the presence of this issue.

This troubleshooter runs automatically on devices that meet the following criteria:

- Runs on Windows 10, version 2004
- Uses a Cloud files filter (OneDrive, iCloud, Workfolders)

|Activation date|Retirement date|More information|
|---|---|---|
|6/30/2020|9/30/2020|[https://aka.ms/AA8vtwr](https://aka.ms/AA8vtwr)|

## Storage Spaces cleanup troubleshooter

Text displayed in Settings:  
Automatically restore your previous settings and environment for Storage Spaces.

### Description

Devices that use Parity Storage Spaces might not be able to use or access their Storage Spaces after you update to Windows 10, version 2004 (the May 2020 update) or Windows Server, version 2004. After [KB4568831](https://support.microsoft.com/help/4568831) has been applied to your device, this troubleshooter restores your previous Storage Spaces settings.

This troubleshooter runs automatically on devices that meet the following criteria:

Successfully ran the "Hardware and Devices" or "Storage Spaces" troubleshooter


|Activation date|Retirement date|More information|
|---|---|---|
|7/30/2020|10/30/2020|[https://aka.ms/AA8uojg](https://aka.ms/AA8uojg)|

## Storage space troubleshooter

Text displayed in Settings:  
Data corruption was detected on your parity storage space. This troubleshooter takes actions to prevent further corruption. It also restores write access if the space was previously marked read-only. For more information and recommended actions, please see the link below.

### Description

Devices that use Parity Storage Spaces might experience issues when they try to use or access their Storage Spaces after they update to Windows 10, version 2004 (the May 2020 Update) or Windows Server, version 2004. This troubleshooter mitigates the issue for some users and restores read and write access to your Parity Storage Spaces.

This troubleshooter runs automatically on devices that meet the following criteria.

Successfully ran the "Hardware and Devices" or "Storage Spaces" troubleshooter.

|Activation date|Retirement date|More information|
|---|---|---|
|7/2/2020|10/2/2020|[https://aka.ms/AA8uojg](https://aka.ms/AA8uojg)|

## Hardware and Devices troubleshooter

Text displayed in Settings:  
Automatically change system settings to fix a problem on your device.

### Description

Devices that use Parity Storage Spaces might experience issues when they try to use or access their Storage Spaces after they are updated to Windows 10, version 2004 (the May 2020 Update) or Windows Server, version 2004. This troubleshooter helps prevent issues that affect the data on your Storage Spaces. After the troubleshooter runs, you will not be able to write to your Storage Spaces.

This troubleshooter runs two times on devices that meet the following criteria:

- Runs Windows 10, version 2004
- Uses Storage Spaces

The first time, the troubleshooter runs automatically. The second time, it notifies the user.

|Activation date|Retirement date|More information|
|---|---|---|
|6/26/2020|9/26/2020|[https://aka.ms/AA8uojg](https://aka.ms/AA8uojg)|

## Windows Update troubleshooter

Text displayed in Settings:  
Automatically change system settings to fix a problem on your device.

### Description

Some devices might not start if Disk Cleanup runs after you install the Windows version 19041.21 update. This troubleshooter temporarily disables the feature to automatically run Disk Cleanup until devices install the Windows 10, version 19041.84 update.

This troubleshooter automatically runs two times. It runs the first time on all devices on Windows 10, version 19041.21. It then runs again after devices are upgraded to Windows 10, version 19041.84.  
  
|Activation date|Retirement date|More information|
|---|---|---|
|2/7/2020|\-|[https://aka.ms/AA7afc1](https://aka.ms/AA7afc1)|
