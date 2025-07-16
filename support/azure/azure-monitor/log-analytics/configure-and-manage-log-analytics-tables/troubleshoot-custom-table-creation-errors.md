---
title: Troubleshoot Custom Table Creation Errors in Azure
description: Troubleshooting guide for custom table creation errors in Azure.
ms.date: 07/16/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: Configure and Manage Log analytics tables
---

# Troubleshoot Custom Table Creation Errors in Azure

When attempting to create a custom table in Azure, users may encounter an error message indicating that properties of undefined cannot be read. This issue can arise due to temporary glitches or misconfigurations. Understanding the root cause and following the appropriate troubleshooting steps can help resolve this problem efficiently.

## Step-by-Step Instructions to Resolve Custom Table Creation Errors

### 1. Verify JSON File Validity

- Ensure that the JSON file used for table creation is correctly formatted and contains all necessary fields.
- Use tools like *JSONLint* to validate the JSON structure.

### 2. Check Azure Logs

- Navigate to **Azure Monitor** and access the **Logs** section.
- Review the ARM logs for any error messages related to the custom table creation process.

### 3. Reattempt Table Creation

- Retry the table creation process using the Azure portal or Azure CLI.
- If the error persists, consider using a different browser or clearing the browser cache.

### 4. Collect Diagnostic Information

- Gather HAR files and console logs to identify any frontend issues.
- Use the Azure portal to capture network activity during the table creation attempt.

### 5. Consult Azure Documentation

- Refer to the [Azure Custom Tables Documentation](https://learn.microsoft.com/azure/monitoring-and-diagnostics/monitoring-custom-tables) for detailed guidance on creating custom tables.

### Common Issues and Solutions

- **Temporary Glitches**: Often, errors may be temporary. Reattempting the process after a short interval can resolve the issue.
- **Configuration Errors**: Ensure all configurations and permissions are correctly set in Azure.

## Reference

- [Azure Monitor Overview](https://learn.microsoft.com/azure/azure-monitor/overview)
- [Troubleshooting Azure Issues](https://learn.microsoft.com/azure/azure-supportability/troubleshooting-azure-issues)

If the issue persists after following the solution steps, please open a support case for further assistance.
