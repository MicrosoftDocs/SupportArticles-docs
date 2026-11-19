---
title: Teams disabled for tenant error during sign-in on Teams Rooms for Android
description: Learn how to fix the TEAMS_DISABLED_FOR_TENANT error when you sign in to a Microsoft Teams Rooms for Android device.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams, Microsoft Teams Rooms for Android
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/17/2026
---

# Teams disabled for tenant error during sign-in on Teams Rooms for Android

## Summary

This article explains how to fix the **TEAMS_DISABLED_FOR_TENANT** error when you sign in to a Microsoft Teams Rooms for Android device.

## Symptoms

When you sign in to a Microsoft Teams Rooms for Android device, sign-in doesn't complete successfully.

You might see one or more of the following symptoms:

- The device shows a black screen that prompts you to select your organization.
- After you go back, the Teams Rooms interface appears, but the signed-in account name and room information are missing.
- In the Teams admin center, the device shows a sign-in error that includes **TEAMS_DISABLED_FOR_TENANT**.

## Cause

This issue occurs because Microsoft Teams isn't enabled for users with the affected license type in your organization settings.

## Resolution

To enable Teams for the affected license type, follow these steps:

1. Open the Microsoft 365 admin center.
1. Go to **Settings** > **Org settings**.
1. Select the **Services** tab, and then select **Microsoft Teams**.
1. Turn on **Teams** for users with the affected licenses, including **Other** if that's the license category used by the device account.
1. Save your changes.

> [!NOTE]
> If you don't see this setting, sign in with a Global Administrator account, and then try again.

After you update the setting, try to sign in to the device again.

## More information

This issue has been observed when only one Teams Rooms for Android device is affected, such as during an initial evaluation or a single-device deployment.

If the device account has a Teams Rooms Basic or Teams Rooms Pro license, make sure that Teams is enabled for that account in your organization settings.