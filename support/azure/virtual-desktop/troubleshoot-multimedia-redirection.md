---
title: Troubleshoot multimedia redirection on Azure Virtual Desktop
description: Known issues and troubleshooting instructions for multimedia redirection for Azure Virtual Desktop.
ms.topic: troubleshooting
ms.date: 02/03/2025
ms.reviewer: daknappe
ms.custom: docs_inherited, pcy:wincomm-user-experience
---
# Troubleshoot multimedia redirection for Azure Virtual Desktop

This article describes known issues and troubleshooting instructions for multimedia redirection for Azure Virtual Desktop and Windows 365.

## Known issues and limitations

Here are the current known issues and limitations for multimedia redirection:

- In the first browser tab a user opens, the extension pop-up might show the message "The extension is not loaded" or a message that says video playback or call redirection isn't supported while redirection is working correctly in the tab. You can resolve this issue by opening a second tab.
- Multimedia redirection only works on Windows. Any other platforms, such as macOS, iOS, or Android, or connecting to a remote session in a web browser on any platform don't support multimedia redirection.
- Multimedia redirection doesn't work as expected if the session hosts in your deployment block **cmd.exe**.
- If you aren't using the default Windows size settings for video players, such as not fitting the player to the window or not maximizing the window, parts of video players might not appear correctly. If you encounter this issue, you should change the settings back to the default settings.
- If your monitor or browser scale factor isn't set to 100%, you might see a grey pattern appear on the video screen.

### Known issues for video playback redirection

- Video playback redirection doesn't support protected content.
- When you resize the video window, the window's size adjusts faster than the video itself. You also see this issue when minimizing and maximizing the window.
- If you access a video site, sometimes, the video remains in a loading or buffering state but never actually starts playing. For now, you can make videos load again by signing out of your remote session and signing in again.

### Known issues for call redirection

- Call redirection only works for WebRTC-based audio calls on the sites listed in [Call redirection](/azure/virtual-desktop/multimedia-redirection-video-playback-calls#call-redirection).
- When you disconnect from a remote session, call redirection might stop working. You can make redirection start working again by refreshing the webpage.
- If you see issues on a supported WebRTC audio calling site and enabled the **Enable video playback for all sites** setting in the multimedia redirection extension pop-up, disable the setting and try again.

### The MSI installer doesn't install the browser extension

- If the `.msi` file doesn't install the browser extension, you can install the multimedia redirection extension from the Microsoft Edge Store or Google Chrome Store. You need to use the following links as the extension isn't searchable:

  - [Multimedia redirection browser extension (Microsoft Edge)](https://microsoftedge.microsoft.com/addons/detail/wvd-multimedia-redirectio/joeclbldhdmoijbaagobkhlpfjglcihd)
  - [Multimedia browser extension (Google Chrome)](https://chrome.google.com/webstore/detail/wvd-multimedia-redirectio/lfmemoeeciijgkjkgbgikoonlkabmlno)

- Installing the extension on host machines with the MSI installer prompts users to either accept the extension the first time they open the browser or display a warning or error message. If users deny this prompt, it can cause the extension to not load. To avoid this issue, install the extensions by [editing the group policy](/azure/virtual-desktop/multimedia-redirection#install-the-browser-extension-using-group-policy).

- Sometimes, the host and client version number disappears from the extension status message, which prevents the extension from loading on websites that support it. If you installed the extension correctly, this issue is because your host machine doesn't have the latest C++ Redistributable installed. To fix this issue, install the [latest supported Visual C++ Redistributable downloads](/cpp/windows/latest-supported-vc-redist).

## Getting help for call redirection and video playback

If you can start a call with multimedia redirection enabled and see the green phone icon on the extension icon while calling, but the call quality is low, you should contact the app provider for help.

If calls aren't going through, certain features don't work as expected while multimedia redirection is enabled, or multimedia redirection isn't enabled at all, submit a [Microsoft support ticket](/azure/azure-portal/supportability/how-to-create-azure-support-request).

If you encounter any video playback issues that this guide doesn't address or resolve, submit a [Microsoft support ticket](/azure/azure-portal/supportability/how-to-create-azure-support-request).

## Collect logs

If a web page isn't working as expected with multimedia redirection, you can collect logs to help troubleshoot the issue. To collect logs:

1. Select the extension icon in your browser.
2. Select **Show Advanced Settings**.
3. For **Collect logs**, select **Start**.
4. Reproduce the issue on the web page, select the extension icon again, and for **Collect logs**, select **Stop**. Your browser automatically prompts you to download one or more log files that you can save and use with support cases.

## Next steps

For more information about this feature and how it works, see [What is multimedia redirection for Azure Virtual Desktop?](/azure/virtual-desktop/multimedia-redirection-video-playback-calls)

To learn how to use this feature, see [Multimedia redirection for Azure Virtual Desktop](/azure/virtual-desktop/multimedia-redirection).
