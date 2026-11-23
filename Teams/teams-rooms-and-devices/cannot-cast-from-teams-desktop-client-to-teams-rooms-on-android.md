---
title: Can't cast from Teams desktop client to Teams Rooms on Android
description: Learn why casting from the Teams desktop client to a Microsoft Teams Rooms on Android device doesn't show laptop content during an active room meeting.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams, Microsoft Teams Rooms for Android
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug
ms.date: 10/22/2026
---

# Can't cast from Teams desktop client to Teams Rooms on Android

## Summary

This article explains why casting from the Microsoft Teams desktop client to a Microsoft Teams Rooms on Android device doesn't display your laptop content when the room is already in an active meeting, and what you can do instead.

## Symptoms

You try to cast from the Teams desktop client to a Microsoft Teams Rooms on Android device.

You can open the cast menu in Teams and select the room. After you choose **Cast only**, your laptop shows a red border that indicates sharing is active. However, the room display doesn't show your laptop content.

Instead, the room's display continues to show meeting content such as:

- The in-room camera feed.
- The Teams icon.
- Remote participants' video.

This behavior can occur even when Bluetooth is enabled on the laptop and room discovery works as expected.

## Cause

This issue occurs because casting laptop content to a Microsoft Teams Rooms on Android device while the room is already in an active call isn't a supported scenario.

## Resolution

If you want to present laptop content in a meeting that's already running on the Teams Rooms on Android device, use the laptop to join the meeting and share content directly from the laptop.

1. Open the meeting on the laptop.
1. Join the same meeting from the Teams desktop client.
1. Select **Share**.
1. Choose the screen, window, or content that you want to present.

> [!NOTE]
> Using **Cast only** to send content to a Teams Rooms on Android device doesn't inject that content into an active room meeting.
