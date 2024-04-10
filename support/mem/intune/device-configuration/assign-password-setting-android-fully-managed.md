---
title: Tips for assigning device password settings to Android Enterprise fully managed devices in Intune
description: Describes different behavior when a device restrictions profile that includes password settings is assigned to Android Enterprise fully managed devices before and after enrollment. 
author: helenclu
ms.author: luche
ms.reviewer: kaushika, anziob
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure Devices - Android\Device restrictions
---
# Assigning device password settings to Android Enterprise fully managed devices in Intune

When you assign a device restrictions profile that includes password settings to Android Enterprise fully managed (formerly known as Corporate Owned Business Only) devices, a different behavior occurs depending on whether the profile is assigned before or after the devices are enrolled in Microsoft Intune.

## Behavior if the profile is assigned before enrollment

If the profile is assigned before the device is enrolled, the password settings are applied at the initial state of device setup. Therefore, you are prompted to set a password, as shown in the following screenshot:

:::image type="content" source="media/assign-password-setting-android-fully-managed/set-screen-lock.png" alt-text="Screenshot of the Set a screen lock step.":::

## Behavior if the profile is assigned after enrollment

If the profile is assigned after the device is enrolled, you aren't prompted to set a password during device setup, as shown in the following screenshot:

:::image type="content" source="media/assign-password-setting-android-fully-managed/install-work-apps.png" alt-text="Screenshot of the Install work apps step.":::

When the profile is assigned to the device, you won't be notified or prompted to set a password. The password settings deployment will report as failed until you manually set a password that meets the requirements.

## Recommendation

Because of the OS limitation on Android Enterprise fully managed devices, we recommend that you assign the device restrictions profile that includes password settings to the devices before enrollment.

## More information

When you assign the profile to a dynamic device group, the group membership is decided after the devices are enrolled. Therefore, the profile won't be applied to the targeted devices until the devices are registered to Intune.
