---
title: Line keys issues on Teams phones
description: Troubleshoot common line key issues on Microsoft Teams phones, including settings, sync behavior, and Teams admin center configuration.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/12/2026
---

# Line keys issues on Teams phones

## Summary

This article describes common line key behaviors and troubleshooting steps for Teams phones. It covers issues such as line keys not persisting after sign-out, Teams admin center configurations not applying, speed dial sync expectations, and supported line key scenarios.

## Symptoms

You might notice one or more of the following behaviors on a Teams phone:

- Line keys that you configure directly on the device disappear after the user signs out and signs back in.
- Line key settings that you assign in Teams admin center don't appear on the device.
- The **Allow admin override** setting isn't available in a configuration profile.
- Speed dial contacts that sync to line keys don't behave as expected after you apply an admin configuration.
- Removing a speed dial contact from the desktop or web client doesn't remove the corresponding line key from the phone.
- Only some contact types sync automatically to line keys.

You might also need to confirm the device context before you troubleshoot, because line key behavior varies by:

- Phone model
- Whether the phone uses a sidecar or expansion module
- The user interface on the phone
- The Teams app version

Line keys aren't supported in these interfaces:

- Meeting room interface
- Hotline interface
- Basic common area phone interface, unless a sidecar is used

## Cause

The cause depends on the issue:

- If line keys disappear after sign-out or sign-in, the device stores locally configured line keys on the device and doesn't back them up to the service.
- If a Teams admin center line key configuration doesn't apply, **Allow admin override** is turned off on the device.
- If you can't set **Allow admin override** in a configuration profile, that's by design. This setting is device-based.
- If speed dial contacts don't remain synced the way you expect after an admin configuration applies, the admin-defined line key configuration takes precedence over auto-synced speed dials in the positions that the admin configures.
- If deleting a speed dial contact doesn't remove the line key from the phone, that's by design.
- If only certain contacts sync automatically to line keys, that's by design. Only speed dials, delegates, and delegators sync automatically.

## Resolution

### Line keys disappear after sign-out or sign-in

To keep line key assignments across sign-out and sign-in cycles, configure line keys from Teams admin center instead of configuring them only on the device.

1. Open Teams admin center.
1. Configure the line keys for the device by using the public guidance in the Teams admin center line key documentation.
1. On the phone, make sure that **Allow admin override** is turned on.

> [!NOTE]
> Line keys that you configure only on the device don't persist after sign-out, sign-in, or a factory reset.

### Teams admin center line key configuration doesn't apply

If the line key configuration doesn't appear on the device, verify the device setting that allows admin-applied configuration.

1. On the phone, open **Device Settings**.
1. Open **Admin Settings**.
1. Open **Calling** > **Line Keys settings**.
1. Turn on **Allow admin override**.
1. Sync the device or wait for the configuration to apply again.

### Hide unassigned line keys on common area phones

On common area phones, unassigned line keys are hidden by default. If you need to change that behavior, update the device setting.

1. On the phone, open **Device Settings**.
1. Open **Admin Settings**.
1. Open **Calling** > **Line Keys settings**.
1. Turn **Hide unassigned line keys** on or off as needed.
1. If the device uses an expansion module, turn **Hide unassigned expansion module line keys** on or off as needed.

### Remove line keys that remain after speed dial deletion

If you remove a speed dial contact from the desktop or web client and the line key remains on the phone, remove the line key manually on the device.

1. On the phone, open **Device Settings**.
1. Open **Admin Settings**.
1. Open **Calling** > **Line Keys settings** > **Line keys**.
1. Remove the unwanted line key assignment.

## More information

- Supported line key assignments vary by phone model. Supported options can include speed dial, shared line, circular delegation, call queue, blind transfer, and consult transfer.
- Some features aren't available on non-touch phones.
- On common area phones with the advanced common area phone interface:
  - **Hide unassigned line keys** is enabled by default.
  - **Allow admin override** is enabled by default.
- If you want auto-synced speed dials and admin-defined line keys on the same device, configure only the positions that you want to control in Teams admin center and leave the remaining positions unassigned.
- Only speed dials, delegates, and delegators sync automatically to line keys. Regular contacts and favorites don't sync automatically.
- For public guidance, see:
  - [Configure line keys on Teams phones](/microsoftteams/phones/line-keys)
  - [Configure line keys from Teams admin center](/microsoftteams/phones/configuring-line-keys-tac)