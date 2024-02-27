---
title: Factory reset protection emails not enforced in Intune for Android
description: Describes an issue in which an Android Enterprise device can be activated by using a Google account that isn't included in the factory reset protection email message setting.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure device restrictions
ms.reviewer: kaushika
---
# Factory reset protection emails setting isn't enforced after you reset an Android Enterprise device

This article provides a solution for the issue that the **Factory reset protection emails** setting does not work as expected for an enrolled Android Enterprise Device Owner device.

## Symptoms

Consider the following scenario:

- You have an Android Enterprise device that's enrolled in Microsoft Intune.
- The **Factory reset protection emails** setting is enabled, and an email address is provided, as shown in the following screenshot:

  :::image type="content" source="media/factory-reset-protection-emails-not-enforced/factory-reset-protection-emails.png" alt-text="Screenshot of Factory reset protection emails setting and a sample email address.":::

- You do a factory reset on the device through the **Settings** menu (for example, tap **Settings** > **General management** > **Reset** > **Factory data reset**), or you wipe the device from Intune in the Microsoft Intune admin center.

In this scenario, you can activate the device by using a Google account that isn't included in the **Factory reset protection emails** setting.

## Cause

This behavior is expected. When you do a factory reset on the device through the **Settings** menu or you wipe the device from Intune in the Microsoft Intune admin center, all your data is removed. This includes the Factory Reset Protection (FRP) data.

## Solution

The only way to do a factory reset on the device without losing the FRP data is through Recovery Mode.

We recommend that you set the **Factory reset** value to **Block** to prevent users from using the factory reset option in the device settings.

:::image type="content" source="media/factory-reset-protection-emails-not-enforced/factory-reset.png" alt-text="Screenshot of Factory reset options.":::

Then, use one of the following methods when you reset the device to the factory settings:

- Reset the device through Recovery mode.
- Wipe the device from Intune when the device is in your possession and is expected to be reset for further use.
