---
title: Troubleshoot Permission Errors in Activity Log Configuration
description: Troubleshooting guide for permission errors in Activity Log configuration.
ms.date: 07/17/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Troubleshoot Permission Errors in Activity Log Configuration

When configuring the Azure Activity Log to export to Log Analytics, users may encounter permission errors. This issue typically arises due to insufficient permissions assigned to the custom role. Understanding the root cause and applying the correct permissions can resolve this problem efficiently.

## Common Issues and Solutions

- **Authorization Failed**: This error indicates that the user does not have the necessary permissions to perform the action. Verify that the correct permissions are assigned and that the scope is set correctly.

### Step-by-Step Instructions to Resolve Permission Errors

1. **Verify Role Assignments**:
   - Navigate to **Azure Portal**.
   - Go to **Subscriptions** and select the relevant subscription.
   - Click on **Access Control (IAM)** and then **Role assignments**.
   - Ensure that the custom role is assigned to the account responsible for creating the diagnostic settings.

2. **Assign Necessary Permissions**:
   - Duplicate the **Log Analytics Contributor** role.
   - Remove any unnecessary permissions.
   - Ensure the **Microsoft.Insights/diagnosticSettings/write** permission is included.

3. **Set Scope Appropriately**:
   - Ensure the scope is set to the **subscription level** rather than the resource group level.

4. **Update Credentials**:
   - If access was recently granted, update the credentials to reflect the changes.

## Reference

- [Azure Analysis Services Overview](https://learn.microsoft.com/analysis-services/azure-analysis-services/analysis-services-overview?view=asallproducts-allversions)
- [Log Analytics Contributor Role](https://learn.microsoft.com/azure/role-based-access-control/built-in-roles/analytics#log-analytics-contributor)
- [Azure Monitor Activity Log](https://learn.microsoft.com/azure/azure-monitor/platform/activity-log?tabs=powershell)

If the issue persists after following the solution steps, please open a support case for further assistance.
