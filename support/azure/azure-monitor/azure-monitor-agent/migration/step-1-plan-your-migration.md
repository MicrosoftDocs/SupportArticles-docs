---
title: Step 1 - Plan your migration to Azure Monitor Agent
description: Learn how to plan your migration to Azure Monitor Agent as the first step toward upgrading from the legacy Log Analytics Agent.
ms.date: 07/08/2024
author: neilghuman
ms.author: neghuman
ms.reviewer: jeffwo, laurahu, vabruwer, irfanr, jofehse, muniesa, amanan, v-leedennis
editor: v-jsitser
ms.service: azure-monitor
ms.custom: 
#Customer intent: As an Azure Monitor user, I want to learn how to plan a migration to Azure Monitor so that I can move on from using the legacy Log Analytics Agent.
---
# Step 1: Plan your migration

Before you start the migration, you should prepare a migration plan. To facilitate this step, it's important to first understand how many agents you must migrate, which legacy solutions you're using, and what prerequisites you need to get in place.

## Understand your estate

You can use the [Azure Monitor Agent Migration Helper workbook](/azure/azure-monitor/agents/azure-monitor-agent-migration-helper-workbook) to gain an understanding of your environment and how many agents you must migrate. To access this workbook, follow these steps:

1. In the [Azure portal][ap], search for and select **Monitor**.
1. In the **Monitor** menu pane, select **Workbooks**.
1. In the gallery of workbooks, locate the **Azure Monitor essentials** heading, and then select the **AMA Migration Helper** workbook:

   :::image type="content" source="media/step-1-plan-your-migration/monitor-workbooks-gallery-ama-migration-helper.png" alt-text="Azure portal screenshot of the AMA Migration Helper workbook, from the Monitor | Workbooks | Gallery page." lightbox="media/step-1-plan-your-migration/monitor-workbooks-gallery-ama-migration-helper.png":::

The Azure Monitor Agent Migration Helper workbook has several tabs that help you understand your estate and track your migration progress.

In the **Subscriptions Overview** tab, you can see all the subscriptions that you have selected and have access to, how many Azure Monitor Logs workspaces exist across those subscriptions, and how many virtual machines (VMs) exist across those subscriptions:

:::image type="content" source="media/step-1-plan-your-migration/azure-monitor-migration-helper-subscriptions-overview-tab.png" alt-text="Azure portal screenshot of the Subscriptions Overview tab of the Azure Monitor Agent Migration Helper workbook." lightbox="media/step-1-plan-your-migration/azure-monitor-migration-helper-subscriptions-overview-tab.png":::

After the tabbed sections, the workbook displays the **Migration Status** section, showing an overview of the migration status for each subscription:

:::image type="content" source="media/step-1-plan-your-migration/azure-monitor-migration-helper-migration-status.png" alt-text="Azure portal screenshot of the Migration Status section of the Azure Monitor Agent Migration Helper workbook." lightbox="media/step-1-plan-your-migration/azure-monitor-migration-helper-migration-status.png":::

At the beginning of each workbook, there are corresponding tabs for each of the resource types (such as Arc-enabled servers and virtual machine scale sets) that are represented in the **Resource Type** column of the **Migration Status** section. For example, to look at your Azure VMs, select the **Azure Virtual Machines** tab:

:::image type="content" source="media/step-1-plan-your-migration/azure-monitor-migration-helper-azure-virtual-machines-tab.png" alt-text="Azure portal screenshot of the Azure Virtual Machines tab of the Azure Monitor Agent Migration Helper workbook." lightbox="media/step-1-plan-your-migration/azure-monitor-migration-helper-azure-virtual-machines-tab.png":::

The **Azure Virtual Machines** tab shows the full list of Azure VMs, displaying the full details for each VM. This tab tells you which agents are installed as extensions and shows the corresponding migration status, based on the following relationship table.

| Agent extension type            | Value of Migration Status column |
|---------------------------------|----------------------------------|
| MMA/OMS only                    | **Not Started**                  |
| MMA/OMS and Azure Monitor Agent | **In Progress**                  |
| Azure Monitor Agent only        | **Completed**                    |

You can export the table of information in this tab to Microsoft Excel. To do this, select the **More** button (...), and then select **Export to Excel** from the menu.

> [!NOTE]
> The list of column values that are shown in the **Azure Virtual Machines** tab is the same if you select the **Azure Virtual Machine Scale Sets** tab or the **Arc-Enabled Servers** tab.

## Understand your agent deployment methodologies

If you're using automated deployment methodologies to deploy the legacy Log Analytics agent, now is a good time to disable these methodologies. For example, if you're using Defender for Cloud to deploy the agent, you can disable this configuration by following these steps:

1. In the [Azure portal][ap], search for and select **Microsoft Defender for Cloud**.

1. In the **Microsoft Defender for Cloud** menu pane, search for the **Management** heading, and then select **Environment Settings**.

1. In the **Microsoft Defender for Cloud | Environment settings** page, select the subscription that you want to change the configuration of.

1. In the **Settings | Defender plans** page, select **Settings & monitoring**.

1. In the **Settings & monitoring** page, locate the **Log Analytics agent** value in the **Component** column, and then change the corresponding **Status** column value to **Off**.

## Verify prerequisites

### Non-Azure VMs

For all servers that are hosted outside of Azure, you must install the [Azure Arc Connected Machine agent](/azure/azure-arc/servers/agent-overview) first.

The Azure Arc Connected Machine agent is a software component that connects non-Azure VMs to Azure resources and services. To install the agent, you need to download the installation package from the Azure portal, run the installation script on each machine, and then register the VM in your Azure subscription. For more information, see [What is Azure Arc-enabled servers?](/azure/azure-arc/servers/overview) and [Quickstart: Connect hybrid machines with Azure Arc-enabled servers](/azure/azure-arc/servers/learn/quick-enable-hybrid-vm).

### Permissions

To deploy Azure Monitor Agent, you must have the following permissions:

| Built-in role | Scopes | Reason |
|--|--|--|
| <ul> <li>Virtual Machine Contributor</li> <li>Azure Connected Machine Resource Administrator</li> </ul> | <ul> <li>Virtual machines or virtual machine scale sets</li> <li>Azure Arc-enabled servers</li> </ul> | To deploy the agent |
| Any role that includes the action Microsoft.Resources/deployments/* (for example, [Log Analytics Contributor](/azure/role-based-access-control/built-in-roles#log-analytics-contributor)) | <ul> <li>Subscription</li> <li>Resource Group</li> </ul> | To deploy agent extension by using Azure Resource Manager templates (also used by Azure Policy) |

## Next steps

> [!div class="nextstepaction"]
> [Step 2: Understand your data collection](step-2-understand-your-data-collection.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]

[ap]: https://portal.azure.com
