---
title: Code 31 error for WAN Miniport device
description: Describes an error that's returned in Device Manager for the WAN Miniport (Network monitor) device. Occurs after you install Windows. A resolution is provided.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:wireless-networking-and-802.1x-authentication, csstroubleshoot
---
# Code 31 error in Device Manager for WAN Miniport (Network monitor) device in Windows

This article provides a workaround for an issue where Device Manager displays a yellow exclamation mark next to the WAN Miniport (Network monitor) device.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2871372

## Symptoms

Consider the following scenario:

- You are installing Windows.
- You open Device Manager after the installation is complete.

In this scenario, Device Manager displays a yellow exclamation mark next to the WAN Miniport (Network monitor) device. Additionally, the **Details** tab of the device properties window displays the following message:

The device is not working properly because Windows cannot load the drivers required for this device. (Code 31)  

## Cause

This issue occurs because Windows cannot load the drivers that are required for the WAN (Network monitor) device. Because there is no driver associated with the device, it cannot be removed from Device Manager.

## Resolution

To prevent this issue during future installs, you must integrate update [2822241](https://support.microsoft.com/help/2822241) into the installation media that you use during setup.

For information about how to use Deployment Image Servicing and Management (DISM) to integrate a hotfix package into installation media, see [Add or remove packages offline](https://technet.microsoft.com/library/hh824838.aspx).

## Workaround

If you have already installed the operating system and are currently receiving a "code 31" error on the WAN Miniport (Network Monitor) device, follow these steps:

1. Open Device Manager.
2. Right-click the WAN miniport (Network monitor) device, and then click **Update Driver Software**.
3. Click **Browse my computer for driver software**.
4. Click **Let me pick from a list of device drivers on my computer**.
5. Clear the **Show compatible hardware** check box.
6. In the column on the left side, select **Microsoft**, and in the column on the right side, select **Microsoft KM-TEST Loopback Adapter**.
7. In the **Update Driver Warning** dialog box, click **Yes** to continue installing this driver.
8. After the driver is installed, right-click the device, and then click **Uninstall**.
9. After the device is uninstalled, right-click the computer name in Device Manager, and then click **Scan for hardware changes**.
10. On the **View** menu, click **Show hidden devices**. The WAN Miniport (Network monitor) device should now be started and no longer have a yellow exclamation mark next to it.
