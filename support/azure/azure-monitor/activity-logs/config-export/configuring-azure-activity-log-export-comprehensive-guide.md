---
title: Configure Azure activity log export
description: Learn how to configure Azure activity log export and resolve common issues. Verify settings, replace legacy log profiles, and start exporting logs.
ms.date: 11/02/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: neghuman, vikamala, tcsougan
ms.service: azure-monitor
ms.custom: I can't configure export of activity logs
ai-usage: ai-assisted
---

# Configure Azure activity log export

This article explains how to configure Azure activity log export so that you can send activity logs to a Log Analytics workspace, event hub, or storage account. It also provides solutions to common issues, especially if you're transitioning from legacy log profiles.

## Configuring activity log export

To configure Azure activity log export, follow these steps.

### Step 1: Verify the current activity log export configuration

1. Go to the [Azure portal](https://portal.azure.com), and then access the **Activity Logs** section.
1. Check the current export settings to make sure that they align with your requirements.

#### Check diagnostic settings and legacy log profiles

You can also use Azure CLI or Azure PowerShell to list the active diagnostic settings for a subscription and to identify any legacy log profiles that still exist. Legacy log profiles don't appear in the Azure portal.

#### Azure CLI

1. List the active activity log diagnostic settings for the subscription.

   ```azurecli
   az monitor diagnostic-settings subscription list \
       --subscription <subscription-id> \
       --query "[].{Name:name, Workspace:workspaceId, StorageAccount:storageAccountId, EventHub:eventHubAuthorizationRuleId}" \
       --output table
   ```

   Example output:

   ```output
   Name                         Workspace                                                                                                                StorageAccount    EventHub
   ---------------------------  -----------------------------------------------------------------------------------------------------------------------  ----------------  ----------
   activity-logs-diag-settings  /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/contoso-rg/providers/Microsoft.OperationalInsights/workspaces/contoso-law
   ```

   If the command returns no rows, no diagnostic settings are configured for activity logs in this subscription.

1. Identify legacy log profiles.

   ```azurecli
   az monitor log-profiles list \
       --query "[].{Name:name, StorageAccount:storageAccountId, ServiceBusRule:serviceBusRuleId}" \
       --output table
   ```

   The following is an example output when a legacy log profile exists.

   ```output
   Name     StorageAccount                                                                                                       ServiceBusRule
   -------  -------------------------------------------------------------------------------------------------------------------  ----------------
   default  /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/contoso-rg/providers/Microsoft.Storage/storageAccounts/contosologs
   ```

   If the command returns no rows, no legacy log profiles exist.

#### Azure PowerShell

1. Select the subscription to check.

   ```powershell
   Set-AzContext -Subscription "<subscription-id>"
   ```

1. List the active activity log diagnostic settings for the subscription.

   ```powershell
   Get-AzSubscriptionDiagnosticSetting |
       Select-Object Name, WorkspaceId, StorageAccountId, EventHubAuthorizationRuleId |
       Format-List
   ```

   The following is an example output.

   ```output
   Name                        : activity-logs-diag-settings
   WorkspaceId                 : /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/contoso-rg/providers/Microsoft.OperationalInsights/workspaces/contoso-law
   StorageAccountId            :
   EventHubAuthorizationRuleId :
   ```

1. To see which log categories a setting collects, run the following command.

   ```powershell
   (Get-AzSubscriptionDiagnosticSetting -Name "activity-logs-diag-settings").Log |
       Select-Object Category, Enabled
   ```

   The following is an example output.

   ```output
   Category       Enabled
   --------       -------
   Administrative    True
   Security          True
   ServiceHealth     True
   Alert             True
   Recommendation    True
   Policy            True
   Autoscale         True
   ResourceHealth    True
   ```

1. Identify legacy log profiles.

   ```powershell
   Get-AzLogProfile | Select-Object Name, StorageAccountId, ServiceBusRuleId, Locations | Format-List
   ```

   The following is an example output when a legacy log profile exists.

   ```output
   Name             : default
   StorageAccountId : /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/contoso-rg/providers/Microsoft.Storage/storageAccounts/contosologs
   ServiceBusRuleId :
   Locations        : {global, eastus, westus}
   ```

   If the command returns nothing, no legacy log profiles exist.

> [!IMPORTANT]
> If you find a legacy log profile, create an equivalent diagnostic setting first, and then remove the log profile by running `Remove-AzLogProfile -Name "default"` or `az monitor log-profiles delete --name default`. If both are active and send data to the same destination, you might see duplicate data.

### Step 2: Update legacy methods to diagnostic settings

Follow these steps:

1. If you're using legacy APIs, PowerShell commands, or [log profiles](/answers/questions/1851179/what-will-happen-to-the-azure-activity-logs-soluti), update them to use diagnostic settings.
1. Use the `Get-AzOperationalInsightsDataSource` command to verify existing data sources.

### Step 3: Configure new diagnostic settings for activity log export

Follow these steps.

1. Select **Activity log** > **Export Activity Logs**.
1. Find and select the subscription, and then select **Add diagnostic setting**.
1. In the **Diagnostic setting name** box, enter a name.
1. Select all applicable categories and then select **Save**.

> [!NOTE]
> It usually takes about 30 minutes for the export to begin. For more information, see [Time before telemetry gets to destination](/azure/azure-monitor/platform/diagnostic-settings?tabs=portal#time-before-telemetry-gets-to-destination).

## Common issues and solutions

The following are common issues and their solutions.

- **Issue** - Logs aren't appearing in configured destinations.
- **Solution** - See the following guidance for log analytics, event hubs, and storage accounts.

### Verify logs in a Log Analytics workspace

1. Navigate to **Log Analytics workspaces**.
1. Select the workspace and run the following query.

```powershell
AzureActivity
| summarize count() by bin(TimeGenerated,1d)
```

This query returns the number of logs per day that are ingested into this workspace.

### Verify logs in an event hub

Follow these steps:

1. Go to **Event Hubs**.
1. Select the event hub, and then select **Data Explorer**.
1. Verify the logs reach the event hub. 

If the logs don't reach the event hub, check for throttling by using a metrics blade.

### Verify logs in a storage account

Follow these steps:

1. Go to **Storage center | Storage accounts (Blobs)**.
1. Locate and select the **insights-activity-logs** container.

You should see the logs.

## Frequently asked questions

**Q1 - Why don't the logs appear in the destination?**

**A1** - Ensure the network is connected, and verify the permissions for the Log Analytics workspace.

**Q2 - Why do errors appear in the PowerShell commands?**

**A2** - Ensure you're using the latest Azure PowerShell module.

## References

- [Azure Monitor documentation](/azure/azure-monitor/fundamentals/overview)
- [Azure activity logs overview](/azure/azure-monitor/fundamentals/data-sources)
- [Configure diagnostic settings](/azure/azure-monitor/platform/diagnostic-settings?tabs=portal)
  