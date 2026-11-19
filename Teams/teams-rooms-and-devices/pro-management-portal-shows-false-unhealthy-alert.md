---
title: Pro Management Portal shows a false unhealthy alert
description: Learn why Microsoft Teams Rooms devices can show a false unhealthy peripheral alert in Pro Management Portal and how to refresh device sync.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Windows
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/17/2026
---

# Pro Management Portal shows a false unhealthy alert

## Summary

This article explains why Pro Management Portal can show a false unhealthy alert for a peripheral on a Microsoft Teams Rooms for Windows device, and how to refresh the device sync to clear the alert.

## Symptoms

In Pro Management Portal, a peripheral such as a camera appears as **Unhealthy** even though the peripheral works as expected on the Microsoft Teams Rooms device.

## Cause

A sync issue between the device and Pro Management Portal can cause the portal to show a false unhealthy alert.

## Resolution

Refresh the sync by making a configuration change for the affected peripheral in Pro Management Portal.

1. Open Pro Management Portal, and sign in with an admin account.
1. Open the Microsoft Teams Rooms on Windows device that shows the unhealthy peripheral alert.
1. Go to the settings for the affected peripheral, such as **Settings** > **Camera**.
1. Change the peripheral setting to the desired device, or set it to **None**.
1. Apply the change.

This action resets the sync process between the device and Pro Management Portal and can stop further false unhealthy alerts.

## More information

If you investigate the issue from the device, the Microsoft Teams Rooms app can report a peripheral as unhealthy in device logs even when the peripheral appears to work correctly.

For related information about managing Microsoft Teams Rooms on Windows devices, see the [Microsoft Learn article about Pro Management Portal settings](/MicrosoftTeams/rooms/pro-portal-settings)
