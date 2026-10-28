---
title: Room Remote app doesn't connect to Teams Rooms on Windows
description: Describes a connection issue with the Room Remote app and provides a fix for the issue.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams, Microsoft Teams Rooms for Windows
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug
ms.date: 10/28/2026
---

# Room Remote app doesn't connect to Teams Rooms on Windows

## Summary

This article explains how to fix [Room Remote](https://support.microsoft.com/en-us/teams/calls-devices/use-a-room-remote-to-control-a-room-device-in-microsoft-teams) connection errors when users try to control a Microsoft Teams Rooms on Windows device from the Microsoft Teams mobile app.

## Symptoms

When you try to control a Microsoft Teams Rooms on Windows device by using the Microsoft Teams mobile app on iOS or Android, you see one of the following errors:

- "Failed to connect"
- "Can't open room remote"

## Cause

The Room Remote app is blocked by a Teams app permission policy or in Teams app management.

## Resolution

To resolve the issue, allow the Room Remote app in Teams app permission policies.

1. Go to the Microsoft Teams admin center.
1. Open **Teams apps** > **Manage apps**.
1. Search for **Room Remote**.
1. Verify that the app is allowed.
1. If the app is blocked, change it to **Allowed**.
1. Confirm that the affected users are assigned a Teams app permission policy that allows the Room Remote app.

Ask the affected users to try connecting to the Teams Rooms device again from the Teams mobile app.

> [!NOTE]
> If your organization uses custom Teams app permission policies, make sure that those policies also allow the Room Remote app for the affected users.
