---
title: Can't access company resources on DEP devices
description: Describes an issue in which Conditional Access fails on an Apple DEP device that's enrolled in Intune. Provides a resolution.
ms.date: 05/20/2020
ms.prod-support-area-path: Create and assign conditional access policy
---
# You cannot access company resources on a DEP device

This article provides the methods to solve the error that occurs when you access company resources on an Apple's Device Enrollment Program (DEP) device.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4493320

## Symptoms

You have a DEP device that's enrolled in Microsoft Intune and has Conditional Access policies applied. When you try to access a cloud app on the device, you receive the following error message:

> Your sign-in was successful but your admin requires your device to be managed by [*CompanyName*] to access this resource.

:::image type="content" source="media/cannot-access-company-resources-on-dep/error.png" alt-text="screenshot of error":::

## Cause

This issue occurs if the following conditions are true:

- The enrollment profile has **Select where users must authenticate** set to **Setup Assistant**.

    :::image type="content" source="media/cannot-access-company-resources-on-dep/user-affinity.png" alt-text="screenshot of User affinity":::

- The Company Portal app isn't deployed to the DEP device.
- The Company Portal app is required to enforce Conditional Access policies.

## Resolution - Method 1

Set **Select where users must authenticate** to **Company Portal** in the enrollment profile. To do this, follow these steps:

1. Sign in to [Intune](https://ms.portal.azure.com/#blade/Microsoft_Intune_DeviceSettings/ExtensionLandingBlade/overview), select **Device enrollment** > **Apple Enrollment** > **Enrollment program tokens**.

2. Select the token, select **Profiles**, select the enrollment profile that's assigned to the affected devices, then select **Properties**.

3. In the **Select where users must authenticate** list, select **Company Portal**.

    > [!NOTE]
    > After you change the authentication method from **Setup Assistant** to **Company Portal**, Intune skips user authentication through the iOS Setup Assistant and, instead, uses modern authentication. This enables the user to use Azure Active Directory multi-factor authentication (MFA). This method can be enforced without blocking Apple DEP enrollment.

## Resolution - Method 2

Deploy the Company Portal app to the device. To do this, follow the steps in [Configure the Company Portal app to support iOS DEP devices](/mem/intune/apps/app-configuration-policies-use-ios#configure-the-company-portal-app-to-support-ios-and-ipados-dep-devices).
