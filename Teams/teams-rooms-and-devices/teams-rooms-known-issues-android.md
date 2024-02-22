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
localization_priority: Normal
ms.collection: 
  - M365-collaboration
ms.custom: 
  - seo-marvel-apr2020
  - CSSTroubleshoot
  - CI 121996
  - CI 160661
  - CI 164223
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 02/22/2024
---
# Known issues with Teams Rooms on Android

<!-- If you get word that one of these issues no longer applies, contact meerak@microsoft.com or kaushika@microsoft.com and let them know to EoL the corresponding KB  -->

## Issues affecting multiple devices

| Issue  |  Description | Workaround |
| --- | --- | --- |
|The **Report an issue** option in Teams Rooms on Android devices doesn't work|In Teams Rooms on Android devices, Teams phones, Teams panels and Teams displays, the **Report an issue** option under **Settings** is unavailable.|The option to report issues from Teams Rooms on Android devices is being enhanced. The **Report an issue** option will be unavailable until the updated experience is released.</br></br>If you were using the **Report an issue** option to collect device logs to troubleshoot issues, use the Microsoft Teams admin center instead. See [Collect Android Teams device logs](/microsoftteams/troubleshoot/teams-rooms-and-devices/collect-device-logs) for detailed instructions.|
|Teams phones and Teams panels sign out automatically.<br/><br/> Teams Rooms on Android devices sign out automatically and become unpaired|Some models of Teams phones and Teams panels that are running version 5.0.5882.0 of the Company Portal app sign out automatically.<br/><br/>Also, Teams Rooms on Android devices that are running the Teams Rooms app version 1449/1.0.96.2023090601 and Company portal app version 5.0.5954.0 might sign out automatically and the touch console on the devices becomes unpaired.<br/><br/>These issues occur if the devices run out of memory or Workplace Join experiences errors.|Periodically restart the affected devices through the Microsoft Teams admin center or Pro Management portal. For applicable device models, you can also set a nightly restart option in the firmware.|
|Teams on Android devices experience a delay with signing in after a user signs out.|You sign out of a Teams on Android device either manually or from the Microsoft Teams admin center. When you try to sign in again immediately, there's a delay. This is because the authentication code takes 15 minutes or longer to refresh after a device signs out.<br/><br/>This issue occurs on all Teams on Android devices, including those devices that are running version 5.0.6061.0 of the Company portal app.|Restart the affected device to force the code to refresh.|

## Issues with meeting room devices

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Laser pointer and drawing tools in PowerPoint Live don't display for in-room participants | In-room meeting participants in a Teams meeting who are using Teams Rooms on Android devices aren't able to see the following features during a PowerPoint Live presentation: Laser pointer, pen, highlighter, and eraser. | Join the meeting on your personal device to see the laser pointer and drawing tools in PowerPoint Live. |
|Teams Admin Settings unavailable on Teams Rooms on Android devices with Teams Rooms Basic license. | The **Teams Admin Settings** option under **Device Settings** is unavailable on devices that have the Teams Rooms Basic license for Teams Rooms on Android CY22 U3 app (version 1449/1.0.96.2022120503). | Admins can either assign a Teams Rooms Pro license to the same device or downgrade the device to use Teams Rooms on Android CCY22 U2B app (version: 1449/1.0.96.2022090606) instead. |
|Rotate 180 option doesn't work for all meeting participants|You select the **Rotate 180** option for a Content camera in your Teams Rooms on Android device. However, the rotation is applied only to the video feed for in-room participants. Remote participants still see an inverted video display.|If possible, mount the Content camera right side up instead of upside down.|

## Issues with Direct Guest Join

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Video issues in some Logitech devices during Cisco Webex meetings|On some Logitech devices that run Teams Rooms on Android, the participant's video might either freeze or not display during Cisco Webex meetings.|When you join a third-party online meeting by using a Teams Rooms device, the meeting experience is controlled by the third-party online meeting provider. In the meetings where this issue occurs, Cisco Webex controls the video display. The issue with the participant video isn't caused by Teams Rooms on Android.|

## Issues with Teams phones

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Sign in loops or fails for Teams on Android phones |You can't sign in or the sign-in continually loops when both the MFA and the Terms of Use (ToU) Conditional Access (CA) policies are used. |The combination of MFA CA and ToU CA isn't supported. You should exclude it from being used. <br><br> To avoid the sign-in error, ensure that only the MFA CA or only the MDM CA is used. When only the MFA CA is used, make sure that it's enabled in Device Registration Services (DRS). For more information, see [Conditional Access: Cloud apps, actions, and authentication context](/azure/active-directory/conditional-access/concept-conditional-access-cloud-apps#user-actions).|
|Can't add, delete, or edit contacts on Android phones|You can't perform the add, delete, and edit operations on contacts from Teams on Android phones.|Use either the Teams desktop or the Teams web client to perform these actions.|
|Signed out of Teams on Android devices | Teams Rooms on Android, Teams phone devices, Teams panels, and Teams displays are signed out of Teams automatically. | Follow the instructions provided in [Signed out of Teams on Android devices](./signed-out-of-teams-android-devices.md).|
|an't resume a call after using **Consult first** option on Teams phones | After using the **Consult first** option in the **Transfer** menu when you select the **Resume** option to resume the call, the call fails. | End the call made by using the **Consult first** option and then resume the original call.|
|Calls on long hold in GCCH tenants drop intermittently|On GCCH tenants that are running 2022 update #4A (Teams app version 1449/1.0.94.2022110803), when a user puts a call on long hold the call drops in some instances. This issue doesn't occur on other clouds.|No workaround is available at this time.|
|In Better together mode, the **Mute** setting on Teams phones doesn't seem to work during a screen share with audio|On Teams phones that use the Better together feature, when you share a screen and enable the **Include computer sound** option during a Teams meeting, the audio from the phones that are muted is still heard.<br/><br/>If you toggle the **Unmute** and **Mute** options a few times, the audio output that is coming from both from the desktop client and the Teams phones results in howling.|No workaround is available at this time.|

## Issues with Teams panels

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Joining a meeting on a Teams Rooms device doesn't check you in for the meeting|You have a panel that shares a resource account with a Teams Room device. If you join a scheduled meeting on the Teams Rooms device, you might not be checked in for your reservation on the panel. This issue occurs intermittently.|If the issue is happening often, turn off the **Release room if no one checks in** setting in the Microsoft Teams admin center.|

## Limitations

- Front row requires 1920 × 1080 resolution for a 16:9 display or 2560 × 1080 resolution for a 21:9 display. These displays are set to 100 percent scaling. If the chat panel on your front-of-room display shows unreadable UI, see [Change scale and resolution for front-of-room](/microsoftteams/rooms/rooms-operations#scale-and-resolution) to adjust your display settings.
- Teams Rooms doesn't support High-Bandwidth Digital Content Protection (HDCP) input. Using HDCP input might cause issues that affect High-Definition Multimedia Interface (HDMI) ingest functionality, such as video and audio. To avoid these issues, make sure that the HDCP options are turned off for switches that are connected to Teams Rooms.
- Teams Rooms on Android doesn't support the ability to join cross-cloud meetings.
- When you use the Call app on a Teams Rooms device to dial the toll number or conference ID for a Teams meeting, the conference bridge triggers multiple call flows. Because the Teams Rooms app is designed to support only one active call at a time, the call fails.

  Instead of using the Call app, join the meeting by using the **Join with an ID** option and entering the meeting ID.

## Expected behavior

- If your Teams Rooms device loses trust with the domain, you won't be able to authenticate into the device and access its settings. For example, if you remove Teams Rooms from the domain after it gets domain joined, the trust relationship will be lost. In this situation, sign in to the device by using a local administrator account.
- If you use a consumer TV as the front-of-room display, then you might see stability issues with Teams Rooms for the following reasons:
  - Inconsistent implementation of standby modes
  - Active video source selection
  - Incorrect EDID information that's communicated to the Teams Rooms device

  The symptoms include a black or gray screen on the front-of-room display, or the Teams Rooms console becomes unresponsive after waking from standby mode. If you experience issues when you use consumer TVs, we recommend that you install a configurable EDID controller or EDID emulator, such as the [HD-RX-4K-201-C-E](https://www.crestron.com/Products/Video/HDMI-Solutions/HDMI-Extenders/HD-RX-4K-210-C-E) from Crestron, or [DR-EDID Emulator](https://fsrinc.com/fsr-products/product/4051-dr-edid2-emulator) from FSR Video Products Group.
- The Microsoft Teams admin center only identifies valid, certified firmware. If uncertified firmware is updated on the device by means other than the Microsoft Teams admin center, the admin center will display only the old firmware. This behavior might occur with Teams Rooms on Android devices and Teams IP phones.
- If you're in a call with another user who is on a Teams Rooms device, you can't transfer the call. This is because the Teams Rooms app is designed to support only one call at a time.

## Support for third-party Teams devices

For issues with Teams devices offered by third-party providers, contact their individual sites for support:

- Logitech: [Logitech Support](https://support.logi.com/hc/)
- Crestron: [Crestron Support](https://support.crestron.com/)
- Poly: [Poly Support](https://www.poly.com/us/en/support)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
