---
title: Known issues in Teams Rooms and devices
description: Provides a list of known issues for various features of Teams Rooms and limitations and expected behavior.
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
ms.date: 06/06/2022
---
# Known issues in Teams Rooms and devices

This article lists the known issues for the Microsoft Teams Rooms app when it's used on Windows and Android devices.
<!-- If we get word that one of these issues no longer applies, contact meerak@microsoft.com or kaushika@microsoft.com and let them know to EoL the corresponding KB  -->

## Teams Rooms on Windows

### Software issues

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Split gallery participants sharing video appear as audio-only |In a meeting that includes more than nine remote participants, the meeting is presented in dual front-of-room displays, and when content isn't being shared, the participants who are sharing video might appear as participants sharing audio-only. <br/><br/>Also, the number of participants displayed in the dual front-of-room displays as sharing audio-only is smaller than the actual number of such participants in the meeting.|No workaround is available at this time.|
|Teams Rooms app doesn't start|After you update to version 4.4.41.0, the Teams Rooms app displays a black screen after it starts where it might get stuck, or go to the logon screen after a few minutes.|To fix this issue, follow the steps in [Microsoft Teams Rooms application does not start after update to version 4.4.41.0](https://support.microsoft.com/topic/microsoft-teams-rooms-application-does-not-start-after-you-update-to-version-4-4-41-0-or-later-387eff45-3905-d768-a5df-a0c716c9b757).|
|Low meeting volume after content sharing|Teams Rooms devices on Windows 10 20H2 experience decreased media and meeting volume after you share content through in-room HDMI. This issue is caused by an audio condition in Windows 10 20H2.|To fix this issue, upgrade to version [4.9.12.0](/microsoftteams/rooms/rooms-release-note#49120-7282021) of the Teams Rooms app.|
|Teams Rooms app out of date|The Teams Rooms console displays the **system config out of date** error.|To fix this issue, [use the Microsoft Teams Rooms recovery tool](/MicrosoftTeams/rooms/recovery-tool).|
|Windows version on device updated to unsupported version for Teams Rooms|A Windows 10 device is updated from version 1803 to version 1809. Version 1809 isn't supported for Teams Rooms.|This issue can occur if the [Group Policy or MDM setting for the DeferFeatureUpdatesPeriodinDays parameter](/windows/deployment/update/waas-configure-wufb#configure-when-devices-receive-feature-updates) is set to 365 days, which is the maximum value. As of March 27, 2020, version 1809 is more than 365 days old. Therefore, the Windows 10 device that's running version 1803 installs version 1809 after 365 days of running version 1803. However, version 1809 isn't supported for Teams Rooms and might cause issues that affect Teams Rooms adversely.<br/><br/>To avoid this situation, remove the configuration from any Group Policy or MDM setting that's set up to defer updates. It's important to leave the policy or setting unconfigured and not set to 0. Then the device will always update to the latest version of Windows that supports Teams Rooms.|
|Virtual keyboard missing|The virtual keyboard doesn't appear when you have to enter information in Microsoft Teams Rooms. This issue occurs in Windows 10, version 1903.|Install the April 2020 Cumulative Update for Windows 10, version 1903 for x64-based systems through Windows Update.|

### Hardware issues

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Monitors not detected|When you run Teams Rooms on a Surface Pro (Model 2017) device, monitors aren't detected.|Hold down the power button of the Surface Pro device for 20 seconds or more to restart it. This will clear the graphics cache.|

## Teams Rooms on Android

### Teams Phone devices

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Login loops or fails for Teams on Android phones |You can't sign in or the sign-in continually loops when both the MFA and the Terms of Use (ToU) Conditional Access (CA) policies are used. |The combination of MFA CA and ToU CA isn't supported. You should exclude it from being used. <br><br> To avoid the sign-in error, ensure that only the MFA CA or only the MDM CA is used. When only the MFA CA is used, make sure that it's enabled in Device Registration Services (DRS). For more information, see [Conditional Access: Cloud apps, actions, and authentication context](/azure/active-directory/conditional-access/concept-conditional-access-cloud-apps#user-actions).|
|Can't delete contacts on Android phones|You can't delete contacts from Teams on Android phones.|Use either the Teams desktop or the Teams web client to delete contacts from Teams.|
|The username isn't displayed in Teams on Android phones |The sidecar username isn't displayed on the **Calls** tab or the **People** tab. |No workaround is available at this time. |
|No video for remote participants from Android Meeting Room devices| Remote participants can't get video from meeting participants who are using Teams Rooms on Android devices, such as MTRA Poly X50, X30, and Yealink A20. The issue is intermittent. | Install [Update 1449/1.0.96.2022051102 of the Teams Rooms app for Android](https://support.microsoft.com/office/what-s-new-in-microsoft-teams-devices-eabf4d81-acdd-4b23-afa1-9ee47bb7c5e2#ID0EBD=Teams_Rooms_on_Android) and check whether the issue is fixed for your device. |
|A random string displays in Teams on Android phones | A random string of characters is displayed in the **More** page when the time format is set to 24 hours. This issue occurs in **Firmware : 143.15.0.5 Teams app : 2022032303 CP : 5304 AA : 322**. | No workaround is available at this time. |
|Busy on Busy feature is unavailable | The Busy on Busy feature isn't available in Teams on phones. | This feature isn't available for Teams on phones at this time. |
|Jabra Panacast 50 doesn't display video in Teams meeting|When using Jabra Panacast 50 in a Teams meeting, if the **Whiteboard sharing mode** in Jabra Direct is set to **In separate content camera view**, the video doesn't display.|The fix for this issue is available in application version [4.12.138.0](/microsoftteams/rooms/rooms-release-note#4121380-5262022).|
| Signed out of Teams on Android devices | Teams Rooms on Android, Teams phone devices, Teams panels, and Teams displays are signed out of Teams automatically. | Follow the instructions provided in [Signed out of Teams on Android devices](./signed-out-of-teams-android-devices.md).|

## Limitations

- Front row is currently labeled as **Preview** on the layout picker in the front-of-room display.
- Front row layout displays up to four video participants on a single front-of-room display and up to nine video participants on dual front-of-room displays. These participants are chosen from the last active speakers.
- Front row requires 1920 × 1080 resolution for a 16:9 display or 2560 × 1080 resolution for a 21:9 display. These displays are set to 100 percent scaling. If the chat panel on your front-of-room display shows unreadable UI, see [Change scale and resolution for front-of-room](/microsoftteams/rooms/rooms-operations#scale-and-resolution) to adjust your display settings.
- Microsoft Teams Rooms doesn't support High-Bandwidth Digital Content Protection (HDCP) input. Using HDCP input may cause issues that affect High-Definition Multimedia Interface (HDMI) ingest functionality, such as video and audio. To avoid these issues, make sure that the HDCP options are turned off for switches that are connected to Teams Rooms.

## Expected behavior

- If your Teams Rooms device loses trust with the domain, you won't be able to authenticate into the device and access its settings. For example, if you remove Teams Rooms from the domain after it gets domain joined, the trust relationship will be lost. In this situation, sign in to the device by using a local administrator account.
- A consumer TV that's used as the front-of-room display might cause stability issues with Teams Rooms for the following reasons:
  - Inconsistent implementation of standby modes
  - Active video source selection
  - Incorrect EDID information that's communicated to the Teams Rooms device

  Known symptoms include a black or gray screen on the front-of-room display, or the Teams Rooms console becomes unresponsive after waking from standby mode. If you experience issues when you use consumer TVs, we recommend that you install a configurable EDID controller or EDID emulator, such as the [HD-RX-201-C-E](https://www.crestron.com/Products/Video/HDMI-Solutions/HDMI-Extenders/HD-RX-201-C-E) from Crestron, or [DR-EDID Emulator](https://fsrinc.com/fsr-products/product/dr-edid-manager-learner/category_pathway-143) from FSR Video Products Group.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
