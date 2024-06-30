# Step 7: Remove Microsoft Monitoring Agent and clean up configurations

If you want to uninstall Microsoft Monitoring Agent from multiple devices in your environment, you can use the Microsoft Monitoring Agent discovery and removal utility. This utility is a PowerShell script that helps you find and remove Microsoft Monitoring Agent instances that are connected to a specific Azure Monitor workspace. You can also use this utility to check the health status of the agents and the connectivity to the workspace.

## Prerequisites

- An Azure subscription that has permissions to access the Azure Monitor workspace.

- A Windows device on which PowerShell version 5.1 (or a more recent version) and the [Az PowerShell module](/powershell/azure/new-azureps-module-az) are installed.

- Network connectivity to the devices on which Microsoft Monitoring Agent is installed.

## Use the Microsoft Monitoring Agent discovery and removal utility

To use the Microsoft Monitoring Agent discovery and removal utility, follow these steps:

1. Download the Microsoft Monitoring Agent discovery and removal utility script from GitHub, and save it to a local folder.

1. Open a PowerShell session as an administrator, and go to the folder in which you saved the script.

1. Run the script by entering the following command:

   ```powershell
   .\MMAAgentDiscoveryAndRemoval.ps1 -WorkspaceId <workspace-id> -WorkspaceKey <workspace-key> -Action <name-of-action>
   ```

The workspace ID and key are the credentials that Microsoft Monitoring Agent uses to connect to the Azure Monitor workspace. You can find these items in the **Advanced Settings** section of the workspace. The `-Action` parameter specifies whether you want to discover or remove the agents. If you choose discovery, the script scans the network and generates a comma-separated value (*.csv*) file that contains the details of the Microsoft Monitoring Agent instances. If you choose removal, the script uninstalls the agents and removes the workspace configurations from the devices.

After the script completes, you can review the output and the log files for any errors or warnings. You can also verify that the agents are no longer connected to the workspace by checking the **Agents management** section of the workspace.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
