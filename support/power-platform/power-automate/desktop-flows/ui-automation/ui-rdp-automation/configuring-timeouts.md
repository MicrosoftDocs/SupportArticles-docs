---
title: Configuring timeouts for RDP/Citrix automations
description: This article guides through the procedure needed to configure timeouts for RPD/Citrix automation.
ms.reviewer: amitrou
ms.author: iopanag
author: iopanag
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 03/28/2025
---

# Configuring timeouts for RDP/Citrix automations

There might be cases where interacting with RDP/Citrix applications might timeout and require more time to work. These timeouts can be configured like the rest of Power Automate timeouts like in [Timeout configuration for UI and browser automation](/power-automate/desktop-flows/how-to/ui-automation-change-timeout-cofiguration). Use this guide to configure the following values as needed.

## Issue: Something takes long time and fails afterwards

The webpage/application might not repond fast to Power Automate requests. This issue is probably due to application/webpage misbehavior or bad connection to RDP/Citrix environment. Depending on the application type you can extend the max wait time Power Automate waits for response from the application:

- **Java.Bridge.Client.ReadWriteTimeout**: In case the target application is JAVA based, this timeout additionally increases time waiting for responses. In remote JAVA applications (RDP/Citrix), this timeout needs to be changed on the remote machine.
- **BrowserNativeMessageHost.MessageTimeout** and **WebExtensionsMessageProxy.SendTimeout**: In case web automation is used, this timeout increases the max time that waits for webpages to respond. In remote webpages (RDP/Citrix), this timeout needs to be changed on the remote machine.
- **RDP.Client.CallTimeOut**: When the application/webpage is on a remote machine, either RDP or Citrix. This timeout additionally increases the max time that waits for the remote application/webpage to respond.

If the problem is design oriented (for example, failing to capture an Element from the designer), you also need to configure the following too:

- **AutomationServerEndpoint.DesignTime.CallTimeout**: This increases the time the Power Automate Designer waits for response.

If the problem is in runtime (when running the flow), you also need to configure the following too:

- **AutomationServerEndpoint.Runtime.CallTimeout**: This increases the max time that runtime waits for an action to be performed.