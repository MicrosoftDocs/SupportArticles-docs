---
title: App installation failed error after updating Android APK app - Intune
description: Describes an issue in which you receive the App installation failed error message after an Android APK app is updated in the Intune portal. This issue occurs if you have removed the app from the device.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Assign apps
ms.reviewer: kaushika
---
# App installation failed error after an Android APK app is updated

This article helps you fix an issue in which users receive the **App installation failed** error message after an Android APK app is updated in the Intune portal.

## Symptoms

After an Android line-of-business (LOB) APK app is updated in the Intune portal, users who were assigned the app receive the following notification on their devices:

> App installation failed.

## Cause

This issue occurs if users have removed the app from their devices. When the Intune service tries to update the app on a device, the update fails because the app is no longer installed on the device.

## Solution

To fix the issue, have the users reinstall the app from the Company Portal to their devices.
