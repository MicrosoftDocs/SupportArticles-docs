---
title: Teams-specific notification sound reverts to macOS notification sound
description: Resolves an issue in which the Teams-specific notification sound that you configured doesn't play when you use Microsoft Teams on macOS devices.
ms.date: 11/27/2024
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
search.appverid: 
  - SPO160
  - MET150
ms.custom: 
  - sap:Teams Clients\Mac Desktop
  - CI 2857
  - CSSTroubleshoot
ms.reviewer: opreda
---

# Teams-specific notification sound reverts to macOS notification sound

## Symptoms

When you use Microsoft Teams on your macOS device, you notice that the Teams-specific notification sound that you configured doesn't play. Instead, the device reverts to using the default macOS notification sound.

## Cause

The Notification Center on the macOS device is recaching the file that's associated with the configured sound. As a result, Teams can't use the configured sound.

## Resolution

To resolve the issue, clear the Notification Center cache. This action makes sure that the sound settings that you configured are applied again.

If you have administrator privileges on your macOS device, use method 1. Otherwise, use method 2.

### Method 1: For administrators

Use the following steps:

1. [Open Terminal](https://support.apple.com/guide/terminal/apd5265185d-f365-44cb-8b09-71a064a42125/mac) on the macOS device.
1. Run the following command:

   ```console
    pkill -9 NotificationCenter 
   ```

1. Enter the administrator password.

### Method 2: For nonadministrators

Restart the macOS device by selecting the Apple menu > **Restart**.
