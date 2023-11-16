---
title: Settings for Teams calls with Apple CarPlay on iOS device
description: Describes if you're unable to use Apple CarPlay in Teams, ask your administrator to configure settings for you.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 157482
  - CSSTroubleshoot
ms.reviewer: alicelu; meerak
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---

# Settings for Teams calls with Apple CarPlay

[Apple CarPlay](https://support.microsoft.com/office/place-teams-calls-with-apple-carplay-a96c617f-0249-4e12-8c06-788638497679) enables you to safely make Teams audio calls when you're on the road by using Siri voice commands. However, if you use a Microsoft Intune-managed iOS device to make the calls, Siri can be blocked from use by your administrator.

If you're unable to use Apple CarPlay in Teams, your administrator must configure the following settings by using the [Microsoft Endpoint Manager admin center](https://endpoint.microsoft.com/).

### Allow your device to use Siri

The default setting for using Siri should allow you to use CarPlay. If your admin has created a configuration profile that directs your device to block Siri, the setting must be updated.

1. Navigate to **Devices** > **Configuration profiles** > **Your_Configuration_profile** > **Properties** > **Configuration Settings** > **Built-in Apps**.

1. Set the **Block Siri** option to **Not configured**.

    :::image type="content" source="media/cannot-make-teams-calls-carplay/block-siri-setting.png" alt-text="Screenshot of setting the Block Siri option to not configured.":::

### Allow data transfer to any app on your device

If your admin has created an application protection policy that allows data transfer to only specific apps, that restriction must be removed to allow data transfer to all apps.

1. Navigate to **Apps** > **App protection policies** > **Your_App_protection_policy** > **Properties** > **Data protection**.

1. Set **Send Org data to other apps** to **All apps**.

    :::image type="content" source="media/cannot-make-teams-calls-carplay/setting-send-org-data-to-other-apps.png" alt-text="Screenshot of setting Send Org data to other apps to All apps.":::

For more information, see [iOS app protection policy settings](/mem/intune/apps/app-protection-policy-settings-ios#data-protection).
