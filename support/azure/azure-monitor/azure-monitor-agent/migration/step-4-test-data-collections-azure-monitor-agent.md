---
title: Step 4 - Test data collections in Azure Monitor Agent
description: Learn how to test data collections in Azure Monitor Agent as part of migrating from the legacy Log Analytics agent.
ms.date: 07/11/2024
author: neilghuman
ms.author: neghuman
ms.reviewer: jeffwo, laurahu, vabruwer, irfanr, jofehse, muniesa, amanan, v-leedennis
editor: v-jsitser
ms.service: azure-monitor
ms.custom: 
#Customer intent: As an Azure Monitor user, I want to learn how to test data collections in Azure Monitor Agent so that I can migrate from the legacy Log Analytics agent.
---
# Step 4: Test data collections in Azure Monitor Agent

This article discusses how to deploy new data collection rules (DCRs) and associate a pilot group of server agents so that you can test data collections in Azure Monitor Agent.

## Deploy new data collection rules (DCRs)

To deploy a new DCR from a Bicep template, follow these steps:

1. Install the Azure CLI and Bicep CLI on your virtual machine (VM).

1. Create or modify a Bicep file that defines the DCR resource and its properties. You can use the sample template that's provided in the documentation as a reference.

1. Run the [az login](/cli/azure/reference-index#az-login) command to sign in to your Azure account, and then set the subscription on which you want to deploy the DCR.

1. Run the [az deployment group create](/cli/azure/deployment/group#az-deployment-group-create) command to deploy the DCR to a resource group.

1. Verify that the DCR is created and configured correctly by running the [az monitor data-collection rule show](/cli/azure/monitor/data-collection/rule#az-monitor-data-collection-rule-show) command or by checking the Azure portal.

## Associate pilot agents

To test the data collections, we recommend that you identify a pilot group of servers that are representative of your environment and associate the servers with the DCRs that you created.

To associate a VM with a DCR, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Monitor**.
1. In the **Monitor** menu pane, select **Settings** > **Data Collection Rules**.
1. In the list of data collection rules, select the DCR that you want to associate with a VM.
1. In the menu pane of your DCR, locate the **Configuration** heading, and then select **Resources**.

   :::image type="content" source="media/step-4-test-data-collections-azure-monitor-agent/data-collection-rule-resources-page.png" alt-text="Azure portal screenshot of the data collection rule's Resources page." lightbox="media/step-4-test-data-collections-azure-monitor-agent/data-collection-rule-resources-page.png":::

1. Select the **Add** button to search for VMs to associate with the DCR. The **Select a scope** pane appears:

   :::image type="content" source="media/step-4-test-data-collections-azure-monitor-agent/data-collection-rule-select-a-scope-pane.png" alt-text="Azure portal screenshot of the data collection rule's Select a scope pane after you select the Add button." lightbox="media/step-4-test-data-collections-azure-monitor-agent/data-collection-rule-select-a-scope-pane.png":::

1. Locate the VMs that you want to associate with the DCR, and then select the **Apply** button. If Azure Monitor Agent hasn't been deployed to the VM, it will be deployed at this time.

## Troubleshoot Azure Monitor Agent

To troubleshoot Azure Monitor Agent, you can use one of the following tools:

- [Windows operating system (OS) Azure Monitor Agent Troubleshooter](/azure/azure-monitor/agents/troubleshooter-ama-windows)
- [Linux operating system (OS) Azure Monitor Agent Troubleshooter](/azure/azure-monitor/agents/troubleshooter-ama-linux)

## Next steps

> [!div class="nextstepaction"]
> [Step 5: Deploy at scale](step-5-deploy-at-scale.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
