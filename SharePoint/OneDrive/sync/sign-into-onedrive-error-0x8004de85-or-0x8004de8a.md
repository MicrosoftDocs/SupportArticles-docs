---
title: Error 0x8004de85 or 0x8004de8a when signing in to OneDrive
description: Fixes an issue in which you can't sign in to OneDrive and you receive error code 0x8004de85 or 0x8004de8a.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 168010
  - CSSTroubleshoot
ms.reviewer: bpeterse
appliesto: 
  - OneDrive for Business
  - Microsoft OneDrive
search.appverid: 
  - MET150
ms.date: 10/21/2022
---
# Error 0x8004de85 or 0x8004de8a when signing in to OneDrive

## Symptoms

You can't sign in to Microsoft OneDrive and receive error code 0x8004de85 or 0x8004de8a.

## Cause

This issue may occur if there's a problem with your OneDrive account, such as a missing account, or a mismatch if you sign in by using a personal Microsoft account and a work or school account.

To resolve this issue, try the following solutions.

## Solution 1: Make sure that you're using the correct OneDrive account

Sign in to your [personal Microsoft account](https://account.live.com/reputationcheck) or [Microsoft 365 account](https://www.office.com/signin) to verify that there are no authentication issues. Then, check your OneDrive account by following these steps:

1. Select the **OneDrive** icon (:::image type="icon" source="media/sign-into-onedrive-error-0x8004de85-or-0x8004de8a/onedrive-icon.png":::) in the taskbar notification area.

   > [!NOTE]
   > You might need to select the **Show hidden icons** arrow (:::image type="icon" source="media/sign-into-onedrive-error-0x8004de85-or-0x8004de8a/arrow-icon.png":::) next to the notification area to see the **OneDrive** icon. If the icon doesn't appear, OneDrive might not be running. To start OneDrive, select **Start**, type *OneDrive* in the search box, and then select **OneDrive** in the search results.

2. Select Help & Settings (:::image type="icon" source="media/sign-into-onedrive-error-0x8004de85-or-0x8004de8a/setting-icon.png":::), and then select **Settings**.

   :::image type="content" source="media/sign-into-onedrive-error-0x8004de85-or-0x8004de8a/onedrive-settings.png" alt-text="Screenshot of the OneDrive window in which the settings icon and settings are highlighted.":::

3. On the **Account** tab, make sure that the correct or expected account is displayed. Otherwise, sign in to OneDrive by using the correct account.

## Solution 2: Reset OneDrive

To reset the OneDrive sync app, follow these steps:

1. Right-click the **OneDrive** icon (:::image type="icon" source="media/sign-into-onedrive-error-0x8004de85-or-0x8004de8a/onedrive-icon.png":::) in the taskbar notification area.
2. Select Help & Settings (:::image type="icon" source="media/sign-into-onedrive-error-0x8004de85-or-0x8004de8a/setting-icon.png":::), and then select **Quit OneDrive**.
3. Select **Start** icon, type *cmd*. Right-click **Command Prompt** from the result, and then select **Run as administrator**.  
4. Run the `%localappdata%\Microsoft\OneDrive\onedrive.exe /reset` command.
5. Restart the OneDrive sync app and sign in with your work or school account.

## Solution 3: Make sure that the account has a valid license assigned

Depending on how your organization purchased OneDrive for users, you may no longer have the assigned OneDrive license, or the license may have expired.

**Note** The following steps must be completed by your organization's Microsoft 365 administrator.

1. In the [Microsoft 365 admin center](https://admin.microsoft.com/AdminPortal/Home#/users), select **Users** > **Active users**.
2. Select the user who is experiencing the issue.  
3. In the user pane, select **Licenses and apps**.
4. Expand the **Licenses** section, and make sure that a OneDrive for Business license is assigned to the user.

> [!NOTE]
> If multiple users experience the issue, the subscription may have expired. To check the subscription status, select **Billing** > **Your products** in the Microsoft 365 admin center.
