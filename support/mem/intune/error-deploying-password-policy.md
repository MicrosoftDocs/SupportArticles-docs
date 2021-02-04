---
title: Error -2016281112 deploying password policy
description: Describes error -2016281112 when you deploy a password policy in Microsoft Intune.
ms.date: 05/11/2020
ms.prod-support-area-path: Device protection
---
# Error -2016281112 when you deploy password policy in Microsoft Intune

This article fixes an issue in which you receive error -2016281112 when you deploy a password policy in Microsoft Intune.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4095085

## Symptom

When you deploy a device restriction policy for password in Microsoft Intune, you receive error -2016281112.

Here is an example case in which you specify the **Required password type** setting:

![Screenshot of the error code -2016281112.](./media/error-deploying-password-policy/error-code.png)

## Cause

For Android and Windows desktop devices, password policies can't be immediately enforced on the users by using device restriction policies. If the user doesn't change the password as required by the policy, the error remains.

## Resolution

To fix the issue, direct the users to change their password.

> [!NOTE]
>
> - On the Android platform, the end user must accept the password change notification.
> - On the Windows MDM desktop platform, the user must press CTRL+ALT+DEL and click **Change Password**, and then the new password rules will be enforced.

## More information

For Android and Windows desktop devices, we recommend that you deploy a device-compliance policy to enforce the same password setting. This enforces the password change at device enrollment or blocks noncompliant devices from company resources.

You can also notify the users by email and give them a grace period to be compliant. See [Configure actions for noncompliant devices in Intune](/mem/intune/protect/actions-for-noncompliance).
