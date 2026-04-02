---
title: Configure activity log export for a specific resource group
description: "Export Azure activity logs for your resource group to monitor changes and ensure compliance. Learn the steps to filter and export logs effectively."
ms.date: 03/31/2026
ms.author: jarrettr
ms.editor: v-gsitser
ms.reviewer: v-ryanberg 
ms.service: azure-monitor
ms.custom: I can't configure export of Activity Logs
---

# Configure activity log export for a specific resource group

## Summary

This article provides guidance to configure the export of activity logs for a resource group in Microsoft Azure. When you export activity logs, you can monitor changes more easily and ensure compliance within your Azure environment.

To monitor changes and detect unauthorized modifications, you often have to export activity logs for specific resource groups. However, Azure doesn't support log export for individual resources or groups directly. Instead, you can filter logs by using the **Resource** column in the AzureActivity table.

### Common problems and solutions

- **Problem**: Can't export logs for a specific resource group.
- **Solution**: Use the **Resource** column in the AzureActivity table to filter logs by resource group.

### Configure activity log export

Use Azure Monitor to configure activity log export:

1. In the [Azure portal](https://portal.azure.com), search for and select **Azure Monitor**.

1. To view the logs for your subscription, select **Activity Logs**.

1. Filter the logs by resource group:
    1. Use **Filter** to narrow down the logs.
    1. Select the **Resource** column, and specify the resource group that you're looking for.

1. Export the logs:
    1. To save the filtered logs, select **Export**.
    1. Select the desired format and destination for the export.

1. Verify the export:
    1. Review the file to make sure that the exported logs contain the necessary information.
    1. Check for any missing entries or discrepancies.

### References

- [Azure Monitor documentation](/azure/azure-monitor/)
- [Azure activity logs overview](/azure/azure-monitor/platform/activity-log)
- [Azure Log Analytics](/azure/azure-monitor/logs/log-analytics-overview)
