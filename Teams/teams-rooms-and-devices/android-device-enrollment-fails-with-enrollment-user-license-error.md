---
title: Android device enrollment fails with EnrollmentUserLicense error
description: Learn how to fix an AOSP enrollment issue in which Teams Android devices sign in but don't appear in Intune and show an EnrollmentUserLicense error.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams, Microsoft Teams Rooms for Android
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/12/2026
---

# Android device enrollment fails with EnrollmentUserLicense error

## Summary

This article describes an issue in which a Teams Android device can sign in after an upgrade to Android Open Source Project (AOSP) firmware, but the device doesn't appear in Microsoft Intune. In this scenario, Intune shows an unknown enrollment error, and the enrollment process fails with an EnrollmentUserLicense error.

## Symptoms

After you upgrade a Teams Android device to AOSP firmware, you see the following behavior:

- The device signs in successfully.
- The device doesn't appear in Intune.
- The Intune admin center shows an unknown enrollment error for the device.
- The enrollment process fails with an EnrollmentUserLicense error.

## Cause

This issue occurs when the account that you use for enrollment is assigned as a Device Enrollment Manager (DEM). DEM isn't supported for AOSP enrollment.

## Resolution

Remove the enrollment account from the Device Enrollment Managers list, and then enroll the device again.

1. Go to the Microsoft Intune admin center.
1. Open **Devices** > **Enroll devices** > **Device enrollment managers**.
1. Locate the account that you're using to enroll the Teams Android device.
1. Remove that account from the Device Enrollment Managers list.
1. Start the enrollment process again on the device.

## More information

For more information about Device Enrollment Manager support and limitations, see [Enroll devices using a device enrollment manager account](/mem/intune/enrollment/device-enrollment-manager-enroll).

> [!NOTE]
> A user can have the required Intune and Teams licensing and still experience this issue if the account is configured as a Device Enrollment Manager.
