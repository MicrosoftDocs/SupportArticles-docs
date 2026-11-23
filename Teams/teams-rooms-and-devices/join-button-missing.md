---
title: Join button missing in Teams Rooms
description: Describes why the Join button is missing in Teams Rooms, and how to fix it.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Windows, Microsoft Teams Rooms for Android
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug
ms.date: 10/28/2026
---

# Join button missing in Teams Rooms

## Summary

This article explains why the **Join** button might be missing in a Microsoft Teams Rooms device and how to restore it.

## Symptoms

You don't see the **Join** button in the Teams Rooms interface for a meeting when the meeting link is copied and pasted into the room's calendar invite manually.

## Cause

Copying and pasting a meeting link into a calendar invite manually isn't a supported way to schedule meetings for Teams Rooms devices. This method can add formatting errors such as hidden characters or line breaks. These issues can prevent the Teams Rooms device from recognizing the meeting correctly.

## Resolution

The supported method to invite a Teams Rooms device to a meeting is to forward the original invite directly to the room mailbox. Forwarding the original meeting invite preserves the meeting data that Teams Rooms needs to recognize the meeting correctly. Make sure that the resource mailbox has the recommended Calendar processing rule in place.

1. Open the original Teams meeting invite.
1. Forward the meeting invite directly to the Teams Rooms resource mailbox.
1. Don't copy and paste the meeting link into a new or existing calendar item.
1. Confirm that the meeting appears on the Teams Rooms device calendar.
1. Verify that the **Join** button appears for the meeting.
