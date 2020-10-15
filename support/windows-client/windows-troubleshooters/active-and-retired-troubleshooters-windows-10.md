---
title: Active and retired troubleshooters for Windows 10
description: Active and retired troubleshooters for Windows 10.
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: ksharma, kaushika
ms.prod-support-area-path: TPM
ms.technology: WindowsSecurity
---
# Active and retired troubleshooters for Windows 10

This article provides a list of active and retired troubleshooters for Windows 10, including a description of what the troubleshooter does, the problem that it addresses, and which devices it applies to. To learn more about troubleshooters, see [keep your device running smoothly with recommended troubleshooting](https://support.microsoft.com/en-us/help/4487232/keep-your-device-running-smoothly-with-recommended-troubleshooting).

## More information

|Troubleshooter text|Description|Activation date|Retirement date|More information|
|---|---|---|---|---|
|**Files On-Demand troubleshooter**<br />You may have lost access to your Files On-Demand. This troubleshooter restores access or prevents the loss of access from happening in the near future.Important: Please reboot your device once the troubleshooter is finished.|After updating to Windows 10, version 2004, some older devices or devices that have certain older apps installed that use legacy [file system filter drivers](https://docs.microsoft.com/en-us/windows-hardware/drivers/ifs/about-file-system-filter-drivers) might be unable to connect to OneDrive through the OneDrive app. Affected devices might not be able to download new Files On-Demand content or open previously synced or downloaded files. This troubleshooter mitigates the issue. <br />Devices that successfully ran the "Hardware and devices" troubleshooter will be notified and asked to run this troubleshooter. This troubleshooter cannot be run manually.|6/30/20|-|<https://aka.ms/AA8vtwr>|
|**Hardware and devices troubleshooter**<br />Automatically repairs system files and settings to fix a problem on your device|After updating to Windows 10, version 2004, some older devices or devices that have certain older apps installed that use legacy [file system filter drivers](https://docs.microsoft.com/en-us/windows-hardware/drivers/ifs/about-file-system-filter-drivers) might be unable to connect to OneDrive through the OneDrive app. Affected devices might not be able to download new Files On-Demand content or open previously synced or downloaded files. This troubleshooter detects the presence of this issue.<br />This troubleshooter runs automatically on devices that meet the following criteria:<ul><li><p>Runs on Windows 10, version 2004</p></li><li><p>Uses a Cloud files filter (OneDrive, iCloud, Workfolders)</p></li></ul>**Note:** This troubleshooter cannot be run manually.|6/30/20|-|<https://aka.ms/AA8vtwr>|