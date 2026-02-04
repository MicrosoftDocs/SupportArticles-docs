---
title: Troubleshoot issues in Power Automate browser extensions
description: Provides a resolution for the Failed to assume control of browser (Internal error or communication failure) error or Get Extension message.
ms.reviewer: nimoutzo, gtrantzas, jspantouris, v-shaywood 
ms.date: 12/01/2025
ms.custom: sap:Desktop flows\UI or browser automation
---
# Troubleshoot issues in Power Automate browser extensions

This article provides tips to troubleshoot and resolve issues related to Power Automate browser extensions when you use web automation in desktop flows.

## Symptoms

You experience the following symptoms:

- At runtime, the browser automation group takes an action that fails and returns the following error message:

  > Failed to assume control of _browser_ (Internal error or communication failure).

   > [!NOTE]  
   > In this message, _browser_ represents the name of the web browser (for example, Microsoft Edge or Google Chrome).

- During the design phase, when you open the UI element picker or the recorder and hover the mouse over a webpage, the following message is displayed:

  > You need the Power Automate extension.

    :::image type="content" source="media/web-extensions-policies/get-extension-message.png" alt-text="Screenshot of the Get Extension message that reminds you to install the Power Automate extension.":::

## Prerequisites

- Make sure that the Power Automate web extension is installed and enabled in your browser.
- Make sure that the correct Power Automate web extension is installed and enabled in your browser. Only one of the following extensions should be installed:

  - For Power Automate for desktop v2.27 or later versions, you need the **Microsoft Power Automate** extension.
  - For Power Automate for desktop v2.26 or earlier versions, you need the **Microsoft Power Automate (Legacy)** extension.

For more information, see [Install Power Automate browser extensions](/power-automate/desktop-flows/install-browser-extensions).

## Resolution

To troubleshoot and resolve the issue, use the steps in the following sections.

### Check whether PAD.BrowserNativeMessageHost.exe is running for your browser

Follow these steps:

1. Close all open browser windows.
1. Open the browser that you use in your desktop flow.
1. Open Windows Task Manager, select the **Details** tab, and then verify that `PAD.BrowserNativeMessageHost.exe` is running.

   > [!NOTE]  
   > One instance of this .exe file runs for each browser type.

1. If PAD.BrowserNativeMessageHost.exe isn't running, follow these steps:

   1. Check whether the Power Automate web extension is installed and enabled. If it isn't installed, see the [Prerequisites](#prerequisites) section.

   1. If the extension is installed, run the **Troubleshoot UI/Web automation issues** diagnostic in [Power Automate for desktop troubleshooter](/power-automate/desktop-flows/troubleshooter).

   1. Follow the steps that are suggested in the troubleshooter.

### Look for errors in the background script

> [!NOTE]
> This step is valid only for Microsoft Edge and Google Chrome.

Follow these steps:

1. Go to the appropriate extension page:

   - Microsoft Edge: `edge://extensions/`
   - Google Chrome: `chrome://extensions/`
1. Enable Developer mode.
1. Find the Microsoft Power Automate extension.
1. Select **background.html** for the Microsoft Power Automate (Legacy) browser extension or **service worker** for the Microsoft Power Automate browser extension. This step opens the developer tools.
1. Check for any errors on the **Console** tab.

   The error message, "Access to the native messaging host was disabled by the system administrator," indicates that the **NativeMessagingBlocklist** policy is enabled for the Power Automate for desktop native messaging host or all native messaging hosts.

### Check for policies that block the message host

Follow these steps:

1. Go to the appropriate extension page:

   - Microsoft Edge: `edge://policy/`
   - Google Chrome: `chrome://policy/`

1. Check the **NativeMessagingBlocklist** policy. If this policy is enabled for all native messaging hosts, add the Power Automate for desktop native messaging host to the **NativeMessagingAllowlist** policy:

    1. Open **Start**, enter _Registry Editor_, and then select **Registry Editor** in the results.

    1. Create the **NativeMessagingAllowlist** policy if it doesn't already exist, and then add the Power Automate for desktop native messaging host.

       For the Microsoft Power Automate (Legacy) browser extension, follow these steps for your preferred browser.

       #### [Microsoft Edge](#tab/microsoft-edge)

       To add a policy at the local machine level:

       ```console
       Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\NativeMessagingAllowlist
       Name = {number}
       Data = com.robin.messagehost
       ```

       To add a policy at the current user level:

       ```console
       Computer\HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge\NativeMessagingAllowlist
       Name = {number}
       Data = com.robin.messagehost
       ```

       #### [Google Chrome](#tab/google-chrome)

       To add a policy at the local machine level:

       ```console
       Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\NativeMessagingAllowlist
       Name = {number}
       Data = com.robin.messagehost
       ```

       To add a policy at the current user level:

       ```console
       Computer\HKEY_CURRENT_USER\SOFTWARE\Policies\Google\Chrome\NativeMessagingAllowlist
       Name = {number}
       Data = com.robin.messagehost
       ```

       #### [Mozilla Firefox](#tab/mozilla-firefox)

       To add a policy at the local machine level:

       ```console
       Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Mozilla\NativeMessagingAllowlist
       Name = {number}
       Data = com.robin.messagehost
       ```

       To add a policy at the current user level:

       ```console
       Computer\HKEY_CURRENT_USER\SOFTWARE\Policies\Mozilla\NativeMessagingAllowlist
       Name = {number}
       Data = com.robin.messagehost
       ```

       ---

       For the Microsoft Power Automate browser extension, follow these steps for your preferred browser.

       #### [Microsoft Edge](#tab/microsoft-edge)

       To add a policy at the local machine level:

       ```console
       Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\NativeMessagingAllowlist
       Name = {number}
       Data = com.microsoft.pad.messagehost
       ```

       To add a policy at the current user level:

       ```console
       Computer\HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge\NativeMessagingAllowlist
       Name = {number}
       Data = com.microsoft.pad.messagehost
       ```

       #### [Google Chrome](#tab/google-chrome)

       To add a policy at the local machine level:

       ```console
       Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\NativeMessagingAllowlist
       Name = {number}
       Data = com.microsoft.pad.messagehost
       ```

       To add a policy at the current user level:

       ```console
       Computer\HKEY_CURRENT_USER\SOFTWARE\Policies\Google\Chrome\NativeMessagingAllowlist
       Name = {number}
       Data = com.microsoft.pad.messagehost
       ```

       #### [Mozilla Firefox](#tab/mozilla-firefox)

       To add a policy at the local machine level:

       ```console
       Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Mozilla\NativeMessagingAllowlist
       Name = {number}
       ```

       To add a policy at the current user level:

       ```console
       Computer\HKEY_CURRENT_USER\SOFTWARE\Policies\Mozilla\NativeMessagingAllowlist
       Name = {number}
       Data = com.microsoft.pad.messagehost
       ```

       ---

    1. Check the [NativeMessagingUserLevelHosts](/deployedge/microsoft-edge-browser-policies/nativemessaginguserlevelhosts) policy. If **NativeMessagingUserLevelHosts** is disabled, enable it or make sure that `com.robin.messagehost` for the legacy browser extension and `com.microsoft.pad.messagehost` for the default browser extension are added to your **NativeMessagingAllowlist** policy in HKLM (Local Machine level).

        > [!NOTE]
        > You must enable **NativeMessagingUserLevelHosts** when using the [Microsoft Store (MSIX) version of Power Automate for desktop](/power-automate/desktop-flows/install#install-power-automate-from-microsoft-store).

### Check whether the message host points to the correct location

Follow these steps:

1. Close and reopen Power Automate for desktop. (Also, close the Power Automate console from the Windows task bar before you reopen it.)
1. Open Registry Editor.
1. Navigate to the following registry subkeys:

   #### [Microsoft Edge](#tab/microsoft-edge)
  
   - For the Microsoft Power Automate (Legacy) browser extension:
   `Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Edge\NativeMessagingHosts\com.robin.messagehost`

   - For the Microsoft Power Automate browser extension:
   `Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Edge\NativeMessagingHosts\com.microsoft.pad.messagehost`

   #### [Google Chrome](#tab/google-chrome)
  
   - For the Microsoft Power Automate (Legacy) browser extension:
      `Computer\HKEY_CURRENT_USER\SOFTWARE\Google\Chrome\NativeMessagingHosts\com.robin.messagehost`
   - For the Microsoft Power Automate browser extension:
      `Computer\HKEY_CURRENT_USER\SOFTWARE\Google\Chrome\NativeMessagingHosts\com.microsoft.pad.messagehost`

   #### [Mozilla Firefox](#tab/mozilla-firefox)
  
   - For the Microsoft Power Automate (Legacy) browser extension:
     `Computer\HKEY_CURRENT_USER\SOFTWARE\Mozilla\NativeMessagingHosts\com.robin.messagehost`
   - For the Microsoft Power Automate browser extension:
     `Computer\HKEY_CURRENT_USER\SOFTWARE\Mozilla\NativeMessagingHosts\com.microsoft.pad.messagehost`

   ---

1. Check the value of the registry key. The correct value is as follows:

   - MSI: `C:\Program Files (x86)\Power Automate Desktop\dotnet\PAD.ChromiumManifest.json`
   - MSIX Windows 11: `C:\Program Files\WindowsApps\Microsoft.PowerAutomateDesktop_X.Y.Z.0_x64__8wekyb3d8bbwe\PAD.ChromiumManifest.json`

     To retrieve `X.Y.Z`:

     1. Select **Start**, search on **Power Automate**, and then right-click its icon.
     1. Select **App settings**.
     1. Retrieve the value from **Version**. In the following example, the values are `X` = `10`, `Y` = `0`, and `Z` = `5396`.

        :::image type="content" source="media/web-extensions-policies/version-value.png" alt-text="Screenshot of the version value of Power Automate for desktop." border="false":::

   - MSIX Windows 10: `AppData\Local\Packages\Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe\TempState\webextensions\PAD.ChromiumManifest.json`

### Check whether cmd.exe execution is disabled

Power Automate for desktop relies on the browser extension to communicate with the native messaging host. If `cmd.exe` execution is blocked by Group Policy, Intune, or registry restrictions, the browser can't launch the native messaging host, and the Power Automate browser extension might fail.

Restoring access to `cmd.exe` ensures that the browser can correctly launch the native messaging host that's required by the Power Automate browser extension.To re-enable `cmd.exe` by using one of the following methods.

#### Re-enable cmd.exe by using Group Policy

1. Press <kbd>Win</kbd>+<kbd>R</kbd>, enter `gpedit.msc`, and then press <kbd>Enter</kbd>.
1. Go to **User Configuration** > **Administrative Templates** > **System**.
1. Open **Prevent access to the command prompt**.
1. Set the policy to **Disabled** or **Not configured**.
1. Select **OK** to save the changes.

#### Re-enable cmd.exe by using Registry Editor

1. Open **Start**, search for and select **Registry Editor**.
1. Go to `HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\System`.
1. Find the `DisableCMD` value, and then do one of the following:
   - Set the value to `0`.
   - Delete the value.

### Check for the ComSpec variable

Check whether the `ComSpec` variable exists in **Environment variable** under **System variables**. If it doesn't exist, add it, and then try again:

1. Select **Start**, search on **Environment variables**, and then select **Edit the system environment variables** in the search results.
1. Select **Environment variables**.

    > [!NOTE]
    > The system variables should include the `ComSpec` variable. The expected value for `ComSpec` is `C:\WINDOWS\system32\cmd.exe`.

### Check if more than one browser profile exists

To check if more than one profile exists, select the profile icon in the browser. A menu displaying the profiles should appear. The profile icon is usually located either on the top or right side of the browser window.

If more than one browser profile exists:

1. Uninstall the Power Automate web extension from each existing browser profile.
1. Close the browser and [install the extension](/power-automate/desktop-flows/install-browser-extensions) only in the browser profile that you use for the automation.

### Check for errors in Windows Event Viewer

Follow these steps:

1. Open **Start**, search on **Event Viewer**, and then select **Event Viewer** in the search results.
1. In the left pane, expand **Event Viewer (Local)** > **Windows Logs** > **Application**.
1. Locate the error entries that are related to Power Automate for desktop.

### Disable other web extensions

Try disabling all other web extensions except the Power Automate extension to see whether the issue persists.

### Disable browser background settings

Some browser settings can interfere with the Power Automate extension. To resolve this issue, disable the following settings in your browser:

1. Open Microsoft Edge or Google Chrome.
1. Go to **Settings** > **System and performance**.
1. Turn off the following settings:
   1. **Continue running background extensions and apps when Microsoft Edge is closed** (or **Continue running background apps when Google Chrome is closed**).
   1. **Startup boost** (Microsoft Edge only).

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
