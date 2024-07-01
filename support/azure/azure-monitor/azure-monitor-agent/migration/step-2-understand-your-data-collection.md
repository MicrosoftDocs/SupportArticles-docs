---
title: Step 2 - Understand the data that you're collecting
description: Understand the data that you're collecting as the second step of the process of migrating to Azure Monitor Agent from the legacy Log Analytics Agent.
ms.date: 07/08/2024
author: neilghuman
ms.author: neghuman
ms.reviewer: jeffwo, laurahu, vabruwer, irfanr, jofehse, muniesa, v-leedennis
editor: v-jsitser
ms.service: azure-monitor
ms.custom: 
#Customer intent: As an Azure Monitor user, I want to understand the data that I'm collecting so that I can successfully migrate to Azure Monitor Agent from the legacy Log Analytics agent.
---
# Step 2: Understand the data that you're collecting

To understand the data that you're collecting for the migration to Microsoft Azure Monitor Agent, repeat the following guidance for each of the workspaces in your environment.

## Data collections configured in the workspace

To see which legacy data collections are configured in the Log Analytics workspace, follow these steps:

1. In the [Azure portal][ap], go to your workspace.

1. In the menu pane, select **Settings** > **Data** to open the **Data settings** page. On this page, you can see the different types of data sources that the workspace can collect.

1. In the **Data sources** section, select **Windows event logs**, **Windows performance counters**, **Linux performance counters**, **Linux syslogs**, or **Custom logs**, depending on the type of legacy data collection that you want to check.

1. On the corresponding page, view the list of data sources that are currently enabled for the workspace. You can also add, remove, or edit the data sources as necessary.

## Solutions configured

To see which legacy solutions are added to your Log Analytics workspace, go to the [Azure portal][ap], view your Log Analytics workspaces, select your workspace, and then go to the **Solutions** section. You can search for solutions by name, category, or publisher. On the **Solutions** page, you can view the details of each solution, such as the following fields:

- Description
- Status
- Configuration settings

You can also add, remove, or updated the solutions as necessary.

Some solutions might require extra steps to enable data collection. Examples of these steps include the following actions:

- Installing agents
- Configuring diagnostics
- Enabling features

The following table describes the features that you might have to enable.

| Service or feature | Migration path |
|--|--|
| System Center Operations Manager | If you use Operations Manager to monitor your Windows or Linux virtual machines (VMs), continue to use Microsoft Monitoring Agent for Operations Manager agent management. However, you have to install Azure Monitor Agent separately to send data to Azure Monitor. You can run both agents side-by-side on the same VM if they're configured to use different ports. |
| Azure Automation Change Tracking and Inventory | If you use Change Tracking and Inventory to track configuration changes and software inventory on your VMs, you have to migrate to the current version of the solution, which uses Azure Monitor Agent instead of Microsoft Monitoring Agent. To do this, remove the legacy solution from your workspace, install Azure Monitor Agent on your VMs, and then add the current solution to your workspace. |
| Azure Automation Update Management | If you use Update Management to manage updates and patches on your VMs, you have to migrate to the current version of the solution, which uses Azure Monitor Agent instead of Microsoft Monitoring Agent. To do this, remove the legacy solution from your workspace, install Azure Monitor Agent on your VMs, and then add the current solution to your workspace. |
| Azure Security Center | If you use Azure Security Center to protect your VMs from threats and vulnerabilities, you have to migrate to the current version of the service, which uses Azure Monitor Agent instead of Microsoft Monitoring Agent. To do this, enable Azure Monitor Agent data collection option in Azure Security Center, install Azure Monitor Agent on your VMs, and then disable the Microsoft Monitoring Agent data collection option. |
| Azure Automation Hybrid Runbook Worker | If you use Azure Automation Hybrid Runbook Worker to run automation runbooks on your VMs, you can continue to use Microsoft Monitoring Agent for this feature. However, you have to install Azure Monitor Agent separately to send data to Azure Monitor. You can run both agents side-by-side on the same VM if they're configured to use different ports. |
| Microsoft Sentinel | If you use Microsoft Sentinel to collect and analyze security data from your VMs, you have to migrate to the current version of the service, which uses Azure Monitor Agent instead of Microsoft Monitoring Agent. To do this, you have to install Azure Monitor Agent on your VMs, configure the data sources and connectors for Microsoft Sentinel, and then remove Microsoft Monitoring Agent from your VMs. |

You can also use the Azure Monitor Agent Migration Helper workbook to analyze the added solutions. To use the workbook, go to **Monitor** > **Workbooks** > **AMA Migration Helper** in the [Azure portal][ap], and then select the **Workspaces** tab. You can now select the workspace that you want to check, and then check the **Solutions** tab:

:::image type="content" source="media/step-2-understand-your-data-collection/azure-monitor-migration-helper-workspaces-solutions-tab.png" alt-text="Azure portal screenshot of the Solutions tab of the Workspaces Overview section the Azure Monitor Agent Migration Helper workbook." lightbox="media/step-2-understand-your-data-collection/azure-monitor-migration-helper-workspaces-solutions-tab.png":::

The workbook displays a table that contains the following columns:

- Solution name
- Solution type
- Publisher
- Solution status
- Last data received
- Recommendation

The solution name column shows the name of the solution that's added to the workspace, while the solution type column indicates whether it is a legacy or a current solution. The publisher column shows the provider of the solution, such as Microsoft or a third-party vendor.

You can use the filters at the top of the table to narrow down the results by solution type, publisher, or status.

## Next steps

> [!div class="nextstepaction"]
> [Step 3: Configure data collections](step-3-configure-data-collections.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]

[ap]: https://portal.azure.com
