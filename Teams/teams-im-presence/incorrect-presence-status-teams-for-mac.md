---
title: Stale or incorrect presence status in Teams for Mac
description: Work around an issue that your presence status may be out of date or incorrect when you use Teams on macOS device. This issue usually occurs when the device is locked.
ms.date: 11/13/2023
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - CI 184113
  - CSSTroubleshoot
ms.reviewer: corbinm, kristinw
---

# Stale or incorrect presence status in Teams for Mac

## Symptoms

Your presence status may be out of date or incorrect when you use one of the following Microsoft Teams clients on a macOS device:

- The new Teams
- The classic Teams
- Teams on the web

This issue usually occurs when the device is locked manually or due to inactivity.  When you resume activity on the device, your presence status remains the same as it was before the device was locked.

**Note:** If you also use Teams on other devices, such as Teams for iOS on iPhone, the status on your Mac may reflect the last status set on the iOS client. For example, you lock your Mac and leave it for a while (more than five minutes), but Teams for iOS is running on your iPhone. In this situation, your presence status on the macOS device may reflect the status on the iOS client. When you resume activity on the macOS device, this state remains unchanged and doesn’t reflect current activity on your Mac.

## Cause

The issue occurs because the presence subscription expires and isn't recreated when you resume activity on the macOS device.

## Workaround

To work around this issue, try to reset your status. If the issue persists, restart the Teams client.
**Note:** If you’re using Teams on other devices, sign out of the Teams app on those devices.

## Status

Microsoft is aware of this issue and is investigating possible solutions. In the meantime, we recommend that you use the workarounds in the [Workaround](#workaround) section.
