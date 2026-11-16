---
title: Unable to reserve room from Teams panel
description: Learn how to fix room reservation failures on Teams panels when required meeting policy settings are disabled.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Android
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/12/2026
---

# Unable to reserve room from Teams panel

## Summary

This article explains how to troubleshoot a Teams panel when you can't reserve a room from the panel. In many cases, the reservation fails because required Teams meeting policy settings aren't enabled for the resource account.

## Symptoms

When you try to reserve a room from a Teams panel, the reservation or meeting creation fails.

You may see an error message similar to this:

> "We are having difficulties connecting to the service right now."

## Cause

This issue occurs when required Teams meeting policy settings are disabled for the resource account that the panel uses.

The reservation request can fail in these situations:

- **AllowPrivateMeetingScheduling**, **PrivateMeetNowAllowed**, and **AllowOutlookAddIn** are disabled.
- **AllowPrivateMeetingScheduling** and **AllowOutlookAddIn** are disabled, and the reservation attempt isn't a Meet now meeting.

The panel needs these settings to create the temporary meeting that's used during the reservation process.

## Resolution

1. Open the Microsoft Teams admin center.
1. Go to **Meetings** > **Meeting policies**.
1. Select the meeting policy that's assigned to the resource account for the panel.
1. Make sure that the following settings are enabled:
   - **AllowPrivateMeetingScheduling** = **True**
   - **PrivateMeetNowAllowed** = **True**
   - **AllowOutlookAddIn** = **True**
1. Save your changes.
1. Try the room reservation again from the Teams panel.

> [!NOTE]
> If the reservation still fails after you update the policy, allow time for the policy change to apply to the device and account before you test again.

## More information

A common sign of this issue is that the panel can't create the temporary meeting that's required for the reservation workflow.

If you collect device logs from the Pro Management Portal, they may indicate a scheduling service failure or an access-denied response during meeting creation. This behavior typically points to a meeting policy configuration issue.
