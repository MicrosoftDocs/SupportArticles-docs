---
title: Operation Takes a Long Time and Fails During Runtime
description: Solves an issue where interactions with Remote Desktop Protocol (RDP) or Citrix applications take a long time and fail during runtime in Power Automate.
ms.reviewer: amitrou
ms.author: iopanag
author: iopanag
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 04/16/2025
---
# Interactions with RDP or Citrix applications take a long time and fail

This article provides guidance on resolving an issue where operation takes a long time and fails afterwards by adjusting certain time-out configurations.

## Symptoms

When you try to highlight, capture, test a [UI element](/power-automate/desktop-flows/ui-elements), or interact with UI elements during runtime in Power Automate, the operation might take a significant amount of time and ultimately fail. This issue occurs when interacting with Microsoft Remote Desktop Protocol (RDP) or Citrix applications.

## Cause

The default time-out settings in Power Automate might be insufficient. The time-outs might need to be adjusted to accommodate the increased time required for communication between the local and remote environments.

## Resolution

To resolve the issue, modify the following keys as needed. For more information about configuring the values, see [time-out configuration for UI and browser automation](/power-automate/desktop-flows/how-to/ui-automation-change-timeout-cofiguration).

- **Java.Bridge.Client.ReadWriteTimeout**

  - Use this setting if the target application is Java-based.
  - This time-out increases the waiting time for responses from Java applications.
  - For remote Java applications (for example, on RDP or Citrix), configure this time-out on the remote machine.

- **BrowserNativeMessageHost.MessageTimeout** and **WebExtensionsMessageProxy.SendTimeout**
  - Use these settings if web automation is being used.
  - These time-outs increase the maximum waiting time for webpages to respond.
  - For webpages in remote environments (for example, RDP or Citrix), configure these time-outs on the remote machine.

- **RDP.Client.CallTimeOut**
  - Use this setting when interacting with applications or webpages on a remote machine via RDP or Citrix.
  - This time-out increases the maximum waiting time for responses from remote applications or webpages.

## Other time-out settings

Depending on whether the issue occurs during design time or runtime, the following time-out settings might need to be configured:

- For design-time issues (for example, failing to capture an element from the designer), adjust the following setting:

  - **AutomationServerEndpoint.DesignTime.CallTimeout**: This setting increases the time the Power Automate Designer waits for response.

- For runtime issues (for example, failing during the execution of a flow), adjust the following setting:

  - **AutomationServerEndpoint.Runtime.CallTimeout**: This setting increases the maximum waiting time during runtime for an action to be executed.

[!INCLUDE [Third-party disclaimer](../../../../../includes/third-party-disclaimer.md)]
