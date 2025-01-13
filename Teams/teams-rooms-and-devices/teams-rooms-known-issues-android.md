---
title: Known issues with Teams Rooms on Android
description: Provides a list of known issues for Teams Rooms on Android.
ms.author: luche
author: helenclu
ms.reviewer: sohailta, garyanselme, czawideh
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
f1.keywords: 
  - NOCSH
ms.collection: 
  - M365-collaboration
ms.custom: 
  - sap:Msft Teams Rooms Android (MTRA)
  - seo-marvel-apr2020
  - CSSTroubleshoot
  - CI 121996
  - CI 160661
  - CI 164223
  - CI 187786
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 01/13/2025
---
# Known issues with Teams Rooms on Android

<!-- If you get word that one of these issues no longer applies, contact meerak@microsoft.com to EoL the corresponding KB.  -->

## Issues affecting multiple devices

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Teams Rooms on Android devices experience a delay with signing in after a user signs out.|You sign out of a Teams Rooms on Android device either manually or from the Microsoft Teams admin center. When you try to sign in again immediately, there's a delay. This delay is because the authentication code takes 15 minutes or longer to refresh after a device signs out.<br/><br/>This issue occurs on all Teams on Android devices, including those devices that are running version 5.0.6061.0 of the Company portal app.|Restart the affected device to force the code to refresh.|
|Unable to open a whiteboard on Android touch displays and all-in-one devices.|On Teams Rooms for Android touch displays and all-in-one devices, you're unable to start a whiteboard session outside of a meeting by selecting the **Whiteboard** option.<br/><br/>This issue occurs on devices that are running on tenants which are more than two years old.|To resolve this issue, contact Microsoft Support.|

## Issues with Teams phones

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Sign in loops or fails for Teams on Android phones |You can't sign in or the sign-in continually loops when both the MFA and the Terms of Use (ToU) Conditional Access (CA) policies are used. |The combination of MFA CA and ToU CA isn't supported. You should exclude it from being used. <br><br> To avoid the sign-in error, ensure that only the MFA CA or only the Mobile Device Management (MDM) CA is used. When only the MFA CA is used, make sure that it's enabled in Device Registration Services (DRS). For more information, see [Conditional Access: Cloud apps, actions, and authentication context](/azure/active-directory/conditional-access/concept-conditional-access-cloud-apps#user-actions).|
|Can't add, delete, or edit contacts on Android phones|You can't perform the add, delete, and edit operations on contacts from Teams on Android phones.|Use either the Teams desktop or the Teams web client to perform these actions.|
|Signed out of Teams on Android devices | Teams Rooms on Android, Teams phone devices, Teams panels, and Teams displays are signed out of Teams automatically. | Follow the instructions provided in [Signed out of Teams on Android devices](./signed-out-of-teams-android-devices.md).|
|Can't resume a call after using **Consult first** option on Teams phones | After using the **Consult first** option in the **Transfer** menu when you select the **Resume** option to resume the call, the call fails. | End the call made by using the **Consult first** option and then resume the original call.|
|Calls on long hold in GCC High tenants drop intermittently|On GCC High tenants that are running 2022 update #4A (Teams app version 1449/1.0.94.2022110803), when a user puts a call on long hold the call drops in some instances. This issue doesn't occur on other clouds.|No workaround is available at this time.|

## Limitations

- Teams Rooms doesn't support High-Bandwidth Digital Content Protection (HDCP) input. Using HDCP input might cause issues that affect High-Definition Multimedia Interface (HDMI) ingest functionality, such as video and audio. To avoid these issues, make sure that the HDCP options are turned off for switches that are connected to Teams Rooms.
- Teams Rooms on Android doesn't support the ability to join cross-cloud meetings.
- When you use the Call app on a Teams Rooms device to dial the toll number or conference ID for a Teams meeting, the conference bridge triggers multiple call flows. Because the Teams Rooms app is designed to support only one active call at a time, the call fails.

  Instead of using the Call app, join the meeting by using the **Join with an ID** option and entering the meeting ID.
- If you're in a call with another user who is on a Teams Rooms device, you can't transfer the call. This is because the Teams Rooms app is designed to support only one call at a time.
- If your organization has configured policies to block legacy authentication for the Teams Rooms app, then Teams Rooms on Android devices, (Teams Rooms on Windows devices) Teams displays, Teams panels, and Teams phones can't join Teams meetings.
- If your organization has configured policies to block legacy authentication for the Teams Rooms app, then Teams Rooms on Android devices, Teams displays, Teams panels, and Teams phones can't join Teams meetings.
- The meeting details that you export in the Microsoft Teams admin center includes the link speed of the Ethernet network interface that's used during the meeting. This display always shows the default value of 10 Mbps. However, this might not be accurate because Teams Rooms for Android devices can't fetch the exact value. The actual link speed might be faster than the default value.

## Support for third-party Teams devices

For issues with Teams devices offered by third-party providers, contact their individual sites for support:

- Logitech: [Logitech Support](https://support.logi.com/hc/)
- Crestron: [Crestron Support](https://support.crestron.com/)
- Poly: [Poly Support](https://www.poly.com/us/support)
- Yealink: [Yealink Support](https://support.yealink.com/portal/home)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
