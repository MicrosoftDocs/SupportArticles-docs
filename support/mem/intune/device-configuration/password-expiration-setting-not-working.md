---
title: Password expiration setting for Android devices in Intune doesn't work
description: Describes an issue where the password expiration device restriction setting doesn't function as expected on Android devices that are enrolled in Microsoft Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure Devices - Android\Device restrictions
ms.reviewer: kaushika
---
# Device password expiration setting doesn't work as expected

This article describes an issue in which the **Password expiration** device restriction setting in Microsoft Intune doesn't function as expected.

## Symptoms

You deploy a policy that contains the following device restriction setting for Android devices in Intune:

**Password expiration (days)**

For example, you set the value to 180. However, the user isn't prompted to change the device password after 180 days.

## Cause

This issue usually occurs because you edited the policy after it was initially assigned to the device. When you edit a policy, the password expiration timer is reset&mdash;even if you don't change the **Password expiration** setting.

For example, you assign the policy to devices that are enrolled on January 1, and the password expiration date is June 30. If you change the policy on June 29, the timer is reset, and the password expiration date is changed to December 26.

## More information

To find the latest password expiration date, go to the Microsoft Intune admin console, and then check the last modified date of the policy.

In the example scenario in the **Symptoms** section, assume that the policy is assigned to devices during enrollment. If a device is enrolled *before* the last modified date of the policy, its password expires 180 days after the last modified date. If the device is enrolled *after* the last modified date, its password expires 180 days after enrollment.
