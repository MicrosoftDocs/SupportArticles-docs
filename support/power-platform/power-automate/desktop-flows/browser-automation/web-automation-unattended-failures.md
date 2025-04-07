---
title: Web Automation Fails in Unattended Mode
description: Works around an issue where a web automation action fail in unattended environment during runtime.
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: amitrou
author: amitrou
ms.date: 04/07/2025
---
# Web automation action fails in unattended mode

This article provides workarounds for resolving issues where a web automation action fails when executed in unattended mode.

## Symptoms

In attended mode, web automation actions under the Browser Automation group execute successfully. However, in unattended mode, these actions fail.

### Scenario 1: The Launch new Microsoft Edge, Launch new Chrome, or Launch new Firefox action fails

The [Launch new Microsoft Edge](/power-automate/desktop-flows/actions-reference/webautomation#launch-new-microsoft-edge), [Launch new Chrome](/power-automate/desktop-flows/actions-reference/webautomation#launchchromebase), or [Launch new Firefox](/power-automate/desktop-flows/actions-reference/webautomation#launchfirefoxbase) action fails with the following error:

> Failed to assume control of Microsoft Edge/ Chrome / Firefox (communication with Power Automate web extension failed)

This error might occur due to the following reasons:

#### The browser doesn't start and the browser window isn't visible

To work around this issue, make sure that the browser start isn't blocked in unattended mode. Verify by using the actions listed and make sure that browser opens and the window is visible. To create the corresponding action, copy the following command and paste it in the [flow designer](/power-automate/desktop-flows/flow-designer).

For Chrome:

```ps
System.RunApplication.RunApplication ApplicationPath: $'''chrome''' CommandLineArguments: $'''<https://www.microsoft.com/>''' WindowStyle: System.ProcessWindowStyle.Normal ProcessId=> AppProcessId
```

For Microsoft Edge:

```ps
System.RunApplication.RunApplication ApplicationPath: $'''msedge''' CommandLineArguments: $'''<https://www.microsoft.com/>''' WindowStyle: System.ProcessWindowStyle.Normal ProcessId=> AppProcessId
```

If the browser opens and the window is visible, use the "attach" mode of the Launch Browser action:

```ps
WebAutomation.LaunchEdge.AttachToEdgeByUrl TabUrl: $'''https://www.microsoft.com/''' AttachTimeout: 5 TargetDesktop: $'''{\"DisplayName\":\"Local computer\",\"Route\":{\"ServerType\":\"Local\",\"ServerAddress\":\"\"},\"DesktopType\":\"local\"}''' BrowserInstance=> Browser
```

#### The web page takes too long to load in the browser

To work around this issue:

1. In the **Launch new Microsoft Edge**, **Launch new Chrome**, or **Launch new Firefox** action, increase the default values of the following parameters located in the **Advanced** section:

    - **Timeout on webpage load** (for example, set to **120** seconds)
    - **Timeout** (for example, set to **120** seconds)

1. If increasing the timeout doesn't resolve the issue, use the following actions to obtain a browser instance:

    ```ps
    System.RunApplication.RunApplication ApplicationPath: $'''msedge''' CommandLineArguments: $'''<https://www.microsoft.com/>''' WindowStyle: System.ProcessWindowStyle.Normal ProcessId=> AppProcessId
    WAIT 120
    WebAutomation.LaunchEdge.AttachToEdgeByUrl TabUrl: $'''https://www.microsoft.com/''' AttachTimeout: 30 TargetDesktop: $'''{\"DisplayName\":\"Local computer\",\"Route\":{\"ServerType\":\"Local\",\"ServerAddress\":\"\"},\"DesktopType\":\"local\"}''' BrowserInstance=> Browser
    ```

#### The cloud flow is executed with a different user than the one with the browser extension installed

To work around this issue, ensure that the user running the cloud flow in unattended mode has the browser extension installed.

To check the browser extension installation, you can go through the **Tools** > **Browser extensions** options in the [flow designer](/power-automate/desktop-flows/flow-designer). For more information, see [Install Power Automate browser extensions](/power-automate/desktop-flows/install-browser-extensions#install-browser-extensions).

#### The machine's CPU usage reaches 100%, preventing the service worker of the web extension from starting

To work around this issue, provide more CPU resources to the machine where the flow is executed. For more information, see [Prerequisites](/power-automate/desktop-flows/requirements#prerequisites).

### Scenario 2: Other web automation actions fail with the "Element not found" error

The following web automation actions might fail with the "Element not found" error:

- [Click link on web page](/power-automate/desktop-flows/actions-reference/webautomation#clickbase)
- [Populate text field on web page](/power-automate/desktop-flows/actions-reference/webautomation#populatetextfieldbase)
- [Press button on web page](/power-automate/desktop-flows/actions-reference/webautomation#pressbuttonbase)
- Any web action involving interaction with a web element.

#### Cause

Web automation actions might fail due to screen resolution discrepancies. In unattended mode, the screen resolution might differ from the one used in attended mode, causing web elements or the UI to render differently (for example, responsive layouts.)

#### Workaround

To work around this issue, follow the steps in the documentation [Set screen resolution on unattended mode](/power-automate/desktop-flows/how-to/set-screen-resolution-unattended-mode). This documentation provides the necessary configuration and registry key setup to ensure consistent screen resolution during unattended executions.
