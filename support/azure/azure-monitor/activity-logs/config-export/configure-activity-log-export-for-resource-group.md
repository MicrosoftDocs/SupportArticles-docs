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

This article provides guidance on configuring the export of activity logs for a resource group in Azure. Exporting activity logs helps you monitor changes and ensure compliance within your Azure environment.

To monitor changes and detect unauthorized modifications, you often need to export activity logs for specific resource groups. However, Azure doesn't support exporting logs for individual resources or groups directly. Instead, filter logs by using the **Resource** column in the AzureActivity table.

### Common problems and solutions

- **Problem**: Can't export logs for a specific resource group.
- **Solution**: Use the **Resource** column in the AzureActivity table to filter logs by resource group.

### Configure activity log export

1. **Go to Azure Monitor** 

    1. In the [Azure portal](https://portal.azure.com), search for and select **Azure Monitor**.

1. **Select activity logs** 

    1. Select **Activity Logs** to view the logs for your subscription.

1. **Filter logs by resource group**

    1. Use **Filter** to narrow down the logs.
    1. Select the **Resource** column and specify the resource group you're looking for.

1. **Export logs**

    1. Select **Export** to save the filtered logs.
    1. Choose the desired format and destination for the export.

1. **Verify export**

    1. Ensure that the exported logs contain the necessary information by reviewing the file.
    1. Check for any missing entries or discrepancies.

### References

- [Azure Monitor documentation](/azure/azure-monitor/)
- [Azure activity logs overview](/azure/azure-monitor/insights/activity-logs)
- [Azure Log Analytics](/azure/azure-monitor/logs/log-analytics-overview)