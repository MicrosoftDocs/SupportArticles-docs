---
title: Intune Company Portal apps don't appear as Available
description: Fixes an issue in which applications aren't displayed as Available in the Intune Company Portal app on a Windows 10 device.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:AppDeployment - Android\Advisory
ms.reviewer: kaushika
---
# Applications don't appear as Available in the Intune Company Portal app on Windows 10

This article fixes an issue in which the Intune Company Portal apps aren't displayed as **Available** on a Windows 10 device.

## Symptoms

After you deploy applications to Windows 10 devices, the apps aren't displayed as **Available** in the Company Portal app.

## Cause

This issue occurs if users don't identify their device in the Information Worker portal (IW portal) at [https://portal.manage.microsoft.com](https://portal.manage.microsoft.com).

## Solution

To fix this issue, users must use the following steps to identify their enrolled device.

1. Go to [https://portal.manage.microsoft.com](https://portal.manage.microsoft.com), and then log in by using your account. You should see something similar to the following.

   :::image type="content" source="media/apps-appear-unavailable/cannot-show-apps.png" alt-text="Screenshot of We can't show you any apps message.":::

2. Select **My Devices**.
3. On the **My Devices** screen, select **Tap here**.

   :::image type="content" source="media/apps-appear-unavailable/my-device.png" alt-text="Screenshot of the Tap here link in my devices page.":::

4. On the next screen, select your device to enroll it.

   :::image type="content" source="media/apps-appear-unavailable/select-device.png" alt-text="Screenshot of selecting device.":::

5. You're returned to **My Devices**. The device should show a green check, as shown in the following screenshot.

   :::image type="content" source="media/apps-appear-unavailable/my-device.png" alt-text="Screenshot of my devices page with a green check in the selected device.":::

6. Return to the **Apps** screen. The applications should now be visible.

   :::image type="content" source="media/apps-appear-unavailable/apps.png" alt-text="Screenshot of apps displayed in the screen.":::
