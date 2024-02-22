---
title: Known issues with Teams Rooms on Windows
description: Provides a list of known issues for Teams Rooms on Windows.
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
# Known issues with Teams Rooms on Windows

This article lists the known issues for the Microsoft Teams Rooms app when it's used on Windows devices.
<!-- If you get word that one of these issues no longer applies, contact meerak@microsoft.com or kaushika@microsoft.com and let them know to EoL the corresponding KB  -->

## Software issues

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
|Video of remote participants has low resolution in SIP and H.323 calls|On a Teams Rooms device that is running either version 4.18.35 or 4.18.43 of the Teams Rooms app, the remote participant's video is set to a default resolution of 360p when using either SIP or H.323 dialing for Teams calls.|To fix the issue, upgrade the Teams Rooms app to version 4.19.57.0.|
|Mismatch between time and calendar display on Teams Rooms device and Front of Room display|If a Teams Rooms device on Windows is idle for more than 2 hours, the time and calendar display on the device freezes. As a result, there's a mismatch between the time and calendar information in the Front of Room display and on the console. This issue occurs intermittently.|To fix the issue, upgrade the Teams Rooms app to version 4.19.57.0.|
|Teams Rooms app freezes or crashes|After you update the Intel UHD graphics driver on a Teams Rooms device that's running version 4.18.35.0 of the Teams Rooms app, the device either freezes or crashes. This issue occurs both when a user has joined a Teams meeting on the device and when the device is free.|Roll back the Intel UHD graphics driver on the device from version 31.0.101.4502 to 31.0.101.4274. Then restart the Teams Rooms device.|

## Hardware issues

| Issue  |  Description | Workaround |
| --- | --- | --- |
|During a Coordinated meeting, when the meeting volume is changed by using a room remote, the speaker on a Surface Hub or Teams Rooms device turns on.|For a trusted device such as a Surface Hub or Teams Rooms device that is set up to automatically join a Coordinated meeting when the primary device joins, the speaker turns on when a room remote is used to change the meeting volume. This issue occurs even though the audio settings on the device are turned off, and whether they're enabled or disabled.|Turn off proximity join and room remote capabilities on the trusted devices that automatically join a Coordinated meeting.|

## Issues with Direct Guest Join

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Black screen during a Zoom meeting on a Crestron device|You use a Crestron device that's running Teams Rooms on Windows to join a Zoom meeting. When another user in the meeting shares their screen, the screen on your device turns black. The issue is intermittent. If you leave and rejoin the meeting, the issue might occur again.<br/><br/>**Only Crestron devices are experiencing this issue.**|When you join a third-party online meeting by using a Teams Rooms device, the meeting experience is controlled by the third-party online meeting provider. In the meetings where this issue occurs, Zoom controls the meeting display. <br/><br/>The black screen during the Zoom meeting isn't caused by Teams Rooms on Windows. The issue is being investigated by Zoom.|

## Limitations

- Front row requires 1920 × 1080 resolution for a 16:9 display or 2560 × 1080 resolution for a 21:9 display. These displays are set to 100 percent scaling. If the chat panel on your front-of-room display shows unreadable UI, see [Change scale and resolution for front-of-room](/microsoftteams/rooms/rooms-operations#scale-and-resolution) to adjust your display settings.
- Teams Rooms doesn't support High-Bandwidth Digital Content Protection (HDCP) input. Using HDCP input might cause issues that affect High-Definition Multimedia Interface (HDMI) ingest functionality, such as video and audio. To avoid these issues, make sure that the HDCP options are turned off for switches that are connected to Teams Rooms.
- When you use the Call app on a Teams Rooms device to dial the toll number or conference ID for a Teams meeting, the conference bridge triggers multiple call flows. Because the Teams Rooms app is designed to support only one active call at a time, the call fails. 

  Instead of using the Call app, join the meeting by using the **Join with an ID** option and entering the meeting ID.

## Expected behavior

- If your Teams Rooms device loses trust with the domain, you won't be able to authenticate into the device and access its settings. For example, if you remove Teams Rooms from the domain after it gets domain joined, the trust relationship will be lost. In this situation, sign in to the device by using a local administrator account.
- If you use a consumer TV as the front-of-room display, then you might see stability issues with Teams Rooms for the following reasons:
  - Inconsistent implementation of standby modes
  - Active video source selection
  - Incorrect EDID information that's communicated to the Teams Rooms device

  The symptoms include a black or gray screen on the front-of-room display, or the Teams Rooms console becomes unresponsive after waking from standby mode. If you experience issues when you use consumer TVs, we recommend that you install a configurable EDID controller or EDID emulator, such as the [HD-RX-4K-201-C-E](https://www.crestron.com/Products/Video/HDMI-Solutions/HDMI-Extenders/HD-RX-4K-210-C-E) from Crestron, or [DR-EDID Emulator](https://fsrinc.com/fsr-products/product/4051-dr-edid2-emulator) from FSR Video Products Group.
- If you're in a call with another user who is on a Teams Rooms device, you can't transfer the call. This is because the Teams Rooms app is designed to support only one call at a time.

## Support for third-party Teams devices

For issues with Teams devices offered by third-party providers, contact their individual sites for support:

- Logitech: [Logitech Support](https://support.logi.com/hc/)
- Crestron: [Crestron Support](https://support.crestron.com/)
- Poly: [Poly Support](https://www.poly.com/us/en/support)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]