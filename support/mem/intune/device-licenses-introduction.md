---
title: Purchase device licenses in Microsoft Intune
description: Introduces a new device-only subscription service that helps organizations manage devices that are not affiliated with specific users.
ms.date: 05/25/2021
ms.custom: sap:Microsoft Intune
---
# Introduction to device licenses in Microsoft Intune

Microsoft Intune offers a device-only subscription service that helps organizations manage devices that aren't affiliated with specific users.
You can't assign an Intune device license, usage is based on trust.

The Intune device subscription is licensed per device at a cost of $2 a month. For more information about the purpose of Intune device licensing, see [Microsoft Intune announces device-only subscription for shared resources](https://techcommunity.microsoft.com/t5/Enterprise-Mobility-Security/Microsoft-Intune-announces-device-only-subscription-for-shared/ba-p/280817).

## How to purchase the device-only subscription

You can purchase device licenses based on your estimated usage. Microsoft Intune device licenses are applicable when a devices is enrolled through any of the following methods:

- [Windows Autopilot Self-Deploying mode](/windows/deployment/windows-autopilot/self-deploying)
- [Apple Device Enrollment Program without user affinity](/mem/intune/enrollment/device-enrollment-program-enroll-ios)
- [Apple School Manager without user affinity](/mem/intune/enrollment/apple-school-manager-set-up-ios)
- [Apple Configurator without user affinity](/mem/intune/enrollment/apple-configurator-enroll-ios)
- [Android Enterprise dedicated](/mem/intune/enrollment/android-kiosk-enroll)
- [Using a device enrollment manager account](/mem/intune/enrollment/device-enrollment-manager-enroll)

> [!NOTE]
> Visit the [Microsoft Licensing](https://www.microsoft.com/licensing/default) page, or contact your account representative if you have any questions or you would like to receive the latest information about product editions, product licensing updates, volume licensing plans, and other information related to your specific use cases.

## Limitations

When a device is enrolled by using a device license, the following Intune functions aren't supported:

- [Intune app protection policies](/mem/intune/apps/app-protection-policy)
- [Conditional access](/mem/intune/protect/conditional-access)
- User-based management features, such as email and calendaring.
