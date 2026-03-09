---
title: Factory Reset Protection Emails Not Enforced in Intune for Android
description: Describes an issue in which an Android Enterprise device can be activated by using a Google account that isn't included in the "Factory reset protection emails" setting.
ms.date: 02/11/2025
search.appverid: MET150
ms.custom: sap:Configure Devices - Android\Device restrictions
ms.reviewer: kaushika
---

# Factory reset protection (FRP) enforcement behavior for Android Enterprise

> **Applies to:** Android Enterprise **corporate-owned work profile (COPE)**, **fully managed (COBO)**, **dedicated (COSU)**

Factory reset protection (FRP) helps prevent unauthorized access to your device after it's been factory reset. If the device is reset without your permission, in some situations, only the email addresses that you enter in the **Factory reset protection emails** setting can unlock the device. 

## Symptoms

Consider the following scenario:

- You have an Android Enterprise device that's enrolled in Microsoft Intune.
- The **Factory reset protection emails** setting is enabled, and an email address is provided, as shown in the following screenshot.

  :::image type="content" source="media/factory-reset-protection-emails-not-enforced/factory-reset-protection-emails.png" alt-text="Screenshot of Factory reset protection emails setting and a sample email address.":::

After a factory reset, devices sometimes prompt for a Google account (FRP) and sometimes don’t.

## Expected behavior

If the Intune setting, **Factory reset protection emails**, is configured, FRP is expected to behave as shown in the following table.

  | Enrollment method | Settings > Factory data reset | Settings > Recovery/bootloader | Intune [wipe](/intune/intune-service/configuration/device-restrictions-android-for-work) |
  | --- | --- | --- | --- |
  | **Corporate-owned devices with work profile** (COPE) | ✅ factory reset protection | ✅ factory reset protection | ❌ no factory reset protection |
  | **Fully managed** (COBO) | ❌ no factory reset protection | ✅ factory reset protection | ❌ no factory reset protection |
  | **Dedicated** (COSU) | ❌ no factory reset protection | ✅ factory reset protection | ❌ no factory reset protection |

> [!NOTE]
> - For the COPE method: FRP is enforced. The device requires one of the specified Google accounts to complete setup.
> - For the Intune wipe method: By default, FRP isn’t enforced because Intune doesn’t preserve FRP data in this flow.

If **Factory reset protection emails** is set to **Not configured** (default), Intune doesn't change or update this setting.
  
> [!NOTE]
> **Android 15** introduced FRP hardening. Some OEMs previously skipped FRP in certain paths. As of Android 15, FRP enforcement now aligns with Google’s intended design.

We recommend that you set the **Factory reset** value to **Block** to prevent users from using the factory reset option in the device settings. This is only available for fully managed and dedicated devices. 

:::image type="content" source="media/factory-reset-protection-emails-not-enforced/factory-reset.png" alt-text="Screenshot of Factory reset options.":::

Then, use one of the following methods when you reset the device to the factory settings:

- Reset the device through Recovery mode (FRP will be enforced).
- Wipe the device from Intune when the device is in your possession and is expected to be reset for further use (FRP will not be enforced).

For background and guidance, see [Factory reset protection (FRP) enforcement behavior for Android Enterprise](factory-reset-protection-emails-not-enforced.md).

## References

- [Device restriction settings for Android in Microsoft Intune](/intune/intune-service/configuration/device-restrictions-android-for-work?tabs=aecorporate)
