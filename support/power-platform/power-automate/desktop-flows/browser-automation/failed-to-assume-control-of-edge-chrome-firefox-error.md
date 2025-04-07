---
title: Failed to assume control of Edge or Chrome or Firefox error
description: Provides a resolution to the error that occurs when running a desktop flow that has a "Launch browser" action in Power Automate.
ms.reviewer: nimoutzo, jefernn
ms.date: 04/07/2025
ms.custom: sap:Desktop flows\UI or browser automation
---
# "Failed to assume control of Microsoft Edge/Chrome/Firefox" error

This article provides a resolution for the error that may occur when you run a desktop flow that contains a "Launch browser" action in Microsoft Power Automate. If the error occurs right after a browser update and has the same symptoms, see [Browser automation actions stop working after a browser update](browser-automation-error-after-chromium-update.md).

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5001691

## Symptoms

### Scenario 1

When you run a desktop flow that has a [Launch new Microsoft Edge](/power-automate/desktop-flows/actions-reference/webautomation#launch-new-microsoft-edge), [Launch new Chrome](/power-automate/desktop-flows/actions-reference/webautomation#launchchromebase), or [Launch new Firefox](/power-automate/desktop-flows/actions-reference/webautomation#launchfirefoxbase) action in Microsoft Power Automate, the execution fails with one of the following error messages:

- > Failed to assume control of Microsoft Edge (Internal error or communication failure).
- > Failed to assume control of Chrome (Internal error or communication failure).
- > Failed to assume control of Firefox (Internal error or communication failure)

> [!IMPORTANT]
> To resolve the error,
>
> 1. First run the **Troubleshoot UI/Web automation issues** diagnostic using the [Power Automate for desktop troubleshooter](/power-automate/desktop-flows/troubleshooter).  
> 2. When the diagnostic runs, a report is generated that identifies issues. These issues can be resolved by pressing the **Fix** button that appears after the diagnostics check completes.  
> 3. If the troubleshooter doesn't resolve the error, proceed to the potential causes and resolutions provided in this article.

### Scenario 2

The error message also can occur when you run a "Launch browser" action, and the browser is launched using a different system user than the one used to run Power Automate for desktop. For the recommended workaround, see [Cause 3](#cause-3-the-browser-is-launched-using-a-different-system-user-than-the-one-used-to-run-power-automate-for-desktop-version-238-or-higher) in this article.

## Cause 1: Web extension isn't installed properly or enabled

The Microsoft Edge, Google Chrome, or Firefox web extension isn't installed properly or enabled.

### Verifying issue for cause 1

- Execution of a desktop flow with one of the respective actions fails with the error message.
- Web Recorder initiation for the specific browser shows the below message:

  :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/you-need-power-automate-desktop-extension.png" alt-text="Screenshot that shows a message that contains a Get Extension button to install the web extension.":::

- The web extension might seem to be installed and enabled in the extension repository of the specific browser but the execution to be unsuccessful.

### Resolution

1. Install the respective web extension from the Power Automate for desktop designer.

   :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/browser-extensions.png" alt-text="Screenshot that shows how to install the web extension from the list.":::

2. Even if the extension seems installed and enabled, you need to remove it and reinstall it.
3. Restart the browser.

## Cause 2: Launch browser action takes longer than the default timeout

Launch of the browser takes longer than the default timeout (30 seconds) of the action. The automation tries to assume control of the browser before opening and as a result the "Launch browser" action fails.

### Verifying issue for cause 2

Execution of a desktop flow with one of the respective actions fails with the error message. This behavior might not be consistent (some executions could be successful).

### Resolution 1

In the **Launch new Edge**, **Launch new Chrome**, or **Launch new Firefox** action, increase the values of **Timeout on webpage load** and **Timeout** parameters located in the **Advanced** section. For example, set these values to **120** seconds.

If this adjustment doesn't resolve the issue, follow the steps outlined in [Resolution 2](#resolution-2) or [Resolution 3](#resolution-3).

### Resolution 2

Use the Launch Browser action to start the process of the corresponding browser. Then a combination of an additional Launch Browser action with mode set to **Attach to running instance** and a [Go to web page](/power-automate/desktop-flows/actions-reference/webautomation#gotowebpagebase) action afterwards can be used to resolve the issue.

1. Insert a new "Launch new browser" action as:
    - Launch new Edge
    - Launch new Chrome
    - Launch new Firefox
    - Launch new Internet Explorer

2. Set up the parameters of the action:
    - Launch mode: Launch new Instance
    - Initial URL: A default URL
    - Rest parameters can be set as desired.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/parameters-of-launch-new-browser-action.png" alt-text="Screenshot that shows how to set up the parameters of the Launch new browser action.":::

3. Insert an error handling policy by:
    - Select the **On error** option in the action window:

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/insert-error-handling-policy-for-action.png" alt-text="Screenshot that shows how to insert an error handling policy by using the On error option.":::

    - Select **Continue flow run** > **Go to next action** in the dropdown list, and then select **Save**.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/save-settings-on-error.png" alt-text="Screenshot that shows how to select the Continue flow run and Go to next action options and then save the settings.":::

4. Insert a new "Launch new browser" action of the same browser as step 1 and set up the parameters of the action:
    - Launch mode: Attach to running instance
    - Attach to browser tab: By URL
    - Tab URL: The URL inserted in step 1.
    - Variables produced: Replace the new browser variable with the name of the variable produced in step 1.

        :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/replace-variables-produced-browser.png" alt-text="Screenshot that shows how to replace the new browser variable with the name of the variable produced in step 1.":::

5. Select the **On error** option and take the following steps:
    1. Enable the **Retry action if an error occurs** option.

       :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/enable-retry-action-if-an-error-occurs.png" alt-text="Screenshot that shows how to enable the Retry action if an error occurs option.":::

    2. Set the number of times to **20** by selecting the number of times.
    3. Set the interval in seconds to **5** by selecting the number of seconds.
    4. Select **Save**.

6. Insert a **Go to web page** action and set up the parameters of the action:
    - Web browser instance: The variable produced by the "Launch new browser" action.
    - Navigate: To URL
    - URL: The URL you would like to navigate to.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/select-parameters-in-go-to-web-page.png" alt-text="Screenshot that shows how to configure the parameters of the Go to web page action.":::

### Resolution 3

Use the Launch Browser action to start the process of the corresponding browser. Then a combination of an additional Launch Browser action with mode set to **Attach to running instance** and a **Wait** action set to a duration afterwards can be used to resolve the issue.

1. Insert a new "Launch new browser" action as:
    - Launch new Edge
    - Launch new Chrome
    - Launch new Firefox
    - Launch new Internet Explorer

2. Set up the parameters of the action:
    - Launch mode: Launch new Instance
    - Initial URL: A default URL
    - Rest parameters can be set as desired.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/parameters-of-launch-new-browser-action.png" alt-text="Screenshot that shows how to set up the parameters of the Launch new browser action.":::

3. Insert an error handling policy by:
    - Select the **On error** option in the action window:

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/insert-error-handling-policy-for-action.png" alt-text="Screenshot that shows how to insert an error handling policy by using the On error option.":::

    - Select **Continue flow run** > **Go to next action** in the dropdown list, and then select **Save**.

      :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/save-settings-on-error.png" alt-text="Screenshot that shows how to select the Continue flow run and Go to next action options and then save the settings.":::

4. Insert a **Wait** action and set its duration to **90** seconds (adjust duration as needed).

     :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/wait-action.png" alt-text="Screenshot that shows how to insert a Wait action with value set to 90.":::

5. Insert another "Launch new browser" action for the same browser used in step 1, and configure the parameters:
    - Launch mode: Attach to running instance
    - Attach to browser tab: By URL
    - Tab URL: The URL inserted in step 1.
    - Variables produced: Replace the new browser variable with the name of the variable produced in step 1.

        :::image type="content" source="media/failed-to-assume-control-of-edge-chrome-firefox-error/replace-variables-produced-browser.png" alt-text="Screenshot that shows how to replace the new browser variable with the name of the variable produced in step 1.":::

## Cause 3: The browser is launched using a different system user than the one used to run Power Automate for desktop (version 2.38 or higher)

This issue can occur in attended and unattended desktop flow modes.

To resolve the issue, ensure that the browser is launched using the same system user account that's being used to run Power Automate for desktop.

## General checks

If the above actions don't resolve the issue, ensure the following:

- Make sure that the environmental variable `ComSpec` with value `C:\WINDOWS\system32\cmd.exe` exists on the machine.
- (Chrome only) Check and set the `exit_type` parameter to `normal` at _%localappdata%\Google\Chrome\User Data\Default\Preferences_.
- Clear the browser cache and cookies manually, then restart the browser.
