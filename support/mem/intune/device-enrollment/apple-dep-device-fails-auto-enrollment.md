---
title: Apple ADE devices don't start auto-enrollment in Intune
description: Describes an issue in which Microsoft Intune enrollment doesn't automatically start on Apple Automated Device Enrollment (ADE) devices when you turn on the devices.
ms.date: 12/23/2021
search.appverid: MET150
ms.custom: sap:iOS/iPadOS enrollment
ms.reviewer: kaushika
---
# Intune enrollment process doesn't start on Apple ADE devices

This article fixes an issue in which Intune enrollment doesn't automatically start on Apple [Automated Device Enrollment (ADE)](https://support.apple.com/en-us/HT204142) devices when you turn on the devices.

## Symptom

When you turn on an iOS device that's enrolled in the Apple ADE and is assigned an Intune enrollment profile, the Intune enrollment process doesn't start.

## Cause

This issue occurs if one of the following conditions is true:

- The enrollment profile is created before the ADE token is uploaded to Intune.
- There's no mobile device management (MDM) profile assigned to the device in Intune.

## Resolution

To fix this issue, follow these steps:

1. Make sure that an enrollment profile exists and is assigned to the device. For more information about how to create and assign an ADE enrollment profile, see [Create an Apple enrollment profile](/mem/intune/enrollment/device-enrollment-program-enroll-ios#create-an-apple-enrollment-profile).
1. If an enrollment profile exists and is assigned to the device, update the modification time of the enrollment profile by editing the profile and making any change.
1. Synchronize the ADE device; in the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), go to **Devices** > **iOS/iPadOS** > **iOS/iPadOS enrollment** > **Enrollment Program Tokens**.
1. Select the token in the list, and then select **Devices** > **Sync**.
1. After the synchronization finishes, turn on the ADE device.

For more information about how to enroll ADE devices, see [Automatically enroll iOS/iPadOS devices](/mem/intune/enrollment/device-enrollment-program-enroll-ios).
