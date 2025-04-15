---
title: Operation Takes a Long Time and Fails During Runtime
description: This article guides through the procedure that's needed to resolve an issue when interactions with RDP or Citrix applications take long and fail during runtime in Power Automate.
ms.reviewer: amitrou
ms.author: iopanag
author: iopanag
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 04/15/2025
---
# Operation takes a long time and fails during runtime in Power Automate

his article provides guidance on resolving an issue where operations take a long time during runtime and eventually fail in Power Automate.

## Symptoms

When you try to highlight, capture, test an element, or interact with elements during runtime in Power Automate, you may notice that the operation takes a significant amount of time and ultimately fails.

## Cause

The issue occurs due to default timeout settings in Power Automate that may be insufficient for certain scenarios, such as interacting with Microsoft Remote Desktop Protocol (RDP) or Citrix Virtual Apps. These timeouts may need to be adjusted to accommodate the increased time required for communication between the local and remote environments.

## Resolution

To resolve the issue, modify the following timeout settings as needed. For more information about configuring these values, see [time-out configuration for UI and browser automation](/power-automate/desktop-flows/how-to/ui-automation-change-timeout-cofiguration).

- **Java.Bridge.Client.ReadWriteTimeout**

  - Use this setting if the target application is Java-based.
  - This timeout increases the waiting time for responses from Java applications.
  - For remote Java applications (for example, on RDP or Citrix), configure this timeout on the remote machine.

- **BrowserNativeMessageHost.MessageTimeout** and **WebExtensionsMessageProxy.SendTimeout**
  - Use these settings if web automation is being used.
  - These timeouts increase the maximum waiting time for webpages to respond.
  - For webpages in remote environments (for example, RDP or Citrix), configure these timeouts on the remote machine.

- **RDP.Client.CallTimeOut**
  - Use this setting when interacting with applications or webpages on a remote machine via RDP or Citrix.
  - This timeout increases the maximum waiting time for responses from remote applications or webpages.

## Additional timeout settings

Depending on whether the issue occurs during design time or runtime, additional timeout settings may need to be configured:

- For design-time issues (for example, failing to capture an element from the designer), adjust the following setting:

  - **AutomationServerEndpoint.DesignTime.CallTimeout**: This setting increases the time the Power Automate Designer waits for response.

- For runtime issues (for example, failing during the execution of a flow), adjust the following setting:

  - **AutomationServerEndpoint.Runtime.CallTimeout**: This setting increases the maximum waiting time during runtime for an action to be executed.
