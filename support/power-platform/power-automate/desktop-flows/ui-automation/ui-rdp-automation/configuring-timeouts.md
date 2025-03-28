---
title: Configuring timeouts for RDP/Citrix automations
description: Guide on how configure certain timeout that affect RDP/Citrix automations on Power Automate.
ms.reviewer: amitrou
ms.author: iopanag
author: iopanag
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 03/28/2025
---

# Configuring timeouts for RDP/Citrix automations

There might be cases where interacting with RDP/Citrix applications might timeout and require additional time to work. These can be configured like the rest of Power Automate timeouts like in [Timeout configuration for UI and browser automation](/power-automate/desktop-flows/how-to/ui-automation-change-timeout-cofiguration). Use this guide to configure the following values as needed.

## Issue: Something takes long time and fails afterwards

The webpage/application may not repond fast to Power Automate requests. This is probably to application/webpage misbehaviour or bad connection to RDP/Citrix environment. Depending the application type you can extend the max wait time Power Automate will wait for response from the application:

- **Java.Bridge.Client.ReadWriteTimeout**: In case the target application is JAVA based, this will additionally increase time waiting for responses. In remote JAVA applications (RDP/Citrix), this is needed to be changed on the remote machine.
- **BrowserNativeMessageHost.MessageTimeout** and **WebExtensionsMessageProxy.SendTimeout**: In case web automation is used, this will increase the max time that will wait for webpage to respond. In remote webpages (RDP/Citrix), this is needed to be changed on the remote machine.
- **RDP.Client.CallTimeOut**: When the application/webpage is on a remote machine, either RDP or Citrix. This will will additionaly increase the max time that will wait for the remote application/webpage to respond.

If the problem is design oriented (e.g. failing to capture an Element from the designer), you will also need to configure the following too:

- **AutomationServerEndpoint.DesignTime.CallTimeout**: This will increase the time the Power Automate Designer will wait for response.

If the problem is in runtime (when running the flow), you will also need to configure the following too:

- **AutomationServerEndpoint.Runtime.CallTimeout**: This will increase the max time that runtime will wait for an action to be performed.