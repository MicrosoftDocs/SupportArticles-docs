---
title: Can't access company resources on Intune-enrolled ADE devices
description: Troubleshoot an issue in which Conditional Access fails on an Apple Automated Device Enrollment (ADE) device that's enrolled in Microsoft Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Create and assign conditional access policy
ms.reviewer: kaushika
---
# You cannot access company resources on an Intune-enrolled ADE device

This article provides two methods to solve the error that occurs when you can't access company resources on an Apple Automated Device Enrollment (ADE) device.

## Symptoms

You have an ADE device that's enrolled in Microsoft Intune and has Conditional Access policies applied. When you try to access a cloud app on the device, you receive the following error message:

> Your sign-in was successful but your admin requires your device to be managed by <*CompanyName*> to access this resource.

:::image type="content" source="media/cannot-access-company-resources-on-dep/require-device-managed-error.png" alt-text="Screenshot of your admin requires your device to be managed by error.":::

## Cause

This issue occurs if the following conditions are true:

- The enrollment profile has **Authentication method** set to **Setup Assistant**.
- The Company Portal app isn't deployed to the ADE device.
- The Company Portal app is required to enforce Conditional Access policies.

## Solution 1

Set the **Authentication method** to **Company Portal** in the enrollment profile. To do this, follow these steps:

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), select **Devices** > **iOS/iPad** > **iOS/iPad enrollment** > **Enrollment Program Tokens**.

2. Select the token, select **Profiles**, select the enrollment profile that's assigned to the affected devices.

3. In the **Authentication method** list, select **Company Portal**.

    > [!NOTE]
    > After you change the authentication method from **Setup Assistant** to **Company Portal**, Intune skips user authentication through the iOS Setup Assistant and, instead, uses modern authentication. This enables the user to use Microsoft Entra multifactor authentication (MFA). This method can be enforced without blocking Apple ADE enrollment.

    :::image type="content" source="media/cannot-access-company-resources-on-dep/select-where-users-must-authenticate.png" alt-text="Screenshot of the Select where users must authenticate option.":::

## Solution 2

Deploy the Company Portal app to the device. To do this, follow the steps in [Add app configuration policies for managed iOS/iPadOS devices](/mem/intune/apps/app-configuration-policies-use-ios#configure-the-company-portal-app-to-support-ios-and-ipados-dep-devices).
