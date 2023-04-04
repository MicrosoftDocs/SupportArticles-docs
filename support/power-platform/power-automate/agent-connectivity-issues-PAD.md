---
title: Error code occurs when running an attended or unattended desktop flow
description: Provides mitigation steps for the error codes that occur when running attended or unattended desktop flows.
ms.reviewer: kenseongtan
ms.topic: troubleshooting
ms.date: 04/04/2023
ms.subservice: power-automate-desktop-flows
---
# Agent related error code occurs when running an attended or unattended desktop flow

This article provides the mitigation steps for the agent related error codes that occur when running attended or unattended desktop flows.

> [!NOTE]
> If the agent related error code that you receive is not listed in the table, contact [Power Automate support](https://powerautomate.microsoft.com/support/).

|Error code|Description|Mitigation steps|
|---|---|---|
|AgentNotReachable|The agent running the desktop flow is not reachable.|</br>- Ensure that there are no other user connecting to the machine while there are automations running.</br>- Verify that the machine has sufficient compute and memory resources.</br>- Check if the machine has restarted during the execution.
|UnresponsiveAgent|The agent running the desktop flow is not responsive.|Verify that the machine has sufficient compute and memory resources.|
|AgentHasNotStarted|Power Automate was able to create a session to run the desktop flow but were not able to start the agent inside the session.|Verify that the machine has sufficient compute and memory resources.|
|GatewayTimeout|This is a general technical error code|Contact [Power Automate support](https://powerautomate.microsoft.com/support/).|
