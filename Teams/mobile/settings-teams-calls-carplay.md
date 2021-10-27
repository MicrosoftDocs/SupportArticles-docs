---
title: Settings for Teams calls with Apple CarPlay on iOS device
description: Describes if you're unable to use Apple CarPlay with Teams, ask your administrator to configure settings for you.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 157482
- CSSTroubleshoot
ms.reviewer: alicelu; meerak
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---

# Settings for Teams calls with Apple CarPlay

[Apple CarPlay](https://support.microsoft.com/en-us/office/place-teams-calls-with-apple-carplay-a96c617f-0249-4e12-8c06-788638497679) allows you to safely make Teams audio calls when you're on the road by using Siri voice commands. However, if you use a Microsoft Intune-managed iOS device to make the calls, Siri can be blocked from use by your administrator.

If you're unable to use Apple CarPlay with Teams, your administrator must configure the following settings in the [Microsoft Endpoint Manager admin center](https://endpoint.microsoft.com/):

## Allow your device to use Siri

To allow the device to use Siri, create and assign an iOS/iPadOS device restrictions configuration profile to the users or groups.

1. Navigate to **Devices** > **Configuration profiles**, create a device restrictions profile for iOS/iPadOS devices.

1. Under **Configuration settings** > **Built-in Apps**, set the [Block Siri](/mem/intune/configuration/device-restrictions-ios#settings-apply-to-all-enrollment-types-1) option to **Not configured**.

    :::image type="content" source="media/cannot-make-teams-calls-carplay/block-siri-setting.png" alt-text="Screenshot of configuring block Siri to not configured.":::

1. In **Assignments**, select the users or groups that will receive your profile. For more information on assigning profiles, see [assign user and device profiles](/mem/intune/configuration/device-profile-assign).

1. In **Review + create**, review your settings. When you select **Create**, your changes are saved, and the profile is assigned.

## Allow data transfer to and from any app on your device

To allow data transfer on the device, create and assign an iOS/iPadOS app protection policy to the users or groups.

1. Navigate to **Devices** > **Compliance polices**, create an app protection policy for iOS/iPadOS devices.

1. Under **Data protection** > **Data Transfer**.

    1. Set **Send Org data to other apps** to **All apps**.

    1. Set **Receive data from other apps** to **All apps**.

    :::image type="content" source="media/cannot-make-teams-calls-carplay/data-protection-setting .png" alt-text="Screenshot of configuring two settings: Send Org data to other apps and Receive data from other apps to All apps.":::

1. In **Assignments**, assign the app protection policy to the users or groups.

1. In **Review + create**, review your settings. When you select **Create**, your changes are saved, and the policy is assigned.

For more information, see [create app protection policies](/mem/intune/apps/app-protection-policies) and [iOS app protection policy settings](/mem/intune/apps/app-protection-policy-settings-ios#data-protection).
