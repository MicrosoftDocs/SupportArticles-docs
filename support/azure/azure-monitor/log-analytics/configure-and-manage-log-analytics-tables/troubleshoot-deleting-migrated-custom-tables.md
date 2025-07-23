---
title: Troubleshoot Deleting Migrated Custom Tables in Log Analytics
description: Step-by-step guide on how to resolve issues with deleting migrated custom tables in Log Analytics.
ms.date: 07/23/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: Configure and Manage Log analytics tables
---

# Troubleshoot Deleting Migrated Custom Tables in Log Analytics

When attempting to delete a custom log table in Log Analytics, users may encounter issues due to the table being migrated. This guide provides a solution to effectively resolve this problem.

## Common Issues and Solutions

- **API Access Issues**: Ensure you have the necessary permissions to use the API.
- **Table Not Found**: Confirm the correct table name and workspace details.

### Solution: Use Azure Log Analytics API

To delete a migrated custom table, follow these steps using the Azure Log Analytics API:

1. **Access Azure Portal**: Navigate to the [Azure portal](https://portal.azure.com) and login to your Azure account.
2. **Locate Log Analytics Workspace**: Access the **Log Analytics workspaces** section and select the workspace containing the table you wish to delete.
3. **Use API for Deletion**: Use the **Tables - Delete** API to remove the table. Refer to the link in the [reference section](#reference) for detailed instructions.
4. **Verify Deletion**: After executing the API call, confirm that the table has been successfully deleted by checking the workspace.

## Reference

- [Azure Log Analytics API Documentation](/rest/api/loganalytics/)

If the issue persists after following the solution steps, please open a support case for further assistance.
