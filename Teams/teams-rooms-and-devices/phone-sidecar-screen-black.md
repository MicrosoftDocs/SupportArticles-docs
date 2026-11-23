---
title: Phone sidecar expansion module screen is black
description: Learn why a phone sidecar expansion module shows a black screen after startup and how to fix it.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams
ms.reviewer: joshj, iztoth, taherr, gurug, miaitelh
author: Cloud-Writer
ms.author: meerak
ms.date: 10/19/2026
---

# Phone sidecar expansion module screen is black

## Summary

This article explains how to restore a phone sidecar expansion module that shows a black screen by updating the Microsoft Intune device restrictions policy that controls screen capture.

## Symptoms

Your phone sidecar (expansion module) shows the normal boot screen during startup. After startup finishes and the phone is otherwise running, the sidecar screen turns black and doesn't show any content.

## Cause

This issue is likely caused by a Microsoft Intune device restrictions policy that blocks screen capture on the Android Open Source Project (AOSP) profile for the device.

## Resolution

1. In Microsoft Intune, review the device restrictions policies that apply to the affected device or user.
1. Check whether the AOSP profile has a setting that blocks screen capture.
1. If the setting is enabled, update the policy so screen capture isn't blocked for devices that use the sidecar expansion module.
1. Sync the device, or wait for the updated policy to apply.
1. Confirm that the sidecar screen now shows content normally.

> [!NOTE]
> You might not find evidence of this behavior in the standard Teams device logs.

## More information

This issue is associated with the **Device restrictions** policy in Intune for Android Enterprise AOSP devices. For more information, see the following articles:

- [Device restriction settings for Android in Microsoft Intune](/intune/intune-service/configuration/device-restrictions-android-for-work?tabs=aosp#general-1)
- [Restrict device features using policy in Microsoft Intune](/intune/intune-service/configuration/device-restrictions-configure#create-the-profile)
