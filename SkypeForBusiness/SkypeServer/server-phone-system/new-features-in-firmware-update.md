---
title: New features in the firmware update for Polycom VVX IP phones
description: Describes the new features in the firmware update for the Polycom VVX IP phone that support Skype for Business Online.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business Online
ms.date: 03/31/2022
---

# New features in the firmware update for Polycom VVX IP phones

> [!IMPORTANT]
> Skype for Business Online will be retired on July 31, 2021. If you haven't upgraded your Skype for Business Online users to Microsoft Teams before that date, they will be automatically scheduled for an [assisted upgrade](/microsoftteams/upgrade-assisted). If you want to upgrade your organization to Teams yourself, we strongly recommend that you begin planning your upgrade path today. Remember that a successful upgrade aligns technical and user readiness, so be sure to leverage our [upgrade guidance](/microsoftteams/upgrade-start-here) as you navigate your journey to Teams.

## Introduction 

This article describes the features of the firmware update for the Polycom VVX Phone for Skype for Business (IP phone) that supports Microsoft Skype for Business Online.


### Firmware upgrade options

Phones that are certified for the Skype for Business Cloud PBX add-on are configured to download and install new firmware automatically when updates are available. For manual control of firmware upgrades, see [Set-CsIPPhonePolicy](/powershell/module/skype/Set-CsIPPhonePolicy).

To avoid affecting core business hours, the phones receive firmware updates during off hours for specific regions. The updates are also delivered on a staggered schedule to have a minimal effect on traffic bandwidth.

### Prerequisites for Cloud PBX automatic device updates

The following prerequisites apply to automatic device updates for Cloud PBX.
- The phone must be signed in by using a Skype for Business Online user account in order to download and install the new firmware.   
- A minimum software release of 5.4.0.10182 must be deployed on the phone in order to automatically download and install the new firmware by using a device update policy.    

### Supported models for this release

The following models of the Polycom VVX Business Media Phone are supported by this firmware update: 

- VVX 6**xx**   
- VVX 5**xx**   
- VVX 4**xx**   
- VVX 3**xx**   
- VVX 201   

> [!NOTE]
> - The estimated time to install new firmware on this phone is less than 15 minutes.   
> - The phone will restart as part of the upgrade process.   

### What's new

The following table lists the features that are provided in this firmware update.

|Feature|Description|
|---|---|
|Improved visual voice mail|Improvements to the visual representation of voice mail, retrieval process, and details and controls|
|Improved PC pairing|Improved and secure user experience for PC pairing, together with multiple-scenario enhancements and software updates|
|Web sign-in|A simple sign-in method for online users|
|Phone lock|A device security mechanism to protect the user's privacy and security|
|User interface (UI) improvements|Improvements to the Skype for Business UI on VVX5**xx** and VVX6**xx** phones|
|Log upload|Log upload mechanism for troubleshooting|
|QoE|Quality of Experience (QoE) upload metrics|
|Modern authentication support|For improved and secured authentication against Skype for Business and Microsoft Exchange Server|

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

## More information

- [Polycom Phones FAQ](https://support.poly.com/support/s/article/Poly-Teams-Device-Certification-FAQ)
- [OAuth 2.0 and third-party application ID](https://techcommunity.microsoft.com/t5/skype-for-business-blog/oauth-2-0-and-third-party-application-id-timeline-extended-to/ba-p/482876)
- [IP Phones](/skypeforbusiness/certification/devices-ip-phones)
- [Device update considerations](/skypeforbusiness/what-is-phone-system-in-office-365/getting-phones-for-skype-for-business-online/deploying-skype-for-business-online-phones#step-4---device-update-considerations)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
