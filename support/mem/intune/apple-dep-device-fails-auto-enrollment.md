---
title: Apple DEP devices don't start auto-enrollment
description: Describes an issue in which Intune enrollment doesn't automatically start on Apple DEP devices when you turn on the devices.
ms.date: 04/16/2020
ms.prod-support-area-path: iOS/iPadOS enrollment
---
# Intune enrollment process doesn't start on Apple DEP devices

This article fixes an issue in which Intune enrollment doesn't automatically start on Apple DEP devices when you turn on the devices.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4490645

## Symptom

When you turn on an iOS device that's enrolled in the Apple [Device Enrollment Program (DEP)](https://deploy.apple.com/) and is assigned an Intune enrollment profile, the Intune enrollment process doesn't start.

## Cause

This issue occurs if one of the following conditions is true:

- The enrollment profile is created before the DEP token is uploaded to Intune.
- There's no mobile device management (MDM) profile assigned to the device in Intune.

## Resolution

To fix this issue, follow these steps:

1. Make sure that an enrollment profile exists and is assigned to the device. For more information about how to create and assign a DEP enrollment profile, see [Create an Apple enrollment profile](/mem/intune/enrollment/device-enrollment-program-enroll-ios#create-an-apple-enrollment-profile).
2. If an enrollment profile exists and is assigned to the device, update the modification time of the enrollment profile by editing the profile and making any change.
3. Synchronize the DEP device; in [Intune in the Azure portal](https://aka.ms/intuneportal), go to **Mobile Device Management** > **iOS** > **Device Enrollment Program**, and then select **Sync now**.
4. After the synchronization finishes, turn on the DEP device.

For more information about how to enroll DEP devices, see [Automatically enroll iOS devices with Apple's Device Enrollment Program](/mem/intune/enrollment/device-enrollment-program-enroll-ios).
