---
title: Troubleshoot Export of Activity Logs across Azure Subscriptions
description: Troubleshooting guide for issues with exporting activity logs across Azure subscriptions.
ms.date: 07/17/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Troubleshoot Export of Activity Logs across Azure Subscriptions

When attempting to export activity logs from one Azure subscription to another, users may encounter permission-related issues that prevent successful log transfer. This guide provides steps to troubleshoot and resolve these issues, ensuring seamless log export between subscriptions.

## Common Issues and Solutions

- **Permission Configuration**: Ensure that the shared access policy for the Event Hub namespace includes **Manage**, **Send**, and **Listen** permissions. These permissions are crucial for streaming logs to Event Hubs.
- **Diagnostic Settings**: Verify that the diagnostic settings are correctly configured to use the appropriate Event Hub policy name. Navigate to the diagnostic settings, note the Event Hub policy name, and check the permissions in the Event Hub namespace.
- **Role Assignment**: Confirm that the Azure system-assigned managed identity has the necessary role assignments. Use the Azure CLI to list role assignments and verify that the **Azure Event Hubs Data Sender** role is assigned.

### Step-by-Step Instructions to Resolve Export Issues

1. **Verify Shared Access Policy Permissions**:
   - Open the diagnostic settings in Azure.
   - Note the Event Hub policy name used.
   - Navigate to the Event Hub namespace and open the **Shared Access Policy** tab.
   - Ensure that **Manage**, **Send**, and **Listen** permissions are checked.

2. **Check Role Assignments**:
   - Go to **Access Control (IAM)** on the Event Hub namespace or resource group.
   - Look for any Microsoft Insights or Azure Monitor-related identities with the **Azure Event Hubs Data Sender** role.
   - Run the following command in Azure CLI to list role assignments:

    ```bash
     az role assignment list --scope <EventHubNamespaceResourceID> --output table
     ```

3. **Verify Data Ingestion**:
   - Ensure that data is being ingested into the Event Hub as expected.
   - If issues persist, consider scheduling a remote session for further investigation.

## Reference

- [Authorize access to Azure Event Hubs](https://learn.microsoft.com/azure/event-hubs/authorize-access)
- [Diagnostic settings in Azure](https://learn.microsoft.com/azure/azure-monitor/essentials/diagnostic-settings)
- [Azure CLI Documentation](https://learn.microsoft.com/cli/azure)
