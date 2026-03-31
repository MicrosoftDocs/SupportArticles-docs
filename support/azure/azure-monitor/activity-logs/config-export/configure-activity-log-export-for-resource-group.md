---
title: Configure activity log export for a specific resource group
description: Learn how to configure the export of Azure activity logs for a specific resource group to monitor changes and ensure compliance.
ms.date: 03/31/2026
ms.author: jarrettr
ms.editor: v-gsitser
ms.reviewer: v-ryanberg 
ms.service: azure-monitor
ms.custom: I can't configure export of Activity Logs
---

# Configure activity log export for a specific resource group

## Summary

This article provides guidance on configuring the export of activity logs for a specific resource group in Azure. This is useful for monitoring changes and ensuring compliance within your Azure environment.

Users often need to export activity logs for specific resource groups to monitor changes and detect unauthorized modifications. However, Azure doesn't support exporting logs for individual resources or groups directly. Instead, users can filter logs using the **Resource** column in the AzureActivity table.

### Common Issues and Solutions

- **Issue**: Unable to export logs for a specific resource group.
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
    1. Check for any missing entries or discrepancies

### References

- [Azure Monitor Documentation](https://learn.microsoft.com/azure/azure-monitor/)
- [Azure Activity Logs Overview](https://learn.microsoft.com/azure/azure-monitor/insights/activity-logs)
- [Azure Log Analytics](https://learn.microsoft.com/azure/azure-monitor/logs/log-analytics-overview)