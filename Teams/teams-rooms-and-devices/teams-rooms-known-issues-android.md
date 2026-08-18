---
title: Known issues with Teams on Android devices
description: Provides a list of known issues with Android devices that run Teams.
ms.author: meerak
author: Cloud-Writer
ms.reviewer: meerak
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
ms.date: 08/18/2026
---
# Known issues with Teams Android devices

<!-- If you get word that one of these issues no longer applies, contact meerak@microsoft.com to EoL the corresponding KB.  -->

## Issues affecting multiple device types

| Issue | Description | Workaround |
| -------- | -------- | -------- |
|Signed out of Teams on Android devices |Teams Rooms on Android, Teams Phones, Teams panels, and Teams displays are signed out of Teams automatically due to a policy block on the device registration service.| See [Signed out of Teams on Android devices](./signed-out-of-teams-android-devices.md) for more information. |

## Issues affecting Teams meeting room devices

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Unable to join E2EE meeting using Teams Rooms on Android device. | When you use a Teams Rooms on Android device that is paired with a console, you're not able to join a Teams meeting that is set up with end-to-end encryption (E2EE). | No workaround is available at this time. |

## Issues affecting Teams phone devices

| Issue |  Description | Workaround |
| --- | --- | --- |
|Sign in loops or fails for Teams Phones.|You can't sign in or the sign-in continually loops when both the MFA and the Terms of Use (ToU) Conditional Access (CA) policies are used. |The combination of MFA CA and ToU CA isn't supported. You should exclude it from being used. <br><br> To avoid the sign-in error, ensure that only the MFA CA or only the Mobile Device Management (MDM) CA is used. When only the MFA CA is used, make sure that it's enabled in Device Registration Services (DRS). For more information, see [Conditional Access: Cloud apps, actions, and authentication context](/azure/active-directory/conditional-access/concept-conditional-access-cloud-apps#user-actions).|
|Incoming calls generate a "Just me" chat automatically.|When you receive a call from a main call queue on a Teams Phone, a "Just Me" chat is generated automatically in the Teams desktop app. This chat only includes you and it remains in the chat notifications list until you delete it manually. A new chat is generated with each incoming call.<br/><br/>The problem occurs specifically when answering calls from a call queue on a Teams Phone device, but not when they're answered by using the Teams desktop app.|To work around the issue, turn on Conference mode for the call queue. Use the following steps:<br/><ol><li>In the Microsoft Teams admin center, select **Call queues**.</li><li>Select **Edit a call queue** > **Call answering**.</li><li>On the Call answering page, toggle the **Conference mode** button to turn it on.</li></ol>|
|Unable to save app configuration settings in the Teams admin center.|In the Microsoft Teams admin center you're not able to access the **Allowed apps** feature to remove applications that're installed on Teams Phone devices. This feature has been rolled back temporarily.|No workaround is available at this time.|
|Can't configure ringtones for line keys on a device.| When you use line keys on either a Yealink, AudioCodes, or Poly device that is provisioned with a Teams Shared Space license, you can't configure ringtones for individual line keys.| Configure a ringtone for a line key by using a user license, such as an E5 license instead. <br/><br/> Use the following steps:<br/><ol><li>On a touch-enabled device's home screen, select the **Line Keys** app. <br/>On a non-touch enabled device, select an assigned line key.</li><li>By using your finger, long press on an assigned line key and select **Manage Ringtone**.</li></ol>|
|Basic Calling displays instead of Advanced Calling.| You're using a Teams Shared Devices license that has the sign-in mode set to Common Area Phone (CAP) and is enabled for Advanced Calling. However, you see the Basic Calling experience instead of the expected Advanced Calling experience. This issue occurs after you update the device to version 1449/1.0.94.2026220406.| Use one of the following workarounds:<ol><li> [Change the sign-in mode to UserSignIn by using the Teams IP Phone policy](/microsoftteams/phones/set-up-common-area-phones).</li><li>[Re-enable Advanced Calling in the Microsoft Teams admin center](/microsoftteams/phones/set-up-common-area-phones#turn-on-advanced-calling-in-teams-admin-center).</li><li>[Enable Advanced Calling directly on the device](/microsoftteams/phones/set-up-common-area-phones#turn-on-advanced-calling-from-a-teams-phone-device).</li></ol>|

## Limitations

- Teams Rooms doesn't support High-Bandwidth Digital Content Protection (HDCP) input. Using HDCP input might cause issues that affect High-Definition Multimedia Interface (HDMI) ingest functionality, such as video and audio. To avoid these issues, make sure that the HDCP options are turned off for switches that are connected to Teams Rooms.
- Teams Rooms on Android devices that are paired with a console don't support the ability to join cross-cloud meetings. However devices that aren't paired with a console can join cross-cloud meetings by installing Teams Rooms on Android app version [1449/1.0.96.2025325609](/MicrosoftTeams/rooms/rooms-release-note?tabs=Android#144910962025325609-october-2025) or a later version.
- When you use the Call app on a Teams Rooms device to dial the toll number or conference ID for a Teams meeting, the conference bridge triggers multiple call flows. Because the Teams Rooms app is designed to support only one active call at a time, the call fails. Instead of using the Call app, join the meeting by using the **Join with an ID** option and entering the meeting ID.
- If you're in a call with another user who is on a Teams Rooms device, you can't transfer the call. The Teams Rooms app is designed to support only one call at a time.
- The meeting details that you export in the Microsoft Teams admin center includes the link speed of the Ethernet network interface that's used during the meeting. The details always display the default value of 10 Mbps. However, this value might not be accurate because Teams Rooms for Android devices can't fetch the exact value. The actual link speed might be faster than the default value.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
