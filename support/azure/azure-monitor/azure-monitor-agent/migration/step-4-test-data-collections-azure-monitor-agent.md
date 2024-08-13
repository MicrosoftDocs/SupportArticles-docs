---
title: Step 4 - Test data collections in Azure Monitor Agent
description: Learn how to test data collections in Azure Monitor Agent as part of migrating from the legacy Log Analytics agent.
ms.date: 07/16/2024
ms.reviewer: neghuman, jeffwo, laurahu, vabruwer, irfanr, jofehse, muniesa, amanan, v-weizhu
ms.service: azure-monitor
ms.custom: sap:Issues migrating to Azure Monitor Agent (AMA)
#Customer intent: As an Azure Monitor user, I want to learn how to test data collections in Azure Monitor Agent so that I can migrate from the legacy Log Analytics agent.
---
# Step 4: Test data collections in Azure Monitor Agent

In this article, you will find several methods for linking recently formed Data Collector Reports (DCRs) with existing virtual machines. By following these techniques, you can begin gathering data for analysis in either a testing environment or directly in production.

## Deploying newly generated data collection rules (DCRs) to a test workspace

### Deploy Log Analytics Testing Workspace

To set up a short-term Log Analytics workspace for testing purposes, follow these steps:

1. Sign in to the Azure portal with your Azure account credentials.
1. In the search bar at the top of the portal, type "Log Analytics" and press Enter to open the Log Analytics blade.
1. Click on "+ Add" or the "Add" button to create a new Log Analytics workspace.
1. Fill in the required details for your new workspace, such as the name and the subscription where you want to create it.
1. Choose a resource group for your new workspace. You can either create a new one or use an existing one.
1. Select the location for your Log Analytics workspace. This should be the same region as your virtual machines.
1. Click "Create" to start the deployment process. The creation of the Log Analytics workspace may take several minutes.
1. Once the deployment is complete, navigate to the newly created Log Analytics workspace in the Azure portal.

### Swapping production Workspace with test Workspace

1. In the search bar at the top of the portal, type "Data Collection Rules" and press Enter to open the Data Colletion Rules blade.
1. Select the newly create Data Collection rule name that we curated with the DCR tool.
1. Select configuration, then Data Sources, click on a Data Source.
1. Validate the data source setting and select destination tab.
1. Select Destination Details to remove the production workspace and replace with testing workspace.
1. Begin your testing activities within this temporary Log Analytics workspace, ensuring that you have all required permissions and access levels in place.

### Associating VM's to DCR

1. In the list of data collection rules, select the DCR that you want to associate with VMs.
1. In the menu pane of your DCR, locate the **Configuration** heading, and then select **Resources**.

   :::image type="content" source="media/step-4-test-data-collections-azure-monitor-agent/data-collection-rule-resources-page.png" alt-text="Azure portal screenshot of the data collection rule's Resources page." lightbox="media/step-4-test-data-collections-azure-monitor-agent/data-collection-rule-resources-page.png":::

1. Select the **Add** button to search for VMs to associate with the DCR. The **Select a scope** pane appears:

   :::image type="content" source="media/step-4-test-data-collections-azure-monitor-agent/data-collection-rule-select-a-scope-pane.png" alt-text="Azure portal screenshot of the data collection rule's Select a scope pane after you select the Add button." lightbox="media/step-4-test-data-collections-azure-monitor-agent/data-collection-rule-select-a-scope-pane.png":::

1. Locate the VMs that you want to associate with the DCR, and then select the **Apply** button. If Azure Monitor Agent hasn't been deployed to the VM, it will be deployed at this time.

1. You are now ready to validate your configuration.

### Post validation steps

Once the data validation is completed:  

   1. Switch the destination workspace in the DCR from the temporary workspace to the production workspace.
   1. Remove the Legacy Agent from the Virtual machine by removing the extension from the VM in the portal.
   1. Migration is now been completed.

1. To migrate additional workspaces, repeats steps 1 to 4.

1. To check the latest status of your migration, please consult the AMA Migration Helper workbook.

:::image type="content" source="media/step-1-plan-your-migration/azure-monitor-migration-helper-azure-virtual-machines-tab.png" alt-text="Azure portal screenshot of the Azure Virtual Machines tab of the Azure Monitor Agent Migration Helper workbook." lightbox="media/step-1-plan-your-migration/azure-monitor-migration-helper-azure-virtual-machines-tab.png":::

## Troubleshoot Azure Monitor Agent

To troubleshoot Azure Monitor Agent, you can use one of the following tools:

- [Windows operating system (OS) Azure Monitor Agent Troubleshooter](/azure/azure-monitor/agents/troubleshooter-ama-windows)
- [Linux operating system (OS) Azure Monitor Agent Troubleshooter](/azure/azure-monitor/agents/troubleshooter-ama-linux)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
