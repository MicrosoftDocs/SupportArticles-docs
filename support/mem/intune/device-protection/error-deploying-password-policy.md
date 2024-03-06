---
title: Error -2016281112 deploying password policy in Intune
description: Describes error -2016281112 when you deploy a password policy in Microsoft Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Device protection
ms.reviewer: kaushika
---
# Error -2016281112 when you deploy password policy in Microsoft Intune

This article fixes an issue in which you receive error -2016281112 when you deploy a password policy in Microsoft Intune.

## Symptom

When you deploy a device restriction policy for password in Microsoft Intune, you receive error -2016281112.

Here is an example case in which you specify the **Required password type** setting:

:::image type="content" source="media/error-deploying-password-policy/error-2016281112.png" alt-text="Screenshot of the error code -2016281112.":::

## Cause

For Android and Windows desktop devices, password policies can't be immediately enforced on users by using device restriction policies. If the user doesn't change the password as required by the policy, the error remains.

## Solution

To fix the issue, direct the users to change their password.

> [!NOTE]
>
> - On the Android platform, the user must accept the password change notification.
> - On the Windows MDM desktop platform, the user must press CTRL+ALT+DEL and select **Change Password**, and then the new password rules will be enforced.

## More information

For Android and Windows desktop devices, we recommend that you deploy a device-compliance policy to enforce the same password setting. This enforces the password change at device enrollment or blocks noncompliant devices from company resources.

You can also notify the users by email and give them a grace period to be compliant. See [Configure actions for noncompliant devices in Intune](/mem/intune/protect/actions-for-noncompliance).
