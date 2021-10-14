---
title: Can't make Teams calls with Apple CarPlay on iOS device
description: Describes an issue in which you can't make Teams calls with CarPlay. This issue occurs because the access to Siri or the app data transfer may be blocked.
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

# Can't make Teams calls with Apple CarPlay

If users can't use a Microsoft Intune-managed iOS device to [place Teams calls with Apple CarPlay](https://support.microsoft.com/en-us/office/place-teams-calls-with-apple-carplay-a96c617f-0249-4e12-8c06-788638497679), the access to Siri or the app data transfer may be blocked on the device. In [Microsoft Endpoint Manager admin center](https://endpoint.microsoft.com/), administrators should configure the following settings:

- Allow the device to use the Siri voice assistant:  
    Configure the **[Block Siri](/mem/intune/configuration/device-restrictions-ios#settings-apply-to-all-enrollment-types-1)** setting to **Not configured** (default) for built-in apps.

- Allow the app data transfer from and to any app on the device:
Configure the two [app data protection settings](/mem/intune/apps/app-protection-policy-settings-ios#data-protection) **(Send Org data to other apps** and **Receive data from other apps**) to **All apps**. The receiving app will have the ability to read and edit the data.

For more information, see [Join a meeting in Teams with CarPlay](https://support.microsoft.com/en-us/office/join-a-meeting-in-teams-1613bb53-f3fa-431e-85a9-d6a91e3468c9#ID0EDBD=Mobile).
