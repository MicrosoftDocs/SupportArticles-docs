---
title: Troubleshoot Custom Log Table Creation in Azure
description: Troubleshooting guide for custom log table creation in Azure.
ms.date: 07/16/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: Configure and Manage Log analytics tables
---

# Troubleshoot custom log table creation in Azure

Users might receive an error message that states "Cannot read properties of undefined (reading length)" when they try to create a custom log table by using a JSON file in Microsoft Azure. This issue typically occurs during the final step of table creation even though the JSON file is valid. If you understand the root cause of the issue and follow the correct steps, you can resolve this issue efficiently.

## Common issues and solutions

- Error: Cannot read properties of undefined (reading length): This error often indicates an issue that affects the JSON structure or the DCR configuration. Doublecheck both for accuracy.

- No Data Ingestion: Verify that the data source is correctly set up to collect log files. The data source type should be **Custom (Log files)**, and the stream declaration should follow the format `Custom-<TableName>`.

### Instructions to resolve the issue

1. Make sure that the JSON file that's used is correctly formatted and valid. Use a JSON validator tool to verify this.

2. Create a new data collection rule (DCR):
   1. Navigate to the Azure portal > **Log Analytics Workspace**.
   1. Create a DCR specifically for the custom log table. Avoid using an existing DCR that collects other types of data because this action can cause configuration conflicts.

3. Follow the steps that are outlined in the [Azure documentation](https://learn.microsoft.com/azure/azure-monitor/vm/data-collection-log-json#create-custom-table) to create the custom table by using a PowerShell script. This method allows you to specify the file pattern and verify the DCR configuration after the creation is finished.

4. To be able to perform these actions, make sure that you have at least the Contributor role in the relevant Azure Workspace.

5. If the issue persists, try to refresh the Azure portal to make sure that all settings are updated.

## Reference

- [Create Custom Table in Azure](https://learn.microsoft.com/azure/azure-monitor/vm/data-collection-log-json#create-custom-table)
- [Data Collection Rule Best Practices](https://learn.microsoft.com/azure/azure-monitor/data-collection/data-collection-rule-best-practices)

If the issue persists after you follow these steps, please open a support case for further assistance.
