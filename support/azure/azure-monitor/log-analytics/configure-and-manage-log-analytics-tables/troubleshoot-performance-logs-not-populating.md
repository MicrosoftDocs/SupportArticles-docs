---
title: Troubleshoot Performance Logs Not Populating in Azure Government
description: Troubleshooting guide for performance logs not populating in Azure Government.
ms.date: 07/16/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: Configure and Manage Log analytics tables
---

# Troubleshoot Performance Logs Not Populating in Azure Government

When setting up alerts for VM insights using Data Collection Rules (DCR) in Azure Government, users may encounter issues where performance logs fail to populate. This problem typically arises when creating alerts through DCR, as opposed to executing queries directly in the Log Analytics workspace.

## Common Issues and Solutions

- **Issue**: Alerts fail to populate performance logs when using DCR.
- **Root Cause**: The custom KQL query is executed against the DCR, which lacks access to necessary data tables. The scope defaults to DCR, preventing data retrieval.
- **Solution**: Set the alert scope to the Log Analytics workspace associated with the DCR.

### Step-by-Step Instructions to Resolve Performance Log Issues

1. **Access Azure Monitor**:
   - Navigate to the Azure portal and select **Azure Monitor** from the services list.

2. **Create or Edit an Alert**:
   - Go to **Alerts** and choose to create a new alert rule or edit an existing one.

3. **Set the Correct Scope**:
   - In the alert rule configuration, ensure the **Scope** is set to the Log Analytics workspace, not the DCR. This allows the query to access the necessary data tables.

4. **Verify Query Execution**:
   - Test the query directly in the Log Analytics workspace to ensure it runs successfully without errors.

5. **Save and Test the Alert**:
   - Save the alert configuration and test it to confirm that performance logs are now populating correctly.

## Reference

- [Azure Monitor Documentation](https://learn.microsoft.com/azure/azure-monitor/)
- [Log Analytics Workspace Overview](https://learn.microsoft.com/azure/azure-monitor/logs/log-analytics-workspace-overview)
- [Creating and Managing Alerts in Azure](https://learn.microsoft.com/azure/azure-monitor/alerts/alerts-overview)

If the issue persists after following the solution steps, please open a support case for further assistance.
