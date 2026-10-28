---
title: Teams Rooms on Android shows events-style meeting interface
description: Describes why Microsoft Teams Rooms on Android shows an events-style interface in some meetings and provides a fix.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Android
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug
ms.date: 10/28/2026
---

# Teams Rooms on Android shows events-style meeting interface

## Summary

This article explains why Microsoft Teams Rooms for Android shows an events-style meeting interface on the touch console, what you see when it happens, and how to control the experience through meeting options.

## Symptoms

On a Microsoft Teams Rooms for Android device, the touch console shows an events-style interface instead of the standard meeting interface.

You might see a list of presenters or options such as:

- **You're in attendee view**
- **Switch to presenter view**
- **Mute all**

## Cause

This behavior occurs in Microsoft Teams Rooms for Android after you restrict the **Who can present?** meeting option to **Organizer and co-organizers only** or **Specific people** and is expected. Teams Rooms for Android uses the events-style interface in these meeting configurations to support capabilities such as managed mode and green room.

## Resolution

If you want the standard Teams meeting interface on the touch console, use a less restrictive presenter setting for the meeting.

1. Schedule a Teams meeting in Outlook or Microsoft Teams.
1. Open **Meeting options**.
1. Set **Who can present?** to **Everyone** or **People in my org and guests**.
1. Save the meeting options.
1. Join the meeting from the Teams Rooms for Android device.

If you want to reproduce the events-style experience for testing, use these steps:

1. Schedule a Teams meeting in Outlook or Microsoft Teams.
1. Open **Meeting options**.
1. Set **Who can present?** to **Organizer and co-organizers only** or **Specific people**.
1. If needed, add the Teams Rooms resource account as a co-organizer.
1. Join the meeting from the Teams Rooms for Android device.

Some meeting experiences and fixes might depend on the version of the Teams Rooms for Android app that's installed on the device. If you continue to see unexpected behavior, check whether the device is running the latest update available for Teams Rooms for Android.
