---
title: Factory reset protection emails setting not enforced
description: Describes an issue in which an Android Enterprise Device Owner device can be activated by using a Google account that isn't included in the factory reset protection email message setting.
ms.date: 05/20/2020
ms.prod-support-area-path: Configure device restrictions
---
# Factory reset protection emails setting isn't enforced after you reset an Android Enterprise Device Owner device

This article provides a solution for the issue that the **Factory reset protection emails** setting does not work as expected for an enrolled Android Enterprise Device Owner device.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4505994

## Symptoms

Consider the following scenario:

- You have an Android Enterprise Device Owner device that's enrolled in Microsoft Intune.
- The **Factory reset protection emails** setting is enabled, and an email address is provided, as shown in the following screenshot:

  :::image type="content" source="media/factory-reset-protection-emails-not-enforced/factory-reset-protection-emails.png" alt-text="screenshot of Factory reset protection emails":::

- You do a factory reset on the device through the **Settings** menu (for example, tap **Settings** > **General management** > **Reset** > **Factory data reset**), or you wipe the device from Intune in the Azure portal.

In this scenario, you can activate the device by using a Google account that isn't included in the **Factory reset protection emails** setting.

## Cause

This behavior is expected. When you do a factory reset on the device through the **Settings** menu or you wipe the device from Intune in the Azure portal, all your data is removed. This includes the Factory Reset Protection (FRP) data. The only way to do a factory reset on the device without losing the FRP data is through Recovery mode.

## More information

We recommend that you set the **Factory reset** value to **Block** to prevent users from using the factory reset option in the device settings.

:::image type="content" source="media/factory-reset-protection-emails-not-enforced/factory-reset.png" alt-text="screenshot of Factory reset":::

Then, use one of the following methods when you reset the device to the factory settings:

- Reset the device through Recovery mode.
- Wipe the device from Intune when the device is in your possession and is expected to be reset for further use.
