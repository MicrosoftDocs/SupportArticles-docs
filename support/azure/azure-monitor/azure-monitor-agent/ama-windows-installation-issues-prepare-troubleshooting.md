---
title: Preparation for troubleshooting AMA installation issues on Windows VMs
description: Describes how to prepare before troubleshooting Azure Monitor Agent installation issues on Windows virtual machines.
ms.date: 10/08/2024
ms.reviewer: johnsirmon, v-weizhu, neghuman
ms.service: azure-monitor
ms.custom: sap:Windows Extension not installing
---
# Preparation for troubleshooting Azure Monitor Agent installation issues on Windows VMs

This article describes the preparations you need to make before troubleshooting issues when the Azure Monitor Agent (AMA) installation fails on Azure Windows virtual machines (VMs).

Before you begin troubleshooting, perform the following checks.

## <a id="operating-system-supported"></a>Ensure the operating system is supported by AMA

To confirm the operating system on your VM is supported by AMA, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com).
2. Navigate to the **Virtual Machines** section.
3. Select the VM where the AMA agent is installed.
4. On the VM's **Overview** page, check the **Operating system** value to see if it's one of the Windows operating systems in the [supported operating systems list](/azure/azure-monitor/agents/azure-monitor-agent-supported-operating-systems#windows-operating-systems).

## <a id="determine-issue-type"></a>Determine the issue type: Installation or configuration

1. Verify that the `AzureMonitorWindowsAgent` extension status isn't "Provisioning Succeeded."

    1. In the Azure portal, go to the **Virtual Machines** section.
    2. Select the VM where AMA is installed.
    3. Verify that the VM is powered on and running.
    4. Under **Settings**, select **Extensions + applications**.
    5. Verify that the `Microsoft.Azure.Monitor.AzureMonitorWindowsAgent` extension status doesn't show "Provisioning Succeeded."

2. Check if one or more of the agent processes have failed to start.

    1. Connect to your VM using Remote Desktop Connection.
    2. Select <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Esc</kbd> to open **Task Manager**.
    3. Select the **Processes** tab.
    4. Verify that one or more of the following processes aren't running:
       - `AMAExtHealthMonitor`
       - `MonAgentHost`
       - `MonAgentLauncher`
       - `MonAgentManager`

If the `Microsoft.Azure.Monitor.AzureMonitorWindowsAgent` extension status doesn't show "Provisioning Succeeded," or if any of the four agent processes aren't running, you're encountering AMA installation issues. In this case, you can troubleshoot the issues by using this article. Otherwise, you need to investigate the AMA Windows configuration.

## <a id="verify-dcr"></a>Verify that at least one DCR is associated with the VM

Adding VMs as data collection rule (DCR) resources is a common way to install AMA. When you create a DCR in the Azure portal, Azure Monitor Agent is installed on any machines that are added as resources for the DCR. Before you begin troubleshooting, verify that at least one DCR is associated with the VM:

1. Sign in to the [Azure portal](https://portal.azure.com).
2. Navigate to **Azure Monitor**.
3. Select **Data Collection Rules**.
4. Verify that at least one DCR is associated with the VM.
5. If no DCR is associated with the VM, create a new DCR:
   1. Select **Create**.
   2. Follow the wizard to define the data source and destination.
   3. Associate the DCR with the VM by selecting the **Resource** tab and selecting the VM.

## <a id="installation-options"></a>Understand installation options

Before troubleshooting, understand the different ways to install AMA for Windows. It's useful to know how AMA is installed. The installation options include VM extension, Create a DCR, VM insights, Container insights, Client installer, and Azure Policy. For more information, see [Install and manage Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-manage#installation-options).

## Next steps

> [!div class="nextstepaction"]
> [Detailed troubleshooting steps](ama-windows-installation-issues-detailed-troubleshooting-steps.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
