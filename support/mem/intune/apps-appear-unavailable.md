---
title: Intune Company Portal apps don't appear as Available
description: Fixes an issue in which applications are not displayed as Available in the Intune Company Portal app on a Windows 10 device.
ms.date: 05/11/2020
ms.prod-support-area-path: App management
---
# Applications do not appear as Available in the Intune Company Portal app on Windows 10

This article fixes an issue in which the Intune Company Portal apps are not displayed as **Available** on a Windows 10 device.

## Symptoms

After you deploy applications to Windows 10 devices, the apps are not displayed as **Available** in the Company Portal app.

## Cause

This issue occurs if users do not identify their device in the Information Worker portal (IW portal) at [https://portal.manage.microsoft.com](https://portal.manage.microsoft.com).

## Solution

To resolve this issue, users must use the following steps to identify their enrolled device.

1. Go to [https://portal.manage.microsoft.com](https://portal.manage.microsoft.com), and then log in by using your account. You should see something similar to the following.

   :::image type="content" source="./media/apps-appear-unavailable/no-device.png" alt-text="Screenshot of no device shown.":::

2. Select **My Devices**.
3. On the **My Devices** screen, select **Tap here**.

   :::image type="content" source="./media/apps-appear-unavailable/my-deivce.png" alt-text="Screenshot of my devices.":::

4. On the next screen, select your device to enroll it.

   :::image type="content" source="./media/apps-appear-unavailable/select-device.png" alt-text="Screenshot of selecting which device.":::

5. You are returned to **My Devices**. The device should show a green check, as shown in the following screenshot.

   :::image type="content" source="./media/apps-appear-unavailable/my-deivce.png" alt-text="Screenshot of my devices.":::

6. Return to the **Apps** screen. The applications should now be visible.

   :::image type="content" source="./media/apps-appear-unavailable/apps.png" alt-text="Screenshot of apps displayed.":::
