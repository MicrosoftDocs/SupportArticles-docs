---
title: Can't cast from Teams desktop client to Teams Rooms on Windows
description: Learn how to fix the issue where casting from the Teams desktop client on Windows or macOS to a Microsoft Teams Rooms for Windows device fails with a connection error.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams, Microsoft Teams Rooms for Windows
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug
ms.date: 10/22/2026
---

# Can't cast from Teams desktop client to Teams Rooms on Windows

## Summary

This article explains why casting from the Microsoft Teams desktop client on Windows or macOS to a Microsoft Teams Rooms for Windows device can fail, and how to fix the issue.

## Symptoms

When you try to cast from the Microsoft Teams desktop client on Windows or macOS to a Microsoft Teams Rooms for Windows device, the cast doesn't start.

You see the following error message:

`Sorry, we couldn't connect you.`

## Cause

This issue occurs when both the following accounts aren't enabled for **Meet Now in private meetings** in their Teams meeting policy:

- The user account that starts the cast.
- The Microsoft Teams Rooms account on the device.

Casting to a Microsoft Teams Rooms for Windows device uses Teams meeting functionality that depends on the **Meet Now in private meetings** policy setting. If either the user account or the room account has this setting turned off, Teams can't create the instant meeting that's required for casting and the connection fails.

## Resolution

Enable **Meet Now in private meetings** for both the user account and the Microsoft Teams Rooms account in the Teams admin center.

1. Open the Teams admin center.
1. Go to **Meetings** > **Meeting policies**.
1. Select the policy that's assigned to the user account that starts the cast.
1. Set **Allow Meet Now in private meetings** to **On**.
1. Select the policy that's assigned to the Microsoft Teams Rooms account.
1. Set **Allow Meet Now in private meetings** to **On**.
