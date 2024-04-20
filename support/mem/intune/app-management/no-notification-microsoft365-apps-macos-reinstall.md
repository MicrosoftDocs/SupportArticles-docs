---
title: Microsoft 365 apps for macOS close and reinstall without notification
description: Microsoft 365 apps that are deployed to macOS devices by using Intune close and reinstall without notification.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:AppDeployment - MacOS\Advisory
ms.reviewer: kaushika, markstan
---
# Microsoft 365 apps for macOS close and reinstall without notification

## Symptoms

Your organization uses Microsoft Intune to [deploy Microsoft 365 apps](/mem/intune/apps/apps-add-office365-macos) to macOS devices. When users use a Microsoft 365 app, they experience the following issue:

The app closes without notification and restarts after a certain amount of time. For example, Microsoft Teams closes during a call and then restarts. When users check the modification date of the app on their device, they see a displayed time that falls between the time that the app was closed and when it was restarted. Here's an example:

:::image type="content" source="media/no-notification-microsoft365-apps-macos-reinstall/app-modified-date.png" alt-text="Screenshot of the modified date of apps.":::

## Cause

This issue can occur for either of the following reasons:

- Multiple deployments of Microsoft 365 apps are [assigned](/mem/intune/apps/apps-deploy#assign-an-app) as **Required** to the device. In this case, the behavior is expected.
- The **Microsoft 365 Apps for macOS** app suite is assigned as **Required** to the device. This is a known issue.

## Resolution

To fix the issue, use the appropriate method for the specific cause:

- If multiple deployments of Microsoft 365 apps are assigned as **Required** to the device, assign one deployment instead.
- If the **Microsoft 365 Apps for macOS** app suite is assigned as **Required** to the device, change the assignment type to **Available for enrolled devices**.
