---
title: Web automation fails in unattended mode
description: Provides workarounds when web automation actions are failing in unattended environment during runtime.
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: amitrou
author: amitrou
ms.date: 03/18/2025
---
# Web automation fails in unattended mode

This article refers to workarounds when web automation fails in unattended mode.

## Syptoms

Web automation actions are executed successfully in flows on attended mode, but are failing when these are executed in unattended mode.

## Applies to

- MSI
- MSIX

## Actions

Any web automation action under the the Browser Automation group.

## Failing Scenarios

1. **Launch new Microsoft Edge / Chrome / Firefox action fails**.

    The action fails with the following error:
     _**"Failed to assume control of Microsoft Edge/ Chrome / Firefox (communication with Power Automate web extension failed)"**_

    This might be caused due to the following reasons:
     - The browser has not started and the browser window is not visible.
     - The web page is taking too much time to be load in the browser.
     - The flow is executed with a different user than the user that browser extension is installed.
     - The machine CPU has reached 100% usage that prevents the service worker of the web extension to start.

2. **Web automation actions** such as:
     - Click link on web page.
     - Populate text field on web page.
     - Press button on web page

or any web action that involves interaction with a web element are failing with error "Element not found"

## Workarounds

 **Launch new Microsoft Edge / Chrome / Firefox action fails**.

1. The browser has not started and the browser window is not visible.

         Make sure that browser start in not blocked in unattended mode.

         Verify this by using the actions below and make sure that browser opens and the window is visible.

         Chrome: System.RunApplication.RunApplication ApplicationPath: $'''chrome''' CommandLineArguments: $'''https://www.microsoft.com/''' WindowStyle: System.ProcessWindowStyle.Normal ProcessId=> AppProcessId
         Edge: System.RunApplication.RunApplication ApplicationPath: $'''msedge''' CommandLineArguments: $'''https://www.microsoft.com/''' WindowStyle: System.ProcessWindowStyle.Normal ProcessId=> AppProcessId

         If the above actions work then use the Attach mode of the Launch browser action 
         WebAutomation.LaunchEdge.AttachToEdgeByUrl TabUrl: $'''https://www.microsoft.com/''' AttachTimeout: 5 TargetDesktop: $'''{\"DisplayName\":\"Local computer\",\"Route\":{\"ServerType\":\"Local\",\"ServerAddress\":\"\"},\"DesktopType\":\"local\"}''' BrowserInstance=> Browser

2. The web page is taking too much time to be loaded in the browser.
         a) Increase the default values of the following parameters
            - Timeout on webpage load (eg 120)
            - Timeout.(eg 120)
         b) If (a) won't work then use the following actions to get a browser instance
            System.RunApplication.RunApplication ApplicationPath: $'''msedge''' CommandLineArguments: $'''<https://www.microsoft.com/>''' WindowStyle: System.ProcessWindowStyle.Normal ProcessId=> AppProcessId
            WAIT 120
            WebAutomation.LaunchEdge.AttachToEdgeByUrl TabUrl: $'''https://www.microsoft.com/''' AttachTimeout: 30 TargetDesktop: $'''{\"DisplayName\":\"Local computer\",\"Route\":{\"ServerType\":\"Local\",\"ServerAddress\":\"\"},\"DesktopType\":\"local\"}''' BrowserInstance=> Browser

3. The cloud flow is executed with a different user than the user that browser extension is installed.
         
            Verify in the cloud flow that the user that is executing the flow in unattended has the browser extension installed

4. The machine CPU has reached 100% usage that prevents the service worker of the web extension to start.

         Provide additional CPU resources to the machine where the flow is executed.

         Prerequisites: https://learn.microsoft.com/en-us/power-automate/desktop-flows/requirements#prerequisites

**Web automation actions fail with element not found**:

Customers are facing issues with web automation actions due to the fact that they use physical interactions and the resolution of the display is not the same with the resolution they use in attended mode and the web sites being responsive show different elements or different UI altogether.

The following documentation [Set screen resolution on unattended mode - Power Automate | Microsoft Learn](https://learn.microsoft.com/en-us/power-automate/desktop-flows/how-to/set-screen-resolution-unattended-mode) should be used to create the necessary configuration/registry keys for specifying exactly the same resolution for unattended executions.
