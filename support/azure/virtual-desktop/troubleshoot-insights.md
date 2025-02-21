---
title: Troubleshoot Monitor Azure Virtual Desktop
description: Helps troubleshoot issues with Azure Virtual Desktop Insights.
ms.topic: troubleshooting
ms.date: 01/21/2025
ms.reviewer: daknappe
ms.custom: docs_inherited, pcy:wincomm-user-experience
---
# Troubleshoot Azure Virtual Desktop Insights

This article presents known issues and solutions for common problems in Azure Virtual Desktop Insights.

> [!IMPORTANT]
> [The Log Analytics Agent is currently being deprecated](https://azure.microsoft.com/updates/were-retiring-the-log-analytics-agent-in-azure-monitor-on-31-august-2024/). If you use the Log Analytics Agent for Azure Virtual Desktop support, you'll eventually need to migrate to the [Azure Monitor Agent](/azure/azure-monitor/agents/agents-overview) by August 31, 2024.

# [Azure Monitor Agent](#tab/monitor)

## Issues with configuration and setup

If the configuration workbook isn't working properly to automate the setup, you can use these resources to set up your environment manually:

- To manually enable diagnostics or access the Log Analytics workspace, see [Send Azure Virtual Desktop diagnostics to Log Analytics](/azure/virtual-desktop/diagnostics-log-analytics).
- To install the Azure Monitor Agent extension on a session host manually, see [Azure Monitor Agent virtual machine extension for Windows](/azure/azure-monitor/agents/azure-monitor-agent-manage#installation-options).
- To set up a new Log Analytics workspace, see [Create a Log Analytics workspace in the Azure portal](/azure/azure-monitor/logs/quick-create-workspace).
- To validate the Data Collection Rules in use, see [View data collection rules](/azure/azure-monitor/essentials/data-collection-rule-view).

## My data isn't displaying properly

If your data isn't displaying properly, check the following common solutions:

- First, make sure you've set up correctly with the configuration workbook as described in [Use Azure Virtual Desktop Insights to monitor your deployment](/azure/virtual-desktop/insights). If you're missing any counters or events, the data associated with them won't appear in the Azure portal.
- Check your access permissions and contact the resource owners to request missing permissions. Anyone monitoring Azure Virtual Desktop requires the following permissions:

  - Read access to the Azure resource groups that hold your Azure Virtual Desktop resources.
  - Read access to the subscription's resource groups that hold your Azure Virtual Desktop session hosts.
  - Read access to whichever Log Analytics workspaces you're using.

- You might need to open outgoing ports in your server's firewall to allow Azure Monitor to send data to the portal. For more information, see [Firewall requirements](/azure/azure-monitor/agents/azure-monitor-agent-data-collection-endpoint#firewall-requirements).
- If you're not seeing data from recent activity, you might need to wait 15 minutes and refresh the feed. Azure Monitor has a 15-minute latency period for populating log data. For more information, see [Log data ingestion time in Azure Monitor](/azure/azure-monitor/logs/data-ingestion-time).

If you're not missing any information but your data still isn't displaying properly, there might be an issue in the query or the data sources. For more information, see [known issues and limitations](#known-issues-and-limitations).

# [Log Analytics agent](#tab/analytics)

## Issues with configuration and setup

If the configuration workbook isn't working properly to automate setup, you can use these resources to set up your environment manually:

- To manually enable diagnostics or access the Log Analytics workspace, see [Send Azure Virtual Desktop diagnostics to Log Analytics](/azure/virtual-desktop/diagnostics-log-analytics).
- To install the Log Analytics extension on a session host manually, see [Log Analytics virtual machine extension for Windows](/azure/virtual-machines/extensions/oms-windows).
- To set up a new Log Analytics workspace, see [Create a Log Analytics workspace in the Azure portal](/azure/azure-monitor/logs/quick-create-workspace).
- To add, remove, or edit performance counters, see [Configuring performance counters](/azure/azure-monitor/agents/data-sources-performance-counters).
- To configure Windows Event Logs for a Log Analytics workspace, see [Collect Windows event log data sources with Log Analytics agent](/azure/azure-monitor/agents/data-sources-windows-events).

## My data isn't displaying properly

If your data isn't displaying properly, check the following common solutions:

- First, make sure you've set up correctly with the configuration workbook as described in [Use Azure Virtual Desktop Insights to monitor your deployment](/azure/virtual-desktop/insights). If you're missing any counters or events, the data associated with them won't appear in the Azure portal.
- Check your access permissions and contact the resource owners to request missing permissions. Anyone monitoring Azure Virtual Desktop requires the following permissions:

  - Read access to the Azure resource groups that hold your Azure Virtual Desktop resources.
  - Read access to the subscription's resource groups that hold your Azure Virtual Desktop session hosts.
  - Read access to whichever Log Analytics workspaces you're using.

- You might need to open outgoing ports in your server's firewall to allow Azure Monitor and Log Analytics to send data to the portal. For more information, see the following articles:

  - [Azure Monitor Outgoing ports](/azure/azure-monitor/ip-addresses)
  - [Log Analytics Firewall Requirements](/azure/azure-monitor/agents/log-analytics-agent#firewall-requirements)

- Not seeing data from recent activity? You might want to wait 15 minutes and refresh the feed. Azure Monitor has a 15-minute latency period for populating log data. For more information, see [Log data ingestion time in Azure Monitor](/azure/azure-monitor/logs/data-ingestion-time).

If you're not missing any information but your data still isn't displaying properly, there might be an issue in the query or the data sources. For more information, see [known issues and limitations](#known-issues-and-limitations).

---

## I want to customize Azure Virtual Desktop Insights

Azure Virtual Desktop Insights uses Azure Monitor Workbooks. Workbooks let you save a copy of the Azure Virtual Desktop workbook template and make your own customizations.

By design, custom Workbook templates won't automatically adopt updates from the products group. For more information, see [Troubleshooting workbook-based insights](/azure/azure-monitor/insights/troubleshoot-workbooks) and the [Workbooks overview](/azure/azure-monitor/visualize/workbooks-overview).

## I can't interpret the data

Learn more about data terms in the [Azure Virtual Desktop Insights glossary](/azure/virtual-desktop/insights-glossary).

# [Azure Monitor Agent](#tab/monitor)

## The data I need isn't available

If this article doesn't have the data point you need to resolve an issue, you can send us feedback at the following places:

- To learn how to leave feedback, see [Troubleshooting overview, feedback, and support for Azure Virtual Desktop](/azure/virtual-desktop/troubleshoot-set-up-overview).
- You can also leave feedback for Azure Virtual Desktop at the [Azure Virtual Desktop feedback hub](https://support.microsoft.com/help/4021566/windows-10-send-feedback-to-microsoft-with-feedback-hub-app).

# [Log Analytics agent](#tab/analytics)

## The data I need isn't available

If you want to monitor more performance counters or Windows event logs, you can enable them to send diagnostics info to your Log Analytics workspace and monitor them in **Host Diagnostics: Host browser**.

- To add performance counters, see [Configuring performance counters](/azure/azure-monitor/agents/data-sources-performance-counters#configure-performance-counters)
- To add Windows events, see [Configuring Windows event logs](/azure/azure-monitor/agents/data-sources-windows-events#configure-windows-event-logs)

Can't find a data point to help diagnose an issue? Send us feedback!

- To learn how to leave feedback, see [Troubleshooting overview, feedback, and support for Azure Virtual Desktop](/azure/virtual-desktop/troubleshoot-set-up-overview).
- You can also leave feedback for Azure Virtual Desktop at the [Azure Virtual Desktop feedback hub](https://support.microsoft.com/help/4021566/windows-10-send-feedback-to-microsoft-with-feedback-hub-app).

---

## Known issues and limitations

The following are issues and limitations we're aware of and working to fix:

- To save favorite settings, you have to save a custom template of the workbook. Custom templates don't automatically adopt updates from the product group.
- The configuration workbook sometimes show "query failed" errors when loading your selections. Refresh the query and reenter your selection if needed. The error should resolve itself.
- Some error messages aren't phrased in a user-friendly way, and not all error messages are described in the documentation.
- The total session performance counter can overcount sessions by a small number and your total sessions might appear to exceed your Max Sessions limit.
- The available session count doesn't reflect scaling policies on the host pool.
- Do you see contradicting or unexpected connection times? While rare, a connection's completion event can go missing and affect some visuals and metrics.
- Time to connect includes the time it takes users to enter their credentials; this correlates to the experience but can show false peaks in some cases.

## More information

- To get started, see [Use Azure Virtual Desktop Insights to monitor your deployment](/azure/virtual-desktop/insights).
- To estimate, measure, and manage your data storage costs, see [Estimate Azure Monitor costs](/azure/virtual-desktop/insights-costs).
- Check out the [glossary](/azure/virtual-desktop/insights-glossary) to learn more about terms and concepts related to Azure Virtual Desktop Insights.
