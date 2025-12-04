---
title: Failed to assume control of Edge or Chrome or Firefox error
description: Provides a solution to the error that occurs when running a desktop flow that has a "Launch browser" action in Power Automate.
ms.reviewer: nimoutzo, jefernn, v-shaywood
ms.date: 04/09/2025
ms.custom: sap:Desktop flows\UI or browser automation
---
# "Failed to assume control of Microsoft Edge/Chrome/Firefox" error

This article resolves an error that might occur when you run a desktop flow that contains a Launch Browser action in Microsoft Power Automate. If the error occurs immediately after a browser update, see [Browser automation actions stop working after a browser update](./browser-automation-error-after-chromium-update.md) to determine whether you're experiencing those symptoms.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5001691

## Symptoms

### Scenario 1

When you run a desktop flow that has a [Launch new Microsoft Edge](/power-automate/desktop-flows/actions-reference/webautomation#launch-new-microsoft-edge), [Launch new Chrome](/power-automate/desktop-flows/actions-reference/webautomation#launchchromebase), or [Launch new Firefox](/power-automate/desktop-flows/actions-reference/webautomation#launchfirefoxbase) action in Microsoft Power Automate, the attempt fails. Additionally and the program returns one of the following error messages:

- > Failed to assume control of Microsoft Edge (Internal error or communication failure).
- > Failed to assume control of Chrome (Internal error or communication failure).
- > Failed to assume control of Firefox (Internal error or communication failure).

> [!IMPORTANT]
> To resolve the error, run the **Troubleshoot UI/Web automation issues** diagnostic by using the [Power Automate for desktop troubleshooter](/power-automate/desktop-flows/troubleshooter). When the diagnostic runs, it generates a report that identifies issues. Resolve these issues by pressing the **Fix** button that appears after the diagnostics check finishes. If the troubleshooter doesn't resolve the error, refer to the potential causes and solutions that are provided in this article.

### Scenario 2

The error occurs when you run a Launch Browser action, and the browser is started by using a different system user than the one that was used to run Power Automate for desktop. For the recommended workaround, see [Cause 3](#cause-3-you-launch-the-browser-by-using-a-different-system-user-than-the-one-you-use-to-run-power-automate-for-desktop-version-238-or-higher) in this article.

## Cause 1: Web extension isn't installed correctly or enabled

The Microsoft Edge, Google Chrome, or Firefox web extension isn't installed correctly or enabled.

### Additional symptoms

- Running a desktop flow by using one of the respective actions fails and returns an error message.
- Web Recorder initiation for the specific browser shows the following message.

  > 1. To use web automation in your flows, select 'Get Extension' to download and install to the selected browser.  
  > 2. After installing, be sure to enable the extension in the browser.

  :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/you-need-power-automate-desktop-extension.png" alt-text="Error message that contains a Get Extension button to install the web extension.":::

- The web extension might seem to be installed and enabled in the extension repository of the specific browser, but it doesn't run.

### Solution

1. Install the respective web extension from the Power Automate for desktop designer.

   :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/browser-extensions.png" alt-text="Illustration of how to install the web extension from the list.":::

1. Even if the extension seems to be installed and enabled, remove and reinstall it.
1. Restart the browser.

## Cause 2: Launch Browser action takes longer than the default timeout

Starting the browser takes longer than the Launch Browser action's default timeout (30 seconds). The automation process tries to assume control of the browser before it starts it. This attempt causes the Launch Browser action fails.

### Additional symptoms

Running a desktop flow by using one of the respective actions might fail and return one of the error messages that's listed in "Scenario 1." This behavior is inconsistent.

### Solution 1: Increase timeouts

In the **Launch new Edge**, **Launch new Chrome**, or **Launch new Firefox** action, increase the values of the **Timeout on webpage load** and **Timeout** parameters that are located in the **Advanced** section. For example, set these values to **120** seconds.

If this adjustment doesn't resolve the issue, try the steps in [Solution 2](#solution-2-use-a-go-to-web-page-action) or [Solution 3](#solution-3-use-a-wait-action).

### Solution 2: Use a Go to web page action

Use the **Launch Browser** action to start the process of the corresponding browser. Then, use a combination of an additional **Launch Browser** action that has the mode set to **Attach to running instance** and a [Go to web page](/power-automate/desktop-flows/actions-reference/webautomation#gotowebpagebase) action:

1. Insert a new **Launch Browser** action as:
    - **Launch new Microsoft Edge**
    - **Launch new Chrome**
    - **Launch new Firefox**
    - **Launch new Internet Explorer**

1. Set up the parameters of the action:
    - Launch mode: **Launch new Instance**
    - Initial URL: A default URL
    - The remaining parameters can be set as desired.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/parameters-of-launch-new-browser-action.png" alt-text="How to set up the parameters of the Launch new browser action.":::

1. Insert an error handling policy:
    - Select the **On error** option in the action window.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/insert-error-handling-policy-for-action.png" alt-text="How to insert an error handling policy by using the On error option.":::

    - Select **Continue flow run** > **Go to next action**, and then select **Save**.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/save-settings-on-error.png" alt-text="Illustration of how to select the Continue flow run and Go to next action options and then save the settings.":::

1. Insert a new **Launch Browser** action of the same browser as in step 1, and set up the parameters of the action:
    - Launch mode: **Attach to running instance**
    - Attach to browser tab: **By URL**
    - Tab URL: The URL inserted in step 1.
    - Variables produced: Replace the new browser variable with the name of the variable that was produced in step 1.

        :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/replace-variables-produced-browser.png" alt-text="How to replace the new browser variable with the name of the variable produced in step 1.":::

1. Select the **On error** option, and follow these steps:
    1. Enable the **Retry action if an error occurs** option.

       :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/enable-retry-action-if-an-error-occurs.png" alt-text="How to enable the Retry action if an error occurs option.":::

    1. Set the number of times to **20**.
    1. Set the interval in seconds to **5**.
    1. Select **Save**.

1. Insert a **Go to web page** action and set up the parameters of the action:
    - Web browser instance: The variable produced by the **Launch Browser** action.
    - Navigate: **To URL**
    - URL: The target URL.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/select-parameters-in-go-to-web-page.png" alt-text="How to configure the parameters of the Go to web page action.":::

### Solution 3: Use a Wait action

Use the **Launch Browser** action to start the process of the corresponding browser. Then, use a combination of an additional **Launch Browser** action that has the mode set to **Attach to running instance** and a **Wait** action that's set to a duration of 90 seconds.

1. Insert a new **Launch Browser** action as:
    - **Launch new Microsoft Edge**
    - **Launch new Chrome**
    - **Launch new Firefox**
    - **Launch new Internet Explorer**

1. Set up the parameters of the action:
    - Launch mode: **Launch new Instance**
    - Initial URL: A default URL
    - Rest parameters can be set as desired.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/parameters-of-launch-new-browser-action.png" alt-text="How to set up the parameters of the Launch new browser action.":::

1. Insert an error handling policy:
    - Select the **On error** option in the action window.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/insert-error-handling-policy-for-action.png" alt-text="How to insert an error handling policy by using the On error option.":::

    - Open the **Continue flow run** dropdown list, select **Go to next action**, and then select **Save**.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/save-settings-on-error.png" alt-text="How to select the Continue flow run and Go to next action options and then save the settings.":::

1. Insert a **Wait** action, and set its duration to **90** seconds (adjust duration as appropriate).

     :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/wait-action.png" alt-text="How to insert a Wait action with value set to 90.":::

1. Insert another **Launch Browser** action for the same browser that's used in step 1, and configure the parameters:
    - Launch mode: **Attach to running instance**
    - Attach to browser tab: **By URL**
    - Tab URL: The URL inserted in step 1.
    - Variables produced: Replace the new browser variable with the name of the variable produced in step 1.

        :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/replace-variables-produced-browser.png" alt-text="How to replace the new browser variable with the name of the variable produced in step 1.":::

## Cause 3: You start the browser by using a different system user than the one you use to run Power Automate for desktop (version 2.38 or higher)

This issue can occur in attended and unattended desktop flow modes.

To resolve the issue, make sure you start the browser by using the same system user account that you use to run Power Automate for desktop.

## Cause 4: Browser doesn't start because of profile conflicts

The browser doesn't start, or it starts one time but doesn't start in subsequent attempts.

### Additional symptoms

Running a desktop flow by using a **Launch Browser** action fails, and the browser either doesn't appear or terminates immediately after launch.

### Solution

Another session might be using the same browser profile. When you start a Chromium-based browser (such as Microsoft Edge or Google Chrome), the browser checks whether another instance is already using the same profile on disk. If another instance is using the same profile, the browser terminates immediately.

This issue can occur if the same user signs in to multiple sessions on the same machine, and each session tries to open the browser. Only one session can successfully start the browser. The other attempts terminate on startup.

To work around this issue, manually launch the browser from Power Automate for desktop by using a different profile on disk. Use the following example:

```powershell
Folder.GetSpecialFolder SpecialFolder: Folder.SpecialFolder.DesktopDirectory SpecialFolderPath=> SpecialFolderPath  
System.RunApplication.RunApplication ApplicationPath: $'''msedge.exe''' CommandLineArguments: $'''--user-data-dir=\"%SpecialFolderPath%\\<ProfileFolder>\"''' WindowStyle: System.ProcessWindowStyle.Normal
```

This command starts the browser by using a unique profile directory to prevent conflicts with other browser instances.

## General checks

If the preceding actions don't resolve the issue, check the following items:

- Make sure that the environmental variable `ComSpec` that has the value `C:\WINDOWS\system32\cmd.exe` exists on the computer.
- (Chrome only) Check the `exit_type` parameter. If it's necessary, set the variable to `normal` at _%localappdata%\Google\Chrome\User Data\Default\Preferences_.
- Clear the browser cache and cookies manually, and then restart the browser.

## WebDriver support

Starting in version 2.62, Power Automate for desktop supports [WebDriver](/power-automate/desktop-flows/actions-reference/webautomation#webdriver-based-browser-automation-preview) as an alternative communication method for browser automation. This change eliminates the need to install a browser extension to enable web automation in Power Automate for Desktop.
