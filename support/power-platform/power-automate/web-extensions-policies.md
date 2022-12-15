---
title: Handle issues with Power Automate browser extensions
description: Provides a resolution for issues related to Power Automate browser extensions.
ms.reviewer: nimoutzo
ms.date: 12/15/2022
ms.subservice: power-automate-desktop-flows
---

# Handle issues with Power Automate browser extensions

This article provides a resolution to issues related to Power Automate browser extensions.

## Prerequisites

- Ensure that the Power Automate web extension is installed and enabled in your browser.

- Ensure that the correct Power Automate web extension is installed and enabled in your browser. Only one of them can be installed:

    For Power Automate for desktop v2.27 or later, you need the **Microsoft Power Automate** extension. For Power Automate for desktop v2.26 or earlier, you need the **Microsoft Power Automate (Legacy)** extension.

## Symptoms

- An action of browser automation group fails at runtime with error **Failed to assume control of browser (Internal error or communication failure)**.

- During design time, when launching the UI element picker or the recorder and hovering the mouse over a webpage, the following message is displayed:

    :::image type="content" source="media/web-extensions-policies/get-extension-message.png" alt-text="Screenshot of the Get extension message.":::

## Troubleshooting

1. Check if **PAD.BrowserNativeMessageHost.exe** is running for your browser:

    1. Close all open browser windows.

    1. Launch the browser you use in your desktop flows.

    1. Launch the Windows Task Manager.

    1. Go to the **Details** tab, and look for **PAD.BrowserNativeMessageHost.exe**.

    > [!NOTE]
    > One instance of this exe runs for each browser type.

1. Look for errors in the background script. This step is valid only for Microsoft Edge and Google Chrome:

    1. Go to the appropriate extension page:

        - Microsoft Edge: [edge://extensions/](edge://extensions/)
        - Google Chrome: [chrome://extensions/](chrome://extensions/)

    1. Enable the developer mode.

    1. Find the Microsoft Power Automate extension.

    1. Select **background.html** for the Microsoft Power Automate (Legacy) browser extension or **service worker** for the Microsoft Power Automate browser extension. This step will open the developer tools.

    1. Check in the **Console** tab for any errors.

        The error **Access to the native messaging host was disabled by the system administrator** indicates that the policy **NativeMessagingBlocklist** is enabled for the Power Automate for desktop native messaging host or all native messaging hosts.

1. Check for policies blocking the message host:

    1. Go to the appropriate extension page:

        - Microsoft Edge: [edge://policy/](edge://policy/)
        - Google Chrome: [chrome://policy/](chrome://policy/)

    1. Check for **NativeMessagingBlocklist**. If this policy is enabled for all native messaging hosts, add the Power Automate for desktop native messaging host to the **NativeMessagingAllowlist** policy.

    1. For remediation:

        1. Type **Registry Editor** in Windows search to launch the Registry Editor.

        1. For the Microsoft Power Automate (Legacy) browser extension, create the **NativeMessagingAllowlist** policy, if it doesn't already exist, and add the Power Automate for desktop native messaging host:

            ```Registry
            Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\NativeMessagingAllowlist
            Name = {number}
            Data = com.robin.messagehost
            ```

        1. For the Microsoft Power Automate browser extension, there will be a different naming for the messaging host to avoid conflicts with the previous one:

            ```Registry
            Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\NativeMessagingAllowlist
            Name = {number}
            Data = com.microsoft.pad.messagehost
            ```

            :::image type="content" source="media/web-extensions-policies/registry-keys.png" alt-text="Screenshot of the created policy.":::

    1. Check for **NativeMessagingUserLevelHosts**. By default, if **NativeMessagingUserLevelHosts** is disabled, Power Automate for desktop registers the extension in both HKLM and HKCU hence, and it shouldn't prevent the extension from running.

        If native messaging is explicitly blocked at the system level via the **NativeMessagingBlocklist** policy, make sure that **com.robin.messagehost** or **com.microsoft.pad.messagehost** are added to your **NativeMessagingAllowlist** policy in HKLM.

1. Check if the message host points to the right location:

    1. Close and launch again Power Automate for desktop (Also, close the Power Automate console from the Windows task bar).

    1. Launch the Registry Editor.

    1. Navigate to:

        - For the Microsoft Power Automate (Legacy) browser extension: **Computer\HKEY_CURRENT_USER \SOFTWARE\Google\Chrome\NativeMessagingHosts\com.robin.messagehost**

        - For the Microsoft Power Automate browser extension: **Computer\HKEY_CURRENT_USER \SOFTWARE\Google\Chrome\NativeMessagingHosts\com.microsoft.pad.messagehost**

    1. Check the value of the registry key. The correct value is:

        - MSI: **C:\Program Files (x86)\Power Automate Desktop\PAD.ChromiumManifest.json**
        - MSIX Windows 11: **C:\Program Files\WindowsApps\Microsoft.PowerAutomateDesktop_X.Y.Z.0_x64__8wekyb3d8bbwe\PAD.ChromiumManifest.json**

            You can retrieve **X.Y.Z** with the following steps:

            1. Search for **Power Automate** in Windows search, and right-click on its icon.

            1. Select **App settings**.

            1. Retrieve the value from **Version**. In the following example, the values were X=10, Y=0, and Z=5426.

                :::image type="content" source="media/web-extensions-policies/version-value.png" alt-text="Screenshot of the version value of Power Automate for desktop.":::

        - MSIX Windows 10: **AppData\Local\Packages\Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe\TempState\webextensions\PAD.ChromiumManifest.json**

1. Check if the **ComSpec** variable exists in **Environment variable** under **System variables**. If it doesn't exist, add it and try again:

    1. Search for **Environment variables** in Windows search bar and select **Edit the system environment variables**.

    1. Select **Environment variables**.

    1. The system variables should include the **ComSpec** variable. The expected value for **ComSpec** is **C:\WINDOWS\system32\cmd.exe**.

1. Check Windows Event Viewer for errors:

    1. Search for **Event Viewer** in Windows search and launch **Event Viewer**.

    1. In the tree on the left side, go to **Event Viewer (Local)** > **Windows Logs** > **Application**.

    1. Look for errors related to Power Automate for desktop.

## More details about group policies

There are cases where web automation isn't possible with Power Automate for desktop due to group policies applied in Microsoft Edge and Google Chrome browsers.

You can view the list of the policies applied on your machine by navigating to [edge://policy](edge://policy) in Microsoft Edge or [chrome://policy](chrome://policy) for Google Chrome.

If web automation with Power Automate for desktop isn't possible, you may have set **NativeMessagingBlocklist** to block all native messaging. In this case, you need to exclude Power Automate for desktop native message host (**com.robin.messagehost**) by setting the **NativeMessagingAllowlist** policy.  

By default, Power Automate for desktop registers the extension both in HKLM and HKCU hence, if the **NativeMessagingUserLevelHosts** policy is disabled, and it shouldn't prevent the extension from running.

If native messaging is explicitly blocked at system level via the **NativeMessagingBlocklist** policy, make sure that **com.robin.messagehost** or **com.microsoft.pad.messagehost** are added to your **NativeMessagingAllowlist** policy in HKLM.
