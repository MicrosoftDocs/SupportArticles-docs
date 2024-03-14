---
title: Stale presence status in Teams for Mac
description: Provides a workaround for an issue that causes your presence status to be incorrect in Teams on a macOS device. 
ms.date: 11/13/2023
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - New Microsoft Teams
  - Classic Microsoft Teams
  - Teams on the web
ms.custom: 
  - CI 184113
  - CSSTroubleshoot
ms.reviewer: corbinm, kristinw
---

# Stale presence status in Teams for Mac

## Symptoms

Your presence status is incorrect when you resume activity on a locked macOS device that's running one of the following Microsoft Teams clients:

- New Teams
- Classic Teams
- Teams on the web

The device might be locked manually or because of inactivity. After the device is unlocked, your presence status doesn't update as expected but remains unchanged.

**Note:** If you also run Teams on other devices, such as Teams for iOS on iPhone, the status on your macOS device might reflect the last status that was set on the iOS client. For example, you lock your macOS device and the device remains unlocked for more than five minutes, but Teams for iOS is running on your iPhone. In this situation, your presence status on the macOS device might reflect the status on the iOS client. When you resume activity on the macOS device, the presence status remains unchanged and doesn’t reflect the current activity.

## Cause

The issue occurs because the presence subscription expires and isn't re-created when you resume activity on the macOS device.

## Workaround

To work around this issue, reset your status. If the issue persists, restart the Teams client on the macOS device.

**Note:** If you're also running Teams on other devices, sign out of the Teams app on those devices.

## Status

Microsoft is researching this issue and will update this article when new information becomes available.
