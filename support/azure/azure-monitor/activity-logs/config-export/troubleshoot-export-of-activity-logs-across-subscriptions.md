---
title: Troubleshoot Export of Activity Logs across Azure Subscriptions
description: Troubleshooting guide for resolving issues that affect exporting activity logs across Azure subscriptions.
ms.date: 07/23/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Troubleshoot the export of activity logs across Azure subscriptions

Users might experience permission-related issues that prevent successful log transfer when they try to export activity logs from one Microsoft Azure subscription to another. This guide provides troubleshooting steps to resolve these issues and successfully export logs between subscriptions.

## Common issues and solutions

- **Permission Configuration**: Make sure that the shared access policy for the event hub namespace includes **Manage**, **Send**, and **Listen** permissions. These permissions are crucial for streaming logs to Event Hubs.
- **Diagnostic Settings**: Verify that the diagnostic settings are correctly configured to use the appropriate event hubs policy name. Navigate to the diagnostic settings, note the event hub policy name, and check the permissions in the event hub namespace.
- **Role Assignment**: Verify that the Azure system-assigned managed identity has the necessary role assignments. Use the Azure CLI to list role assignments and verify that the **Azure Event Hubs Data Sender** role is assigned.

### Instructions to resolve export issues

1. Verify shared access policy permissions:
   1. Open the diagnostic settings in Azure.
   1. Note the event hub policy name that's used.
   1. Navigate to the event hub namespace and open the **Shared Access Policy** tab.
   1. Make sure that the **Manage**, **Send**, and **Listen** permissions are selected.

2. Check the role assignments:
   1. Go to **Access Control (IAM)** on the event hub namespace or resource group.
   1. Look for any Microsoft Insights or Azure Monitor-related identities that have the **Azure Event Hubs Data Sender** role.
   1. To list role assignments, run the following command in Azure CLI:

    ```bash
     az role assignment list --scope <EventHubNamespaceResourceID> --output table
     ```

3. Verify data ingestion:
   1. Make sure that data is being ingested into the event hub as expected.
   1. If the issue persists, consider scheduling a remote session for further investigation.

## References

- [Authorize access to Azure Event Hubs](/azure/event-hubs/authorize-access-event-hubs)
- [Diagnostic settings in Azure](/azure/azure-monitor/essentials/diagnostic-settings)
- [Azure CLI Documentation](/cli/azure)

If the issue persists after you follow these steps, open a support case for further assistance.