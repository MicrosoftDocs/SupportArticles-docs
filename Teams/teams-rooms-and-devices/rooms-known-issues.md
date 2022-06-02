---
title: Known issues in Teams Rooms and devices
description: Provides a list of known issues for various features of Teams Rooms as well as limitations and expected behavior.
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
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 3/31/2022
---
# Known issues in Teams Rooms and devices

This article lists the known issues for Microsoft Teams Rooms by feature area.
<!-- If we get word that one of these issues no longer applies, contact meerak@microsoft.com or kaushika@microsoft.com and let them know to EoL the corresponding KB  -->

## Update

| Issue  |  Description | Workaround |
|  ---        |      ---             |   ---            |
|Whiteboard or Content Camera doesn't enhance content when edges are not detected|After you update to version [4.11.12.0](/microsoftteams/rooms/rooms-release-note#411120-1242022), the camera doesn't enhance or overlay all content in the camera view if there are no whiteboard edges in the content camera view.|The fix for this issue is available in application version [4.11.17.0](/microsoftteams/rooms/rooms-release-note#411170-332022).|
|Edge browser starts automatically|Edge browser versions that are earlier than build 97.0.1072.62 start automatically together with the Microsoft Teams Rooms app when the device starts.|This issue should be resolved automatically (no user interaction required) on or before Monday, January 17, 2022. If a faster resolution is required when this issue occurs, go to edge://settings/help in Edge. An update should automatically download and install. In the browser, select **Restart** after the installation finishes. Close Azure IoT Edge, and then restart the system. The issue should now be resolved.|
|Split gallery participant videos|When there's no shared content in a meeting that includes more than nine remote participants, and the meeting is presented in dual front-of-room displays, video participants on a front-of-room display that have the self-preview feature might appear as audio participants. Also, a smaller number of audio participants than the actual number of audio participants appears on the dual front-of-room displays.|Currently, there is no workaround.|
| Application doesn't start |  After you update to application version 4.4.41.0, the application starts to a black screen where it may get stuck, or it may go to the logon screen after a few minutes.| To fix this issue, follow the steps in [Microsoft Teams Rooms application does not start after update to version 4.4.41.0](https://support.microsoft.com/topic/microsoft-teams-rooms-application-does-not-start-after-you-update-to-version-4-4-41-0-or-later-387eff45-3905-d768-a5df-a0c716c9b757).  |
|Low meeting volume after content sharing|Microsoft Teams Rooms devices on Windows 10 20H2 experience decreased media and meeting volume after you share content through in-room HDMI. This issue is caused by an audio condition in Windows 10 20H2.|The fix for this issue is available in application version [4.9.12.0](/microsoftteams/rooms/rooms-release-note#49120-7282021)|
|  App out of date         |    The Microsoft Teams Rooms console shows a "system config out of date" error.                |   [Use the Microsoft Teams Rooms recovery tool](/MicrosoftTeams/rooms/recovery-tool)             |
|  Device updated to unsupported version of Windows 10   |    A Windows 10 device was updated from version 1803 to version 1809. Version 1809 is not supported. The supported version is 1903. |   This issue can occur if the [Group Policy or MDM setting for DeferFeatureUpdatesPeriodinDays](/windows/deployment/update/waas-configure-wufb) setting is set to the maximum of 365 days. This setting lets you defer feature updates for a specified number of days.<br><br> Windows 10, version 1809 isn't supported for Microsoft Teams Rooms. Version 1903 is supported. However, as of March 27, 2020, version 1809 is more than 365 days old. If this setting isn't changed, Windows tries to install version 1809. That version might cause issues that affect Microsoft Teams Rooms.<br><br>To avoid this situation, remove any Group Policy or MDM setting for deferring updates. This lets Windows update to the latest supported OS version. <br><br>**Important** The Group Policy or MDM setting must be removed (left unconfigured) and not set to **0**. If the policy is set to **0**, Windows takes the latest available version. That version might not be supported. |

## User interface

| Issue  |  Description | Workaround |
|  ---        |      ---             |   ---            |
|Virtual keyboard missing   | The virtual keyboard doesn't appear when you have to enter information in Microsoft Teams Rooms. This issue occurs in Windows 10, version 1903. | Install the April 2020 Cumulative Update for Windows 10, version 1903 for x64-based systems through Windows Updates.  |

## Hardware

| Issue |  Description | Workaround |
|  ---        |      ---             |   ---            |
| Monitors not detected | When you run Microsoft Teams Rooms on a Surface Pro (Model 2017) device, monitors are not detected. |  Hold down the Surface Pro power button for 20 or more seconds. When you do this, the device restarts and clears the graphics cache. |
| Login loops or fails for Teams on Android phones | You can't sign in or the sign-in continually loops when both the MFA and the Terms of Use (ToU) Conditional Access (CA) policies are used. | The combination of MFA CA and ToU CA is not supported. You should exclude it from being used. <br><br> To avoid the sign-in error, ensure that only the MFA CA or only the MDM CA is used. When only the MFA CA is used, ensure it is enabled in Device Registration Services (DRS). For more information, see [Conditional Access: Cloud apps, actions, and authentication context](/azure/active-directory/conditional-access/concept-conditional-access-cloud-apps#user-actions). |
| Can't delete contacts on Android phones| You can't delete contacts from Teams on Android phones. | Use either the Teams desktop or the Teams web client to delete contacts from Teams. |
| The username isn't displayed in Teams on Android phones | The sidecar username isn't displayed on the **Calls** tab or the **People** tab. | No workaround is available at this time. |
| No video for remote participants from Android Meeting Room devices | Remote participants can't get video from meeting participants who're using Teams Rooms on Android devices, such as MTRA Poly X50, X30, and Yealink A20. The issue is intermittent. | Install [Update 1449/1.0.96.2022051102 of the Teams Rooms app for Android](https://support.microsoft.com/office/what-s-new-in-microsoft-teams-devices-eabf4d81-acdd-4b23-afa1-9ee47bb7c5e2#ID0EBD=Teams_Rooms_on_Android) and check whether the issue is fixed for your device. |
| A random string displays in Teams on Android phones | A random string of characters is displayed in the **More** page when the time format is set to 24 hours. This issue occurs in **Firmware : 143.15.0.5 Teams app : 2022032303 CP : 5304 AA : 322**. | No workaround is available at this time. |
| Busy on Busy feature is unavailable | The Busy on Busy feature isn't available in Teams on phones. | This feature isn't available for Teams on phones at this time. |

## Limitations

- Front row is currently labeled as **Preview** on the layout picker in the front-of-room display.
- Front row layout displays up to four video participants on a single front-of-room display and up to nine video participants on dual front-of-room displays. These participants are chosen from the last active speakers.
- Front row requires 1920 × 1080 resolution for 16:9 display or 2560 × 1080 resolution for 21:9 display. These displays are set to 100 percent scaling. If the chat panel on your front-of-room display shows unreadable UI, see [Change scale and resolution for front-of-room](/microsoftteams/rooms/rooms-operations#change-scale-and-resolution) to adjust your display settings.
- Microsoft Teams Rooms doesn't support HDCP input. HDCP input has been observed to cause issues that affect High-Definition Multimedia Interface (HDMI) ingest functionality (video, audio). To avoid these issues, make sure that switches that are connected to Microsoft Teams Rooms have HDCP options turned off.

## Expected behavior

- If your Microsoft Teams Rooms device loses trust with the domain, you won't be able to authenticate into the device and open settings. For example, if you remove Microsoft Teams Rooms from the domain after it gets domain joined, trust is lost. In this situation, sign in to the device by using a local administrator account.

- A consumer TV that's used as the front-of-room display might cause stability issues in Microsoft Teams Rooms for the following reasons:
  - Inconsistent implementation of standby modes
  - Active video source selection
  - Incorrect EDID information that's communicated to the Microsoft Teams Rooms device

  Known symptoms include a black or gray screen on the front-of-room display, or the Microsoft Teams Rooms console becomes unresponsive after waking from standby mode. If you experience issues when you use consumer TVs, we recommend that you install a configurable EDID controller or EDID emulator, such as the [HD-RX-201-C-E](https://www.crestron.com/Products/Video/HDMI-Solutions/HDMI-Extenders/HD-RX-201-C-E) from Crestron, or [DR-EDID Emulator](https://fsrinc.com/fsr-products/product/dr-edid-manager-learner/category_pathway-143) from FSR Video Products Group.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]

## See also

[Microsoft Teams Rooms help](https://support.office.com/article/Skype-Room-Systems-version-2-help-e667f40e-5aab-40c1-bd68-611fe0002ba2)

[Manage Microsoft Teams Rooms](/MicrosoftTeams/rooms/rooms-manage)
