---
title: Known issues with Teams Rooms on Windows
description: Provides a list of known issues for Teams Rooms on Windows.
ms.author: luche
author: helenclu
ms.reviewer: mattslomka, sohailta, garyanselme, czawideh
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
ms.date: 06/12/2025
---
# Known issues with Teams Rooms on Windows

<!-- If you get word that one of these issues no longer applies, contact meerak@microsoft.com to EoL the corresponding KB.  -->

## Software issues

| Issue  |  Description | Workaround |
| --- | --- | --- |
|Teams Rooms app out of date|The Teams Rooms console displays the **system config out of date** error.|To fix this issue, [use the Microsoft Teams Rooms recovery tool](/MicrosoftTeams/rooms/recovery-tool).|
|Can't access Windows Settings from the desktop right-click menu.|On Teams Rooms devices that are running app version 3.1.98.0 or later versions, any user account that has the Teams Rooms app installed can access Windows Settings only by using the Start menu. If you try to access Windows Settings by using another method, the Teams Rooms app will open instead.|Use one of the following workarounds to access Windows Settings:<ul><li>Select the **Settings** option from the **Start** menu.</li><li>Uninstall the Teams Rooms app for the affected user. Locate the app on the **Start** menu, right-click it and select **Uninstall**.</li></ul>|
|Teams Rooms device loses internet connectivity after installing a feature update for Windows| A Teams Rooms device that is connected to a network, which requires a proxy can't connect to the internet after installing a feature update for Windows, including an upgrade to Windows 11.<br/><br/>This issue occurs if the proxy setting for internet access on the affected device is configured for the LocalSystem instead of a system-wide proxy. The Windows feature update deletes the LocalSystem settings. This behavior is by design.|If your device has proxy settings set for the LocalSystem user, transfer those settings to the [system-wide proxy settings](/windows/client-management/mdm/networkproxy-csp) that are set and maintained through Mobile Device Management (MDM). Alternatively, you can use the [Set-WinInetProxy](https://www.powershellgallery.com/packages/WinInetProxy/0.1.0) PowerShell cmdlet to configure the system-wide proxy settings.</br></br>When you use system-wide proxy settings, they won't be affected when you install Windows feature updates on the device in future.|
|Test service plans display in Teams Rooms Pro and Teams Rooms Basic licenses|IT Admins who assign user licenses in the Microsoft Teams admin center or in Microsoft Entra ID see the following test service plans in Teams Rooms Pro and Teams Rooms Basic licenses:<ul><li>Teams Rooms Test 1</li><li>Teams Rooms Test 2</li></ul> | No workaround is required. These service plans don't have any capabilities and can be ignored. They'll continue to display for the lifetime of the two SKUs.|
|Xbox application window appears on a Teams Rooms device.|In a Teams Rooms on Windows device, when you select **Room Controls** on the console, an Xbox app window appears. In some cases, this window is followed by a pop-up window that displays the following warning message:<br/><br/>In some cases, this window is followed by a pop-up window that displays the following warning message:<br/><br/><i>Gaming Services required</i><br/><br/>The Xbox app is included as part of Windows but should not start automatically.|If you see the warning message, use the following steps to work around the issue:<ol><li>In the Teams Rooms device console, select **More** > **Settings**.</li><li>Select **Windows Settings**.</li><li>Sign in as an administrator.</li><li>Search for and select **Microsoft Store**.</li><li>Select **Library** in the navigation menu.</li><li>Select **Get updates**.</li><li>After all the applications, including the Xbox app finish updating, restart the Teams Rooms device.</li></ol><br/><br/>If you don't see a warning message, use the following steps to prevent the Xbox app from starting automatically:<ol><li>In the Xbox app window that appears, select **Sign in** > **Settings** in the menu.</li><li>Select **General**.</li><li>Uncheck the **Automatically launch app at startup option**.</li><li>Close the Xbox app window.</li></ol>|
|Chat panel in Gallery view is blank.|You restart a Teams Rooms on Windows device and join a meeting. However you see that the chat panel in Gallery view is empty.<br/><br/>This issue occurs only with the first meeting that you join after restarting your device. Subsequent meetings are not affected.|To fix the issue, update to version 5.2.115.0 of the Teams Rooms app.|
|The onscreen keyboard on a touch console device is missing or not responsive.|The onscreen keyboard on the touch console in a Teams Rooms for Windows device either doesn't work or doesn't appear.<br/><br/>Because of this issue, you're unable to perform the following actions:<ul><li>Enter text to call another user.</li><li>Add a user to a meeting.</li><li>Enter a username and password to access the Settings menu.</li></ul>|To fix the issue, update to version 5.2.115.0 of the Teams Rooms app.|
|Teams Rooms device console displays an error message after updating the Teams Rooms app to 5.2.115.0.|You update the Teams Rooms app on your Teams Rooms for Windows device to version 5.2.115.0. As soon as the update is installed, the device console displays the following error message:<br/><br/><i>Teams is experiencing an error.</i><br/><br/>Even after restarting the device, the Teams Rooms app doesn't start.<br/><br/>In this scenario, the error message displays for one of the following reasons:<ul><li>The settings on the Teams Rooms device have been modified to prevent Edge WebView2 Runtime from being installed. The WebView2 control is required for the Teams Rooms app to function.</li><li>The local Skype user account on the Teams Rooms device has been renamed, disabled and replaced with either a different account or an AD/Microsoft Entra ID account.</li><li>Security policies that're applied to the Teams Rooms device are blocking the Skype user account from installing MSIX files.</li></ul><br/>**Note**: There are other scenarios when this error message might appear. However the information provided in this document is specific to Teams Rooms devices that were working as expected until the Teams Rooms app was updated to version 5.2.115.0.|Use one of the following workarounds as appropriate for your scenario.<br/><br/>**Edge WebView2 Runtime missing**<br/><br/>If the Edge WebView2 Runtime is not installed, use the following steps to install it:<ol><li>On the Teams Rooms device console, select **More** > **Settings**.</li><li>Select **Windows Settings**. </li><li>Sign in as an administrator.</li><li>Open Microsoft Edge and navigate to the [download page for Edge Webview2 Runtime](https://developer.microsoft.com/en-us/microsoft-edge/webview2/?form=MA13LH#download).</li><li>Select "x64" in the **Evergreen Standalone Installer** option to download the installer.</li><li>Browse to the downloaded installer file, then right-click and select **Run as administrator**.</li><li>After WebView2 Runtime is installed, restart the Teams Rooms device.</li></ol><br/>**Skype account modified**<br/><br/>If you modify the local Skype user account on the Teams Rooms device, the device breaks. Because [modifications to the Skype user account are not supported](/microsoftteams/rooms/security?tabs=Windows#software-security), the Teams Rooms device must be reset with the factory recovery media.<br/><br/>After the reset, the Skype user account must be left in its default state to ensure that the Teams Rooms app functions correctly.<br/>**Security policies blocking MSIX installation**<br/><br/>When you update to version 5.2 of the Teams Rooms app, there is no provision to fall back to an older version of the app. So if a security policy blocks non-admin users such as the Skype user account from installing MSIX files, the new Teams Rooms app will fail to launch. You need to update your security policies to resolve the issue.|
|Unable to join some Webex meetings|When you select the **Join** button to join a Cisco Webex meeting from a Teams Rooms on Windows device, you're not connected to the meeting and see the home screen on the device instead.|No workaround is available at this time. Cisco is investigating the issue.|
|Only see one camera's view even though multi-camera feature is turned on.|Your Teams Rooms on Windows device is configured for multiple cameras. However after the device restarts, remote users might see only the default camera's view.<br/><br/>This issue might occur only in the first meeting after the device restarts. The cameras function as expected in all subsequent meetings.|To work around the issue, end the first meeting after the device restarts, and start a second meeting.|
|Front of Room view displays a blank, black screen on a remote access tool.|When you access a Teams Rooms on Windows console remotely by using tools such as the Teams Rooms Pro Management Portal (PMP), TeamViewer, Virtual Network Computing (VNC) etc., the Front of Room (FoR) monitors display a black image instead of the expected user interface.<br/><br/>The FoR monitors in the meeting room display the expected screen but show only a black image in the view on the remote access tool.<br/><br/>If you sign in to the Teams Rooms device by using administrator credentials, you see the Windows screen in the FoR view as expected.|No workaround is available at this time.|

## Hardware issues

| Issue  |  Description | Workaround |
| --- | --- | --- |
|During a Coordinated meeting, when the meeting volume is changed by using a room remote, the speaker on a Surface Hub or Teams Rooms device turns on.|For a trusted device such as a Surface Hub or Teams Rooms device that is set up to automatically join a Coordinated meeting when the primary device joins, the speaker turns on when a room remote is used to change the meeting volume. This issue occurs even though the audio settings on the device are turned off, and whether they're enabled or disabled.|Turn off proximity join and room remote capabilities on the trusted devices that automatically join a Coordinated meeting.|
|The central part of the console on a Teams Rooms device doesn't respond to touch and mouse input.|On some Microsoft Teams Rooms devices such as the Crestron Dell Optiplex 7080 that use a 4k monitor connected as the front-of-room display, the central portion of the display intermittently stops responding to touch and mouse controls.<br/><br/>Despite this issue, the Teams Rooms app is functional and accepts inputs from a connected keyboard.|Contact Microsoft Support for assistance to work around this issue.|

## Limitations

- Teams Rooms doesn't support High-Bandwidth Digital Content Protection (HDCP) input. Using HDCP input might cause issues that affect High-Definition Multimedia Interface (HDMI) ingest functionality, such as video and audio. To avoid these issues, make sure that the HDCP options are turned off for switches that are connected to Teams Rooms.
- When you use the Call app on a Teams Rooms device to dial the toll number or conference ID for a Teams meeting, the conference bridge triggers multiple call flows. Because the Teams Rooms app is designed to support only one active call at a time, the call fails.

  Instead of using the Call app, join the meeting by using the **Join with an ID** option and entering the meeting ID.
- If you're in a call with another user who is on a Teams Rooms device, you can't transfer the call. This is because the Teams Rooms app is designed to support only one call at a time.
- If your organization has configured policies to block legacy authentication for the Teams Rooms app, then Teams Rooms on Windows devices, can't join Teams meetings.

## Support for third-party Teams devices

For issues with Teams devices offered by third-party providers, contact their individual sites for support:

- Logitech: [Logitech Support](https://support.logi.com/hc/)
- Crestron: [Crestron Support](https://support.crestron.com/)
- Poly: [Poly Support](https://www.poly.com/us/support)
- Yealink: [Yealink Support](https://support.yealink.com/portal/home)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
