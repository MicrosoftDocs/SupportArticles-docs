---
title: Troubleshoot Azure Monitor Agent installation issues on Windows virtual machines
description: Provides steps to troubleshoot installation issues with Azure Monitor Agent on a Windows virtual machine.
ms.date: 09/18/2024
ms.reviewer: johnsirmon, v-weizhu, neghuman
ms.service: azure-monitor
ms.custom: sap:Windows Extension not installing
---

# Troubleshoot installation issues with Azure Monitor Agent on a Windows virtual machine

This article helps you troubleshoot issues when you fail to install the Azure Monitor Agent (AMA) on an Azure virtual machines (VM) running Windows.

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

> [!NOTE]
> To complete the troubleshooting process, ensure that you are aware of the Resource ID for the VM and have administrative access to its OS.

## Troubleshooting steps

1. [Start the VM if it's not running](#start-vm)
2. [Verify if the VM have a managed identity](#verify-vm-managed-identity)
3. [Verify if the AMA extension exists in the VM configuration](#verify-ama-extension-exists)
4. [Verify if the VM Guest Agent is running](#verify-vm-guest-agent-running)
5. [Verify if the VM Guest Agent downloads the extension binaries](#extension-binaries-downloaded)
6. [Verify if the VM Guest Agent installs and enables the extension](#verify-vm-gust-agent-install-ama)
7. [Verify if the AMA processes are started](#ama-processes-started)

### <a id="start-vm"></a>Step 1: Start the VM if it's not running

1. Sign in to the [Azure portal](https://portal.azure.com).
2. Select the VM where the AMA agent is installed.
3. In the VM **Overview** page, check if the VM **Status** is **Running**.

   :::image type="content" source="media/ama-windows-installation-issues/check-vm-status.png" alt-text="Screenshot that shows the VM status." lightbox="media/ama-windows-installation-issues/check-vm-status.png":::

   If the VM is in the running state, move to [Verify if the VM has a managed identity](#verify-vm-managed-identity). If the VM isn't currently running, start it and wait for it to fully boot and become operational.

### <a id="verify-vm-managed-identity"></a>Step 2: Verify if the VM has a managed identity

1. Sign in to the [Azure portal](https://portal.azure.com).
2. Select the VM where the AMA agent is installed.
3. Under the **Security** blade, and select **Identity** 
4. Check if the "SystemAssigned" or "UserAssigned" identity exists.

   If one or both identities exist, go to [Step 3: Verify if the extension exists in the VM configuration](#verify-ama-extension-exists). If neither is displayed, [enable System managed identity](#enable-system-assigned-identity)  or [assign User managed identity](#assign-user-assigned-identity).

    To determine which identity is appropriate for your environment, see [What are managed identities for Azure resources?](/entra/identity/managed-identities-azure-resources/overview).

#### <a id="enable-system-assigned-identity"></a>Enable system-assigned managed identity on an existing VM

To enable system-assigned managed identity on a VM that was originally provisioned without it, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role assignment. No other Microsoft Entra directory role assignments are required.

1. Sign in to the [Azure portal](https://portal.azure.com/) using an account associated with the Azure subscription that contains the VM.
2. Navigate to the desired Virtual Machine and select **Identity**.
3. Under **System assigned**, **Status**, select **On** and then select **Save**:

    :::image type="content" source="media/ama-windows-installation-issues/turn-on-system-assigned-identity.png" alt-text="Screenshot that shows how to turn on the system managed identity." lightbox="media/ama-windows-installation-issues/turn-on-system-assigned-identity.png" border="true":::

#### <a id="assign-user-assigned-identity"></a>Assign a user-assigned managed identity to an existing VM

To assign a user-assigned identity to a VM, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) and [Managed Identity Operator](/azure/role-based-access-control/built-in-roles#managed-identity-operator) role assignments. No other Microsoft Entra directory role assignments are required.

1. Sign in to the Azure portal using an account associated with the Azure subscription that contains the VM.
2. Navigate to the desired VM and select **Identity**, **User assigned** and then **+Add**.

   :::image type="content" source="media/ama-windows-installation-issues/add-user-assigned-managed-identity.png" alt-text="Screenshot that shows how to add a user-assigned identity." lightbox="media/ama-windows-installation-issues/add-user-assigned-managed-identity.png" border="true":::

3. Select the user-assigned identity you want to add to the VM and then select **Add**.

   :::image type="content" source="media/ama-windows-installation-issues/select-expected-user-identity.png" alt-text="Screenshot that shows a user-assigned identity is already slected." border="true":::

### <a id="verify-ama-extension-exists"></a>Step 3: Verify if the extension exists in the VM configuration

1. Navigate to the [Azure portal](https://portal.azure.com/).

2. Locate your VM:
   1. In the left-hand menu, select **Virtual Machines**.
   2. Find and select the VM you want to check from the list.

3. Check the VM's extensions:
   1. In the VM's left-hand menu, select **Extensions + applications** under the **Settings** section.
   2. Look for the extension with Type `Microsoft.Azure.Monitor.AzureMonitorWindowsAgent`.

      :::image type="content" source="media/ama-windows-installation-issues/verify-ama-extension-exists.png" alt-text="Screenshot that shows the AzureMonitorWindowsAgent extension." lightbox="media/ama-windows-installation-issues/verify-ama-extension-exists.png":::

   3. If the extension exists, go to the step 4.
   4. If the extension doesn't exist, go to the step 5.

4. Verify the extension status:
   1. Check the **Status** column for the `Microsoft.Azure.Monitor.AzureMonitorWindowsAgent` extension.
   2. If the status is "Provisioning Succeeded," skip step 5 and 6 and move to [Verify if the VM Guest Agent is running](#verify-vm-guest-agent-running).

      :::image type="content" source="media/ama-windows-installation-issues/verify-ama-extension-status.png" alt-text="Screenshot that shows the AzureMonitorWindowsAgent extension's status." lightbox="media/ama-windows-installation-issues/verify-ama-extension-status.png":::
   3. If the status isn't "Provisioning Succeeded," proceed to the step 5 and 6.

5. Install the extension:
   - Select the **Add** button.
   - Search for and select `AzureMonitorWindowsAgent`.
   - Follow the prompts to install the extension on the VM.

6. Check the extension and its status again.
   
After the extension is installed, repeat step 3 and 4 to ensure the extension is now present and the status is "Provisioning Succeeded."

### <a id="verify-vm-guest-agent-running"></a>Step 4: Verify if the VM Guest Agent is running

Check the VM Guest Agent's status by using one of the following methods:

- Use the Azure portal.

    1. Navigate to the [Azure portal](https://portal.azure.com/).
    2. Locate your VM:
       1. In the left-hand menu, select **Virtual Machines**.
       2. Find and select the VM you want to check from the list.
    3. Check the VM's extension:
       1. In the VM's left-hand menu, select **Extensions + applications** under the **Settings** section.
       2. Look for the extension with Type `Microsoft.Azure.Monitor.VirtualMachines.GuestHealth.GuestHealthWindowsAgent`.
    4. Verify the status is "Provisioning Succeeded."
  
- Run the `Get-Service WindowsAzureGuestAgent` PowerShell cmdlet and check the `Status` column in the command output:

    :::image type="content" source="media/ama-windows-installation-issues/powershell-command.png" alt-text="Screenshot that shows how to run the 'Get-Service WindowsAzureGuestAgent' cmdlet.":::

If the VM Guest Agent is running, move to [Step 5: Verify if the VM Guest Agent downloads the extension binaries](#extension-binaries-downloaded).

### <a id="extension-binaries-downloaded"></a>Step 5: Verify if the VM Guest Agent downloads the AMA extension binaries

1. Navigate to the [Azure portal](https://portal.azure.com/):

2. Locate your VM:
   1. In the left-hand menu, select **Virtual Machines**.
   2. Find and select the VM you want to check from the list.

3. Check the VM's extensions:
   1. In the VM's left-hand menu, select **Extensions + applications** under the **Settings** section.
   2. Look for the extension with Type `Microsoft.Azure.Monitor.AzureMonitorWindowsAgent`.

4. Check the VM Guest Agent logs:
   1. Open the **Boot Diagnostics** tab under **Support + troubleshooting**.
   2. Select **Serial log** to view the VM's boot and extension logs.
   3. Look for logs related to the `Microsoft.Azure.Monitor.AzureMonitorWindowsAgent` extension.

5. Verify extension binaries.
   
   If the logs indicate that the binaries are downloaded and extracted, move to [Step 6: Verify if the VM Guest Agent installs and enables the extension](#verify-vm-gust-agent-install-ama). If the binaries are missing, the VM Guest Agent doesn't successfully download the extension binary files. In this case, go to step 6.

6. Restart the VM Guest Agent.
   1. Connect to the VM using Remote Desktop Protocol (RDP).
   2. Open a Command Prompt or PowerShell window.
   3. Run the following command:
      ```console
      net stop WindowsAzureGuestAgent
      net start WindowsAzureGuestAgent
      ```

7. Verify extension binaries again.
   
   Repeat the previous step 5 to verify if the binaries have been successfully downloaded and extracted after the restart.

### <a id="verify-vm-gust-agent-install-ama"></a>Step 6: Verify if the VM Guest Agent installs and enables the AMA extension

To ensure that the Azure VM Guest Agent installs and enables the extension correctly, follow these steps:

1. Navigate to the [Azure portal](https://portal.azure.com/).

2. Locate your VM:
   1. In the left-hand menu, select **Virtual Machines**.
   2. Find and select the VM you want to check from the list.

3. Connect to your VM:
   1. Use RDP to connect to your VM.
   2. Enter your VM's IP address, username, and password to sign in.

4. Open the File Explorer and then navigate to the `C:\WindowsAzure\Logs\` directory.

5. Check the VM Guest Agent logs:
   - Open the file *WaAppAgent.log* to view the VM Guest Agent logs.
   - Look for logs related to the extension `Microsoft.Azure.Monitor.AzureMonitorWindowsAgent`.

6. Verify the plugin environment setup:
   
    Check for a log entry indicating the plugin environment is set up:
     
     ```output
     [00000010] YYYY-MM-DDTHH:MM:SS.SSSZ [WARN] Setting up plugin environment (name: Microsoft.Azure.Monitor.AzureMonitorWindowsAgent, version: X.Y.Z.Z)., Code: 0
     ```

7. Verify the plugin installation:
   
    Look for a log entry indicating the plugin installer is run:

     ```output
     [00000010] YYYY-MM-DDTHH:MM:SS.SSSZ [WARN] Installing plugin (name: Microsoft.Azure.Monitor.AzureMonitorWindowsAgent, version: X.Y.Z.Z), Code: 0
     [00000010] YYYY-MM-DDTHH:MM:SS.SSSZ [WARN] Started a process with the launch command C:\Packages\Plugins\Microsoft.Azure.Monitor.AzureMonitorWindowsAgent\X.Y.Z.Z\AzureMonitorAgentExtension.exe, params: install.
     ```

8. Verify plugin installation results:
   
    Check for a log entry indicating the installation results:

     ```output
     [00000010] YYYY-MM-DDTHH:MM:SS.SSSZ [WARN] Installed plugin (name: Microsoft.Azure.Monitor.AzureMonitorWindowsAgent, version: X.Y.Z.Z), Code: 0
     ```

9. Check command execution logs:

   1. Navigate to the directory `C:\WindowsAzure\Logs\Plugins\Microsoft.Azure.Monitor.AzureMonitorWindowsAgent\{version}\`.
   2. Open the files named `CommandExecution*.log` and check for any stdout or stderr messages during the installation and enablement process.

10. Verify the plugin is enabled:
   
    Look for log entries indicating the plugin is enabled:

     ```output
     [00000010] YYYY-MM-DDTHH:MM:SS.SSSZ [WARN] Enabling plugin (handler name: Microsoft.Azure.Monitor.AzureMonitorWindowsAgent, extension name: , version: X.Y.Z.Z)., Code: 0
     [00000010] YYYY-MM-DDTHH:MM:SS.SSSZ [INFO] Command C:\Packages\Plugins\Microsoft.Azure.Monitor.AzureMonitorWindowsAgent\X.Y.Z.Z\AzureMonitorAgentExtension.exe of Microsoft.Azure.Monitor.AzureMonitorWindowsAgent has exited with Exit code: 0
     [00000010] YYYY-MM-DDTHH:MM:SS.SSSZ [WARN] Setting the install state of the handler Microsoft.Azure.Monitor.AzureMonitorWindowsAgent_X.Y.Z.Z to Enabled
     ```

11. Check the extension status:
    1. Navigate to the directory `C:\Packages\Plugins\Microsoft.Azure.Monitor.AzureMonitorWindowsAgent\*\Status\`.
    2. Open the files named `*.status` and verify the extension status is sent to Azure.

12. Identify and resolve issues (if you're encountering):
   
    Identify and resolve issues based on the VM Guest Agent logs and then move to [Step 7: Verify if the AMA processes are started](#ama-processes-started).

    > [!TIP]
    > When you try to resolve the issues, you can refer to Azure official documentations for further assistance.

    If you can't identify or resolve the issues, search for the issues or reach out for assistance in the [Microsoft Q&A forums](/answers/tags/133/azure). Before seeking further help, ensure that you have collected the necessary logs.

### <a id="ama-processes-started"></a>Step 7: Verify if the AMA processes are started

1. Navigate to the [Azure portal](https://portal.azure.com/).

2. Locate your VM:
   1. In the left-hand menu, select **Virtual Machines**.
   2. Select the VM you want to check from the list.

3. Connect to your VM:
   1. Use RDP to connect to your VM.
   2. Enter your VM's IP address, username, and password to sign in.

4. Open Task Manager.
   
    Once signed in, right-click on the taskbar and select **Task Manager**. You can also select <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Esc</kbd> to open Task Manager directly.

5. Check AMA processes:
   
    1. In Task Manager, select the **Processes** tab.
    2. Look for the following processes:
     - `AMAExtHealthMonitor`
     - `MonAgentHost`
     - `MonAgentLauncher`
     - `MonAgentManager`
   
    > [!NOTE]
    > The `MonAgentCore` process isn't included in this list. It's part of the agent configuration, so the installation might succeed without starting this process.

6. Verify if all the AMA processes are running.
   
    If all four processes (`AMAExtHealthMonitor`, `MonAgentHost`, `MonAgentLauncher`, and `MonAgentManager`) are listed and running, the agent processes have successfully started.

## Advanced troubleshooting steps

To troubleshoot more complex installation issues, follow these steps:

1. [Test connectivity to Azure Instance Metadata Service (IMDS)](#tect-imds-connectivity)
2. [Test connectivity to handlers](#tect-handlers-connectivity)
3. [Review network trace](#review-network-trace)

### <a id="tect-imds-connectivity"></a>Step 1: Test connectivity to Azure Instance Metadata Service (IMDS)

1. Connect to your VM using Remote Desktop Connection.
2. Open Command Prompt as an administrator.
3. Test connectivity to IMDS:
    ```console
    curl -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2021-01-01"
    ```

If the connection is successful and there are no IMDS errors in the related logs, move to [Step 2: Test connectivity to handlers](#tect-handlers-connectivity). If the connection fails, review the related logs and attempt to mitigate any issues found.

### <a id="tect-handlers-connectivity"></a>Step 2: Test connectivity to handlers

1. Connect to your VM using Remote Desktop Connection.
2. Open Command Prompt as an administrator.
3. Test connectivity to handlers:

    ```console
    curl -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance/compute/resourceId?api-version=2021-01-01"
    ```

If connectivity is successful and there are no errors in the related logs, move to [Step 3: Review network trace](#review-network-trace). If connectivity fails, review common errors and attempt to mitigate any issues found.

### <a id="review-network-trace"></a>Step 3: Review network trace

1. Use a network tracing tool like Wireshark or Fiddler to capture the network trace.
2. Analyze the trace to identify any issues with connectivity to `global.handler.control.monitor.azure.com`.

If issues can't be mitigated, search for known issues or reach out for assistance in the [Microsoft Q&A forums](/answers/tags/133/azure). Before seeking further help, ensure that you have collected the necessary logs.


[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
