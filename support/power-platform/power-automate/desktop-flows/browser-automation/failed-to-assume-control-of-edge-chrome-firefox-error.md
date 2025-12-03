---
title: Failed to assume control of Edge or Chrome or Firefox error
description: Provides a solution to the error that occurs when running a desktop flow that has a "Launch browser" action in Power Automate.
ms.reviewer: nimoutzo, jefernn, v-shaywood
ms.date: 04/09/2025
ms.custom: sap:Desktop flows\UI or browser automation
---
# "Failed to assume control of Microsoft Edge/Chrome/Firefox" error

This article provides a solution for the error that might occur when you run a desktop flow that contains a Launch Browser action in Microsoft Power Automate. If the error occurs right after a browser update and has the same symptoms, see [Browser automation actions stop working after a browser update](browser-automation-error-after-chromium-update.md).

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5001691

## Symptoms

### Scenario 1

When you run a desktop flow that has a [Launch new Microsoft Edge](/power-automate/desktop-flows/actions-reference/webautomation#launch-new-microsoft-edge), [Launch new Chrome](/power-automate/desktop-flows/actions-reference/webautomation#launchchromebase), or [Launch new Firefox](/power-automate/desktop-flows/actions-reference/webautomation#launchfirefoxbase) action in Microsoft Power Automate, the execution fails with one of the following error messages:

- > Failed to assume control of Microsoft Edge (Internal error or communication failure).
- > Failed to assume control of Chrome (Internal error or communication failure).
- > Failed to assume control of Firefox (Internal error or communication failure)

> [!IMPORTANT]
> To resolve the error:
>
> 1. Run the **Troubleshoot UI/Web automation issues** diagnostic by using the [Power Automate for desktop troubleshooter](/power-automate/desktop-flows/troubleshooter).  
> 1. When the diagnostic runs, it generates a report that identifies issues. Resolve these issues by pressing the **Fix** button that appears after the diagnostics check completes.  
> 1. If the troubleshooter doesn't resolve the error, proceed to the potential causes and solutions provided in this article.

### Scenario 2

The error also occurs when you run a Launch Browser action, and the browser is launched by using a different system user than the one used to run Power Automate for desktop. For the recommended workaround, see [Cause 3](#cause-3-you-launch-the-browser-by-using-a-different-system-user-than-the-one-you-use-to-run-power-automate-for-desktop-version-238-or-higher) in this article.

## Cause 1: Web extension isn't installed properly or enabled

The Microsoft Edge, Google Chrome, or Firefox web extension isn't installed properly or enabled.

### Additional symptoms

- Execution of a desktop flow with one of the respective actions fails with the error message.
- Web Recorder initiation for the specific browser shows the following message:

  :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/you-need-power-automate-desktop-extension.png" alt-text="Screenshot that shows a message containing a Get Extension button to install the web extension.":::

- The web extension might seem to be installed and enabled in the extension repository of the specific browser, but it fails to execute.

### Solution

1. Install the respective web extension from the Power Automate for desktop designer.

   :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/browser-extensions.png" alt-text="Screenshot that shows how to install the web extension from the list.":::

1. Even if the extension seems installed and enabled, remove it and reinstall it.
1. Restart the browser.

## Cause 2: Launch Browser action takes longer than the default timeout

Launching the browser takes longer than the default timeout (30 seconds) of the action. The automation tries to assume control of the browser before opening it and as a result the Launch Browser action fails.

### Additional symptoms

Execution of a desktop flow with one of the respective actions fails with the error message. This behavior might not be consistent (some executions could be successful).

### Solution 1: Increase timeouts

In the **Launch new Edge**, **Launch new Chrome**, or **Launch new Firefox** action, increase the values of **Timeout on webpage load** and **Timeout** parameters located in the **Advanced** section. For example, set these values to **120** seconds.

If this adjustment doesn't resolve the issue, try the steps outlined in [Solution 2](#solution-2-use-a-go-to-web-page-action) or [Solution 3](#solution-3-use-a-wait-action).

### Solution 2: Use a Go to web page action

Use the **Launch Browser** action to start the process of the corresponding browser. Then use a combination of an additional **Launch Browser** action with mode set to **Attach to running instance** and a [Go to web page](/power-automate/desktop-flows/actions-reference/webautomation#gotowebpagebase) action to resolve the issue.

1. Insert a new **Launch Browser** action as:
    - **Launch new Microsoft Edge**
    - **Launch new Chrome**
    - **Launch new Firefox**
    - **Launch new Internet Explorer**

1. Set up the parameters of the action:
    - Launch mode: **Launch new Instance**
    - Initial URL: A default URL
    - The remaining parameters can be set as desired.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/parameters-of-launch-new-browser-action.png" alt-text="Screenshot that shows how to set up the parameters of the Launch new browser action.":::

1. Insert an error handling policy:
    - Select the **On error** option in the action window:

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/insert-error-handling-policy-for-action.png" alt-text="Screenshot that shows how to insert an error handling policy by using the On error option.":::

    - Select **Continue flow run** > **Go to next action** in the dropdown list, then select **Save**.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/save-settings-on-error.png" alt-text="Screenshot that shows how to select the Continue flow run and Go to next action options and then save the settings.":::

1. Insert a new **Launch Browser** action of the same browser as step 1 and set up the parameters of the action:
    - Launch mode: **Attach to running instance**
    - Attach to browser tab: **By URL**
    - Tab URL: The URL inserted in step 1.
    - Variables produced: Replace the new browser variable with the name of the variable produced in step 1.

        :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/replace-variables-produced-browser.png" alt-text="Screenshot that shows how to replace the new browser variable with the name of the variable produced in step 1.":::

1. Select the **On error** option and take the following steps:
    1. Enable the **Retry action if an error occurs** option.

       :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/enable-retry-action-if-an-error-occurs.png" alt-text="Screenshot that shows how to enable the Retry action if an error occurs option.":::

    1. Set the number of times to **20** by selecting the number of times.
    1. Set the interval in seconds to **5** by selecting the number of seconds.
    1. Select **Save**.

1. Insert a **Go to web page** action and set up the parameters of the action:
    - Web browser instance: The variable produced by the **Launch Browser** action.
    - Navigate: To URL
    - URL: The URL you want to navigate to.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/select-parameters-in-go-to-web-page.png" alt-text="Screenshot that shows how to configure the parameters of the Go to web page action.":::

### Solution 3: Use a Wait action

Use the **Launch Browser** action to start the process of the corresponding browser. Then use a combination of an additional **Launch Browser** action with mode set to **Attach to running instance** and a **Wait** action set to a duration afterwards to resolve the issue.

1. Insert a new **Launch Browser** action as:
    - **Launch new Microsoft Edge**
    - **Launch new Chrome**
    - **Launch new Firefox**
    - **Launch new Internet Explorer**

1. Set up the parameters of the action:
    - Launch mode: **Launch new Instance**
    - Initial URL: A default URL
    - Rest parameters can be set as desired.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/parameters-of-launch-new-browser-action.png" alt-text="Screenshot that shows how to set up the parameters of the Launch new browser action.":::

1. Insert an error handling policy:
    - Select the **On error** option in the action window:

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/insert-error-handling-policy-for-action.png" alt-text="Screenshot that shows how to insert an error handling policy by using the On error option.":::

    - Select **Continue flow run** > **Go to next action** in the dropdown list, then select **Save**.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/save-settings-on-error.png" alt-text="Screenshot that shows how to select the Continue flow run and Go to next action options and then save the settings.":::

1. Insert a **Wait** action and set its duration to **90** seconds (adjust duration as needed).

     :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/wait-action.png" alt-text="Screenshot that shows how to insert a Wait action with value set to 90.":::

1. Insert another **Launch Browser** action for the same browser used in step 1, and configure the parameters:
    - Launch mode: **Attach to running instance**
    - Attach to browser tab: **By URL**
    - Tab URL: The URL inserted in step 1.
    - Variables produced: Replace the new browser variable with the name of the variable produced in step 1.

        :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/replace-variables-produced-browser.png" alt-text="Screenshot that shows how to replace the new browser variable with the name of the variable produced in step 1.":::

## Cause 3: You launch the browser by using a different system user than the one you use to run Power Automate for desktop (version 2.38 or higher)

This issue can occur in attended and unattended desktop flow modes.

To resolve the issue, make sure you launch the browser by using the same system user account that you use to run Power Automate for desktop.

## Cause 4: Browser doesn't open due to profile conflicts

The browser doesn't launch, or it launches once but fails to open in subsequent attempts.

### Additional symptoms

Execution of a desktop flow with a **Launch Browser** action fails, and the browser either doesn't appear or terminates immediately after launch.

### Solution

Another session might be using the same browser profile. When you launch a Chromium-based browser (such as Microsoft Edge or Chrome), the browser checks if another instance is already using the same profile on disk. If another instance is using the same profile, the browser terminates immediately.

This issue can occur when the same user signs in to multiple sessions on the same machine, and each session attempts to open the browser. Only one session can successfully launch the browser; the others terminate on launch.

To work around this issue, manually launch the browser from Power Automate for desktop with a different profile on disk. Use the following example:

```powershell
Folder.GetSpecialFolder SpecialFolder: Folder.SpecialFolder.DesktopDirectory SpecialFolderPath=> SpecialFolderPath  
System.RunApplication.RunApplication ApplicationPath: $'''msedge.exe''' CommandLineArguments: $'''--user-data-dir=\"%SpecialFolderPath%\\<ProfileFolder>\"''' WindowStyle: System.ProcessWindowStyle.Normal
```

This command launches the browser with a unique profile directory, preventing conflicts with other browser instances.

## General checks

If the preceding actions don't resolve the issue, ensure the following checks:

- Make sure that the environmental variable `ComSpec` with value `C:\WINDOWS\system32\cmd.exe` exists on the machine.
- (Chrome only) Check and set the `exit_type` parameter to `normal` at _%localappdata%\Google\Chrome\User Data\Default\Preferences_.
- Clear the browser cache and cookies manually, and then restart the browser.

## WebDriver support

Starting in version 2.62, Power Automate for desktop supports [WebDriver](/power-automate/desktop-flows/actions-reference/webautomation#webdriver-based-browser-automation-preview) as an alternative communication method for browser automation. This approach eliminates the need to install a browser extension to enable web automation in Power Automate for Desktop.
