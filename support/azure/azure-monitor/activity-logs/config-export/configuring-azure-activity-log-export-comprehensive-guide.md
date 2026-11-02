---
title: Configuring Azure Activity Log Export
description: Provides guidance for resolving issues related to configuring the export of Azure activity logs
ms.date: 10/30/2026
author: kaushika-msft
ms.author: kaushika
ms.reviewer: v-gsitser, v-ryanberg, neghuman, vikamala
ms.service: azure-monitor
ms.custom: I can’t configure export of activity logs
---

# Configure Azure activity log export

This article outlines the steps to successfully configure Azure activity log export. This article also provides solutions to common issues that you might experience, especially if you're transitioning from older methods.

## Verify existing Diagnostic Settings

Before you create or change an export, check whether the subscription already exports activity logs through a diagnostic setting, and make sure that no legacy log profile is still configured. This check helps you avoid duplicate exports (and duplicate ingestion charges) and confirms that the subscription doesn't depend on log profiles, which are being retired.

A subscription is correctly configured when both of the following conditions are true:

- At least one subscription-level diagnostic setting exists, the required activity log categories are enabled, and the setting sends data to the expected destination (Log Analytics workspace, storage account, event hub, or partner solution).
- No legacy log profile exists for the subscription.

> [!NOTE]
> You need at least the **Monitoring Reader** role on the subscription to view diagnostic settings and log profiles.

The Azure portal doesn't provide a dedicated view to list legacy log profiles. To confirm that no log profile exists, use the commands in the **Azure CLI** or **PowerShell** tab.

### [Azure CLI](#tab/azure-cli)

1. Sign in, and select the subscription that you want to check:

    ```azurecli
    az login
    az account set --subscription "<subscription-id>"
    ```

2. List the subscription-level diagnostic settings:

    ```azurecli
    az monitor diagnostic-settings subscription list --subscription "<subscription-id>" --output json
    ```

    If a diagnostic setting is configured, the output resembles the following example. Check the `logs` array to make sure that the required categories have `"enabled": true`, and check the `workspaceId`, `storageAccountId`, `eventHubAuthorizationRuleId`, or `marketplacePartnerId` values for the destination.

    ```output
    [
      {
        "eventHubAuthorizationRuleId": null,
        "eventHubName": null,
        "id": "/subscriptions/<subscription-id>/providers/microsoft.insights/diagnosticSettings/export-activity-logs",
        "logs": [
          { "category": "Administrative", "enabled": true },
          { "category": "Security", "enabled": true },
          { "category": "ServiceHealth", "enabled": true },
          { "category": "Alert", "enabled": true },
          { "category": "Recommendation", "enabled": true },
          { "category": "Policy", "enabled": true },
          { "category": "Autoscale", "enabled": true },
          { "category": "ResourceHealth", "enabled": true }
        ],
        "name": "export-activity-logs",
        "storageAccountId": null,
        "workspaceId": "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.OperationalInsights/workspaces/<workspace-name>"
      }
    ]
    ```

    An empty result (`[]`) means that no diagnostic setting exports activity logs for the subscription.

3. To view a single diagnostic setting, run the following command:

    ```azurecli
    az monitor diagnostic-settings subscription show --name "<setting-name>" --subscription "<subscription-id>"
    ```

4. Check for legacy log profiles:

    ```azurecli
    az monitor log-profiles list --output table
    ```

    If no log profile exists, the command returns no rows. If a log profile is returned, migrate to diagnostic settings, and then delete the log profile:

    ```azurecli
    az monitor log-profiles delete --name "<log-profile-name>"
    ```

### [PowerShell](#tab/powershell)

1. Install or update the [Az PowerShell module](/powershell/azure/install-azure-powershell), sign in, and then select the subscription that you want to check:

    ```powershell
    Connect-AzAccount
    Set-AzContext -Subscription "<subscription-id>"
    ```

2. List the subscription-level diagnostic settings:

    ```powershell
    Get-AzSubscriptionDiagnosticSetting -SubscriptionId "<subscription-id>"
    ```

3. To review the enabled categories and the destination of each setting, run the following commands:

    ```powershell
    $settings = Get-AzSubscriptionDiagnosticSetting -SubscriptionId "<subscription-id>"

    foreach ($setting in $settings) {
        [PSCustomObject]@{
            Name              = $setting.Name
            WorkspaceId       = $setting.WorkspaceId
            StorageAccountId  = $setting.StorageAccountId
            EventHubRuleId    = $setting.EventHubAuthorizationRuleId
            EnabledCategories = ($setting.Log | Where-Object Enabled | Select-Object -ExpandProperty Category) -join ', '
        }
    }
    ```

    The output resembles the following example:

    ```output
    Name              : export-activity-logs
    WorkspaceId       : /subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.OperationalInsights/workspaces/<workspace-name>
    StorageAccountId  :
    EventHubRuleId    :
    EnabledCategories : Administrative, Security, ServiceHealth, Alert, Recommendation, Policy, Autoscale, ResourceHealth
    ```

    If the command returns nothing, no diagnostic setting exports activity logs for the subscription.

4. Check for legacy log profiles:

    ```powershell
    Get-AzLogProfile
    ```

    If no log profile exists, the command returns nothing. If a log profile is returned, migrate to diagnostic settings, and then delete the log profile:

    ```powershell
    Remove-AzLogProfile -Name "<log-profile-name>"
    ```

---

If the subscription already has a diagnostic setting that meets your requirements and no legacy log profile exists, you don't have to create another export. Otherwise, follow the steps in the next section.

## Configuring activity log export

To configure Azure activity log export, follow these steps.

### Step 1: Verify current configuration

1. Check the existing diagnostic settings and legacy log profiles for the subscription. For more information, see [Verify existing Diagnostic Settings](#verify-existing-diagnostic-settings).
2. Make sure that the current export settings align with your requirements.

### Step 2: Update legacy methods

1. If you're using legacy APIs, PowerShell commands, or [log profiles](/answers/questions/1851179/what-will-happen-to-the-azure-activity-logs-soluti), update them to use diagnostic settings.
2. Use the `Get-AzOperationalInsightsDataSource` command to verify existing data sources.

### Step 3: Configure new export settings

1. Select **Activity log** > **Export Activity Logs**.
2. Find and select the subscription, and then select **Add diagnostic setting**.
3. In the **Diagnostic setting name** box, enter a name.
4. Select all applicable categories and then select **Save**.

> [!NOTE]
> It usually takes about 30 minutes for the export to begin. For more information, see [Time before telemetry gets to destination](/azure/azure-monitor/platform/diagnostic-settings?tabs=portal#time-before-telemetry-gets-to-destination).

## Common issues and solutions

- **Issue**: Logs aren't appearing in configured destinations.
- **Solution**: See the following guidance for log analytics, event hubs, and storage accounts.

### For log analytics

1. Navigate to **Log Analytics workspaces**.
2. Select the workspace and then run the following query:

```powershell
AzureActivity
| summarize count() by bin(TimeGenerated,1d)
```

This should determine the number of logs per day that are being ingested into this workspace.

### For event hubs

1. Navigate to **Event Hubs**.
2. Select the event hub and then select **Data Explorer**.
3. Verify the logs are reaching the event hub. 

If the logs aren't reaching the event hub, check for throttling using a metrics blade.

### For storage accounts

1. Navigate to **Storage center | Storage accounts (Blobs)**.
2. Locate and select the **insights-activity-logs** container.

The logs should be visible.

## Frequently asked questions

**Q1: Why don't the logs appear in the destination?**

**A1:** Make sure that the network is well connected, and verify the permissions for Log Analytics workspace.

**Q2: Why do errors appear in the PowerShell commands?**

**A2:** Make sure that you're using the latest Azure PowerShell module.

## References

- [Azure Monitor documentation](/azure/azure-monitor/fundamentals/overview)
- [Azure activity logs overview](/azure/azure-monitor/fundamentals/data-sources)
- [Configure diagnostic settings](/azure/azure-monitor/platform/diagnostic-settings?tabs=portal)