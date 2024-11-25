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
ms.date: 11/08/2024
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
|Text in QR code displays outside the box.|In the home screen on Teams Rooms on Windows devices that use Germany as the locale, the text in the QR code box to join a meeting overflows the boundary of the box.<br/><br/>This issue is purely visual and doesn't impact the functionality of the QR code.|To fix the issue, update to version 5.1.24.0 of the Teams Rooms app.|
|Teams Rooms app window doesn't fill the screen on the device console.|The window of the Teams Rooms app takes up only a part of the device console or Front of Room display and doesn't resize to fill the screen.<br/><br/>This issue usually occurs in displays that are disconnected in their Sleep or Wake states.|To fix the issue, update to version 5.1.24.0 of the Teams Rooms app.|
|Chat panel in Gallery view is blank.|You restart a Teams Rooms on Windows device and join a meeting. However you see that the chat panel in Gallery view is empty.<br/><br/>This issue occurs only with the first meeting that you join after restarting your device. Subsequent meetings are not affected.|To fix the issue, update to version 5.2.115.0 of the Teams Rooms app.|
|The onscreen keyboard on a touch console device is missing or not responsive.|The onscreen keyboard on the touch console in a Teams Rooms for Windows device either doesn't work or doesn't appear.<br/><br/>Because of this issue, you're unable to perform the following actions:<ul><li>Enter text to call another user.</li><li>Add a user to a meeting.</li><li>Enter a username and password to access the Settings menu.</li></ul>|To fix the issue, update to version 5.2.115.0 of the Teams Rooms app.|
|Teams Rooms device console displays an error message after updating the Teams Rooms app to 5.2.115.0.|You update the Teams Rooms app on your Teams Rooms for Windows device to version 5.2.115.0. As soon as the update is installed, the device console displays the following error message:<br/><br/><i>Teams is experiencing an error.</i><br/><br/>Even after restarting the device, the Teams Rooms app doesn't start.<br/><br/>In this scenario, the error message displays for one of the following reasons:<ul><li>The settings on the Teams Rooms device have been modified to prevent Edge WebView2 Runtime from being installed. The WebView2 control is required for the Teams Rooms app to function.</li><li>The local Skype user account on the Teams Rooms device has been renamed, disabled and replaced with either a different account or an AD/Microsoft Entra ID account.</li><li>Security policies that're applied to the Teams Rooms device are blocking the Skype user account from installing MSIX files.</li></ul><br/>**Note**: There are other scenarios when this error message might appear. However the information provided in this document is specific to Teams Rooms devices that were working as expected until the Teams Rooms app was updated to version 5.2.115.0.|Use one of the following workarounds as appropriate for your scenario.<br/><br/>**Edge WebView2 Runtime missing**<br/><br/>If the Edge WebView2 Runtime is not installed, use the following steps to install it:<ol><li>On the Teams Rooms device console, select **More** > **Settings**.</li><li>Select **Windows Settings**. </li><li>Sign in as an administrator.</li><li>Open Microsoft Edge and navigate to the [download page for Edge Webview2 Runtime](https://developer.microsoft.com/en-us/microsoft-edge/webview2/?form=MA13LH#download).</li><li>Select "x64" in the **Evergreen Standalone Installer** option to download the installer.</li><li>Browse to the downloaded installer file, then right-click and select **Run as administrator**.</li><li>After WebView2 Runtime is installed, restart the Teams Rooms device.</li></ol><br/>**Skype account modified**<br/><br/>If you modify the local Skype user account on the Teams Rooms device, the device breaks. Because [modifications to the Skype user account are not supported](/microsoftteams/rooms/security?tabs=Windows#software-security), the Teams Rooms device must be reset with the factory recovery media.<br/><br/>After the reset, the Skype user account must be left in its default state to ensure that the Teams Rooms app functions correctly.<br/>**Security policies blocking MSIX installation**<br/><br/>When you update to version 5.2 of the Teams Rooms app, there is no provision to fall back to an older version of the app. So if a security policy blocks non-admin users such as the Skype user account from installing MSIX files, the new Teams Rooms app will fail to launch. You need to update your security policies to resolve the issue.|
|Resource accounts not getting real-time alerts about audio & video quality.|Some Teams Rooms resource accounts which are assigned the Microsoft Teams Rooms Pro service plan are not sent the expected real-time alerts when the audio or video quality is poor.<br/><br/>When you check the Microsoft Teams admin center, the status of these accounts is displayed as **Pending provisioning**.<br/><br/>When you try to add the Teams Rooms Pro licensed account to the Real-Time Analytics policy in the Microsoft Teams admin center, you get the following error message:<br/><i>Audio monitoring is available only for users who have Teams Premium or a Teams Rooms Pro license. Visit the Microsoft 365 admin center to upgrade licenses.</i>|To work around the issue, use the following steps:<ol><li>Navigate to the Microsoft 365 admin center.</li><li>Remove the Teams Rooms Pro license from the Teams Rooms resource account.</li><li>Save the updated settings.</li><li>Reassign the Teams Rooms Pro license to the Teams Rooms resource account.</li><li>Save the updated settings.</li></ol>|

## Hardware issues

| Issue  |  Description | Workaround |
| --- | --- | --- |
|During a Coordinated meeting, when the meeting volume is changed by using a room remote, the speaker on a Surface Hub or Teams Rooms device turns on.|For a trusted device such as a Surface Hub or Teams Rooms device that is set up to automatically join a Coordinated meeting when the primary device joins, the speaker turns on when a room remote is used to change the meeting volume. This issue occurs even though the audio settings on the device are turned off, and whether they're enabled or disabled.|Turn off proximity join and room remote capabilities on the trusted devices that automatically join a Coordinated meeting.|

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
