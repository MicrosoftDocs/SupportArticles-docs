---
title: Troubleshooting guidance for when a user is not authorized to enroll a Windows device in Intune
description: Helps resolve the issue when a user is not allowed to enroll their Windows device in Microsoft Intune.
ms.date: 10/06/2021
---

# Windows user is not authorized to enroll

This article gives troubleshooting steps to help resolve an issue where a user is not authorized to enroll their Windows device. 

## Symptom

When a user tries to enroll a Windows device, they see one of the following error messages:

> Error 0x801c003: "This user is not authorized to enroll. You can try to do this again or contact your system administrator with the error code (0x801c0003)."

> Error 80180003: "Something went wrong. This user is not authorized to enroll. You can try to do this again or contact your system administrator with error code 80180003."

# Cause

These errors can result from any of the following conditions:

- The user has already enrolled the maximum number of devices allowed in Intune.
- The device is blocked by the device type restrictions.
- The computer is running Windows 10 Home. However, enrolling in Intune or joining Azure Active Directory (Azure AD) is only supported on Windows 10 Pro and higher editions.
- The Azure AD setting **Users may join devices to Azure AD** is set to **None**, which prevents new users from joining their devices to Azure AD. Therefore Intune enrollment fails.

Try the following solutions, depending on your scenario.

## Solution 1

If your user has reached the maximum number of allowed devices, use these steps to remove unused devices.

1. Sign in to the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
2. Go to **Users** > **All Users**.
3. Select the affected user account, and then click **Devices**.
4. Select any unused or unwanted devices, and then click **Delete**.

## Solution 2

If there are no unused devices to remove, use these steps to increase the device enrollment limit.

> [!NOTE]
> This method increases the device enrollment limit for all users, not just the affected user.

1. Sign in to the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
1. Go to **Devices** > **Enrollment restrictions** > **Default** (under **Device limit restrictions**) > **Properties** > **Edit** (next to **Device limit**) > increase the **Device limit** (maximum 15)> **Review + Save**.

## Solution 3

Check if device enrollment is blocked by device type restrictions.

1. Sign in to the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431) with a global administrator account.
2. Go to **Devices** > **Enrollment restrictions**, and then select the **Default** restriction under **Device Type Restrictions**.
3. Select **Platforms**, and then select **Allow** for **Windows (MDM)**.

    > [!IMPORTANT]
    > If the current setting is already **Allow**, change it to **Block**, save the setting, and then change it back to **Allow** and save the setting again. This resets the enrollment setting.

4. Wait for approximately 15 minutes, and then enroll the affected device again.

## Solution 4

[Upgrade Windows 10 Home to Windows 10 Pro](https://support.microsoft.com/help/12384/windows-10-upgrading-home-to-pro) or a higher edition.

## Solution 5

Check or update your Azure AD settings to allow users to join devices.

1. Sign in to the [Azure portal](https://portal.azure.com/) as an administrator.
1. Go to **Azure Active Directory** > **Devices** > **Device Settings**.
1. Set **Users may join devices to Azure AD** to **All**.
1. Enroll the device again.
