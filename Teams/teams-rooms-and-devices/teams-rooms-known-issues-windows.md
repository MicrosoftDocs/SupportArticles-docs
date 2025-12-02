---
title: Known issues with Teams Rooms on Windows
description: Provides a list of known issues for Teams Rooms on Windows.
ms.author: meerak
author: Cloud-Writer
ms.reviewer: mattslomka
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
f1.keywords: 
  - NOCSH
ms.collection: 
  - M365-collaboration
ms.custom: 
  - sap:Msft Teams Rooms Windows (MTRW)
  - seo-marvel-apr2020
  - CSSTroubleshoot
  - CI 121996
  - CI 160661
  - CI 164223
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 11/20/2025
---
# Known issues with Teams Rooms on Windows

<!-- If you get word that one of these issues no longer applies, contact meerak@microsoft.com to EoL the corresponding KB.  -->

## Software issues

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Teams Rooms app out of date|The Teams Rooms console displays the **system config out of date** error.|To fix this issue, [use the Microsoft Teams Rooms recovery tool](/MicrosoftTeams/rooms/recovery-tool).|
|Can't access Windows Settings from the desktop right-click menu.|On Teams Rooms devices that are running app version 3.1.98.0 or later versions, any user account that has the Teams Rooms app installed can access Windows Settings only by using the Start menu. If you try to access Windows Settings by using another method, the Teams Rooms app opens instead.|Use one of the following workarounds to access Windows Settings:<ul><li>Select the **Settings** option from the **Start** menu.</li><li>Uninstall the Teams Rooms app for the affected user. Locate the app on the **Start** menu, right-click it, and select **Uninstall**.</li></ul>|
|Test service plans display in Teams Rooms Pro and Teams Rooms Basic licenses|IT Admins who assign user licenses in the Microsoft Teams admin center or in Microsoft Entra ID see the following test service plans in Teams Rooms Pro and Teams Rooms Basic licenses:<ul><li>Teams Rooms Test 1</li><li>Teams Rooms Test 2</li></ul> | No workaround is required. These service plans don't have any capabilities and can be ignored. They'll continue to display for the lifetime of the two SKUs.|
|Xbox application window appears on a Teams Rooms device.|In a Teams Rooms on Windows device, when you select **Room Controls** on the console, an Xbox app window appears. In some cases, this window is followed by a pop-up window that displays the following warning message:<br/><br/>In some cases, this window is followed by a pop-up window that displays the following warning message:<br/><br/><i>Gaming Services required</i><br/><br/>The Xbox app is included as part of Windows but shouldn't start automatically.|If you see the warning message, use the following steps to work around the issue:<ol><li>In the Teams Rooms device console, select **More** > **Settings**.</li><li>Select **Windows Settings**.</li><li>Sign in as an administrator.</li><li>Search for and select **Microsoft Store**.</li><li>Select **Library** in the navigation menu.</li><li>Select **Get updates**.</li><li>After all the applications, including the Xbox app finish updating, restart the Teams Rooms device.</li></ol><br/><br/>If you don't see a warning message, use the following steps to prevent the Xbox app from starting automatically:<ol><li>In the Xbox app window that appears, select **Sign in** > **Settings** in the menu.</li><li>Select **General**.</li><li>Uncheck the **Automatically launch app at startup option**.</li><li>Close the Xbox app window.</li></ol>|
|Unable to join some Webex meetings|When you select the **Join** button to join a Cisco Webex meeting from a Teams Rooms on Windows device, you're not connected to the meeting and see the home screen on the device instead.|No workaround is available at this time. Cisco is investigating the issue.|
|Automatic remediation in Pro Management portal keeps failing.|The built-in remediation in the Microsoft Teams Rooms Pro Management portal to disable the USB peripheral power draining option under Windows USB settings keeps failing with the error message:<br/><br/>`Auto Remediation was unable to resolve this issue.`|To resolve the issue, implement a manual fix as described in [USB Peripheral Power Drain signal is unhealthy](./usb-peripheral-power-drain-status-unhealthy.md).|
|Lenovo Teams Rooms devices display BitLocker recovery screen.|When you try to update Windows from 23H2 to 24H2 on a Lenovo Teams Rooms for Windows device that has BitLocker enabled, the update might fail and you see a BitLocker recovery screen instead.|The Windows update to 24H2 on Lenovo devices is [blocked](https://support.microsoft.com/topic/kb5070632-some-devices-are-temporarily-unable-to-upgrade-to-windows-11-version-24h2-or-25h2-c3dd7515-21e6-46ce-9a9d-64a8882ef5ca) due to this issue. <br/><br/>You can safely upgrade the versions of the Teams Rooms app to 5.3.205.0 and 5.4.210.0 on the affected devices that will remain on Windows version 23H2. <br/><br/>If one of these versions of the Teams Rooms app is already installed and the device displays the BitLocker recovery screen, enter the BitLocker recovery key to restore functionality.|

## Hardware issues

| Issue  |  Description | Workaround |
| --- | --- | --- |
|During a Coordinated meeting, when the meeting volume is changed by using a room remote, the speaker on a Surface Hub or Teams Rooms device turns on.|For a trusted device such as a Surface Hub or Teams Rooms device that is set up to automatically join a Coordinated meeting when the primary device joins, the speaker turns on when a room remote is used to change the meeting volume. This issue occurs even though the audio settings on the device are turned off, and whether they're enabled or disabled.|Turn off proximity join and room remote capabilities on the trusted devices that automatically join a Coordinated meeting.|
|The central part of the console on a Teams Rooms device doesn't respond to touch and mouse input.|On some Microsoft Teams Rooms devices such as the Crestron Dell Optiplex 7080 that use a 4k monitor connected as the front-of-room display, the central portion of the display intermittently stops responding to touch and mouse controls.<br/><br/>Despite this issue, the Teams Rooms app is functional and accepts inputs from a connected keyboard.|Contact Microsoft Support for assistance to work around this issue.|
|Poor audio quality from a Teams Rooms device.|You might experience any of the following audio quality issues from a USB microphone or speaker that is connected to your Teams Rooms device: <ul><li> - Echo sent to remote participants on the call.</li><li> - Low audio quality sent to remote participants on the call.</li><li> - Decrease in audio quality as the call progresses.</li><li> - Low volume in speakers within the room.</li></ul><br/>This issue might be caused when a setting in the audio driver configuration to enhance audio quality is enabled.|To fix the audio quality issue, disable the audio enhancement setting for the attached Teams-certified USB audio device by using the following steps:<ol><li>Select **Settings** on the Teams Rooms device console.</li><li>Select **Windows Settings**, and sign in to the Teams Rooms device as an administrator.</li><li>Open **Control Panel**.</li><li>Select **Hardware and Sound** > **Sound**.</li><li>On the **Playback** tab, select the affected audio device and then select **Properties**.</li><li>Select the **Advanced** tab.</li><li>In the **Signal Enhancements** section, uncheck **Enable audio enhancements**, and then select **OK**.</li><li>Select the **Recording** tab and repeat steps 5, 6 & 7 for the same audio device </li><li>Select **OK** and then close **Control Panel.</li><li>Restart the Teams Rooms device.</li></ol>|

## Limitations

- Teams Rooms doesn't support High-Bandwidth Digital Content Protection (HDCP) input. Using HDCP input might cause issues that affect High-Definition Multimedia Interface (HDMI) ingest functionality, such as video and audio. To avoid these issues, make sure that the HDCP options are turned off for switches that are connected to Teams Rooms.
- When you use the Call app on a Teams Rooms device to dial the toll number or conference ID for a Teams meeting, the conference bridge triggers multiple call flows. Because the Teams Rooms app is designed to support only one active call at a time, the call fails.

  Instead of using the Call app, join the meeting by using the **Join with an ID** option and entering the meeting ID.
- If you're in a call with another user who is on a Teams Rooms device, you can't transfer the call. This issue occurs because the Teams Rooms app is designed to support only one call at a time.
- If your organization configured policies to block legacy authentication for the Teams Rooms app, then Teams Rooms on Windows devices, can't join Teams meetings.

## Support for non-Microsoft Teams devices

For issues with Teams devices offered by providers other than Microsoft, contact their individual sites for support:

- Logitech: [Logitech Support](https://support.logi.com/hc/)
- Crestron: [Crestron Support](https://support.crestron.com/)
- Poly: [Poly Support](https://www.poly.com/us/support)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
