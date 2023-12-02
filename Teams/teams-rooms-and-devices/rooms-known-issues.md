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
ms.date: 12/01/2023
---
# Known issues in Teams Rooms and devices

This article lists the known issues for the Microsoft Teams Rooms app when it's used on Windows and Android devices.
<!-- If you get word that one of these issues no longer applies, contact meerak@microsoft.com or kaushika@microsoft.com and let them know to EoL the corresponding KB  -->

## Teams Rooms on Windows

### Software issues

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Teams Rooms app out of date|The Teams Rooms console displays the **system config out of date** error.|To fix this issue, [use the Microsoft Teams Rooms recovery tool](/MicrosoftTeams/rooms/recovery-tool).|
|Can't access Windows Settings from the desktop right-click menu.|On Teams Rooms devices that are running app version 3.1.98.0 or later versions, any user account that has the Teams Rooms app installed can access Windows Settings only by using the Start menu. If you try to access Windows Settings by using another method, the Teams Rooms app will open instead.|Use one of the following workarounds to access Windows Settings:<ul><li>Select the **Settings** option from the **Start** menu.</li><li>Uninstall the Teams Rooms app for the affected user. Locate the app on the **Start** menu, right-click it and select **Uninstall**.</li></ul>|
|Teams Rooms device loses internet connectivity after installing a feature update for Windows| A Teams Rooms device that is connected to a network, which requires a proxy can't connect to the internet after installing a feature update for Windows, including an upgrade to Windows 11.<br/><br/>This issue occurs if the proxy setting for internet access on the affected device is configured for the LocalSystem instead of a system-wide proxy. The Windows feature update deletes the LocalSystem settings. This behavior is by design.|If your device has proxy settings set for the LocalSystem user, transfer those settings to the [system-wide proxy settings](/windows/client-management/mdm/networkproxy-csp) that are set and maintained through Mobile Device Management (MDM). Alternatively, you can use the [Set-WinInetProxy](https://www.powershellgallery.com/packages/WinInetProxy/0.1.0) PowerShell cmdlet to configure the system-wide proxy settings.</br></br>When you use system-wide proxy settings, they won't be affected when you install Windows feature updates on the device in future.|
|Test service plans display in Teams Rooms Pro and Teams Rooms Basic licenses|IT Admins who assign user licenses in the Microsoft Teams admin center or in Microsoft Entra ID see the following test service plans in Teams Rooms Pro and Teams Rooms Basic licenses:<ul><li>Teams Rooms Test 1</li><li>Teams Rooms Test 2</li></ul> | No workaround is required. These service plans don't have any capabilities and can be ignored. They'll continue to display for the lifetime of the two SKUs.|
|Front-of-room display shows a black screen intermittently|On devices that are running version 4.17.x.x of the Teams Rooms for Windows app, you might see a black screen intermittently in the front-of-room display after the system has been idle for some time. </br></br>The information in the Microsoft Teams admin center & the Pro Management portal indicates that the front-of-room display is functioning normally. This status is displayed because the display isn't disconnected. Instead, the app window is hidden.|Select either the **Meet now** or the **Call** button on the console of the Teams Rooms device to restore the front-of-room display immediately.</br></br>To fix the issue, upgrade the Teams Rooms app to version 4.18.35.0.|
|Teams Rooms device console display shows only a **Refresh** button.| On devices that are running version 4.17.x.x of the Teams Rooms for Windows app, you might see a black screen with a **Refresh** button on the console intermittently after the system has been idle for some time.|Select the **Refresh** button to restore the console display. </br></br> If you see the black screen both in the front-of-room display and on the console, select the **Refresh** button on the console display to restore both affected displays.|
|Error displays in Teams Rooms device console|On devices that are running version 4.17.51.0 or later of the Teams Rooms app, the console displays the following error: Teams is currently experiencing an error. If the problem persists, please try restarting your device or talk to your administrator.</i> </br></br>The error displays after actions such as the following occur:<ul><li>The account credentials to sign in to the device are changed.</li><li>The Teams cache is cleared.</li><li>Updates are installed by Teams in the background.</li></ul>|In most cases, this error display goes away after a few minutes and the Teams Rooms app starts normally. No user action is needed. </br></br>If the error display persists beyond a few minutes, then restart the device.|
|Text and icons turn dark on a device that's running Teams Rooms on Windows|After the Teams Rooms app is updated from version 4.16 to 4.17 on devices that are running Teams Rooms on Windows, the text and icons in the device display become dark and unreadable in the new home screen experience.|Use the following steps:<ol><li>Access the Admin mode on the device.</li><li>Navigate to C:\Users\Skype\AppData\Local\Packages\Microsoft.SkypeRoomSystem_8wekyb3d8bbwe\LocalCache\Roaming\Microsoft\Teams</li><li>Open the desktop-config.json file.</li><li>Either update or add the **theme** property with <i>contrast</i> as its value as shown in the following example:</br>"theme" : "contrast".</li><li>Restart the Teams Rooms device.</li><li>Select **Accessibility** on the device console, and turn off the **High contrast** option.</li><li>Restart the Teams Rooms device and check whether the text and icons are readable.</li><li>If the issue still persists, update the value of the **theme** property to <i>darkV2</i>.</li><li>Restart the Teams Rooms device and verify that the issue is fixed.</li></ol>|
|Resolution and scaling settings aren't applied as specified|If you're using an XML configuration file to apply scaling and resolution settings to Front of Room displays, the settings aren't applied correctly anymore after you update the Teams Rooms app to version 4.18.35. Instead, Windows display default settings for scaling and resolution override them.|To work around the issue, reapply the resolution and scaling settings manually by using Teams Rooms admin settings. See [Front of Room display settings](/MicrosoftTeams/rooms/rooms-operations#front-of-room-display-settings?view=exchange-ps&preserve-view=true) for more information.|  
|Video of remote participants has low resolution in SIP and H.323 calls|On a Teams Rooms device that is running either version 4.18.35 or 4.18.43 of the Teams Rooms app, the remote participant's video is set to a default resolution of 360p when using either SIP or H.323 dialing for Teams calls.|No workaround is available at this time.|
|Mismatch between time and calendar display on Teams Rooms device and Front of Room display|If a Teams Rooms device on Windows is idle for more than 2 hours, the time and calendar display on the device freezes. As a result, there's a mismatch between the time and calendar information in the Front of Room display and on the console. This issue occurs intermittently.|Refresh the home screen. Tap either **Meet Now**, **Call**, or **Join with an ID**, and navigate to the home screen.<br/><br/>Also, the home screen refreshes automatically when a user joins a meeting.|
|Teams Rooms app freezes or crashes|After you update the Intel UHD graphics driver on a Teams Rooms device that's running version 4.18.35.0 of the Teams Rooms app, the device either freezes or crashes. This issue occurs both when a user has joined a Teams meeting on the device and when the device is free.|Roll back the Intel UHD graphics driver on the device from version 31.0.101.4502 to 31.0.101.4274. Then restart the Teams Rooms device.|
|Teams Rooms app freezes on HP POLY MTR G9 ELITE MINI and HP Presence|When you use the GC8 controller on an HP POLY MTR G9 ELITE MINI or an HP Presence device, the touch controls stop processing inputs. As a result the Teams Rooms app appears to be frozen.|See [HP Poly MTR G9 Elite Mini  Teams App Freezing while using GC8 Controller.](https://support.poly.com/support/s/article/HP-Poly-MTR-G9-Elite-Mini-Teams-App-Freezing-while-using-GC8-Controller).|

### Hardware issues

| Issue  |  Description | Workaround |
| --- | --- | --- |
|During a Coordinated meeting, when the meeting volume is changed by using a room remote, the speaker on a Surface Hub or Teams Rooms device turns on.|For a trusted device such as a Surface Hub or Teams Rooms device that is set up to automatically join a Coordinated meeting when the primary device joins, the speaker turns on when a room remote is used to change the meeting volume. This issue occurs even though the audio settings on the device are turned off, and whether they're enabled or disabled.|Turn off proximity join and room remote capabilities on the trusted devices that automatically join a Coordinated meeting.|

## Teams Rooms and devices on Android

### Issues affecting multiple devices

| Issue  |  Description | Workaround |
| --- | --- | --- |
|The **Report an issue** option in Teams Rooms on Android devices doesn't work|In Teams Rooms on Android devices, Teams phones, Teams panels and Teams displays, the **Report an issue** option under **Settings** is unavailable.|The option to report issues from Teams Rooms on Android devices is being enhanced. The **Report an issue** option will be unavailable until the updated experience is released.</br></br>If you were using the **Report an issue** option to collect device logs to troubleshoot issues, use the Microsoft Teams admin center instead. See [Collect Android Teams device logs](/microsoftteams/troubleshoot/teams-rooms-and-devices/collect-device-logs) for detailed instructions.|
|Teams phones and Teams panels sign out automatically.<br/><br/> Teams Rooms on Android devices sign out automatically and become unpaired|Some models of Teams phones and Teams panels that are running version 5.0.5882.0 of the Company Portal app sign out automatically.<br/><br/>Also, Teams Rooms on Android devices that are running the Teams Rooms app version 1449/1.0.96.2023090601 and Company portal app version 5.0.5954.0 might sign out automatically and the touch console on the devices becomes unpaired.<br/><br/>These issues occur if the devices run out of memory or Workplace Join experiences errors.|Periodically restart the affected devices through the Microsoft Teams admin center or Pro Management portal. For applicable device models, you can also set a nightly restart option in the firmware.|

### Issues with meeting room devices

| Issue  |  Description | Workaround |
| --- | --- | --- |
| Laser pointer and drawing tools in PowerPoint Live don't display for in-room participants | In-room meeting participants in a Teams meeting who are using Teams Rooms on Android devices aren't able to see the following features during a PowerPoint Live presentation: Laser pointer, pen, highlighter, and eraser. | Join the meeting on your personal device to see the laser pointer and drawing tools in PowerPoint Live. |
| Teams Admin Settings unavailable on Teams Rooms on Android devices with Teams Rooms Basic license. | The **Teams Admin Settings** option under **Device Settings** is unavailable on devices that have the Teams Rooms Basic license for Teams Rooms on Android CY22 U3 app (version 1449/1.0.96.2022120503). | Admins can either assign a Teams Rooms Pro license to the same device or downgrade the device to use Teams Rooms on Android CCY22 U2B app (version: 1449/1.0.96.2022090606) instead. |
|Video issues in some Logitech devices during Cisco Webex meetings|On some Logitech devices that run Teams Rooms on Android, the participant's video might either freeze or not display during Cisco Webex meetings.<br/><br/>When you join a third-party online meeting by using a Teams Rooms device, the meeting experience is controlled by the third-party online meeting provider. In the meetings where this issue occurs, Cisco Webex controls the video display. The issue with the participant video isn't caused by Teams Rooms on Android.|

### Issues with Teams phones

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Sign in loops or fails for Teams on Android phones |You can't sign in or the sign-in continually loops when both the MFA and the Terms of Use (ToU) Conditional Access (CA) policies are used. |The combination of MFA CA and ToU CA isn't supported. You should exclude it from being used. <br><br> To avoid the sign-in error, ensure that only the MFA CA or only the MDM CA is used. When only the MFA CA is used, make sure that it's enabled in Device Registration Services (DRS). For more information, see [Conditional Access: Cloud apps, actions, and authentication context](/azure/active-directory/conditional-access/concept-conditional-access-cloud-apps#user-actions).|
|Can't add, delete, or edit contacts on Android phones|You can't perform the add, delete, and edit operations on contacts from Teams on Android phones.|Use either the Teams desktop or the Teams web client to perform these actions.|
|Users can't configure the Busy on Busy feature on the phone device.|The Busy on Busy feature that's configured in the Microsoft Teams admin center is honored on the phone device. However, a user controlled option for the Busy on Busy feature isn't supported.|No workaround is available at this time.|
| Signed out of Teams on Android devices | Teams Rooms on Android, Teams phone devices, Teams panels, and Teams displays are signed out of Teams automatically. | Follow the instructions provided in [Signed out of Teams on Android devices](./signed-out-of-teams-android-devices.md).|
| Can't resume a call after using **Consult first** option on Teams phones | After using the **Consult first** option in the **Transfer** menu when you select the **Resume** option to resume the call, the call fails. | End the call made by using the **Consult first** option and then resume the original call.|
|Calls on long hold in GCCH tenants drop intermittently|On GCCH tenants that are running 2022 update #4A (Teams app version 1449/1.0.94.2022110803), when a user puts a call on long hold the call drops in some instances. This issue doesn't occur on other clouds.|No workaround is available at this time.|
|In Better together mode, the **Mute** setting on Teams phones doesn't seem to work during a screen share with audio|On Teams phones that use the Better together feature, when you share a screen and enable the **Include computer sound** option during a Teams meeting, the audio from the phones that are muted is still heard.<br/><br/>If you toggle the **Unmute** and **Mute** options a few times, the audio output that is coming from both from the desktop client as well as the Teams phones results in howling.|No workaround is available at this time.|

### Issues with Teams panels

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Joining a meeting on a Teams Rooms device doesn't check you in for the meeting|You have a panel that shares a resource account with a Teams Room device. If you join a scheduled meeting on the Teams Rooms device, you might not be checked in for your reservation on the panel. This issue occurs intermittently.|If the issue is happening often, turn off the **Release room if no one checks in** setting in the Microsoft Teams admin center.|

## Limitations

- Front row requires 1920 × 1080 resolution for a 16:9 display or 2560 × 1080 resolution for a 21:9 display. These displays are set to 100 percent scaling. If the chat panel on your front-of-room display shows unreadable UI, see [Change scale and resolution for front-of-room](/microsoftteams/rooms/rooms-operations#scale-and-resolution) to adjust your display settings.
- Teams Rooms doesn't support High-Bandwidth Digital Content Protection (HDCP) input. Using HDCP input might cause issues that affect High-Definition Multimedia Interface (HDMI) ingest functionality, such as video and audio. To avoid these issues, make sure that the HDCP options are turned off for switches that are connected to Teams Rooms.
- Teams Rooms on Android doesn't support the ability to join cross-cloud meetings.
- When you use the Call app on a Teams Rooms device to dial the toll number or conference ID for a Teams meeting, the conference bridge triggers multiple call flows. Because the Teams Rooms app is designed to support only one active call at a time, the call fails. This behavior occurs in both Teams Rooms on Windows and Teams Rooms on Android.<br/><br/>Instead of using the Call app, join the meeting by using the **Join with an ID** option and entering the meeting ID.

## Expected behavior

- If your Teams Rooms device loses trust with the domain, you won't be able to authenticate into the device and access its settings. For example, if you remove Teams Rooms from the domain after it gets domain joined, the trust relationship will be lost. In this situation, sign in to the device by using a local administrator account.
- If you use a consumer TV as the front-of-room display, then you might see stability issues with Teams Rooms for the following reasons:
  - Inconsistent implementation of standby modes
  - Active video source selection
  - Incorrect EDID information that's communicated to the Teams Rooms device

  The symptoms include a black or gray screen on the front-of-room display, or the Teams Rooms console becomes unresponsive after waking from standby mode. If you experience issues when you use consumer TVs, we recommend that you install a configurable EDID controller or EDID emulator, such as the [HD-RX-4K-201-C-E](https://www.crestron.com/Products/Video/HDMI-Solutions/HDMI-Extenders/HD-RX-4K-210-C-E) from Crestron, or [DR-EDID Emulator](https://fsrinc.com/fsr-products/product/4051-dr-edid2-emulator) from FSR Video Products Group.
- The Microsoft Teams admin center only identifies valid, certified firmware. If uncertified firmware is updated on the device by means other than the Microsoft Teams admin center, the admin center will display only the old firmware. This behavior might occur with Teams Rooms on Android devices and Teams IP phones.
- If you're in a call with another user who is on a Teams Rooms device, you can't transfer the call. This is because the Teams Rooms app can handle only one call at a time. This behavior occurs in both Teams Rooms on Windows and Teams Rooms on Android.

## Support for third-party Teams devices

For issues with Teams devices offered by third-party providers, contact their individual sites for support:

- Logitech: [Logitech Support](https://support.logi.com/hc/)
- Crestron: [Crestron Support](https://support.crestron.com/)
- Poly: [Poly Support](https://www.poly.com/us/en/support)
- Yealink: [Yealink Support](https://support.yealink.com/portal/home)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
