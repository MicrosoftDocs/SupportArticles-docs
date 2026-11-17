---
title: HID controls don't work when Teams and Skype for Business run side by side
description: Troubleshoot headset call controls that stop working when Microsoft Teams and Skype for Business run together on Windows.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/12/2026
---

# HID controls don't work with Teams and Skype for Business run side by side

## Summary

This article helps you troubleshoot headset Human Interface Device (HID) controls, such as mute, unmute, answer, hold, and call buttons, when Microsoft Teams and Skype for Business run side by side on Windows.

## Symptoms

You may notice one or more of the following symptoms:

- Headset mute, unmute, answer, hold, or other call controls don't work in Teams.
- Audio mutes unexpectedly or drops while Teams and Skype for Business both run.
- HID controls start working again after you close Skype for Business.
- Teams detects that Skype for Business is running and doesn't take control of the HID device.

## Cause

This issue can occur because HID behavior depends on your coexistence mode, client configuration, device support, device firmware, and whether both Teams and Skype for Business are running at the same time.

## Resolution

1. Check the user's Teams upgrade or coexistence mode.
1. Record the Windows, Teams, and Skype for Business versions.
1. Confirm whether Skype for Business is running.
1. Identify the HID device model, connection type, and firmware version.
1. If you use a Bluetooth device, close any vendor Bluetooth management software, and then test again.
1. Quit Skype for Business, and then test the HID controls in Teams again.
1. If a newer supported firmware version is available for the device, update the device firmware.
1. Verify that the device is supported for Microsoft Teams call controls.
1. If HID controls work after you close Skype for Business, review your coexistence configuration and apply only the registry settings that current Microsoft guidance documents for your supported scenario.
1. Restart Teams and Skype for Business after you apply any required configuration changes.

> [!NOTE]
> For current coexistence behavior and supported configuration, see the Microsoft Teams and Skype for Business coexistence and interoperability guidance on Microsoft Learn.
> Older deployment guidance may reference registry values such as `EnableTeamsHIDInterop` or `FreezeDisableHIDForConvergence`, older Skype for Business client version requirements, or legacy policy settings. Use current Microsoft guidance before you deploy or change these settings.

## More information

Expected behavior varies by coexistence mode:

- In TeamsOnly mode, HID controls are available in Teams.
- In Islands mode, Teams and Skype for Business can run side by side, and HID coordination depends on supported clients, devices, and coexistence configuration.
- In Skype for Business coexistence modes, HID behavior depends on which client owns the active call and the supported interoperability configuration.

If the issue occurs only when Skype for Business is running, the behavior points to cross-client coordination instead of a device-only failure.

For related troubleshooting, review documentation about Teams and Skype for Business coexistence, HID device support, and compatible devices and peripherals.
