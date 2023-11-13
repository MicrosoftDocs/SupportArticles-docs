---
title: Stale or incorrect presence status in Teams for Mac
description: Work around an issue that causes your presence status to be out of date or incorrect when you run Teams on a macOS device. This issue usually occurs when the device is locked.
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

Your presence status is out of date or incorrect when you run one of the following Microsoft Teams clients on a macOS device:

- New Teams
- Classic Teams
- Teams on the web

This issue usually occurs if the device is locked manually or because of inactivity.  When you resume activity on the device, your presence status remains the same as it was before the device was locked.

**Note:** If you also run Teams on other devices, such as Teams for iOS on iPhone, the status on your Mac might reflect the last status that was set on the iOS client. For example, you lock your Mac and you don't touch it for a while (more than five minutes), but Teams for iOS is running on your iPhone. In this situation, your presence status on the macOS device might reflect the status on the iOS client. When you resume activity on the macOS device, the presence status remains unchanged and doesn’t reflect the current activity on your Mac.

## Cause

The issue occurs because the presence subscription expires and isn't re-created when you resume activity on the macOS device.

## Workaround

To work around this issue, try to reset your status. If the issue persists, restart the Teams client.

**Note:** If you’re also running Teams on other devices, sign out of the Teams app on those devices.

## Status

Microsoft is researching this issue and will update this article when new information becomes available. In the meantime, we recommend that you try the workarounds that are mentioned in the [Workaround](#workaround) section.
