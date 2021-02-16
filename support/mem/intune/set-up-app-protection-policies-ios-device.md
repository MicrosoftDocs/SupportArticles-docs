---
title: Set up app protection policies for iOS devices
description: Describes how to set up and validate Intune app protection policies for managed iOS devices.
ms.date: 05/13/2020
ms.prod-support-area-path: App management
---
# Set up and validate app protection policies for managed iOS devices

This article provides the steps to have Intune app protection policies apply only to managed iOS devices.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4482726

## Set up app protection policies to apply only to managed iOS devices

To have Intune app protection policies apply only to managed iOS devices, follow these steps:

1. In the app protection policies, set **Target to all app types** to **No**, and then select **Apps on Intune managed devices** from the **App types** drop-down list.

    :::image type="content" source="media/set-up-app-protection-policies-ios-device/target-app-types.png" alt-text="screenshot of Target app types":::

2. Deploy the policy-managed apps through the Mobile Device Management (MDM) channel with **Available** or **Required** intent. The apps can't be installed from the App Store.

3. Create an app configuration policy for each targeted app. **Device enrollment type** must be set to **Managed devices**. And you must set the **IntuneMAMUPN** key and value. For more information, see [Target app protection policies based on device management state](/mem/intune/apps/app-protection-policies#target-app-protection-policies-based-on-device-management-state). Here's an example:

    :::image type="content" source="media/set-up-app-protection-policies-ios-device/policy-setting.png" alt-text="screenshot of Policy setting":::

4. After the configuration policies are assigned, verify the app configuration status for each managed device. To do this, go to **Devices** > **All devices** from **Microsoft Intune** in the Azure portal, select a device from the list of managed devices, and then select **App configuration** on the device blade.

    :::image type="content" source="media/set-up-app-protection-policies-ios-device/app-configuration.jpg" alt-text="screenshot of App configuration":::

5. To validate the setup, select a user and check the **APP PROTECTION STATUS** for that user. For more information, see [How to validate your app protection policy setup](/mem/intune/apps/app-protection-policies-validate).

    :::image type="content" source="media/set-up-app-protection-policies-ios-device/app-protection-status.jpg" alt-text="screenshot of App protection status":::
