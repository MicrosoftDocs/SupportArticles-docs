---
title: Known issues with Teams Rooms on Android
description: Provides a list of known issues for Teams Rooms on Android.
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
ms.date: 07/22/2025
---
# Known issues with Teams Rooms on Android

<!-- If you get word that one of these issues no longer applies, contact meerak@microsoft.com to EoL the corresponding KB.  -->

## Issues affecting Teams meeting room devices

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Unable to pair Yealink MeetingBar A40 device with CTP25 touch panel.|You might experience intermittent or failed pairing attempts between a Yealink MeetingBar A40 device and a CTP25 touch panel that are running the following firmware versions:<br/><br/>A40 device: 289.320.0.60<br/>CTP25 touch panel: 311.320.0.55<br/><br/>In some instances, the device might revert to an unpaired state shortly after initialization, or the touch panel might remain stuck on the pairing screen without displaying a code.|No workaround is available at this time.|
|Logitech Rally Bar device is failing during remote login authentication.|You're able to sign in to a LogiTech VR1009 Rally Bar device locally but it signs out if an attempt is made to log in remotely. In this situation you might see Entra ID error codes 530003, 530002, and others.|No workaround is available at this time.|

## Issues affecting multiple devices

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Signed out of Teams on Android devices | Teams Rooms on Android, Teams phone devices, Teams panels, and Teams displays are signed out of Teams automatically. | Follow the instructions provided in [Signed out of Teams on Android devices](./signed-out-of-teams-android-devices.md).|

## Issues with Teams phones

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Sign in loops or fails for Teams phones |You can't sign in or the sign-in continually loops when both the MFA and the Terms of Use (ToU) Conditional Access (CA) policies are used. |The combination of MFA CA and ToU CA isn't supported. You should exclude it from being used. <br><br> To avoid the sign-in error, ensure that only the MFA CA or only the Mobile Device Management (MDM) CA is used. When only the MFA CA is used, make sure that it is enabled in Device Registration Services (DRS). For more information, see [Conditional Access: Cloud apps, actions, and authentication context](/azure/active-directory/conditional-access/concept-conditional-access-cloud-apps#user-actions).|
|Can't add, delete, or edit contacts on Teams phones|You can't perform the add, delete, and edit operations on contacts from Teams phones.|Use either the Teams desktop or the Teams web client to perform these actions.|
|Can't resume a call after using **Consult first** option on Teams phones | After using the **Consult first** option in the **Transfer** menu when you select the **Resume** option to resume the call, the call fails. | End the call made by using the **Consult first** option and then resume the original call.|
|Unable to assign speed dial to line keys on a sidecar|When you assign speed dial contacts to line keys on the sidecar that is connected to a touch phone device, they don't work.|No workaround is available for the speed dial contacts that you assigned by using the sidecar. However the speed dial contacts that're already set up and shared line delegates and other groups are automatically pinned on the sidecar.|
|Speed dial line key doesn't transfer an active call.|In older Teams Phones versions, you could transfer an active call by selecting a line key that is configured as a speed dial for a specific contact.<br/><br/>Beginning with Teams Phones version 1.7.0 1449/1.0.94.2025165302, you're only able to make an outgoing call to the speed dial after you select it from the **Transfer** menu.|If you want to transfer active calls to specific contacts, configure line keys as speed dials for those contacts and assign the **Transfer** and **Consult Transfer** menu options to the appropriate line keys.|
|Unable to extract log files.|You're trying to extract a log file but either the log files are empty or you see an error message. This behavior can occur when the logs contain partially corrupted zip files or log files.|Contact Microsoft Support by filing a request at [SERVICENOW](https://microsoft.service-now.com/sp?id=sc_cat_item&sys_id=0baac5bcdb0ca414b720f337689619ce&sysparm_category=8b859929136eea002620b0912244b066).|

## Limitations

- Teams Rooms doesn't support High-Bandwidth Digital Content Protection (HDCP) input. Using HDCP input might cause issues that affect High-Definition Multimedia Interface (HDMI) ingest functionality, such as video and audio. To avoid these issues, make sure that the HDCP options are turned off for switches that are connected to Teams Rooms.
- Teams Rooms on Android doesn't support the ability to join cross-cloud meetings.
- When you use the Call app on a Teams Rooms device to dial the toll number or conference ID for a Teams meeting, the conference bridge triggers multiple call flows. Because the Teams Rooms app is designed to support only one active call at a time, the call fails.

  Instead of using the Call app, join the meeting by using the **Join with an ID** option and entering the meeting ID.
- If you're in a call with another user who is on a Teams Rooms device, you can't transfer the call. The Teams Rooms app is designed to support only one call at a time.
- If your organization has policies that're configured to block legacy authentication for the Teams Rooms app, then Teams Rooms on Android devices, Teams displays, Teams panels, and Teams phones can't join Teams meetings.
- The meeting details that you export in the Microsoft Teams admin center includes the link speed of the Ethernet network interface that's used during the meeting. This display always shows the default value of 10 Mbps. However, this value might not be accurate because Teams Rooms for Android devices can't fetch the exact value. The actual link speed might be faster than the default value.
- Incoming videos in large gallery view on Teams Rooms on Android devices are duplicated and might be blurry at times.
- After the dual display mode is disabled for a Teams Rooms on Android device which is attached to two external displays, the extended display continues to be active. This is because the updated settings take effect only after the device restarts.

## Support for third-party Teams devices

For issues with Teams devices offered by third-party providers, contact their individual sites for support:

- Logitech: [Logitech Support](https://support.logi.com/hc/)
- Crestron: [Crestron Support](https://support.crestron.com/)
- Poly: [Poly Support](https://www.poly.com/us/support)
- Yealink: [Yealink Support](https://support.yealink.com/us/portal/home)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
