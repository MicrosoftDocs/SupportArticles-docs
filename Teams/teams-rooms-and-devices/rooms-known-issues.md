---
title: Known issues in Teams Rooms and devices
description: Provides a list of known issues for Teams Rooms on Windows and Android.
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
ms.date: 07/20/2023
---
# Known issues in Teams Rooms and devices

This article lists the known issues for the Microsoft Teams Rooms app when it's used on Windows and Android devices.
<!-- If we get word that one of these issues no longer applies, contact meerak@microsoft.com or kaushika@microsoft.com and let them know to EoL the corresponding KB  -->

## Teams Rooms on Windows

### Software issues

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Low meeting volume after content sharing|Teams Rooms devices on Windows 10 20H2 experience decreased media and meeting volume after you share content through in-room HDMI. This issue is caused by an audio condition in Windows 10 20H2.|To fix this issue, upgrade to version [4.9.12.0](/microsoftteams/rooms/rooms-release-note#49120-7282021) of the Teams Rooms app.|
|Teams Rooms app out of date|The Teams Rooms console displays the **system config out of date** error.|To fix this issue, [use the Microsoft Teams Rooms recovery tool](/MicrosoftTeams/rooms/recovery-tool).|
|Windows version on device updated to unsupported version for Teams Rooms|A Windows 10 device is updated from version 1803 to version 1809. Version 1809 isn't supported for Teams Rooms.|This issue can occur if the [Group Policy or MDM setting for the DeferFeatureUpdatesPeriodinDays parameter](/windows/deployment/update/waas-configure-wufb#configure-when-devices-receive-feature-updates) is set to 365 days, which is the maximum value. As of March 27, 2020, version 1809 is more than 365 days old. Therefore, the Windows 10 device that's running version 1803 installs version 1809 after 365 days of running version 1803. However, version 1809 isn't supported for Teams Rooms and might cause issues that affect Teams Rooms adversely.<br/><br/>To avoid this situation, remove the configuration from any Group Policy or MDM setting that's set up to defer updates. It's important to not configure the policy or setting  and not set to 0. Then the device will always update to the latest version of Windows that supports Teams Rooms.|
|Virtual keyboard missing|The virtual keyboard doesn't appear when you have to enter information in Teams Rooms devices. This issue occurs in Windows 10, version 1903.|Install the April 2020 Cumulative Update for Windows 10, version 1903 for x64-based systems through Windows Update.|
|Teams Rooms app fails to start after update|If your Teams Rooms device uses a processor (CPU) which supports Control-flow Enforcement Technology (CET), such as the 11th Gen Intel&reg; Core&trade; Processor or later and you have:<ul><li>Applied cumulative update KB5013942</li><li>Not applied cumulative update KB5015020 or later</li><li>Updated the Teams Rooms app</li></ul>then you might see an error that the Teams Rooms app can't be started.|Reimage the Teams Rooms device with OEM media that uses Windows operating system version 20H2 or later.|
|Can't access Windows Settings from the desktop right-click menu.|On Teams Rooms devices that are running app version 3.1.98.0 or later versions, any user account that has the Teams Rooms app installed will be able to access Windows Settings only by using the Start menu. If you try to access Windows Settings by using another method, the Teams Rooms app will open instead.|Use one of the following workarounds to access Windows Settings:<ul><li>Select the **Settings** option from the **Start** menu.</li><li>Uninstall the Teams Rooms app for the affected user. Locate the app on the **Start** menu, right-click it and select **Uninstall**.</li></ul>|
|Teams Rooms device loses internet connectivity after installing a feature update for Windows| A Teams Rooms device which is connected to a network that requires a proxy can't connect to the internet after installing a feature update for Windows, including an upgrade to Windows 11.<br/><br/>This issue occurs if the proxy setting for internet access on the affected device is configured for the LocalSystem instead of a system-wide proxy. The Windows feature update deletes the LocalSystem settings. This behavior is by design.|If your device has proxy settings set for the LocalSystem user, transfer those settings to the [system-wide proxy settings](/windows/client-management/mdm/networkproxy-csp) that're set and maintained through Mobile Device Management (MDM). Alternatively, you can use the [Set-WinInetProxy](https://www.powershellgallery.com/packages/WinInetProxy/0.1.0) PowerShell cmdlet to configure the system-wide proxy settings.</br></br>When you use system-wide proxy settings, they won't be affected when you install Windows feature updates on the device in future.|
|Teams Rooms calendar doesn't display meeting organizer's name when meeting name is hidden|In the new home screen experience in Teams Rooms on Windows, if the option to hide meeting names is enabled in **Settings**, the Teams Rooms calendar displays "Hidden meeting name" as the meeting title instead of the name of the meeting organizer.|No workaround is available at this time. A fix that will update the user interface automatically to display the meeting organizer's name will be released.|
|Test service plans display in Teams Rooms Pro and Teams Rooms Basic licenses|IT Admins who assign user licenses in the Microsoft Teams admin center or in Azure Active Directory see the following test service plans in Teams Rooms Pro and Teams Rooms Basic licenses:<ul><li>Teams Rooms Test 1</li><li>Teams Rooms Test 2</li></ul> | No workaround is required. These service plans don't have any capabilities and can be ignored. They will continue to display for the lifetime of the two SKUs.|
|Front-of-room display shows a black screen intermittently|On devices that're running version 4.17.x.x of the Teams Rooms for Windows app, you might see a black screen intermittently in the front-of-room display  after the system has been idle for a period of time.</br></br>Both the Microsoft Teams admin center & the Pro Management portal will indicate that the front-of-room display is functioning normally. This is because the display is not disconnected. Instead, the app window is hidden.|Select either the **Meet now** or the **Call** button on the console of the Teams Rooms device to restore the front-of-room display immediately.|
|Teams Rooms device console display shows only a **Refresh** button.| On devices that're running version 4.17.x.x of the Teams Rooms for Windows app, you might see a black screen with a **Refresh** button on the console intermittently after the system has been idle for a period of time.|Select the **Refresh** button to restore the console display. </br></br> If you see the black screen both in the front-of-room display and on the console, select the **Refresh** button on the console display to restore both affected displays.|

### Hardware issues

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Monitors not detected|When you run Teams Rooms on a Surface Pro (Model 2017) device, monitors aren't detected.|Hold down the power button of the Surface Pro device for 20 seconds or more to restart it. A restart will clear the graphics cache.|
|During a Coordinated meeting, when the meeting volume is changed by using a room remote, the speaker on a Surface Hub or Teams Rooms device turns on.|For a trusted device such as a Surface Hub or Teams Rooms device that is set up to auto-join a Coordinated meeting when the primary device joins, the speaker turns on when the meeting volume is changed by using a room remote. This issue occurs even though the audio settings on the device are turned off, and whether they're enabled or disabled.|Turn off proximity join and room remote capabilities on the trusted devices that auto-join a Coordinated meeting.|

## Teams Rooms on Android

### Issues affecting all devices

| Issue  |  Description | Workaround |
| --- | --- | --- |
|The **Report an issue** option in Teams Rooms on Android devices doesn't work|In Teams Rooms on Android devices, Teams phones, Teams panels and Teams displays, the **Report an issue** option under **Settings** is unavailable.|The option to report issues from Teams Rooms on Android devices is being enhanced. The **Report an issue** option will be unavailable until the updated experience is released.</br></br>If you were using the **Report an issue** option to collect device logs to troubleshoot issues, use the Microsoft Teams admin center instead. See [Collect Android Teams device logs](/microsoftteams/troubleshoot/teams-rooms-and-devices/collect-device-logs) for detailed instructions.|

### Issues with meeting room devices

| Issue  |  Description | Workaround |
| --- | --- | --- |
| Laser pointer and drawing tools in PowerPoint Live don't display for in-room participants | In-room meeting participants in a Teams meeting who are using Teams Rooms on Android devices aren't able to see the following features during a PowerPoint Live presentation: Laser pointer, pen, highlighter, and eraser. | Join the meeting on your personal device to see the laser pointer and drawing tools in PowerPoint Live. |
| Teams Admin Settings unavailable on Teams Rooms on Android devices with Teams Rooms Basic license. | The **Teams Admin Settings** option under **Device Settings** is unavailable on devices that have the Teams Rooms Basic license for Teams Rooms on Android CY22 U3 app (version 1449/1.0.96.2022120503). | Admins can either assign a Teams Rooms Pro license to the same device or downgrade the device to use Teams Rooms on Android CCY22 U2B app (version: 1449/1.0.96.2022090606) instead. |
| Volume of the audio received from Poly Studio X30 or X50 devices is low. | In a Teams meeting that uses either the Poly Studio X30 or Poly Studio X50 Teams Rooms device, the audio that is sent to remote participants might have low volume. <br/><br/>This issue occurs because of a change made to Teams audio processing which causes the audio level of the microphone on the device to be set very low. | Log into the web interface for the affected Poly Studio X30 or X50 device using administrator credentials and use the following steps:<ol><li>Select **Audio / Video** > **Audio**.</li><li>Select the drop-down arrow in the **Transmission Audio Gain (dB)** field.</li><li>Select a number between 14 & 18 to specify the decibels for the audio sent from the microphone.</li></ol>
|The **Report an issue** option in Teams Rooms on Android devices doesn't work|In Teams Rooms on Android devices, Teams phones, Teams panels and Teams displays, the **Report an issue** option under **Settings** is unavailable.|The option to report issues from Teams Rooms on Android devices is being enhanced. The **Report an issue** option will be unavailable until the updated experience is released.</br></br>If you were using the **Report an issue** option to collect device logs to troubleshoot issues, use the Microsoft Teams admin center instead. See [Collect Android Teams device logs](/microsoftteams/troubleshoot/teams-rooms-and-devices/collect-device-logs) for detailed instructions.|

### Issues with Teams phones

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Sign in loops or fails for Teams on Android phones |You can't sign in or the sign-in continually loops when both the MFA and the Terms of Use (ToU) Conditional Access (CA) policies are used. |The combination of MFA CA and ToU CA isn't supported. You should exclude it from being used. <br><br> To avoid the sign-in error, ensure that only the MFA CA or only the MDM CA is used. When only the MFA CA is used, make sure that it's enabled in Device Registration Services (DRS). For more information, see [Conditional Access: Cloud apps, actions, and authentication context](/azure/active-directory/conditional-access/concept-conditional-access-cloud-apps#user-actions).|
|Can't add, delete, or edit contacts on Android phones|You can't perform the add, delete, and edit operations on contacts from Teams on Android phones.|Use either the Teams desktop or the Teams web client to perform these actions.|
|Busy on Busy feature is unavailable | The Busy on Busy feature isn't available in Teams on phones. | This feature isn't available for Teams on phones at this time. |
| Signed out of Teams on Android devices | Teams Rooms on Android, Teams phone devices, Teams panels, and Teams displays are signed out of Teams automatically. | Follow the instructions provided in [Signed out of Teams on Android devices](./signed-out-of-teams-android-devices.md).|
| Can't resume a call after using **Consult first** option on Teams phones | After using the **Consult first** option in the **Transfer** menu when you select the **Resume** option to resume the call, the call fails. | End the call made by using the **Consult first** option and then resume the original call.|
|Calls on long hold in GCCH tenants drop intermittently|On GCCH tenants that are running 2022 update #4A (Teams app version 1449/1.0.94.2022110803), when a call is put on long hold by a user the call drops in some instances. This issue doesn't occur on other clouds.|No workaround is available at this time.|

## Limitations

- Front row requires 1920 × 1080 resolution for a 16:9 display or 2560 × 1080 resolution for a 21:9 display. These displays are set to 100 percent scaling. If the chat panel on your front-of-room display shows unreadable UI, see [Change scale and resolution for front-of-room](/microsoftteams/rooms/rooms-operations#scale-and-resolution) to adjust your display settings.
- Teams Rooms doesn't support High-Bandwidth Digital Content Protection (HDCP) input. Using HDCP input may cause issues that affect High-Definition Multimedia Interface (HDMI) ingest functionality, such as video and audio. To avoid these issues, make sure that the HDCP options are turned off for switches that are connected to Teams Rooms.
- Teams Rooms on Android doesn't support the ability to join cross-cloud meetings.

## Expected behavior

- If your Teams Rooms device loses trust with the domain, you won't be able to authenticate into the device and access its settings. For example, if you remove Teams Rooms from the domain after it gets domain joined, the trust relationship will be lost. In this situation, sign in to the device by using a local administrator account.
- A consumer TV that's used as the front-of-room display might cause stability issues with Teams Rooms for the following reasons:
  - Inconsistent implementation of standby modes
  - Active video source selection
  - Incorrect EDID information that's communicated to the Teams Rooms device

  Known symptoms include a black or gray screen on the front-of-room display, or the Teams Rooms console becomes unresponsive after waking from standby mode. If you experience issues when you use consumer TVs, we recommend that you install a configurable EDID controller or EDID emulator, such as the [HD-RX-4K-201-C-E](https://www.crestron.com/Products/Video/HDMI-Solutions/HDMI-Extenders/HD-RX-4K-210-C-E) from Crestron, or [DR-EDID Emulator](https://fsrinc.com/fsr-products/product/4051-dr-edid2-emulator) from FSR Video Products Group.
- Teams Admin Center only identifies valid certified firmware. If uncertified firmware is updated on the device by means other than the Teams Admin Center, the Admin Center will provide only the old firmware. This issue may occur with Teams Rooms on Android devices and Teams IP phones.

## Support for third party Teams devices

For issues with Teams devices offered by third party providers, contact their individual sites for support:

- Logitech: [Logitech Support](https://support.logi.com/hc/)
- Crestron: [Crestron Support](https://support.crestron.com/)
- Poly: [Poly Support](https://www.poly.com/us/en/support)
- Yealink: [Yealink Support](https://support.yealink.com/portal/home)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
