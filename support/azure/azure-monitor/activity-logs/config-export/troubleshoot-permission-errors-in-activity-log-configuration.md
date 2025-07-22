---
title: Troubleshoot Permission Errors in Activity Log Configuration
description: Troubleshooting guide for permission errors in Activity Log configuration.
ms.date: 07/22/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Troubleshoot permission errors in Activity Log configuration

Users might experience permission errors when they configure the Azure Activity Log to export to Log Analytics. This issue typically occurs because insufficient permissions are assigned to the custom role. This article helps you determine the root cause of the errors and apply the correct permissions to resolve the issue efficiently.

## Common issues and solutions

- **Authorization Failed**: This error indicates that the user doesn't have the necessary permissions to perform the action. Verify that the correct permissions are assigned and that the scope is set correctly.

### Instructions to resolve permission errors

1. Verify the role assignments:
   1. Navigate to the Azure portal.
   1. Go to **Subscriptions** and select the relevant subscription.
   1. Select **Access Control (IAM)** > **Role assignments**.
   1. Make sure that the custom role is assigned to the account that's responsible for creating the diagnostic settings.

2. Assign the necessary permissions:
   1. Duplicate the **Log Analytics Contributor** role.
   1. Remove any unnecessary permissions.
   1. Make sure that the **Microsoft.Insights/diagnosticSettings/write** permission is included.

3. Make sure that the scope is set appropriately to the **subscription level** instead of the resource group level.

4. If access was recently granted, update the credentials to reflect the changes.

## References

- [Azure Analysis Services Overview](/analysis-services/azure-analysis-services/analysis-services-overview?view=asallproducts-allversions&preserve-view=true)
- [Log Analytics Contributor Role](/azure/role-based-access-control/built-in-roles/analytics#log-analytics-contributor)
- [Azure Monitor Activity Log](/azure/azure-monitor/platform/activity-log?tabs=powershell)

If the issue persists after you follow these steps, open a support case for further assistance.
