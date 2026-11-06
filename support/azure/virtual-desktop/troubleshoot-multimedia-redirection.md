---
title: Troubleshoot multimedia redirection on Azure Virtual Desktop
description: Learn how to troubleshoot multimedia redirection extension status messages and known issues in Azure Virtual Desktop and Windows 365. Fix problems now.
ms.date: 11/06/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: adpace, hakrager
ms.custom: docs_inherited, pcy:wincomm-user-experience
ai-usage: ai-assisted
---
# Troubleshoot multimedia redirection for Azure Virtual Desktop

## Summary

Use this article to troubleshoot multimedia redirection for Azure Virtual Desktop and Windows 365. It explains how to resolve extension status messages, work around known issues, and collect logs for support.

## Extension status messages

The multimedia redirection browser extension shows a status message in its pop-up that tells you whether redirection is working on the current web page and, if it isn't, why. To see the status message, select the extension icon in your browser's toolbar. If the icon isn't pinned to the toolbar, select **Extensions** (the puzzle piece icon), and then select **Microsoft Multimedia Redirection**. To keep the icon visible, select the pin icon next to the extension name. When there's a problem, the message appears in a highlighted callout. Errors are red, warnings are amber, and informational messages are grey.

When redirection is working, the pop-up shows the current state without a callout. In the following example, the extension icon in the toolbar has a green phone badge, the status reads **A call is being redirected**, and **Call Redirection** has a green check mark.

:::image type="content" source="media/troubleshoot-multimedia-redirection/extension-popup-call-redirected.png" alt-text="Screenshot of the multimedia redirection extension pop-up opened from the browser toolbar, showing the status A call is being redirected and a green check mark next to Call Redirection." lightbox="media/troubleshoot-multimedia-redirection/extension-popup-call-redirected.png":::

The following pop-up shows an error because the microphone is blocked on the local device. The extension icon has a red **X**, and the callout explains how to fix the problem.

:::image type="content" source="media/troubleshoot-multimedia-redirection/extension-popup-microphone-blocked.png" alt-text="Screenshot of the multimedia redirection extension pop-up showing a red callout with the message Microphone is blocked on your local PC, and a check mark next to Call Redirection." lightbox="media/troubleshoot-multimedia-redirection/extension-popup-microphone-blocked.png":::

The following table lists the status messages, what they mean, and how to resolve them. If more than one problem applies, the pop-up shows the most severe one.

| Status message | Severity | Cause | Resolution |
|--|--|--|--|
| **The extension failed to load**<br>Couldn't connect to the Multimedia Redirection service. Check your setup or reinstall the service. | Error | The browser extension can't communicate with the Remote Desktop Multimedia Redirection Service on the session host. The service might not be installed, might be damaged, or might be blocked from starting. | See [The extension failed to load](#the-extension-failed-to-load). |
| **Microphone is blocked on your local PC**<br>Allow microphone access in Windows privacy settings on your local PC. | Error | Windows privacy settings on your local device block Windows App from using the microphone. | See [Microphone is blocked on your local PC](#microphone-is-blocked-on-your-local-pc). |
| **Another Multimedia Redirection extension is running**<br>Running more than one Multimedia Redirection extension isn't supported. Disable or remove one extension to avoid conflicts. | Warning | More than one multimedia redirection extension is enabled in the same browser, for example both the public and Insider versions. | See [Another Multimedia Redirection extension is running](#another-multimedia-redirection-extension-is-running). |
| **The extension is not loaded**<br>Multimedia redirection isn't available on this remote client. | Info | The Remote Desktop client you used to connect to the remote session doesn't support multimedia redirection. | Connect from a supported Remote Desktop client. For the list of supported clients, see the [prerequisites for multimedia redirection](/azure/virtual-desktop/multimedia-redirection-video-playback-calls#prerequisites). |
| **Not active on this site**<br>Refresh the page to check if redirection is available here. | Info | The web page was opened before the extension connected to your Remote Desktop client, for example when the browser started before you connected or after you reconnected to the remote session. | Refresh the web page. If the pop-up still shows **Not active on this site** without the refresh prompt, the web page isn't supported for redirection. |
| **Not active on this site** | Info | The web page isn't supported for video playback redirection or call redirection. | If you expect the web page to support redirection, check that it's in the list of [websites for video playback redirection](/azure/virtual-desktop/multimedia-redirection-video-playback-calls#websites-for-video-playback-redirection) or [websites for call redirection](/azure/virtual-desktop/multimedia-redirection-video-playback-calls#websites-for-call-redirection). To enable call redirection for other websites, see [Enable call redirection for specific domains](/azure/virtual-desktop/multimedia-redirection-video-playback-calls#enable-call-redirection-for-specific-domains). |

When redirection is working, the pop-up shows **The extension is loaded**, **A video is being redirected**, or **A call is being redirected** without a highlighted callout.

### The extension failed to load

If the extension pop-up shows **The extension failed to load**, any of the following issues on the session host can cause it. Check each one, and restart the browser after you fix an issue:

- The Remote Desktop Multimedia Redirection Service isn't installed. To install it, see [install multimedia redirection](/azure/virtual-desktop/multimedia-redirection-video-playback-calls).
- The session host doesn't have the [latest supported Visual C++ Redistributable](/cpp/windows/latest-supported-vc-redist) installed.
- Your deployment blocks **cmd.exe** on the session host. For a workaround, see [Session hosts block cmd.exe](#session-hosts-block-cmdexe).

If none of these issues apply, uninstall and reinstall the Remote Desktop Multimedia Redirection Service, and then restart the browser.

### Microphone is blocked on your local PC

Windows App on your local device needs access to your microphone to redirect calls. To allow access, follow these steps on your **local** Windows device, not in the remote session:

1. Open the **Settings** app.
1. Select **Privacy & security**, then select **Microphone**.
1. Turn on **Microphone access** and **Let apps access your microphone**.
1. In the list of apps, turn on access for **Windows App**.

After you change the setting, refresh the web page. If your organization manages these settings, contact your administrator.

### Another multimedia redirection extension is running

Running more than one multimedia redirection extension in the same browser isn't supported. When more than one extension is enabled, only one of them redirects the web page, and the extension pop-up shows a warning.

To resolve this issue, follow these steps:

1. In your browser, go to `edge://extensions` for Microsoft Edge or `chrome://extensions` for Google Chrome.
1. Disable or remove every multimedia redirection extension except the one you want to use, for example **Microsoft Multimedia Redirection** or **MMR (Insider)**.
1. Refresh the web page.

If your organization deploys the extension by using policy, ensure that only one multimedia redirection extension is force-installed.

### Session hosts block cmd.exe

By default, Microsoft Edge and Google Chrome use **cmd.exe** to start the Remote Desktop Multimedia Redirection Service when the extension loads. If your deployment blocks **cmd.exe** on session hosts, such as by using App Control for Business or AppLocker, the extension can't start the service and the pop-up shows **The extension failed to load**.

To resolve this issue, enable the `NativeHostsExecutablesLaunchDirectly` browser policy on your session hosts. This policy makes the browser start the service directly instead of through **cmd.exe**.

- For Microsoft Edge version 121 and later, see [NativeHostsExecutablesLaunchDirectly](/deployedge/microsoft-edge-policies/nativehostsexecutableslaunchdirectly). Set the policy by using Group Policy, Microsoft Intune, or the following registry value:

  - **Key**: `HKLM\SOFTWARE\Policies\Microsoft\Edge`
  - **Name**: `NativeHostsExecutablesLaunchDirectly`
  - **Type**: `REG_DWORD`
  - **Data**: `1`

- For Google Chrome, see [Chrome Enterprise policy list](https://chromeenterprise.google/policies/#NativeHostsExecutablesLaunchDirectly). Set the policy by using Group Policy or the following registry value:

  - **Key**: `HKLM\SOFTWARE\Policies\Google\Chrome`
  - **Name**: `NativeHostsExecutablesLaunchDirectly`
  - **Type**: `REG_DWORD`
  - **Data**: `1`

Restart the browser after you change the policy.

## Known issues and limitations

Multimedia redirection works only with supported Remote Desktop clients. For the list of supported clients, see the [prerequisites for multimedia redirection](/azure/virtual-desktop/multimedia-redirection-video-playback-calls#prerequisites).

### Known issues for video playback redirection

The following issues are known for video playback redirection:

- Video playback redirection doesn't support protected content.
- When you resize, minimize, or maximize the video window, the window changes size before the video does.

### Known issues for call redirection

The following issues are known for call redirection:

- Call redirection works only for WebRTC-based audio calls on the websites listed in [Call redirection](/azure/virtual-desktop/multimedia-redirection-video-playback-calls#call-redirection).
- After you reconnect to a remote session, call redirection might stop working on web pages that were already open. To fix this issue, refresh the web page.
- If calls don't work as expected on a supported website and **Enable video playback for all sites** is turned on in the extension pop-up, turn off the setting and try again.

### Known issues for installing the browser extension

The following issues are known for installing the browser extension:

- The `.msi` file might not install the browser extension. If this problem occurs, install the extension from the Microsoft Edge Add-ons or Chrome Web Store by using the following links. You can't find the extension by searching the stores.

  - [Microsoft Multimedia Redirection for Microsoft Edge](https://microsoftedge.microsoft.com/addons/detail/wvd-multimedia-redirectio/joeclbldhdmoijbaagobkhlpfjglcihd)
  - [Microsoft Multimedia Redirection for Google Chrome](https://chromewebstore.google.com/detail/lfmemoeeciijgkjkgbgikoonlkabmlno)

- When the `.msi` file installs the extension, the browser prompts users to turn on the extension the first time they open it. If a user doesn't turn on the extension, it doesn't load. To avoid this prompt, [install the extension by using Group Policy](/azure/virtual-desktop/multimedia-redirection#install-the-browser-extension-using-group-policy).

## Collect logs

If a web page isn't working as expected with multimedia redirection, collect logs to help troubleshoot the issue. To collect logs, follow these steps:

1. Select the extension icon in your browser's toolbar. If you don't see it, select **Extensions** (the puzzle piece icon), and then select **Microsoft Multimedia Redirection**.
1. Select **Show Advanced Settings**.
1. For **Collect logs**, select **Start**.
1. Reproduce the issue on the web page, select the extension icon again, and for **Collect logs**, select **Stop**. Your browser automatically prompts you to download one or more log files that you can save and use with support cases.

## Getting help for call redirection and video playback

If you can start a call with multimedia redirection enabled and see the green phone icon on the extension icon while calling, but the call quality is low, contact the app provider for help.

If calls aren't going through, certain features don't work as expected while multimedia redirection is enabled, or multimedia redirection isn't enabled at all, submit a [Microsoft support ticket](/azure/azure-portal/supportability/how-to-create-azure-support-request).

If you encounter any video playback issues that this guide doesn't address or resolve, submit a [Microsoft support ticket](/azure/azure-portal/supportability/how-to-create-azure-support-request).

## References

- For more information about this feature and how it works, see [What is multimedia redirection for Azure Virtual Desktop?](/azure/virtual-desktop/multimedia-redirection-video-playback-calls)
- To learn how to use this feature, see [Multimedia redirection for Azure Virtual Desktop](/azure/virtual-desktop/multimedia-redirection).