---
title: Troubleshoot Custom Table Creation Errors in Azure
description: Troubleshooting guide for custom table creation errors in Azure.
ms.date: 09/30/2025
author: JarrettRenshaw
ms.author: jarrettr
ms.reviewer: v-gsitser, v-ryanberg, neghuman, vikamala
ms.service: azure-monitor
ms.custom: Configure and Manage Log analytics tables
---

# Troubleshoot custom table creation errors in Azure

Users might receive an error message that indicates that properties of undefined data can't be read when they try to create a custom table in Microsoft Azure. This issue can occur because of temporary glitches or misconfigurations. This article helps you determine the root cause of the errors and troubleshoot this issue efficiently.

## Common issues and solutions

- **Temporary Glitches**: Often, errors are temporary. You might be able to resolve the issue by trying the process again after a short time.
- **Configuration Errors**: Make sure that all configurations and permissions are correctly set in Azure.

### Instructions to resolve custom table creation errors

1. Verify JSON file validity:
   1. Make sure that the JSON file that's used for table creation is correctly formatted and contains all the required fields.
   1. Use tools such as *JSONLint* to validate the JSON structure.

2. Check the Azure logs:
   1. Navigate to **Azure Monitor**, and access the **Logs** section.
   1. Review the ARM logs for any error messages that are related to the custom table creation process.

3. Try again to create tables:
   1. Run the table creation process again by using the Azure portal or Azure CLI.
   1. If the error persists, consider using a different browser or clearing the browser cache.

4. Collect diagnostic information:
   1. Gather HAR files and console logs to identify any front-end issues.
   1. Use the Azure portal to capture network activity during the table creation process.

5. Consult Azure documentation: For detailed guidance on custom tables, see [Manage tables in a Log Analytics workspace](/azure/azure-monitor/logs/manage-logs-tables?tabs=azure-portal).

## References

- [Azure Monitor Overview](/azure/azure-monitor/fundamentals/overview)
- [Create an Azure support request](/azure/azure-portal/supportability/how-to-create-azure-support-request)

[!INCLUDE [azure-help-support](~/includes/azure-help-support.md)]