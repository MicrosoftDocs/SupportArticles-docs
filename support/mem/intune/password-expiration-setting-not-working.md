---
title: Password expiration setting doesn't work
description: Describes an issue in which the password expiration device restriction setting doesn't function as expected on Android devices that are enrolled in Microsoft Intune.
ms.date: 05/11/2020
ms.prod-support-area-path: Device configuration
---
# Password expiration setting doesn't work as expected on Android devices

This article describes an issue in which the **Password expiration** device restriction setting doesn't function as expected.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4343011

## Symptoms

You deploy a policy that contains the following device restrictions setting for Android devices in Microsoft Intune:

**Password expiration (days)**

For example, you set the value to 180. However, the user isn't prompted to change the device password after 180 days.

## Cause

This issue occurs because the password expiration timer is reset when you edit the policy, even if you don't change the **Password expiration** setting.

For example, you assign the policy to devices that are enrolled on January 1, and the password expiration date is June 30. If you change the policy on June 29, the timer is reset, and the password expiration date is changed to December 26.

## More information

To find the latest password expiration date, go to the Azure portal, and then check the last modified date of the policy.

In the example scenario in the **Symptoms** section, assume that the policy is assigned to devices during enrollment. If a device is enrolled before the last modified date of the policy, its password expires 180 days after the last modified date. If the device is enrolled after the last modified date, its password expires 180 days after enrollment.
