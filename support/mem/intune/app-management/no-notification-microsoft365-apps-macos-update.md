---
title: Microsoft 365 apps for macOS update without notification
description: Microsoft 365 apps that are deployed to macOS devices by using Intune close and update without notification.
ms.date: 10/19/2021
search.appverid: MET150
ms.custom: sap:Manage Apps
ms.reviewer: kaushika, markstan
---
# No notification when Microsoft 365 apps deployed by using Intune are updated

## Symptoms

Your organization uses Microsoft Intune to [deploy Microsoft 365 apps](/mem/intune/apps/apps-add-office365-macos) to macOS devices. However, users experience the following issue when app updates are installed on the devices:

Microsoft 365 apps close without notification and restart after updates are installed.

**Note:** Usually, users will receive notifications about upcoming [deadlines when updates are required to be installed](/deployoffice/mac/mau-deadline). Here are examples of notifications:

:::image type="content" source="media/no-notification-microsoft365-apps-macos-update/microsoft-autoupdate-notification-time.png" alt-text="Screenshot of the deadline for installing updates in time format.":::

:::image type="content" source="media/no-notification-microsoft365-apps-macos-update/microsoft-autoupdate-notification-countdown.png" alt-text="Screenshot of the deadline for installing updates in countdown format.":::

## Cause

This issue can occur in one of the following situations:

- Multiple configuration profiles that manage Microsoft AutoUpdate (MAU) settings are deployed to the devices.
- Only one configuration profile that manages MAU settings is deployed to the devices. However, there are many MAU settings for different Microsoft 365 apps in this configuration profile.

## Resolution

If multiple configuration profiles that manage MAU settings are deployed to the devices, deploy only one configuration profile instead. In addition, in the configuration profile, include only MAU settings that apply to all apps in the **Microsoft 365 Apps for macOS** app suite.

## More information

[Deploy updates for Office for Mac](/deployoffice/mac/deploy-updates-for-office-for-mac)
