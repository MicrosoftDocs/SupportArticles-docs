---
title: Teams Rooms or laptop video feed disappears in the same meeting
description: Learn why one video feed can replace another when the same account joins the same Teams meeting from a Microsoft Teams Room and a laptop.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams, Microsoft Teams Rooms for Windows
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/13/2026
---

# Teams Rooms or laptop video feed disappears in the same meeting

## Summary

This article explains why a video feed can disappear when the same Microsoft Teams account joins the same meeting from both a Microsoft Teams Room (MTR) device and a laptop, and how to avoid the issue.

## Symptoms

You sign in to both a Microsoft Teams Room device and a laptop by using the same Teams account, and then join the same Teams meeting from both devices.

In this scenario, you might see one of these behaviors:

- If the laptop joins after the Teams Room device, the laptop prompts you to add the device to the meeting. After you do that, the Teams Room video feed can stop for internal participants, and the laptop video feed appears instead.
- External participants might continue to see the Teams Room video feed while internal participants see the laptop video feed.
- If the Teams Room device joins after the laptop, the laptop video feed can stop, and participants see the Teams Room video feed instead.

## Cause

This behavior is expected. Joining the same Teams meeting from two devices by using the same signed-in account in this scenario isn't supported.

## Resolution

To avoid this issue, use a separate resource account for the Microsoft Teams Room device.

1. Sign in to the Microsoft Teams Room device by using its resource account instead of the same user account that's signed in on the laptop.
1. Invite the Microsoft Teams Room resource account to the Teams meeting.
1. Join the meeting from the laptop by using the user's account.
1. Join the meeting from the Microsoft Teams Room device by using the room's resource account.

## More information

This behavior can also occur if you sign in to two laptops by using the same Teams account and join the same Teams meeting from both devices.

