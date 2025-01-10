---
title: Step 2 - Document your current configuration
description: Document your current configuration as the second step to upgrade from Log Analytics Agent to Azure Monitor Agent.
ms.date: 07/16/2024
ms.reviewer: neghuman, jeffwo, laurahu, vabruwer, irfanr, jofehse, muniesa, amanan, v-weizhu
ms.service: azure-monitor
ms.custom: sap:Issues migrating to Azure Monitor Agent (AMA)
#Customer intent: As an Azure Monitor user, I want to understand the data that I'm collecting so that I can successfully migrate to Azure Monitor Agent from the legacy Log Analytics agent.
---
# Step 2: Document your current configuration

It's important to document your current configuration to make sure that your configuration remains consistent after the migration. Note the information for each workspace in your environment from the Azure portal regarding the data that you're collecting. 

## Data collections configured in the workspace

To see which legacy data collections are configured in the Log Analytics workspace, follow these steps:

1. In the [Azure portal][ap], search for and select **Log Analytics workspaces**.

1. In the list of Log Analytics workspaces, select the name of your workspace.

   :::image type="content" source="media/step-2-understand-your-data-collection/log-anlytics-workspaces.png" alt-text="Azure portal screenshot of the Log Analytics workspaces page." lightbox="media/step-2-understand-your-data-collection/log-anlytics-workspaces.png":::

1. In the menu pane of your Log Analytics workspace, select **Classic** > **Legacy agents management**. On the **Legacy agents management** page, you can see the different types of data sources that the workspace can collect.

1. Select one of the following tabs based on the type of legacy data collection that you want to check.

   - **Windows event logs**

     :::image type="content" source="media/step-2-understand-your-data-collection/windows-event-logs.png" alt-text="Azure portal screenshot of the Windows event logs tab." lightbox="media/step-2-understand-your-data-collection/windows-event-logs.png":::
     
   - **Windows performance counters**

     :::image type="content" source="media/step-2-understand-your-data-collection/windows-performance-counters.png" alt-text="Azure portal screenshot of the Windows performance counters tab." lightbox="media/step-2-understand-your-data-collection/windows-performance-counters.png":::
     
   - **Linux performance counters**
   - **Syslog**
   - **IIS Logs**

1. On the corresponding tab, view the list of data sources that are currently enabled for the workspace. Now is an excellent time to review your data collection configuration and sample rate to optimize your configuration.

   You can also add, remove, or edit the data sources as necessary.

## Legacy solutions configured

To see which legacy solutions are added to your Log Analytics workspace:
1.  Navigate to the [Azure portal][ap]
1.  View your Log Analytics workspaces
1.  Select your workspace, and then go to the Legacy Solutions section. 

  :::image type="content" source="media/step-2-understand-your-data-collection/solutions-tab.png" alt-text="Azure portal screenshot of the legacy solutions page." lightbox="media/step-2-understand-your-data-collection/solutions-tab.png":::

Some legacy solutions might require extra steps to enable data collection. Examples of these steps include the following actions:

- Installing agents
- Configuring diagnostics
- Enabling features

The following table describes the features that you might have to enable.

| Service or feature | Migration path |
|--|--|
| System Center Operations Manager | If you use Operations Manager to monitor your Windows or Linux virtual machines (VMs), continue to use Microsoft Monitoring Agent for Operations Manager agent management. However, you have to install Azure Monitor Agent separately to send data to Azure Monitor. You can run both agents side by side on the same VM if they're configured to use different ports. |
| Azure Automation Change Tracking and Inventory | If you use Change Tracking and Inventory to track configuration changes and software inventory on your VMs, you have to migrate to the current version of the solution. This version uses Azure Monitor Agent instead of Microsoft Monitoring Agent. To do this, remove the legacy solution from your workspace, install Azure Monitor Agent on your VMs, and then add the current solution to your workspace. |
| Azure Automation Update Management | If you use Update Management to manage updates on your VMs, you have to migrate to the current version of the solution. This version uses Azure Monitor Agent instead of Microsoft Monitoring Agent. To do this, remove the legacy solution from your workspace, install Azure Monitor Agent on your VMs, and then add the current solution to your workspace. |
| Azure Security Center | If you use Azure Security Center to protect your VMs from threats and vulnerabilities, you have to migrate to the current version of the service. This version uses Azure Monitor Agent instead of Microsoft Monitoring Agent. To do this, enable the Azure Monitor Agent data collection option in Azure Security Center, install Azure Monitor Agent on your VMs, and then disable the Microsoft Monitoring Agent data collection option. |
| Azure Automation Hybrid Runbook Worker | If you use Azure Automation Hybrid Runbook Worker to run automation runbooks on your VMs, you can continue to use Microsoft Monitoring Agent for this feature. However, you have to install Azure Monitor Agent separately to send data to Azure Monitor. You can run both agents side-by-side on the same VM if they're configured to use different ports. |
| Microsoft Sentinel | If you use Microsoft Sentinel to collect and analyze security data from your VMs, you have to migrate to the current version of the service. This version uses Azure Monitor Agent instead of Microsoft Monitoring Agent. To do this, you have to install Azure Monitor Agent on your VMs, configure the data sources and connectors for Microsoft Sentinel, and then remove Microsoft Monitoring Agent from your VMs. |

You can also use the Azure Monitor Agent Migration Helper workbook to analyze the added legacy solutions. To use the workbook, go to **Monitor** > **Workbooks** > **AMA Migration Helper** in the [Azure portal][ap], and then select the **Workspaces** tab. You can now select the workspace that you want to check. Then, check the **Solutions** tab:

:::image type="content" source="media/step-2-understand-your-data-collection/azure-monitor-migration-helper-workspaces-solutions-tab.png" alt-text="Azure portal screenshot of the Solutions tab of the Workspaces Overview section the Azure Monitor Agent Migration Helper workbook." lightbox="media/step-2-understand-your-data-collection/azure-monitor-migration-helper-workspaces-solutions-tab.png":::

The workbook displays a table that contains the following columns:

- **Solution**
- **Last Data Received**
- **Recommendation**

## Next steps

> [!div class="nextstepaction"]
> [Step 3: Configure data collections](step-3-configure-data-collections.md)

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]

[ap]: https://portal.azure.com
