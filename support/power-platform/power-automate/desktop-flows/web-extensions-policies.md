---
title: Troubleshoot issues with Power Automate browser extensions
description: Provides a resolution for the Failed to assume control of browser (Internal error or communication failure) error or Get Extension message.
ms.reviewer: nimoutzo, gtrantzas
ms.date: 11/29/2023
ms.subservice: power-automate-desktop-flows
---

# Troubleshoot issues with Power Automate browser extensions

This article provides a resolution to the issues related to Power Automate browser extensions.

## Prerequisites

- Ensure that the Power Automate web extension is installed and enabled in your browser.
- Ensure that the correct Power Automate web extension is installed and enabled in your browser. Only one of them should be installed:

  - For Power Automate for desktop v2.27 or later versions, you need the **Microsoft Power Automate** extension.
  - For Power Automate for desktop v2.26 or previous versions, you need the **Microsoft Power Automate (Legacy)** extension.

## Symptoms

- An action of browser automation group fails at runtime with error "Failed to assume control of _browser_ (Internal error or communication failure)", where _browser_ is replaced with the name of the browser, for example Microsoft Edge or Google Chrome.
- During design time, when opening the UI element picker or the recorder and hovering the mouse over a webpage, the following message is displayed:

    :::image type="content" source="media/web-extensions-policies/get-extension-message.png" alt-text="Screenshot of the Get Extension message that reminds you to install the Power Automate extension.":::

## Resolution

1. Check if `PAD.BrowserNativeMessageHost.exe` is running for your browser:

    1. Close all open browser windows.
    1. Open the browser you use in your desktop flow.
    1. Open the Windows Task Manager, go to the **Details** tab, and look for `PAD.BrowserNativeMessageHost.exe`.

    > [!NOTE]
    > One instance of this `.exe` file runs for each browser type.

1. Look for errors in the background script. This step is valid only for Microsoft Edge and Google Chrome.

    1. Go to the appropriate extension page:

        - Microsoft Edge: `edge://extensions/`
        - Google Chrome: `chrome://extensions/`

    1. Enable the developer mode.
    1. Find the Microsoft Power Automate extension.
    1. Select **background.html** for the Microsoft Power Automate (Legacy) browser extension or **service worker** for the Microsoft Power Automate browser extension. This step will open the developer tools.

    1. Check for any errors in the **Console** tab.

        The error "Access to the native messaging host was disabled by the system administrator" indicates that the policy **NativeMessagingBlocklist** is enabled for the Power Automate for desktop native messaging host or all native messaging hosts.

1. Check for policies blocking the message host:

    1. Go to the appropriate extension page:

        - Microsoft Edge: `edge://policy/`
        - Google Chrome: `chrome://policy/`

    1. Check for **NativeMessagingBlocklist**. If this policy is enabled for all native messaging hosts, then add the Power Automate for desktop native messaging host to the **NativeMessagingAllowlist** policy:

        1. Type _Registry Editor_ in Windows search box to open the Registry Editor.

        1. For the Microsoft Power Automate (Legacy) browser extension, create the **NativeMessagingAllowlist** policy if it doesn't already exist, and add the Power Automate for desktop native messaging host.

            - Microsoft Edge:

              For adding policy in Local Machine level:

              ```console
              Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\NativeMessagingAllowlist
              Name = {number}
              Data = com.robin.messagehost
              ```

              For adding policy in Current User level:

              ```console
              Computer\HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge\NativeMessagingAllowlist
              Name = {number}
              Data = com.robin.messagehost
              ```

            - Google Chrome:

              For adding policy in Local Machine level:

              ```console
              Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\NativeMessagingAllowlist
              Name = {number}
              Data = com.robin.messagehost
              ```

              For adding policy in Current User level:

              ```console
              Computer\HKEY_CURRENT_USER\SOFTWARE\Policies\Google\Chrome\NativeMessagingAllowlist
              Name = {number}
              Data = com.robin.messagehost
              ```

            - Mozilla Firefox:

              For adding policy in Local Machine level:

              ```console
              Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Mozilla\NativeMessagingAllowlist
              Name = {number}
              Data = com.robin.messagehost
              ```

              For adding policy in Current User level:

              ```console
              Computer\HKEY_CURRENT_USER\SOFTWARE\Policies\Mozilla\NativeMessagingAllowlist
              Name = {number}
              Data = com.robin.messagehost
              ```

        1. For the Microsoft Power Automate browser extension, create the **NativeMessagingAllowlist** policy if it doesn't already exist, and add the Power Automate for desktop native messaging host with the following entries:

           - Microsoft Edge:

             For adding policy in Local Machine level:

             ```console
             Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\NativeMessagingAllowlist
             Name = {number}
             Data = com.microsoft.pad.messagehost
             ```

             For adding policy in Current User level:

             ```console
             Computer\HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge\NativeMessagingAllowlist
             Name = {number}
             Data = com.microsoft.pad.messagehost
             ```

           - Google Chrome:

             For adding policy in Local Machine level:

             ```console
             Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\NativeMessagingAllowlist
             Name = {number}
             Data = com.microsoft.pad.messagehost
             ```

             For adding policy in Current User level:

             ```console
             Computer\HKEY_CURRENT_USER\SOFTWARE\Policies\Google\Chrome\NativeMessagingAllowlist
             Name = {number}
             Data = com.microsoft.pad.messagehost
             ```

           - Mozilla Firefox:

             For adding policy in Local Machine level:

             ```console
             Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Mozilla\NativeMessagingAllowlist
             Name = {number}
             ```

             For adding policy in Current User level:

             ```console
             Computer\HKEY_CURRENT_USER\SOFTWARE\Policies\Mozilla\NativeMessagingAllowlist
             Name = {number}
             Data = com.microsoft.pad.messagehost
             ```

        1. Check for **NativeMessagingUserLevelHosts** policies.

           If **NativeMessagingUserLevelHosts** is enabled, disable it or ensure that `com.robin.messagehost` for legacy and `com.microsoft.pad.messagehost` for default browser extension are added to your **NativeMessagingAllowlist** policy in HKLM (Local Machine level).

1. Check if the message host points to the right location:

    1. Close and open again Power Automate for desktop (Also, close the Power Automate console from the Windows task bar before opening it again).

    1. Open the Registry Editor.
    1. Navigate to:

       - Microsoft Edge:
  
         - For the Microsoft Power Automate (Legacy) browser extension:

            `Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Edge\NativeMessagingHosts\com.robin.messagehost`

         - For the Microsoft Power Automate browser extension:

            `Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Edge\NativeMessagingHosts\com.microsoft.pad.messagehost`

       - Google Chrome:
  
         - For the Microsoft Power Automate (Legacy) browser extension:

            `Computer\HKEY_CURRENT_USER\SOFTWARE\Google\Chrome\NativeMessagingHosts\com.robin.messagehost`

         - For the Microsoft Power Automate browser extension:

            `Computer\HKEY_CURRENT_USER\SOFTWARE\Google\Chrome\NativeMessagingHosts\com.microsoft.pad.messagehost`

       - Mozilla Firefox:
  
         - For the Microsoft Power Automate (Legacy) browser extension:

            `Computer\HKEY_CURRENT_USER\SOFTWARE\Mozilla\NativeMessagingHosts\com.robin.messagehost`

         - For the Microsoft Power Automate browser extension:

            `Computer\HKEY_CURRENT_USER\SOFTWARE\Mozilla\NativeMessagingHosts\com.microsoft.pad.messagehost`

    1. Check the value of the registry key. The correct value is:

        - MSI: `C:\Program Files (x86)\Power Automate Desktop\PAD.ChromiumManifest.json`
        - MSIX Windows 11: `C:\Program Files\WindowsApps\Microsoft.PowerAutomateDesktop_X.Y.Z.0_x64__8wekyb3d8bbwe\PAD.ChromiumManifest.json`

          You can retrieve `X.Y.Z` with the following steps:

            1. Search for **Power Automate** in Windows search box, and right-click its icon.
            1. Select **App settings**.
            1. Retrieve the value from **Version**. In the following example, the values were `X` = `10`, `Y` = `0`, and `Z` = `5396`.

                :::image type="content" source="media/web-extensions-policies/version-value.png" alt-text="Screenshot of the version value of Power Automate for desktop." border="false":::

        - MSIX Windows 10: `AppData\Local\Packages\Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe\TempState\webextensions\PAD.ChromiumManifest.json`

1. Check if the `ComSpec` variable exists in **Environment variable** under **System variables**. If it doesn't exist, add it and try again:

    1. Search for **Environment variables** in Windows search box and select **Edit the system environment variables**.
    1. Select **Environment variables**.
    1. The system variables should include the `ComSpec` variable. The expected value for `ComSpec` is `C:\WINDOWS\system32\cmd.exe`.

1. Check for errors in Windows Event Viewer:

    1. Search for **Event Viewer** in Windows search box and open **Event Viewer**.
    1. In the tree on the left side, go to **Event Viewer (Local)** > **Windows Logs** > **Application**.
    1. Look for the errors related to Power Automate for desktop.
  
1.  Try disabling all other web extensions except the Power Automate extension and see if the problem persists.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
