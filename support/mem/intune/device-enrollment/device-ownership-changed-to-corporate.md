---
title: Android device ownership changed from Personal to Corporate
description: Describes an issue in which the ownership of an Android Enterprise work profile device is automatically changed to Corporate after an enrollment in Microsoft Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Enroll Devices - Android\Android  Enterprise - WorkProfile
ms.reviewer: kaushika
---
# Ownership of an Android Enterprise work profile device is automatically changed to Corporate after enrollment

This article helps you fix an issue where the ownership of an Android Enterprise work profile device is automatically changed to Corporate after an enrollment in Microsoft Intune.

## Symptoms

After you enroll an Android Enterprise work profile device in Intune, the ownership of the device is automatically changed to **Corporate**. You receive the following notification in the Company Portal app:

> Your company support changed the ownership type of this device from Personal to Corporate.

:::image type="content" source="media/device-ownership-changed-to-corporate/notification.png" alt-text="Screenshot of the notification.":::

## Cause

This issue occurs if a corporate identifier was added for the device in the [Microsoft Intune Admin Center](https://go.microsoft.com/fwlink/?linkid=2109431).

## Solution

To fix the issue, [delete the corporate identifier](/mem/intune/enrollment/corporate-identifiers-add#delete-corporate-identifiers) for the device, and then [change the device ownership](/mem/intune/enrollment/corporate-identifiers-add#change-device-ownership) to **Personal**.
