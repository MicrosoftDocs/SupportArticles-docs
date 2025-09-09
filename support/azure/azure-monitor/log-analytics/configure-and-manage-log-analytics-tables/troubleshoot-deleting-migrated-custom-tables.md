---
title: Troubleshoot Deleting Migrated Custom Tables in Log Analytics
description: Troubleshooting guide to deleting migrated custom tables in Log Analytics.
ms.date: 07/24/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: Configure and manage Log Analytics tables
---

# Troubleshoot deleting migrated custom tables in Log Analytics

Users might experience issues when they try to delete custom log tables in Log Analytics if the tables were migrated. This guide provides a solution to effectively resolve these issues.

## Common issues and solutions

- **API Access Issues**: Make sure that you have the necessary permissions to use the API.
- **Table Not Found**: Verify the correct table name and workspace details.

### Solution: Use Azure Log Analytics API

To delete a migrated custom table, follow these steps by using the Azure Log Analytics API:

1. Navigate to the [Azure portal](https://portal.azure.com), and log in to your Azure account.
2. Access the **Log Analytics workspaces** section, and select the workspace that contains the table that you want to delete.
3. Use the **Tables - Delete** API to remove the table. For detailed instructions, refer to the ["References" section](#references).
4. After you run the API call, check the workspace to verify that the table is successfully deleted.

## References

- [Azure Log Analytics API documentation](/rest/api/loganalytics/)

If the issue persists after you follow these steps, open a support case for further assistance.
