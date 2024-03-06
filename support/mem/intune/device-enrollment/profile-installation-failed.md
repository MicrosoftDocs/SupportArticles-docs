---
title: Intune Profile installation failed on iOS/iPadOS device in Intune
description: Troubleshoot when an Intune profile fails to install on an iOS or iPadOS device.
ms.date: 12/05/2023
search.appverid: MET150
ms.reviewer: kaushika
---

# Troubleshooting profile installation failed error on iOS or iPadOS devices

This article gives troubleshooting steps to help you diagnose and resolve when a user receives a **Profile installation failed** error on an iOS/iPadOS device. Before you continue to scenario-specific troubleshooting steps, complete the general checks in [Profile installation failed](troubleshoot-device-enrollment-in-intune.md#profile-installation-failed).

## Error: Profile Installation Failed. A Network Error Has Occurred.

This error message indicates there's an unspecified problem with iOS/iPadOS on the device. Use these steps to back up device data and restore the device. 

1. Back up device data to an alternative storage/cloud location. This will prevent user data loss from the next steps (restoring iOS/iPadOS deletes all data on the device).
2. Put the device in recovery mode and then restore it. Make sure that you set it up as a new device. For more information about how to restore iOS/iPadOS devices, see [https://support.apple.com/HT201263](https://support.apple.com/HT201263).
3. Re-enroll the device.

## Error: Profile Installation Failed. Connection to the server could not be established.

This error message can indicate a few different issues. 

### Scenario 1

Your Intune tenant is configured to only allow corporate-owned devices. 

**Solution:**

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
1. Select **Devices** > **Enroll devices** > **Enrollment restrictions**.
1. Under **Device Type Restrictions**, select the restriction that you want to set > **Properties**.
1. Choose **Edit** > **Select platforms** > select **Allow** for **iOS**, and then click **OK**.
1. Select **Configure platforms**, select **Allow** for personally owned iOS/iPadOS devices, and then click **OK**.
1. Re-enroll the device.

### Scenario 2

You are enrolling a device that was previously enrolled with a different user account, and the previous user was not appropriately removed from Intune.

**Solution:**

1. Cancel any current profile installation.
1. Open [https://portal.manage.microsoft.com](https://portal.manage.microsoft.com) in Safari.
1. Re-enroll the device.

> [!NOTE]
> If enrollment still fails, remove cookies in Safari (don't block cookies), then re-enroll the device.

### Scenario 3

The device is already enrolled with another MDM provider.

**Solution:**

1. Open **Settings** on the iOS/iPadOS device, go to **General** > **VPN & Device Management**.
1. Remove any existing management profile.
1. Re-enroll the device.

### Scenario 4

The user who is trying to enroll the device does not have a Microsoft Intune license.

**Solution:**

1. Go to the [Microsoft 365 Admin Center](https://admin.microsoft.com), and then choose **Users > Active Users**.
1. Select the user account that you want to assign an Intune user license to, and then choose **Product licenses > Edit**.
1. Switch the toggle to the **On** position for the license that you want to assign to this user, and then choose **Save**.
1. Re-enroll the device.

## Error: Profile Installation Failed. The new MDM payload does not match the old payload.

This error indicates a management profile is already installed on the device. Complete the following steps to remove the existing management profile.

1. Open **Settings** on the iOS/iPadOS device > **General** > **VPN & Device Management**.
2. Tap the existing management profile, and tap **Remove Management**.
3. Re-enroll the device.
