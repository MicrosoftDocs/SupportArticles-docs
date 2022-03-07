---
title: Known issues in Rooms
description: Admin can learn about a list of known issues for Microsoft Teams Rooms, including update, user interface, hardware, and limitations and expected behaviors.
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
---
# Known issues in Microsoft Teams Rooms

This article lists the known issues for Microsoft Teams Rooms, by feature area.
<!-- If we get word that one of these issues no longer applies, contact meerak@microsoft.com or msmets@microsoft.com and let them know to EoL the corresponding KB  -->

## Update

| Issue  |  Description | Workaround |
|  ---        |      ---             |   ---            |
|Whiteboard or Content Camera fails to enhance content when edges are not detected|After updating to version [4.11.12.0](/microsoftteams/rooms/rooms-release-note#411120-1242022), when there are no whiteboard edges in the content camera view, the camera doesn't enhance or overlay all content in the camera view.|The fix for this issue is available in the application version [4.11.17.0](/microsoftteams/rooms/rooms-release-note#411170-332022).|
|Edge browser automatically launching|The Edge browser before build 97.0.1072.62 launches automatically alongside the Microsoft Teams Rooms app when the device starts.|This issue should be resolved automatically, with no user interaction required, on or before Monday, January 17, 2022. If a faster resolution is required: when Edge launches alongside the Microsoft Teams Rooms, visit the URL edge://settings/help in Edge, and an update should automatically download and apply. In the browser, select **Restart** once the update has finished applying. Close Azure IoT Edge, reboot the system, and then the issue should be resolved.|
|Split gallery participant videos|When there's no shared content in a meeting with more than 9 remote participants, and the meeting is in the dual Front of Room displays, videos on a Front of Room display with the self-preview feature might appear as audio. Also, a smaller number of audio participants than the actual number of audio participants shows up on the dual Front of Room displays.|There is no workaround currently.|
| Application not launching |  After updating to application version 4.4.41.0, the system boots to black screen, or go to the logon screen after few minutes. | Follow the steps in [Microsoft Teams Rooms application does not start after update to version 4.4.41.0](https://support.microsoft.com/topic/microsoft-teams-rooms-application-does-not-start-after-you-update-to-version-4-4-41-0-or-later-387eff45-3905-d768-a5df-a0c716c9b757) to fix this issue.  |
|Low meeting volume after content sharing|Microsoft Teams Rooms devices on Windows 10 20H2 experience decreased media and meeting volume after sharing content through in-room HDMI. This issue is caused by an audio issue in Windows 10 20H2.|The fix for this issue is available in the application version [4.9.12.0](/microsoftteams/rooms/rooms-release-note#49120-7282021)|
|  App out of date         |    The Microsoft Teams Rooms console shows a "system config out of date" error.                |   [Use the Microsoft Teams Rooms recovery tool](/MicrosoftTeams/rooms/recovery-tool)             |
|  Device updated to unsupported version of Windows 10   |    Windows 10 device updated from version 1803 to version 1809, which is not supported. The supported version is 1903. |   This issue can happen if the [Group Policy or MDM setting for DeferFeatureUpdatesPeriodinDays](/windows/deployment/update/waas-configure-wufb) setting, which lets you defer feature updates for a specified number of days, is set to the maximum of 365 days. <br><br> Windows 10 version 1809 isn't supported with Microsoft Teams Rooms, while version 1903 is supported. However, as of March 27, 2020, version 1809 is over 365 days old. If this setting isn't changed, Windows attempts to install version 1809, which may cause issues with Microsoft Teams Rooms.<br><br>To avoid this situation, remove any Group Policy or MDM setting for deferring updates. This allows Windows to update to the latest, supported OS version. <br><br>**Important** The Group Policy or MDM setting must be removed (left unconfigured) and not set to **0**. If the policy is set to **0**, Windows takes the latest available version which may not be supported. |
||||

## User interface

| Issue  |  Description | Workaround |
|  ---        |      ---             |   ---            |
|Virtual keyboard missing   | The virtual keyboard doesn't appear when you need to enter information in Microsoft Teams Rooms. This issue occurs in Windows 10, version 1903. | Install 2020-04 Cumulative Update for Windows 10, version 1903 for x64-based Systems through Windows Updates.  |
||||

## Hardware

| Issue |  Description | Workaround |
|  ---        |      ---             |   ---            |
| Monitors not detected | When you run Microsoft Teams Rooms on a Surface Pro (Model 2017) device, monitors are not detected. |  Hold down the Surface Pro power button for 20 or more seconds. When you do this, the device restarts and clears the graphics cache. |
||||

## Limitations and expected behaviors

- Front row is marked as Preview in the layout picker in the Front of Room display.
- Front row layout shows up to 4 video participants on a Front of Room single display. It shows up to 9 videos on dual Front of Room. These participants are chosen from the last active speakers.
- Front row requires 1080p displays with 100% scaling. If a font size on your Front of Room display is too small or large for a room's need, see [Change scale and resolution for Front of Room](/microsoftteams/rooms/rooms-operations#change-scale-and-resolution) to adjust your display settings.

- Microsoft Teams Rooms doesn't support HDCP input, which has been observed to cause issues with High-Definition Multimedia Interface (HDMI) ingest functionality (video, audio). Make sure that switches connected to Microsoft Teams Rooms have HDCP options turned off.

- If your Microsoft Teams Rooms device loses trust with the domain, you can't authenticate into the device and open **Settings**. For example, if you remove the Microsoft Teams Rooms from the domain after it's domain joined, trust is lost. You can sign in by using a local Admin account to authenticate into the device.

- If you want a Front of Room display to switch automatically to an active video source, such as an MTR console, when the source wakes from the standby mode, certain conditions must be met. This feature is optional but supported by Microsoft Teams Rooms, provided underlying hardware supports the feature. A consumer TV used as a Front of Room display needs to support the Consumer Electronics Control (CEC) feature of HDMI. Depending on the dock or console selected, a controller such as an [HD-RX-201-C-E](https://www.crestron.com/Products/Video/HDMI-Solutions/HDMI-Extenders/HD-RX-201-C-E) from Crestron or [Extron HD CTL 100](https://www.extron.com/article/hdctl100ad) from Extron may be needed to enable the desired behavior. Refer to the manufacturer's support documentation to confirm the dock or console supports CEC.

- A consumer TV used as the Front of Room display may cause stability issues with Microsoft Teams Rooms. This behavior is caused by inconsistent implementation of standby modes, active video source selection, and communicating faulty EDID information to the Microsoft Teams Rooms device. Known symptoms are a black or gray screen on the Front of Room display or the Microsoft Teams Rooms console becoming unresponsive after waking from the standby mode. If you experience issues when you use consumer TVs, we recommend you install a configurable EDID controller or EDID emulator, such as the [HD-RX-201-C-E](https://www.crestron.com/Products/Video/HDMI-Solutions/HDMI-Extenders/HD-RX-201-C-E) from Crestron or [DR-EDID Emulator](https://fsrinc.com/fsr-products/product/dr-edid-manager-learner/category_pathway-143) from FSR Video Products Group.

- Always use a wired 1-Gbps network connection to make sure you have the needed bandwidth.

- Microsoft Teams Rooms is a multi-window application and requires a Front of Room display to be connected to the HDMI port of the device, for the app to function correctly. Make sure that you either have an HDMI display connected or use a dummy HDMI plug if you are testing and don't have a display purchased yet.

## See also

[Microsoft Teams Rooms help](https://support.office.com/article/Skype-Room-Systems-version-2-help-e667f40e-5aab-40c1-bd68-611fe0002ba2)

[Manage Microsoft Teams Rooms](/MicrosoftTeams/rooms/rooms-manage)
