---
title: Prepare troubleshooting for Azure Monitor Agent installation issues on Windows virtual machines
description: Describes how to prepare troubleshooting for Azure Monitor Agent installation issues on Windows virtual machines.
ms.date: 09/20/2024
ms.reviewer: johnsirmon, v-weizhu, neghuman
ms.service: azure-monitor
ms.custom: sap:Windows Extension not installing
---
# Prepare troubleshooting for Azure Monitor Agent installation issues on Windows virtual machines

This article provides guidance on how to prepare for troubleshooting when the installation of the Azure Monitor Agent (AMA) fails on Azure Windows virtual machines (VMs).

## Before troubleshooting

Before you begin troubleshooting, perform the following checks:

- [Ensure the operating system (OS) is supported by AMA](#operating-system-supported)
- [Determine the issue type: Installation or configuration](#determine-issue-type)
- [Verify at least one Data Collection Rule (DCR) is associated with the VM](#verify-dcr)
- [Understand installation options](#installation-options)

### <a id="operating-system-supported"></a>Ensure the operating system (OS) is supported by AMA

To confirm the OS on your VM is supported by the AMA, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com).
2. Navigate to the **Virtual Machines** section.
3. Select the Virtual Machine (VM) where the AMA agent is installed.
4. In the VM's **Overview** page, check the **Operating system** value to see if it's one of the Windows OS in the [supported operating systems list](/azure/azure-monitor/agents/azure-monitor-agent-supported-operating-systems#windows-operating-systems).

### <a id="determine-issue-type"></a>Determine the issue type: Installation or configuration

1. Verify if the *AzureMonitorWindowsAgent* extension status isn't "Provisioning Succeeded."

    1. In the Azure portal, go to the **Virtual Machines** section.
    2. Select the VM where the AMA is installed.
    3. Verify the VM is powered on and running.
    4. Under **Settings**, select **Extensions + applications**.
    5. Check that the `Microsoft.Azure.Monitor.AzureMonitorWindowsAgent` extension status **isn't** displaying "Provisioning Succeeded."

2. Check if one or more of the agent processes have failed to start.

    1. Connect to your VM using Remote Desktop Connection.
    2. Open **Task Manager** by selecting <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Esc</kbd>.
    3. Select the **Processes** tab.
    4. Check that one or more of the following processes aren't running:
       - `AMAExtHealthMonitor`
       - `MonAgentHost`
       - `MonAgentLauncher`
       - `MonAgentManager`

If the `Microsoft.Azure.Monitor.AzureMonitorWindowsAgent` extension status doesn't show "Provisioning Succeeded" or any of the four agent processes aren't running, you're encountering AMA installation issues. In this case, you can troubleshoot the issues by using this article. Otherwise, you need to investigate the AMA Windows configuration.

### <a id="verify-dcr"></a>Verify at least one Data Collection Rule (DCR) is associated with the VM

Adding VMs as DCR resources is a common way to install the AMA. When you create a DCR in the Azure portal, Azure Monitor Agent is installed on any machines that are added as resources for the DCR. Before you begin troubleshooting, verify that at least one DCR is associated with the VM:

1. Sign in to the [Azure portal](https://portal.azure.com).
2. Navigate to **Azure Monitor**.
3. Select **Data Collection Rules**.
4. Verify there is at least one DCR associated with the VM.
5. If no DCR is associated to the VM, create a new DCR:
   1. Select **Create**.
   2. Follow the wizard to define the data sources and destinations.
   3. Associate the DCR with the VM by selecting the **Resource** tab and selecting the VM.

### <a id="installation-options"></a>Understand installation options

Before troubleshooting, understand the different ways to install the AMA for Windows. It's useful to know how the AMA is installed. The installation options include: VM extension, Create DCR, VM insights, Container insights, Client installer, and Azure Policy. For more information, see [Install and manage Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-manage#installation-options).

## Next steps

> [!div class="nextstepaction"]
> [Detailed troubleshooting steps](ama-windows-installation-issues-detailed-troubleshooting-steps.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]