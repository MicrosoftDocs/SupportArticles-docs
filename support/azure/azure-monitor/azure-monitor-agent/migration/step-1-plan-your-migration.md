---
title: Step 1 - Plan your migration to Azure Monitor Agent
description: Learn how to plan your migration as the first step to upgrade from Log Analytics Agent to Azure Monitor Agent.
ms.date: 07/16/2024
ms.reviewer: neghuman, jeffwo, laurahu, vabruwer, irfanr, jofehse, muniesa, amanan, v-weizhu
ms.service: azure-monitor
ms.custom: sap:Issues migrating to Azure Monitor Agent (AMA)
#Customer intent: As an Azure Monitor user, I want to learn how to plan a migration to Azure Monitor so that I can move on from using the legacy Log Analytics Agent.
---
# Step 1: Plan the migration

Before you start the migration, you should prepare a migration plan. To facilitate this step, it's important to first create an inventory of your environment. Start by gathering information about the number of subscriptions, the number of workspaces per subscription, the number of legacy solutions that are enabled in each workspace, and the number of Log Analytics agents (also known as MMA and OMS) that are running across your respective subscriptions.

## Understand your environment

Use the Azure Monitor Agent Migration Helper workbook to understand your environment and how many agents must migrate. To access the workbook, follow these steps:

1. In the [Azure portal][ap], search for and select **Monitor**.
1. In the **Monitor** menu pane, select **Workbooks**.
1. In the gallery of workbooks, locate the **Azure Monitor essentials** heading, and then select the **AMA Migration Helper** workbook.

   :::image type="content" source="media/step-1-plan-your-migration/monitor-workbooks-gallery-ama-migration-helper.png" alt-text="Azure portal screenshot of the AMA Migration Helper workbook, from the Monitor | Workbooks | Gallery page." lightbox="media/step-1-plan-your-migration/monitor-workbooks-gallery-ama-migration-helper.png":::

The Azure Monitor Agent Migration Helper workbook has several tabs that help identify the environment and track the migration progress.

On the **Subscriptions Overview** tab, you can view all the subscriptions that you have selected and have access to, how many Log Analytics workspaces exist across those subscriptions, and how many virtual machines (VMs) exist across those subscriptions.

:::image type="content" source="media/step-1-plan-your-migration/azure-monitor-migration-helper-subscriptions-overview-tab.png" alt-text="Azure portal screenshot of the Subscriptions Overview tab of the Azure Monitor Agent Migration Helper workbook." lightbox="media/step-1-plan-your-migration/azure-monitor-migration-helper-subscriptions-overview-tab.png":::

On the **Subscriptions Overview** tab, scroll down to view the **Migration Status** section. This provides an overview of the migration status for each subscription.

:::image type="content" source="media/step-1-plan-your-migration/azure-monitor-migration-helper-migration-status.png" alt-text="Azure portal screenshot of the Migration Status section of the Azure Monitor Agent Migration Helper workbook." lightbox="media/step-1-plan-your-migration/azure-monitor-migration-helper-migration-status.png":::

There is a tab for each resource type (**Azure Virtual Machines, Azure Virtual Machine Scale Sets, Arc-Enabled Servers, Hybrid without Arc**). By selecting a resource type tab, you'll see columns of data that provide the current status of your migration.

:::image type="content" source="media/step-1-plan-your-migration/azure-monitor-migration-helper-azure-virtual-machines-tab.png" alt-text="Azure portal screenshot of the Azure Virtual Machines tab of the Azure Monitor Agent Migration Helper workbook." lightbox="media/step-1-plan-your-migration/azure-monitor-migration-helper-azure-virtual-machines-tab.png":::

The **Azure Virtual Machines** tab conatina a full list of Azure VMs and displays the full details for each VM. This tab shows which agents are installed as extensions and the corresponding migration status, based on the following relationship table.

| Agent extension type            | Value of the "Migration Status" column |
|---------------------------------|----------------------------------|
| MMA/OMS only                    | **Not Started**                  |
| MMA/OMS and Azure Monitor Agent | **In Progress**                  |
| Azure Monitor Agent only        | **Completed**                    |

You can export the information table from this tab to Microsoft Excel. To do this, select the **More** button (...), and then select **Export to Excel** from the menu.

> [!NOTE]
> The list of column values that are shown on the **Azure Virtual Machines** tab is the same whether you select the **Azure Virtual Machine Scale Sets** tab or the **Arc-Enabled Servers** tab.

## Verify prerequisites

### Non-Azure VMs

For all servers that are hosted outside Azure, you must first install the [Azure Arc Connected Machine agent](/azure/azure-arc/servers/agent-overview).

The Azure Arc Connected Machine agent is a software component that connects non-Azure VMs to Azure resources and services. To install the agent, you have to download the installation package from the Azure portal, run the installation script on each VM, and then register the VM in your Azure subscription. For more information, see [What Azure Arc-enabled servers are](/azure/azure-arc/servers/overview) and [Quickstart: Connect hybrid machines with Azure Arc-enabled servers](/azure/azure-arc/servers/learn/quick-enable-hybrid-vm).

## Next steps

> [!div class="nextstepaction"]
> [Step 2: Understand your data collection](step-2-understand-your-data-collection.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]

[ap]: https://portal.azure.com
