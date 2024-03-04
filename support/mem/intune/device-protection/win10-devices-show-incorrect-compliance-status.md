---
title: Windows 10 devices show incorrect compliance status in Intune
description: Describes an issue in which Windows 10 devices that have firewall enabled show an incorrect compliance status in Microsoft Intune because of a known issue in Windows 10.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Create Windows policy
ms.reviewer: kaushika
---
# Incorrect compliance status reported for Windows 10 devices with firewall enabled

This article helps you resolve an issue in which Windows 10 devices that have firewall enabled show an incorrect compliance status in Microsoft Intune because of a known issue in Windows 10.

## Symptoms

You create and deploy a device compliance policy for Windows 10 devices in Intune. Under **System Security** > **Device Security**, you set the **Firewall** setting to **Require** to turn on the Microsoft Defender Firewall.

:::image type="content" source="media/win10-devices-show-incorrect-compliance-status/firewall-setting.png" alt-text="Screenshot of the Firewall setting.":::

However, some Windows 10 devices that have the Microsoft Defender Firewall turned on are incorrectly displayed as noncompliant.

## Cause

This issue is caused by a known issue in certain versions of Windows 10.

## Solution

To fix the issue, install the following update on the devices:

- For Windows 10, version 1809: [December 5, 2018-KB4469342 (OS Build 17763.168)](https://support.microsoft.com/help/4469342)
- For Windows 10, version 1803: [November 27, 2018-KB4467682 (OS Build 17134.441)](https://support.microsoft.com/help/4467682)
- For Windows 10, version 1709: [November 27, 2018-KB4467681 (OS Build 16299.820)](https://support.microsoft.com/help/4467681)

## Workaround

If you can't install the update, follow these steps to work around the issue.

1. Change the compliance policy by using one of the following methods.

   - **Method 1 (recommended)**

     Open the device compliance policy, look under **Properties** > **Actions for noncompliance**, select **Mark device noncompliant**, and then enter a nonzero number in **Schedule (days after noncompliance)**. This creates a grace period during which to mark the devices as noncompliant.

     For more information, see [Add actions for noncompliance](/mem/intune/protect/actions-for-noncompliance#add-actions-for-noncompliance).

   - **Method 2**

     Open the device compliance policy, look under **System Security** > **Device Security**, and then set the **Firewall** setting to **Not configured**.

2. Ask the affected users to [manually sync their Windows devices](/mem/intune/user-help/sync-your-device-manually-windows), and check compliance at [https://portal.manage.microsoft.com](https://portal.manage.microsoft.com). After the devices become compliant, the users can access protected resources.
