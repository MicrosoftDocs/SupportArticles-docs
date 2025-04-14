---
title: Something takes long time and fails afterwards
description: This article guides through the procedure that is needed to resolve an issue when interactions with RDP/Citrix applications take long and fail after some time.
ms.reviewer: amitrou
ms.author: iopanag
author: iopanag
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 03/28/2025
---

# Something takes long time and fails afterwards

When trying to highlight, capture, test an element or interacting with elements on runtime, the operation takes a long time and fails afterwards.

The reson for this is that there might be cases where interacting with RDP/Citrix applications might timeout and require more time to work. These time-outs can be configured like the rest of Power Automate time-outs like in [time-out configuration for UI and browser automation](/power-automate/desktop-flows/how-to/ui-automation-change-timeout-cofiguration). Use this guide to configure the following values as needed.

The specific configrations that need to be changed in this case are the following keys:

- **Java.Bridge.Client.ReadWriteTimeout**: In case the target application is JAVA based, this time-out additionally increases time waiting for responses. In remote JAVA applications (RDP/Citrix), this time-out needs to be changed on the remote machine.
- **BrowserNativeMessageHost.MessageTimeout** and **WebExtensionsMessageProxy.SendTimeout**: In case web automation is used, this time-out increases the max time that waits for webpages to respond. In remote webpages (RDP/Citrix), this time-out needs to be changed on the remote machine.
- **RDP.Client.CallTimeOut**: When the application/webpage is on a remote machine, either RDP or Citrix. This time-out additionally increases the max time that waits for the remote application/webpage to respond.

If the problem is design oriented (for example, failing to capture an Element from the designer), you also need to configure the following too:

- **AutomationServerEndpoint.DesignTime.CallTimeout**: This increases the time the Power Automate Designer waits for response.

If the problem is in runtime (when running the flow), you also need to configure the following too:

- **AutomationServerEndpoint.Runtime.CallTimeout**: This increases the max time that runtime waits for an action to be performed.