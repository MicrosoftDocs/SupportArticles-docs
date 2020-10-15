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

This article provides a list of active and retired troubleshooters for Windows 10, including a description of what the troubleshooter does, the problem that it addresses, and which devices it applies to. To learn more about troubleshooters, see [keep your device running smoothly with recommended troubleshooting](https://support.microsoft.com/help/4487232/).

## More information

### Troubleshooter 1

#### Text

**Files On-Demand troubleshooter**

You may have lost access to your Files On-Demand. This troubleshooter restores access or prevents the loss of access from happening in the near future. Important: Please reboot your device once the troubleshooter is finished.

#### Description

After updating to Windows 10, version 2004, some older devices or devices that have certain older apps installed that use legacy [file system filter drivers](/windows-hardware/drivers/ifs/about-file-system-filter-drivers) might be unable to connect to OneDrive through the OneDrive app. Affected devices might not be able to download new Files On-Demand content or open previously synced or downloaded files. This troubleshooter mitigates the issue.

Devices that successfully ran the "Hardware and devices" troubleshooter will be notified and asked to run this troubleshooter. This troubleshooter cannot be run manually.

#### Activation date

6/30/20

#### Retirement date

\-

#### More information

[https://aka.ms/AA8vtwr](https://aka.ms/AA8vtwr)

### Troubleshooter 2

#### Text

**Hardware and devices troubleshooter**

Automatically repairs system files and settings to fix a problem on your device

#### Description

After updating to Windows 10, version 2004, some older devices or devices that have certain older apps installed that use legacy [file system filter drivers](/windows-hardware/drivers/ifs/about-file-system-filter-drivers) might be unable to connect to OneDrive through the OneDrive app. Affected devices might not be able to download new Files On-Demand content or open previously synced or downloaded files. This troubleshooter detects the presence of this issue.

This troubleshooter runs automatically on devices that meet the following criteria:

-   Runs on Windows 10, version 2004

-   Uses a Cloud files filter (OneDrive, iCloud, Workfolders)

> [!NOTE]
> This troubleshooter cannot be run manually.

#### Activation date

6/30/20

#### Retirement date

\-

#### More information

[https://aka.ms/AA8vtwr](https://aka.ms/AA8vtwr)

### Troubleshooter 3

#### Text

**Storage Spaces cleanup troubleshooter**

Automatically restores your previous settings and environment for Storage Spaces.

#### Description

Devices that use Parity Storage Spaces might not be able to use or access their storage spaces after you update to Windows 10, version 2004 (the May 2020 update) or Windows Server, version 2004. After [KB4568831](https://support.microsoft.com/help/4568831) has been applied to your device, this troubleshooter restores your previous Storage Spaces settings.

This troubleshooter runs automatically on devices that meet the following criteria:
 
 - Successfully ran the "Hardware and devices" or "Storage space" troubleshooter

> [!NOTE]
> This troubleshooter cannot be run manually.

#### Activation date

7/30/2020

#### Retirement date

\-

#### More information

[https://aka.ms/AA8uojg](https://aka.ms/AA8uojg)

### Troubleshooter 4

#### Text

**Storage space troubleshooter**

Data corruption was detected on your parity storage space. This troubleshooter takes actions to prevent further corruption. It also restores write access if the space was previously marked read-only. For more information and recommended actions please see the link below.

#### Description

Devices that use Parity Storage Spaces might experience issues when they try to use or access their storage spaces after they update to Windows 10, version 2004 (the May 2020 Update) or Windows Server, version 2004. This troubleshooter mitigates the issue for some users and restores read and write access to your Parity Storage Spaces. 

This troubleshooter runs automatically on devices that meet the following criteria.

- Successfully ran the "Hardware and devices" or "Storage Space" troubleshooter

> [!NOTE]
> This troubleshooter cannot be run manually.

#### Activation date

7/2/2020

#### Retirement date

\-

#### More information

[https://aka.ms/AA8uojg](https://aka.ms/AA8uojg)

### Troubleshooter 5

#### Text

**Hardware and devices troubleshooter**

Automatically changes system settings to fix a problem on your device.

OR

**Storage space troubleshooter**

Data corruption was detected on your parity storage space. To prevent further corruption, the volume has been marked as Read-Only. Your data is still accessible at this time. For more information and recommended actions please see the link below.

#### Description

Devices that use Parity Storage Spaces might experience issues when they try to use or access their storage spaces after they are updated to Windows 10, version 2004 (the May 2020 Update) or Windows Server, version 2004. This troubleshooter helps prevent issues that affect the data on your storage spaces. After the troubleshooter runs, you will not be able to write to your storage spaces.

This troubleshooter runs two times on devices that meet the following criteria:

- Runs Windows 10, version 2004
- Uses storage spaces

The first time, the troubleshooter runs automatically. The second time, it notifies the user.

#### Activation date

6/26/2020

#### Retirement date

\-

#### More information

[https://aka.ms/AA8uojg](https://aka.ms/AA8uojg)

### Troubleshooter 6

#### Text

**Windows Update troubleshooter**

Automatically changes system settings to fix a problem on your device.

#### Description

Some devices might not start if Disk Cleanup runs after you install the Windows version 19041.21 update. This troubleshooter temporarily disables the feature to automatically run Disk Cleanup until devices install the Windows 10, version 19041.84 update.

This troubleshooter automatically runs two times. It runs the first time on all devices on Windows 10, version 19041.21. It then runs again after devices are upgraded to Windows 10, version 19041.84.  
  
> [!NOTE]
> This troubleshooter cannot be run manually.

#### Activation date

2/7/2020

#### Retirement date

\-

#### More information

[https://aka.ms/AA7afc1](https://aka.ms/AA7afc1)
