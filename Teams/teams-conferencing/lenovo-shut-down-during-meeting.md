---
title: Lenovo Yoga L13 might shut down during Teams meetings
description: This article describes an issue in which Lenovo Yoga L13 devices sometimes shut down during a Microsoft Teams meeting.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 144509
  - CSSTroubleshoot
ms.reviewer: lauram, SfB_Triage
appliesto: 
  - Microsoft Teams
ms.date: 3/31/2022
---

# Lenovo Yoga L13 might shut down during Teams meetings

## Symptoms

Lenovo Yoga L13 devices sometimes shut down during a Microsoft Teams meeting.

## Cause

During a Teams meeting that includes video, the CPU temperature of the L13 device could spike to over 90 degrees Celsius (194 degrees Fahrenheit) for multiple seconds, causing it to shut down. It is not yet clear if this issue is limited to the combination of Teams and the L13 device. As this appears to be a widespread issue, it is possible that a recent driver update is involved. 

## Workaround

To work around this issue, reduce the value of the Maximum processor state setting to make sure that the CPU of the L13 device does not overheat.

1. Right-click the battery icon in the task bar, and then select **Power Options**

    :::image type="content" source="./media/lenovo-shut-down-during-meeting/poweroptions-menu.png" alt-text="Screenshot that shows the lication of Power Options.":::

2. Select **Change plan settings**
     :::image type="content" source="./media/lenovo-shut-down-during-meeting/poweroptions-changeplan.png" alt-text="Screenshot that shows the location of Change plan settings button.":::

3. Select **Change advanced power settings**

    :::image type="content" source="./media/lenovo-shut-down-during-meeting/poweroptions-changeadvanced.png" alt-text="Screenshot that shows the location of the Change advanced power settings button.":::

4. Expand **Processor power management** and then **Maximum processor state**. Change both **On battery** and **Plugged in** options to **99%**, and then select **OK**

    :::image type="content" source="./media/lenovo-shut-down-during-meeting/poweroptions-maxproc.png" alt-text="Screenshot that shows the location of Maximum processor state setting.":::

5. Reboot the L13 device.

The CPU temperature should now be controlled and never go above 80 degrees Celsius (176 degrees Fahrenheit). Join a Teams meeting with video to verify that the issue is resolved.

## Status

Microsoft is working with Lenovo to investigate this issue.

## Third-party information disclaimer

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.