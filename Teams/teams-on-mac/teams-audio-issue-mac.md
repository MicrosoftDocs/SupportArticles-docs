---
title: Audio issues when using Teams on macOS
description: Resolve audio-related issues when you use Microsoft Teams on macOS devices. 
ms.date: 10/27/2024
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
search.appverid: 
  - SPO160
  - MET150
ms.custom: 
  - sap:Teams Clients\Mac Desktop
  - CI 980
  - CSSTroubleshoot
ms.reviewer: martinmuzak
---

# Audio issues when using Teams on macOS

## Symptoms

You experience one of the following issues when you use Microsoft Teams on your macOS device:

- You don't receive sound for Teams notifications.
- You can't hear other participants clearly during Teams calls and meetings.

## Cause

These issues can occur if the audio processing isn't working correctly.

## Resolution

To resolve the issue, you must restart the `coreaudiod` process that manages all the audio features on macOS devices.

If you have administrator privileges on your macOS device, use method 1. Otherwise, use method 2.

### Method 1: For administrators

Restart the `coreaudiod` process by following these steps:

1. [Open Terminal](https://support.apple.com/guide/terminal/apd5265185d-f365-44cb-8b09-71a064a42125/mac) on the macOS device.
1. Run the following command:

   ```console
    sudo killall coreaudiod
   ```

1. Enter the administrator password.

### Method 2: For nonadministrators

Restart the macOS device by selecting the Apple menu > **Restart**.
