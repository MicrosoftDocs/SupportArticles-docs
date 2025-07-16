---
title: Troubleshoot Custom Log Table Creation in Azure
description: Troubleshooting guide for custom log table creation in Azure.
ms.date: 07/16/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: Configure and Manage Log analytics tables
---

# Troubleshoot Custom Log Table Creation in Azure

When attempting to create a custom log table using a JSON file in Azure, users may encounter an error stating "Cannot read properties of undefined (reading length)". This issue typically arises during the final step of table creation, despite the JSON being valid. Understanding the root cause and following the correct steps can help resolve this problem.

## Common Issues and Solutions

- **Error: Cannot read properties of undefined (reading length)**
  - This error often indicates a problem with the JSON structure or the DCR configuration. Double-check both for accuracy.

- **No Data Ingestion**
  - Verify that the data source is correctly set up to collect log files. The data source type should be **Custom (Log files)**, and the stream declaration should follow the format `Custom-<TableName>`.

### Step-by-Step Instructions to Resolve the Issue

1. **Verify JSON Validity**
   - Ensure that the JSON file being used is correctly formatted and valid. Use a JSON validator tool to confirm this.

2. **Create a New Data Collection Rule (DCR)**
   - Navigate to the Azure portal and access the **Log Analytics Workspace**.
   - Create a new DCR specifically for the custom log table. Avoid using an existing DCR that collects other types of data, as this can lead to configuration conflicts.

3. **Use PowerShell Script for Table Creation**
   - Follow the steps outlined in the [Azure documentation](https://learn.microsoft.com/azure/azure-monitor/vm/data-collection-log-json#create-custom-table) to create the custom table using a PowerShell script.
   - This method allows you to specify the file pattern and verify the DCR configuration after creation.

4. **Check Contributor Role**
   - Ensure that you have at least the Contributor role in the relevant Azure Workspace to perform these actions.

5. **Refresh the Portal**
   - If issues persist, try refreshing the Azure portal to ensure all settings are updated.

## Reference

- [Create Custom Table in Azure](https://learn.microsoft.com/azure/azure-monitor/vm/data-collection-log-json#create-custom-table)
- [Data Collection Rule Best Practices](https://learn.microsoft.com/azure/azure-monitor/data-collection/data-collection-rule-best-practices)

If the issue persists after following the solution steps, please open a support case for further assistance.
