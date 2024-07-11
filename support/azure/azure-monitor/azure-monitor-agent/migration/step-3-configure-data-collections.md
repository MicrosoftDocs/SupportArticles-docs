---
title: Step 3 - Configure data collections for Azure Monitor Agent
description: Learn how to configure data collections for Azure Monitor Agent so that you can migrate from the legacy Log Analytics agent.
ms.date: 07/11/2024
ms.reviewer: neghuman, jeffwo, laurahu, vabruwer, irfanr, jofehse, muniesa, amanan, v-weizhu
ms.service: azure-monitor
ms.custom: 
#Customer intent: As an Azure Monitor user, I want to configure data collections for Azure Monitor Agent so that I can migrate from the legacy Log Analytics agent.
---
# Step 3: Configure data collections

A data collection rule (DCR) is a new way to configure data collection streams for Azure Monitor Agent. The Azure Monitor DCR Config Generator is a tool to help migrate from legacy agents to Azure Monitor Agent and deploy DCRs. The tool is a PowerShell script that uses the information you have collected in your Log Analytics workspaces to create and deploy DCRs automatically. You must still associate the rules with virtual machines (VMs) so that you can start the data flow.

To use the DCR Config Generator, follow these steps:

1. Download the [latest version of the DCR Config Generator tool](https://github.com/microsoft/AzureMonitorCommunity/tree/master/Azure%20Services/Azure%20Monitor/Agents/Migration%20Tools/DCR%20Config%20Generator) from GitHub.

1. Run the tool and specify the required parameters, such as the following items:

   - Workspace ID
   - Subscription ID
   - Resource group name

   You can also specify optional parameters, such as the following items:

   - Rule name prefix
   - Rule description
   - Association scope

   The tool connects to your Log Analytics workspace and retrieves the configuration of the legacy agents. Then, it generates one or more data collection rules in JSON format and stores the rules in a local folder.

1. Review the generated rules. Make any necessary adjustments, such as the following changes:

   - Adding custom logs or metrics
   - Modifying the filters
   - Changing the retention period

1. Deploy the rules to your Azure Monitor workspace by using the Azure CLI or Azure portal.

1. Associate the rules with your VMs that are running Azure Monitor Agent by using the built-in association policies.

## Related content

[Switch VM Insights to Azure Monitor Agent]()

## Next steps

> [!div class="nextstepaction"]
> [Step 4: Test data collections in Azure Monitor Agent](step-4-test-data-collections-azure-monitor-agent.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
