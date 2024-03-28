---
title: Your organization removed Outlook app data for Android
description: Describes an issue in which you receive the Your organization has removed its data associated with this app error message when you open the Outlook for Android app that's managed by Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.reviewer: kaushika
ms.custom: sap:Application Protection - Android\Sync Data & Printing
---
# Your organization has removed its data associated with this app

This article helps you fix an issue where you receive the **Your organization has removed its data associated with this app** error message when you open the Outlook for Android app that's managed by a Microsoft Intune app protection policy (APP).

## Symptoms

When you open the Outlook for Android app that's managed by an Intune APP, you receive the following message:

> Your organization has removed its data associated with this app because the Microsoft Intune Company Portal data or application was removed. To reconnect, you must sign-in with your work or school account.

:::image type="content" source="media/removed-data-associated-with-app-error/removed-data-error.png" alt-text="Screenshot of the Your organization has removed its data associated with this app error message.":::

## Cause

This issue occurs for one of the following reasons:

- Outlook has been offline for a long time. So you are signed out of Outlook according to an existing app protection policy.
- Outlook can't detect whether the Company Portal app is installed after a system update. Because Outlook can't get the expected access token, it goes offline. So you are signed out of Outlook according to an existing app protection policy.

## Solution

To avoid this issue in the future, complete these steps on the Android device:

1. Turn off battery optimization for Outlook and Company Portal.
2. Change app **Launch** setting for Outlook and Company Portal from **Automatic** to **Manage Manually**. Then, enable the following the **Manage Manually** options:
   - Auto-launch
   - Secondary launch
   - Run in background
3. If you have Data Saver enabled, select Outlook and Company Portal for unrestricted data usage.
4. Enable notification for Outlook and Company Portal.

> [!NOTE]
> We recommend that you also do these steps for other apps that are managed by Intune APP.

If the issue persists, follow these steps to get support:

1. Collect Outlook Diagnostic log information:

   1. Within the Outlook for Android settings, tap **Help & Feedback**.
   1. Tap **Collect Diagnostics**.
   1. Tap **Get Started**.
   1. Tap **Collect Logs**.
   1. Provide the incident ID to Microsoft Support.

1. Collect Android debug log information.
1. Create a service request. To do this, follow the steps in [How to get support in Microsoft Intune admin center](/mem/intune/fundamentals/get-support).
