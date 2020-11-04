---
title: Tips for assigning device password settings to Android Enterprise fully managed devices
description: Describes different behaviors when a device restrictions profile that includes password settings is assigned to Android Enterprise fully managed devices before and after enrollment. 
author: helenclu
ms.author: luche
ms.reviewer: shhodge
ms.date: 11/03/2020
ms.prod-support-area-path: 
---
# Support tip: Assign device password settings to Android Enterprise fully managed devices

When you assign a device restrictions profile that includes password settings to Android Enterprise fully managed (formerly known as Corporate Owned Business Only, or COBO) devices, different behaviors occur when the profile is assigned before and after the devices are enrolled in Intune.

## Behavior when the profile is assigned before enrollment

If the profile is assigned before the device is enrolled, the password settings are applied at the initial state of device setup, and you are prompted to set a password, as shown in the following screenshot:

:::image type="content" source="media/assign-password-setting-android-fully-managed/set-passcode.png" alt-text="Set a screen lock":::

## Behavior when the profile is assigned after enrollment

If the profile is assigned after the device is enrolled, you aren't prompted to set a password during device setup, as shown in the following screenshot:

:::image type="content" source="media/assign-password-setting-android-fully-managed/install-work-apps.png" alt-text="Install the work apps":::

When the profile is assigned to the device after enrollment, you won't be notified or prompted to set a password. The password settings deployment will report as failed until you manually set a password that meets the requirement.

## Tips

Due to the OS limitation on Android Enterprise fully managed devices, it's recommended that you assign the device restrictions profile that includes password settings to the devices before enrollment.

## More information

When you assign the profile to a dynamic device group, because the group membership is decided after the device is enrolled, the profile won't be applied to the targeted devices until the devices are registered to Intune.
