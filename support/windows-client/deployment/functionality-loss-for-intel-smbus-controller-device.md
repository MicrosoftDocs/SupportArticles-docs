---
title: Loss of functionality for some Intel SMBus Controller devices after you update your system through Windows Update
description: Describes an issue that triggers a loss of functionality for some Intel SMBus Controller devices after you update your system from Windows Update. Provides several methods to resolve this issue.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, davidroc
ms.custom: sap:devices-and-drivers, csstroubleshoot
ms.subservice: deployment
---
# Loss of functionality for some Intel SMBus Controller devices after you update your system through Windows Update

This article provides a solution to an issue that triggers a loss of functionality for some Intel SMBus Controller devices after you update your system from Windows Update.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 4011290

## Symptoms

When you update your computer through Windows Update, some Intel SMBus Controller device drivers are unexpectedly overwritten with Intel Chipset Device software. This causes loss of functionality for some affected Intel SMBus Controller devices. This issue applies to the following Windows operating systems:

- Windows 7
- Windows Server 2008 R2
- Windows 8
- Windows Server 2012
- Windows 8.1
- Windows Server 2012 R2

## Cause

The existing Intel SMBus Controller device provides the operating system with information about the device and hardware. This enables the operating system to display the correct product name for that piece of hardware in Device Manager.

The Intel Chipset Device software does not install device drivers for the Intel SMBus Controller. This causes a loss of device functionality.  

To resolve this issue, use one of the following methods.

## Resolution 1: Roll back to the previous Intel SMBus Controller device driver

To do this, follow these steps:

1. Open Device Manager. To do this, click **Start**, click **Control Panel**, and then click **Device Manager**.
2. Select **View**, choose **Devices by Type**, and then expand **System Devices**.
3. Double-click the SMBus device, and then click the **Driver** tab.
4. Click **Roll Back Driver** to restore the SMBus Controller device driver.
5. Restart the system.

## Resolution 2: Reinstall the SMBus device driver

To do this, do one of the following:

- For Intel Desktop or Server Boards, download and install Intel Desktop Utilities.
- Contact your computer manufacturer for the SMBus driver appropriate for your system.

## Resolution 3 (optional): Install the updated Intel Chipset Device software or the Intel Server Chipset driver from Windows Update

To do this, follow these steps:

1. Open Device Manager. To do this, click **Start**, click **Control Panel**, and then click **Device Manager**.
2. Select **View**, choose **Devices by Type**, and then expand **System Devices**.
3. Double-click the Intel chipset device from the list.
4. Click the **Driver** tab, and then click **Update Driver**.

## Resolution 4 (optional): Install the updated Intel Chipset Device software or the Intel Server Chipset driver from the Intel Download Center

To do this, follow these steps:

1. Go to the Intel Download Center.
2. Search for **Intel Chipset Device Software (INF Update Utility)** or **Intel Server Chipset Driver**.
3. Follow the installation instructions.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
