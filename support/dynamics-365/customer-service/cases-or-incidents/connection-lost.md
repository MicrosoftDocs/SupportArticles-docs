---
title: Connection lost error in Customer Service workspace
description: Resolve the connection lost error when the telephony system loses connection in Dynamics 365 Customer Service workspace.
ms.reviewer: tarunshroff
author: ancolucc
ms.author: ancolucc
ai-usage: ai-assisted
ms.date: 04/10/2026
ms.custom: 
---
# Connection lost error in Customer Service workspace
## Symptom
The following error banner might sometimes be shown on the Customer Service workspace:
```
The connection to the telephony system was lost. We're working on re-establish the connection.
```
## Cause
The error might indicate transient network issues or simply a small delay in contacting our services while the workspace is loading.
However, if the banner persists for more than a few seconds, that is usually an indication that there is a permanent network issue. This is usually due to:
- Firewall on your device or network that prevents contacting our telephony services;
- VPN or other network appliances or configuration that prevents contacting our telephony services.

## Troubleshooting steps
1. Open the network tracer in your browser and look for blocked connections to the following domains:
    - *.skype.com
    - *.microsoft.com
    - *.azure.net
    - *.azure.com
    - *.office.com
    > To learn how to use the network tracer in Microsoft Edge, [read this article](https://learn.microsoft.com/en-us/microsoft-edge/devtools/network/). For the same thing in Chrome, [read this artcicle](https://developer.chrome.com/docs/devtools/network).
2. Review your firewall or network configuration to ensure your device can reach our telephony services. For more detailed information on the firewall configuration requirements, review [Network Recommendations for Azure Communication Services](https://learn.microsoft.com/en-us/azure/communication-services/concepts/voice-video-calling/network-requirements#firewall-configuration).

