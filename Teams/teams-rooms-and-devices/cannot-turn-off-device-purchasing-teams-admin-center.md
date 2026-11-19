---
title: "Can't turn off device purchasing in Teams admin center"
description: "Learn what to do if the device purchasing setting in Teams admin center doesn't save and turns back on."
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/17/2026
---

# Can't turn off device purchasing in Teams admin center

## Summary

This article explains what to do if you can't disable device purchasing in the Teams admin center because the setting doesn't save or turns back on.

## Symptoms

When you try to turn off device purchasing in the Teams admin center, you see one or both of these behaviors:

- You get an error message that says your changes couldn't be saved and that you should try again.
- After you turn off the setting and save it, the setting turns back on after a few seconds.

## Cause

This is a known issue in the Teams admin center.

## Resolution

Use the Microsoft 365 Apps admin center to disable device purchasing instead of the Teams admin center.

1. Go to the Microsoft 365 Apps admin center at `https://config.office.com`.
1. Sign in with an account that has Microsoft 365 Apps admin or Global admin permissions.
1. Open **Customization** > **Policy Management**.
1. Create a new tenant-wide cloud policy, or open an existing policy that applies to your users.
1. Find the **Users can purchase devices in the Teams device store** setting.
1. Set **Configuration setting** to **Enabled**.
1. Set **Allow users to purchase** to **Disabled**.
1. Apply the policy.
1. Wait 24 to 48 hours for the policy change to replicate.

> [!NOTE]
> By default, purchasing is enabled. When you disable purchasing, users can still browse the Teams device store, but they can't buy devices.

## More information

To change this setting directly in the Teams admin center under **Devices** > **Store** > **Settings**, you need Global admin permissions.

No additional information is available.