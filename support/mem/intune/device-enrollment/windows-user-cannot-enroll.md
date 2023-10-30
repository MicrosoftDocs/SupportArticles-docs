---
title: Windows user is not authorized to enroll in Intune
description: Troubleshooting guidance for when a user cannot enroll a Windows device in Microsoft Intune
ms.date: 12/02/2021
ms.reviewer: kaushika, joelste
search.appverid: MET150
---

# Windows user is not authorized to enroll

This article gives troubleshooting steps to help resolve an issue where a user is not authorized to enroll their Windows device.

## Symptom

When a user tries to enroll a Windows device, they see one of the following error messages:

> Error 0x801c003: "This user is not authorized to enroll. You can try to do this again or contact your system administrator with the error code (0x801c0003)."

> Error 80180003: "Something went wrong. This user is not authorized to enroll. You can try to do this again or contact your system administrator with error code 80180003."

## Cause

These errors can result from any of the following conditions:

- The user has already enrolled the maximum number of devices allowed in Intune. (See [Solution 1](#solution-1) and [Solution 2](#solution-2).)
- The device is blocked by the device type restrictions. (See [Solution 3](#solution-3).)
- The computer is running Windows 10 Home. However, enrolling in Intune or joining Microsoft Entra ID is only supported on Windows 10 Pro and higher editions. (See [Solution 4](#solution-4).)
- The Microsoft Entra setting **Users may join devices to Microsoft Entra ID** is set to **None**, which prevents new users from joining their devices to Microsoft Entra ID. Therefore Intune enrollment fails. (See [Solution 5](#solution-5).)

Try the following solutions, depending on your scenario.

## Solution 1

If your user has reached the maximum number of allowed devices, use these steps to remove unused devices.

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
1. Go to **Users** > **All Users**.
1. Select the affected user account, and then click **Devices**.
1. Select any unused or unwanted devices, and then click **Delete**.

## Solution 2

If there are no unused devices to remove, use these steps to increase the device enrollment limit.

> [!NOTE]
> This method increases the device enrollment limit for all users, not just the affected user.

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
1. Go to **Devices** > **Enrollment restrictions** > **Default** (under **Device limit restrictions**) > **Properties** > **Edit** (next to **Device limit**) > increase the **Device limit** (maximum 15)> **Review + Save**.

## Solution 3

Check if device enrollment is blocked by device type restrictions.

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431) with a global administrator account.
1. Go to **Devices** > **Enrollment restrictions**, and then select the **Default** restriction under **Device Type Restrictions**.
1. Select **Platforms**, and then select **Allow** for **Windows (MDM)**.

    > [!IMPORTANT]
    > If the current setting is already **Allow**, change it to **Block**, save the setting, and then change it back to **Allow** and save the setting again. This resets the enrollment setting.
1. Wait for approximately 15 minutes, and then enroll the affected device again.

## Solution 4

[Upgrade Windows 10 Home to Windows 10 Pro](https://support.microsoft.com/help/12384/windows-10-upgrading-home-to-pro) or a higher edition.

## Solution 5

Check or update your Microsoft Entra settings to allow users to join devices.

1. Sign in to the [Azure portal](https://portal.azure.com/) as an administrator.
1. Go to **Microsoft Entra ID** > **Devices** > **Device Settings**.
1. Set **Users may join devices to Microsoft Entra ID** to **All**.
1. Enroll the device again.
