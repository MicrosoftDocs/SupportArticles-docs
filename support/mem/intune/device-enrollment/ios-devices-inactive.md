---
title: iOS or iPadOS devices won't check in with Microsoft Intune
description: Resolves an issue where iOS/iPadOS devices are inactive or won't check in with Intune.
ms.date: 09/30/2021
search.appverid: MET150
ms.reviewer: kaushika
---

# iOS or iPadOS devices aren't checking in with the Intune service

This article fixes an issue where iOS/iPadOS devices are inactive or the Microsoft Intune admin console can't communicate with them. Devices must check in periodically with Intune to maintain access to protected corporate resources. If devices don't check in:

- They can't receive policy, apps, and remote commands from the Intune service.
- They show a Management State of **Unhealthy** in the administrator console.
- Users who are protected by Conditional Access policies might lose access to corporate resources.

## Cause

If a device doesn't check in, it means it cannot successfully sync with Intune and might not be properly enrolled.

## Solution

On the affected device, start the iOS/iPadOS Company Portal app to see if the device has lost contact with Intune. If it detects that there's no contact, it automatically tries to sync with Intune to reconnect (users will see the **Trying to sync…** message).

:::image type="content" source="media/troubleshoot-device-enrollment-in-intune/ios-cp-app-trying-to-sync-notification.png" alt-text="Screenshot of the trying to sync notification.":::

If the sync is successful, you see a **Sync successful** inline notification in the iOS/iPadOS Company Portal app, indicating that the device is in a healthy state.

:::image type="content" source="media/troubleshoot-device-enrollment-in-intune/ios-cp-app-sync-successful-notification.png" alt-text="Screenshot of the sync successful notification.":::

If the sync is unsuccessful, you see an **Unable to sync** inline notification in the iOS/iPadOS Company Portal app.

:::image type="content" source="media/troubleshoot-device-enrollment-in-intune/ios-cp-app-unable-to-sync-notification.png" alt-text="Screenshot of the unable to sync notification.":::

To fix the issue, select **Set up** which is to the right of the **Unable to sync** notification. **Set up** takes you to the Company Access Setup flow screen, where you can follow the prompts to enroll the device.

:::image type="content" source="media/troubleshoot-device-enrollment-in-intune/ios-cp-app-company-access-setup.png" alt-text="Screenshot of the Company Access Setup screen.":::

Once enrolled, the device returns to a healthy state and regains access to company resources.
