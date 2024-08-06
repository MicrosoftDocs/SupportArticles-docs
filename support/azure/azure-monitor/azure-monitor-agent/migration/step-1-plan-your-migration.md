---
title: Step 1 - Plan your migration to Azure Monitor Agent
description: Learn how to plan your migration to Azure Monitor Agent as the first step toward upgrading from the legacy Log Analytics Agent.
ms.date: 07/16/2024
ms.reviewer: neghuman, jeffwo, laurahu, vabruwer, irfanr, jofehse, muniesa, amanan, v-weizhu
ms.service: azure-monitor
ms.custom: sap:Issues migrating to Azure Monitor Agent (AMA)
#Customer intent: As an Azure Monitor user, I want to learn how to plan a migration to Azure Monitor so that I can move on from using the legacy Log Analytics Agent.
---
# Step 1: Plan your migration

Before begin migrating, a migration plan should be prepared. To facilitate this step, it's important to first create an inventory.  We need to gather information on the number of subscriptions, the number of workspaces per subscription, the number of legacy solutions enabled in each workspace, and the number of MMA/OMS agents running across your respective subscriptions.

## Understand your environment

You can use the Azure Monitor Agent Migration Helper workbook to understand your environment and how many agents you must migrate. To access this workbook, follow these steps:

1. In the [Azure portal][ap], search for and select **Monitor**.
1. In the **Monitor** menu pane, select **Workbooks**.
1. In the gallery of workbooks, locate the **Azure Monitor essentials** heading, and then select the **AMA Migration Helper** workbook:

   :::image type="content" source="media/step-1-plan-your-migration/monitor-workbooks-gallery-ama-migration-helper.png" alt-text="Azure portal screenshot of the AMA Migration Helper workbook, from the Monitor | Workbooks | Gallery page." lightbox="media/step-1-plan-your-migration/monitor-workbooks-gallery-ama-migration-helper.png":::

The Azure Monitor Agent Migration Helper workbook has several tabs that help you understand your estate and track your migration progress.

In the **Subscriptions Overview** tab, you can see all the subscriptions that you have selected and have access to, how many Log Analytics workspaces exist across those subscriptions, and how many virtual machines (VMs) exist across those subscriptions:

:::image type="content" source="media/step-1-plan-your-migration/azure-monitor-migration-helper-subscriptions-overview-tab.png" alt-text="Azure portal screenshot of the Subscriptions Overview tab of the Azure Monitor Agent Migration Helper workbook." lightbox="media/step-1-plan-your-migration/azure-monitor-migration-helper-subscriptions-overview-tab.png":::

In the **Subscriptions Overview** tab, scroll down to view the **Migration Status** section, which provides an overview of the migration status for each subscription:

:::image type="content" source="media/step-1-plan-your-migration/azure-monitor-migration-helper-migration-status.png" alt-text="Azure portal screenshot of the Migration Status section of the Azure Monitor Agent Migration Helper workbook." lightbox="media/step-1-plan-your-migration/azure-monitor-migration-helper-migration-status.png":::

There are corresponding tabs for each resource type (**Azure Virtual Machines, Azure Virtual Machine Scale Sets, Arc-Enabled Servers, Hybrid without Arc**). By selecting a resource type tab, columns with data will be displayed to provide you with the current status of your migration:

:::image type="content" source="media/step-1-plan-your-migration/azure-monitor-migration-helper-azure-virtual-machines-tab.png" alt-text="Azure portal screenshot of the Azure Virtual Machines tab of the Azure Monitor Agent Migration Helper workbook." lightbox="media/step-1-plan-your-migration/azure-monitor-migration-helper-azure-virtual-machines-tab.png":::

The **Azure Virtual Machines** tab shows the full list of Azure VMs, displaying the full details for each VM. This tab shows which agents are installed as extensions and the corresponding migration status based on the following relationship table.

| Agent extension type            | Value of the "Migration Status" column |
|---------------------------------|----------------------------------|
| MMA/OMS only                    | **Not Started**                  |
| MMA/OMS and Azure Monitor Agent | **In Progress**                  |
| Azure Monitor Agent only        | **Completed**                    |

You can export the information table in this tab to Microsoft Excel. To do this, select the **More** button (...), and then select **Export to Excel** from the menu.

> [!NOTE]
> The list of column values that are shown in the **Azure Virtual Machines** tab is the same if you select the **Azure Virtual Machine Scale Sets** tab or the **Arc-Enabled Servers** tab.

## Verify prerequisites

### Non-Azure VMs

For all servers that are hosted outside of Azure, you must install the [Azure Arc Connected Machine agent](/azure/azure-arc/servers/agent-overview) first.

The Azure Arc Connected Machine agent is a software component that connects non-Azure VMs to Azure resources and services. To install the agent, you need to download the installation package from the Azure portal, run the installation script on each machine, and then register the VM in your Azure subscription. For more information, see [What Azure Arc-enabled servers are](/azure/azure-arc/servers/overview) and [Quickstart: Connect hybrid machines with Azure Arc-enabled servers](/azure/azure-arc/servers/learn/quick-enable-hybrid-vm).

## Next steps

> [!div class="nextstepaction"]
> [Step 2: Understand your data collection](step-2-understand-your-data-collection.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]

[ap]: https://portal.azure.com
