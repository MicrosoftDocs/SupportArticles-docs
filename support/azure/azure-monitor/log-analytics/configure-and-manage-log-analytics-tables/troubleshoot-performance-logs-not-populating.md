---
title: Troubleshoot Performance Logs Not Populating in Azure Government
description: Troubleshooting guide for performance logs not populating in Azure Government.
ms.date: 07/23/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: Configure and Manage Log analytics tables
---

# Troubleshoot performance logs not populating in Azure Government

Users might experience issues if performance logs don't populate in Azure Government when they set up alerts for virtual machine (VM) insights by using Data Collection Rules (DCR). This issue typically occurs when users create alerts through DCR instead of running queries directly in the Log Analytics workspace.

## Common issues and solutions

- **Issue**: Alerts don't populate performance logs when you use DCR.
- **Root Cause**: The custom KQL query is run against the DCR, but the DCR can't access to the required data tables. In this situation, the alert scope defaults to DCR. This action prevents data retrieval.
- **Solution**: Set the alert scope to the Log Analytics workspace that's associated with the DCR.

### Instructions to resolve performance log issues

1. Navigate to the Azure portal, and select **Azure Monitor** on the services list.

2. Go to **Alerts** and select the option to either create an alert rule or edit an existing rule.

3. In the alert rule configuration, make sure that the **Scope** value is set to the Log Analytics workspace, not to the DCR. This setting enables the query to access the required data tables.

4. Verify that the query runs successfully without errors by testing it directly in the Log Analytics workspace.

5. Save the alert configuration, and test it to verify that performance logs are now populating correctly.

## References

- [Azure Monitor documentation](/azure/azure-monitor/)
- [Log Analytics workspace overview](/azure/azure-monitor/logs/log-analytics-workspace-overview)
- [Create and manage alerts in Azure](/azure/azure-monitor/alerts/alerts-overview)

If the issue persists after you follow these steps, open a support case for further assistance.
