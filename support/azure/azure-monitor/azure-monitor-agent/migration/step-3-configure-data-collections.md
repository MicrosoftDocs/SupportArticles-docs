---
title: Step 3 - Configure data collections for Azure Monitor Agent
description: Learn how to configure data collections for Azure Monitor Agent so that you can migrate from the legacy Log Analytics agent.
ms.date: 07/16/2024
ms.reviewer: neghuman, jeffwo, laurahu, vabruwer, irfanr, jofehse, muniesa, amanan, v-weizhu
ms.service: azure-monitor
ms.custom: sap:Issues migrating to Azure Monitor Agent (AMA)
#Customer intent: As an Azure Monitor user, I want to configure data collections for Azure Monitor Agent so that I can migrate from the legacy Log Analytics agent.
---
# Step 3: Configure data collections

A Data Collection Rule (DCR) represents a modern method for setting up data streams for the Azure Monitor Agent. The Azure Monitor DCR Config Generator is a PowerShell script designed to facilitate the transition from older agents to the Azure Monitor Agent by leveraging existing Log Analytics workspace data to automatically generate and implement DCRs. However, it's important to manually link these rules to the virtual machines (VMs) to initiate data collection.

After using the DCR Config Generator tool on your production workspace, Data Collection Rules (DCRs) will be generated and linked to it. To avoid potential issues with duplicate data and disruptions to your production environment, we suggest creating a new, isolated development or staging workspace after running the generator. This allows you to safely test and validate that data is flowing correctly through the DCRs before deploying them to your production environment.

After validation has passed in this new workspace, you have a few options:

1. **Reconnect the DCRs to the original workspace**: If you do this while the legacy agent is still connected, there's a high likelihood of data duplication until the legacy agent is removed.
1. **Retire the old workspace and collect data in the new one**: This allows you to seamlessly transition to the updated configuration without disrupting your production environment.

Choose the approach that best fits your specific requirements and needs.

## Prerequisites to run DCR Config Generator tool
- PowerShell version 7.1.3 or higher is recommended (minimum version 5.1)  
To determine which version of PowerShell is installed on your machine, copy and run the following command:
```powershell
	$PSVersionTable
```
- Az PowerShell module to pull workspace agent configuration information Az PowerShell module. To install the Az PowerShell module, see [Install Azure PowerShell on Windows](/powershell/azure/install-azps-windows)
- Read/Write access to the specified workspace resource

## DCR Config Generator Tool

To use the DCR Config Generator, follow these steps:

1. Download the [latest version of the DCR Config Generator tool PowerShell script](https://github.com/microsoft/AzureMonitorCommunity/tree/master/Azure%20Services/Azure%20Monitor/Agents/Migration%20Tools/DCR%20Config%20Generator) from GitHub.

<!-- Add image displaying to the customer what to select next - image 1 in email -->
<!-- Add image displaying to the customer where the download button is on github - image 2 in email -->

1. After you download the file, please create a ‘migration’ folder on your C drive and move the file there.

1. Run the tool and specify the required parameters, such as the following items:

   - Subscription ID
   - Resource group name
   - Workspace Name
   - DCR Name
   
   The tool connects to your Log Analytics workspace and retrieves the configuration of the legacy agents. Then, it generates one or more data collection rules in JSON format and stores the rules in a local folder.

1. Review the generated rules. Make any necessary adjustments, such as the following changes:

   - Adding custom logs or metrics
   - Modifying the filters
   - Changing the retention period

1. Deploy the rules to your Azure Monitor workspace by using the Azure CLI or Azure portal.

1. Associate the rules with your VMs that are running Azure Monitor Agent by using the built-in association policies.

## Next steps

> [!div class="nextstepaction"]
> [Step 4: Test data collections in Azure Monitor Agent](step-4-test-data-collections-azure-monitor-agent.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
