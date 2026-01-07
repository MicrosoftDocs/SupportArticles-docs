---
title: Known issues with Teams on Android devices
description: Provides a list of known issues with Android devices that run Teams.
ms.author: meerak
author: Cloud-Writer
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
ms.date: 01/07/2026
---
# Known issues with Teams on Android devices

<!-- If you get word that one of these issues no longer applies, contact meerak@microsoft.com to EoL the corresponding KB.  -->

## Issues affecting Teams meeting room devices

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Unable to join E2EE meeting using Teams Rooms on Android device.|You're not able use a Teams Rooms on Android device that is paired with a console to join a Teams meeting that is set up with end-to-end encryption (E2EE).|No workaround is available at this time.|
|Mute/unmute controls don't work.|On Cisco's Teams Rooms on Android devices, the Mute and Unmute functionality doesn't work reliably during a Teams meeting. This issue occurs after you install the 1449/1.0.96.2025328903 version of the Teams Rooms on Android app.|Upgrade to the 1449/1.0.96.2025341701 version of the Teams Rooms app to resolve the issue.|
|Unable to download software updates on Teams Rooms on Android devices.| Your device is running one of the following versions of the Teams Rooms on Android app and you're unable to install software updates on the device:<br/><ul><li>1449/1.0.96.2025328903</li><li>1449/1.0.96.2025325609</li></ul><br/>This issue occurs because the available space on the device is not enough to download software updates to install.|Use the Microsoft Teams admin center to sign out of the device and then sign in again. This action will clear enough space on the device to download software updates.|

## Issues affecting multiple devices

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Signed out of Teams on Android devices | Teams Rooms on Android, Teams Phones, Teams panels, and Teams displays are signed out of Teams automatically. | Follow the instructions provided in [Signed out of Teams on Android devices](./signed-out-of-teams-android-devices.md).|
|Unable to extract log files.|You're trying to extract a log file but either the log files are empty or you see an error message. This behavior can occur when the logs contain partially corrupted zip files or log files.|Try to extract the log files by using the [7-ZIP](https://www.7-zip.org/) tool instead of the built-in Windows file extraction tool.|

## Issues affecting Teams Phones

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Sign in loops or fails for Teams Phones.|You can't sign in or the sign-in continually loops when both the MFA and the Terms of Use (ToU) Conditional Access (CA) policies are used. |The combination of MFA CA and ToU CA isn't supported. You should exclude it from being used. <br><br> To avoid the sign-in error, ensure that only the MFA CA or only the Mobile Device Management (MDM) CA is used. When only the MFA CA is used, make sure that it's enabled in Device Registration Services (DRS). For more information, see [Conditional Access: Cloud apps, actions, and authentication context](/azure/active-directory/conditional-access/concept-conditional-access-cloud-apps#user-actions).|
|Can't add, delete, or edit contacts on Teams Phones.|You can't perform the add, delete, and edit operations on contacts from Teams phones.|Use either the Teams desktop or the Teams web client to perform these actions.|
|Can't resume a call after using **Consult first** option on Teams Phones.| After using the **Consult first** option in the **Transfer** menu when you select the **Resume** option to resume the call, the call fails.| End the call made by using the **Consult first** option and then resume the original call.|
|Speed dial line key doesn't transfer an active call.|In older Teams Phones versions, you could transfer an active call by selecting a line key that is configured as a speed dial for a specific contact.<br/><br/>Beginning with Teams Phones version 1.7.0 1449/1.0.94.2025165302, you're only able to make an outgoing call to the speed dial after you select it from the **Transfer** menu.|If you want to transfer active calls to specific contacts, configure line keys as speed dials for those contacts and assign the **Transfer** and **Consult Transfer** menu options to the appropriate line keys.|
|The screen hangs on Yealink phones when the headset is picked up.|On Yealink MP56 phones that are running version 1449/1.0.94.2025248901 of the Teams for Android app, the screen hangs or crashes when you pick up the headset to make an outbound call.|No workaround is available at this time.|
|Can't see line keys on the home screen.|After you update your Teams Phones to version 1449/1.0.94.2025264001 of the Teams for Android app, you don't see any assigned line keys on the home screen.<br/><br/>This behavior is seen on non-touch phones such as Poly CCX 350 that have either the CAP or Premium CAP licenses.|No workaround is available at this time.|
|Incoming calls generate a "Just me" chat automatically.|When you receive a call from a main call queue on a Teams Phone, a "Just Me" chat is generated automatically in the Teams desktop app. This chat only includes you and it remains in the chat notifications list until you delete it manually. A new chat is generated with each incoming call.<br/><br/>The problem occurs specifically when answering calls from a call queue on a Teams Phone device, but not when they're answered by using the Teams desktop app.|To work around the issue, turn on Conference mode for the call queue. Use the following steps:<br/><ol><li>In the Microsoft Teams admin center, select **Call queues**.</li><li>Select **Edit a call queue** > **Call answering**.</li><li>On the Call answering page, toggle the **Conference mode** button to turn it on.</li></ol>|

## Limitations

- Teams Rooms doesn't support High-Bandwidth Digital Content Protection (HDCP) input. Using HDCP input might cause issues that affect High-Definition Multimedia Interface (HDMI) ingest functionality, such as video and audio. To avoid these issues, make sure that the HDCP options are turned off for switches that are connected to Teams Rooms.
- Teams Rooms on Android doesn't support the ability to join cross-cloud meetings.
- When you use the Call app on a Teams Rooms device to dial the toll number or conference ID for a Teams meeting, the conference bridge triggers multiple call flows. Because the Teams Rooms app is designed to support only one active call at a time, the call fails.

  Instead of using the Call app, join the meeting by using the **Join with an ID** option and entering the meeting ID.
- If you're in a call with another user who is on a Teams Rooms device, you can't transfer the call. The Teams Rooms app is designed to support only one call at a time.
- If your organization has policies that are configured to block legacy authentication for the Teams Rooms app, then Teams Rooms on Android devices, Teams displays, Teams panels, and Teams Phones can't join Teams meetings.
- The meeting details that you export in the Microsoft Teams admin center includes the link speed of the Ethernet network interface that's used during the meeting. The details always display the default value of 10 Mbps. However, this value might not be accurate because Teams Rooms for Android devices can't fetch the exact value. The actual link speed might be faster than the default value.
- Incoming videos in large gallery view on Teams Rooms on Android devices are duplicated and might be blurry at times.
- After the dual display mode is disabled for a Teams Rooms on Android device that is attached to two external displays, the extended display continues to be active. This is because the updated settings take effect only after the device restarts.

## Support for non-Microsoft Teams devices

For issues with Teams devices offered by providers other than Microsoft, contact their individual sites for support:

- Logitech: [Logitech Support](https://support.logi.com/hc/)
- Crestron: [Crestron Support](https://support.crestron.com/)
- Poly: [Poly Support](https://www.poly.com/us/support)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
