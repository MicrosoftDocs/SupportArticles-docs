---
title: Your organization has removed its data associated with this app
description: Describes an issue in which you receive the Your organization has removed its data associated with this app error message when you open the Outlook for Android app that's managed by Intune.
ms.date: 07/24/2020
ms.prod-support-area-path:
---
# Your organization has removed its data associated with this app error when you open the Outlook for Android app

This article helps you fix an issue where you receive the **Your organization has removed its data associated with this app** error message when you open the Outlook for Android app that's managed by Intune mobile application management (MAM).

_Original product version:_ &nbsp; Outlook for Android, Microsoft Intune  
_Original KB number:_ &nbsp; 4549582

## Symptoms

When you open the Outlook for Android app that's managed by Intune mobile application management (MAM), you receive the following message:

> Your organization has removed its data associated with this app because the Microsoft Intune Company Portal data or application was removed. To reconnect, you must sign-in with your work or school account.

:::image type="content" source="media/removed-data-associated-with-app-error/removed-data-error.png" alt-text="Screenshot of the error message.":::

## Cause

This issue occurs for one of the following reasons:

- Outlook has been offline for a long time. So you are signed out of Outlook according to an existing MAM policy.
- Outlook can't detect whether the Company Portal app is installed after a system update. Because Outlook can't get the expected access token, it goes offline. So you are signed out of Outlook according to an existing MAM policy.

## Resolution

To avoid this issue in the future, follow these steps on the Android device:

1. Turn off battery optimization for Outlook and Company Portal.
2. Change app **Launch** setting for Outlook and Company Portal from **Automatic** to **Manage Manually**. Then, enable the following the **Manage Manually** options:
   - Auto-launch
   - Secondary launch
   - Run in background
3. If you have Data Saver enabled, select Outlook and Company Portal for unrestricted data usage.
4. Enable notification for Outlook and Company Portal.

> [!NOTE]
> We recommend that you also do these steps for other apps that are managed by Intune MAM.

If the issue persists, follow these steps to get support:

1. Collect Outlook Diagnostic log information:

   1. Within the Outlook for Android settings, tap **Help & Feedback**.
   2. Tap **Collect Diagnostics**.
   3. Tap **Get Started**.
   4. Tap **Collect Logs**.
   5. Provide the incident ID to Microsoft Support.

1. Collect Android debug log information.
1. Create a service request. To do this, follow the steps in [How to get support for Microsoft Intune](/mem/intune/fundamentals/get-support).
