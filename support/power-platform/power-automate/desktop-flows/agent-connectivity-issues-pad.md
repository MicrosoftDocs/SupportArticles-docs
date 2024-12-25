---
title: Agent-related error codes when running an attended or unattended desktop flow
description: Provides mitigation steps for the agent-related error codes that occur when running attended or unattended desktop flows.
ms.reviewer: kenseongtan, johndund, guco
ms.author: kenseongtan
ms.date: 12/25/2024
ms.custom: sap:Desktop flows
---
# An agent-related error code occurs when running an attended or unattended desktop flow

This article provides the mitigation steps for the agent-related error codes that occur when running attended or unattended desktop flows.

> [!NOTE]
> To solve this issue, we recommend [updating Power Automate for desktop to the latest version](/power-automate/desktop-flows/install#update-power-automate). If the agent-related error code persists after the upgrade, you can try the following mitigation steps to work around the issue. If the agent-related error code that you receive isn't listed in the table, contact [Power Automate support](https://www.microsoft.com/power-platform/products/power-automate/support/).

## Error codes

|Error code|Description|Cause|Mitigation steps|
|---|---|---|---|
|AgentNotReachable|The agent running the desktop flow isn't reachable.|This error code occurs when the Power Automate service running on your machine can no longer communicate with the agent in the user session executing your flow. It's typically caused by suboptimal machine performance, such as high CPU usage, and might temporarily block the communication between the service and the agent. For more information about all the prerequisites and limitations you should consider before installing and using Power Automate on your desktop, see [Prerequisites and limitations](/power-automate/desktop-flows/requirements).|<li> Ensure that no other users connect to the machine while automations run.</li><li> Verify that the machine has sufficient compute and memory resources.</li><li> Check if the machine restarts during the execution. </li><li> If you still have the problem, you can try [increasing the time-out the Power Automate service uses to communicate with the agent](#how-to-increase-the-timeout-the-power-automate-service-uses-to-communicate-with-the-agent). By default, the value is set to 10 seconds.|
|UnresponsiveAgent|The agent running the desktop flow isn't responsive.|This error code occurs when the Power Automate service running on your machine can no longer communicate with the agent in the user session executing your flow. It's typically caused by suboptimal machine performance, such as high CPU usage, and might temporarily block the communication between the service and the agent. For more information about all the prerequisites and limitations you should consider before installing and using Power Automate on your desktop, see [Prerequisites and limitations](/power-automate/desktop-flows/requirements).|<li> Verify that the machine has sufficient compute and memory resources. </li><li> If you still have the problem, you can try [increasing the time-out the Power Automate service uses to communicate with the agent](#how-to-increase-the-time-out-the-power-automate-service-uses-to-communicate-with-the-agent). By default, the value is set to 10 seconds.|
|AgentHasNotStarted|Power Automate can create a session to run the desktop flow but can't start the agent inside the session.||Verify that the machine has sufficient compute and memory resources. For more information about all the prerequisites and limitations you should consider before installing and using Power Automate on your desktop, see [Prerequisites and limitations](/power-automate/desktop-flows/requirements).|
|GatewayTimeout|It's a general technical error code.||Contact [Power Automate support](https://www.microsoft.com/power-platform/products/power-automate/support/).|

## How to increase the time-out the Power Automate service uses to communicate with the agent

To increase the agent time-out in the registry:

1. Press <kbd>Win</kbd>+<kbd>R</kbd> to open the **Run** dialog. Type **regedit** and press <kbd>Enter</kbd> to open the **Registry Editor**.
1. Navigate to the `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Power Automate Desktop\Service` registry.
1. Add a new DWORD (32-bit) and name it **AgentPingTimeoutSeconds**. Select the **Decimal** radio button, double-click the new value, and enter a desired value in the **Value data** field.
1. Restart the Power Automate service. In **Task Manager**, select the **Services** tab, right-click **UIFlowService** in the list, and then select **Restart**.
