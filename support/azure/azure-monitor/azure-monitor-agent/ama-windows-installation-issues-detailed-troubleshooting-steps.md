---
title: Troubleshoot AMA installation issues on Windows VMs
description: Provides detailed steps to troubleshoot installation issues with Azure Monitor Agent on Windows virtual machines.
ms.date: 10/08/2024
ms.reviewer: johnsirmon, v-weizhu, neghuman
ms.service: azure-monitor
ms.custom: sap:Windows Extension not installing
---
# Troubleshoot Azure Monitor Agent installation issues on Windows VMs

This article provides detailed steps to troubleshoot issues when the Azure Monitor Agent (AMA) installation fails on Azure Windows virtual machines (VMs).

> [!NOTE]
> To complete the troubleshooting process, ensure that you know the resource ID of the VM and have administrative access to its operating system.

## <a id="start-vm"></a>Step 1: Start the VM if it's not running

1. Sign in to the [Azure portal](https://portal.azure.com).
2. Select the VM where the AMA agent is installed.
3. On the VM's **Overview** page, check if the VM **Status** is **Running**.

   :::image type="content" source="media/ama-windows-installation-issues-detailed-troubleshooting-steps/check-vm-status.png" alt-text="Screenshot that shows the VM status." lightbox="media/ama-windows-installation-issues-detailed-troubleshooting-steps/check-vm-status.png":::

   If the VM is running, move to [Step 2: Verify if the VM has a managed identity](#verify-vm-managed-identity).
   
   If the VM isn't running, start it and wait for it to fully boot and become operational.

## <a id="verify-vm-managed-identity"></a>Step 2: Verify if the VM has a managed identity

1. Sign in to the [Azure portal](https://portal.azure.com).
2. Select the VM where the AMA agent is installed.
3. Under the **Security** blade, select **Identity** 
4. Check if the "SystemAssigned" or "UserAssigned" identity exists.

   If one or both identities exist, move to [Step 3: Verify if the extension exists in the VM configuration](#verify-ama-extension-exists).
   
   If neither is displayed, [enable a system-assigned managed identity](#enable-system-assigned-identity)  or [assign a user-assigned managed identity](#assign-user-assigned-identity).

    To determine which identity is appropriate for your environment, see [What are managed identities for Azure resources?](/entra/identity/managed-identities-azure-resources/overview)

### <a id="enable-system-assigned-identity"></a>Enable a system-assigned managed identity on an existing VM

To enable a system-assigned managed identity on a VM that was originally provisioned without it, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role assignment. No other Microsoft Entra directory role assignments are required.

1. Sign in to the [Azure portal](https://portal.azure.com/) using an account associated with the Azure subscription that contains the VM.
2. Navigate to the desired VM and select **Identity**.
3. Under **System assigned** > **Status**, select **On**, and then select **Save**:

    :::image type="content" source="media/ama-windows-installation-issues-detailed-troubleshooting-steps/turn-on-system-assigned-identity.png" alt-text="Screenshot that shows how to turn on the system managed identity." lightbox="media/ama-windows-installation-issues-detailed-troubleshooting-steps/turn-on-system-assigned-identity.png" border="true":::

### <a id="assign-user-assigned-identity"></a>Assign a user-assigned managed identity to an existing VM

To assign a user-assigned managed identity to a VM, your account needs the [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) and [Managed Identity Operator](/azure/role-based-access-control/built-in-roles#managed-identity-operator) role assignments. No other Microsoft Entra directory role assignments are required.

1. Sign in to the [Azure portal](https://portal.azure.com) using an account associated with the Azure subscription that contains the VM.
2. Navigate to the desired VM and select **Identity** > **User assigned** > **+Add**.

   :::image type="content" source="media/ama-windows-installation-issues-detailed-troubleshooting-steps/add-user-assigned-managed-identity.png" alt-text="Screenshot that shows how to add a user-assigned identity." lightbox="media/ama-windows-installation-issues-detailed-troubleshooting-steps/add-user-assigned-managed-identity.png" border="true":::

3. Select the user-assigned identity you want to add to the VM and then select **Add**.

   :::image type="content" source="media/ama-windows-installation-issues-detailed-troubleshooting-steps/select-expected-user-identity.png" alt-text="Screenshot that shows a user-assigned identity is already selected." border="true":::

## <a id="verify-ama-extension-exists"></a>Step 3: Verify if the extension exists in the VM configuration

1. Navigate to the [Azure portal](https://portal.azure.com/).

2. Locate your VM:
   1. In the left-hand menu, select **Virtual Machines**.
   2. Find and select the VM you want to check from the list.

3. Check the VM's extensions:
   1. In the VM's left-hand menu, select **Extensions + applications** under the **Settings** section.
   2. Look for the extension with the type `Microsoft.Azure.Monitor.AzureMonitorWindowsAgent`.

      :::image type="content" source="media/ama-windows-installation-issues-detailed-troubleshooting-steps/verify-ama-extension-exists.png" alt-text="Screenshot that shows the AzureMonitorWindowsAgent extension." lightbox="media/ama-windows-installation-issues-detailed-troubleshooting-steps/verify-ama-extension-exists.png":::

   3. If the extension exists, go to step 4.
   
      If the extension doesn't exist, go to step 5.

4. Verify the extension status:
   1. Check the **Status** column for the `Microsoft.Azure.Monitor.AzureMonitorWindowsAgent` extension.
   2. If the status is "Provisioning Succeeded," skip steps 5 and 6 and move to [Step 4: Verify if the VM Guest Agent is running](#verify-vm-guest-agent-running).

      :::image type="content" source="media/ama-windows-installation-issues-detailed-troubleshooting-steps/verify-ama-extension-status.png" alt-text="Screenshot that shows the AzureMonitorWindowsAgent extension's status." lightbox="media/ama-windows-installation-issues-detailed-troubleshooting-steps/verify-ama-extension-status.png":::
      
      If the status isn't "Provisioning Succeeded," proceed to steps 5 and 6.

5. Install the extension:
   1. Select the **Add** button.
   2. Search for and select `AzureMonitorWindowsAgent`.
   3. Follow the prompts to install the extension on the VM.

6. Check the extension and its status again.
   
After the extension is installed, repeat steps 3 and 4 to ensure the extension is now present and the status is "Provisioning Succeeded."

## <a id="verify-vm-guest-agent-running"></a>Step 4: Verify if the VM Guest Agent is running

Check the status of the VM Guest Agent by using one of the following methods:

- Use the Azure portal.

    1. Navigate to the [Azure portal](https://portal.azure.com/).
    2. Locate your VM:
       1. In the left-hand menu, select **Virtual Machines**.
       2. Find and select the VM you want to check from the list.
    3. Check the VM's extension:
       1. In the VM's left-hand menu, select **Extensions + applications** under the **Settings** section.
       2. Look for the extension with the type `Microsoft.Azure.Monitor.VirtualMachines.GuestHealth.GuestHealthWindowsAgent`.
    4. Verify that the status is "Provisioning Succeeded."
  
- Run the `Get-Service WindowsAzureGuestAgent` PowerShell cmdlet and check the `Status` column in the command output:

    :::image type="content" source="media/ama-windows-installation-issues-detailed-troubleshooting-steps/powershell-command.png" alt-text="Screenshot that shows how to run the 'Get-Service WindowsAzureGuestAgent' cmdlet.":::

If the VM Guest Agent is running, move to [Step 5: Verify if the VM Guest Agent downloads the extension binaries](#extension-binaries-downloaded).

## <a id="extension-binaries-downloaded"></a>Step 5: Verify if the VM Guest Agent downloads the AMA extension binaries

1. Navigate to the [Azure portal](https://portal.azure.com/):

2. Locate your VM:
   1. In the left-hand menu, select **Virtual Machines**.
   2. Find and select the VM you want to check from the list.

3. Check the VM's extensions:
   1. In the VM's left-hand menu, select **Extensions + applications** under the **Settings** section.
   2. Look for the extension with the type `Microsoft.Azure.Monitor.AzureMonitorWindowsAgent`.

4. Check the VM Guest Agent logs:
   1. Under **Support + troubleshooting**, open the **Boot Diagnostics** tab.
   2. Select **Serial log** to view the VM boot and extension logs.
   3. Look for logs related to the `Microsoft.Azure.Monitor.AzureMonitorWindowsAgent` extension.

5. Verify the extension binaries.
   
   If the logs indicate that the binaries are downloaded and extracted, move to [Step 6: Verify if the VM Guest Agent installs and enables the extension](#verify-vm-gust-agent-install-ama).
   
   If the binaries are missing, the VM Guest Agent doesn't successfully download the extension binary files. In this case, go to step 6.

6. Restart the VM Guest Agent.
   1. Connect to the VM using Remote Desktop Protocol (RDP).
   2. Open a Command Prompt or PowerShell window.
   3. Run the following commands:
      
      ```console
      net stop WindowsAzureGuestAgent
      net start WindowsAzureGuestAgent
      ```

7. Verify the extension binaries again.
   
   Repeat the preceding step 5 to verify if the binaries have been successfully downloaded and extracted after the restart.

## <a id="verify-vm-gust-agent-install-ama"></a>Step 6: Verify if the VM Guest Agent has the AMA extension installed and enabled 

To ensure that the Azure VM Guest Agent has installed and enabled the extension correctly, follow these steps:

1. Navigate to the [Azure portal](https://portal.azure.com/).

2. Locate your VM:
   1. In the left-hand menu, select **Virtual Machines**.
   2. Find and select the VM you want to check from the list.

3. Connect to your VM:
   1. Use RDP to connect to your VM.
   2. Enter your VM's IP address, username, and password to sign in.

4. Open File Explorer and navigate to the `C:\WindowsAzure\Logs\` directory.

5. Check the VM Guest Agent logs:
   - Open the *WaAppAgent.log* file to view the VM Guest Agent logs.
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

8. Verify the plugin installation results:
   
    Check for a log entry indicating the installation results:

     ```output
     [00000010] YYYY-MM-DDTHH:MM:SS.SSSZ [WARN] Installed plugin (name: Microsoft.Azure.Monitor.AzureMonitorWindowsAgent, version: X.Y.Z.Z), Code: 0
     ```

9. Check the command execution logs:

   1. Navigate to the directory `C:\WindowsAzure\Logs\Plugins\Microsoft.Azure.Monitor.AzureMonitorWindowsAgent\{version}\`.
   2. Open the files named `CommandExecution*.log` and check for any stdout or stderr messages during the installation and enablement process.

10. Verify that the plugin is enabled:
   
    Look for log entries indicating the plugin is enabled:

     ```output
     [00000010] YYYY-MM-DDTHH:MM:SS.SSSZ [WARN] Enabling plugin (handler name: Microsoft.Azure.Monitor.AzureMonitorWindowsAgent, extension name: , version: X.Y.Z.Z)., Code: 0
     [00000010] YYYY-MM-DDTHH:MM:SS.SSSZ [INFO] Command C:\Packages\Plugins\Microsoft.Azure.Monitor.AzureMonitorWindowsAgent\X.Y.Z.Z\AzureMonitorAgentExtension.exe of Microsoft.Azure.Monitor.AzureMonitorWindowsAgent has exited with Exit code: 0
     [00000010] YYYY-MM-DDTHH:MM:SS.SSSZ [WARN] Setting the install state of the handler Microsoft.Azure.Monitor.AzureMonitorWindowsAgent_X.Y.Z.Z to Enabled
     ```

11. Check the extension status:
    1. Navigate to the directory `C:\Packages\Plugins\Microsoft.Azure.Monitor.AzureMonitorWindowsAgent\*\Status\`.
    2. Open the files named `*.status` and verify that the extension status is sent to Azure.

12. Identify and resolve issues (if you encounter them):
   
    Identify and resolve issues based on the VM Guest Agent logs, and then move to [Step 7: Verify if the AMA processes have started](#ama-processes-started).

    > [!TIP]
    > When you try to resolve the issues, you can refer to the Azure official documentation for further assistance.

    If you can't identify or resolve the issues, search for the issues or ask for assistance in the [Microsoft Q&A forum](/answers/tags/133/azure). Before seeking further help, ensure that you have collected the necessary logs.

## <a id="ama-processes-started"></a>Step 7: Verify if the AMA processes have started

1. Navigate to the [Azure portal](https://portal.azure.com/).

2. Locate your VM:
   1. In the left-hand menu, select **Virtual Machines**.
   2. Select the VM you want to check from the list.

3. Connect to your VM:
   1. Use RDP to connect to your VM.
   2. Enter your VM's IP address, username, and password to sign in.

4. Open Task Manager.
   
    Once signed in, right-click the taskbar and select **Task Manager**. You can also select <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Esc</kbd> to open Task Manager directly.

5. Check the AMA processes:
   
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


## Next steps

> [!div class="nextstepaction"]
> [Advanced troubleshooting steps](ama-windows-installation-issues-advanced-troubleshooting-steps.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
