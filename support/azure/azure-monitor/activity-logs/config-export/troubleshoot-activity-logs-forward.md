---
title: Troubleshoot forwarding Azure activity logs to diagnostic settings
description: Learn why Azure activity logs stop forwarding and scripts fail after moving to diagnostic settings. Use this article to fix the problem.
ms.date: 10/30/2026
ms.author: kaushika
ms.editor: v-gsitser
ms.reviewer: v-ryanberg 
ms.service: azure-monitor
ms.custom: I can't configure export of Activity Logs
---

# Troubleshoot forwarding Azure activity logs to diagnostic settings

## Summary

This article addresses the transition from legacy solutions to diagnostic settings in order to forward Azure activity logs. You might encounter problems when you configure these settings, especially if automation relies on outdated APIs. This guide provides steps to identify and resolve these problems.

### Common problems and solutions

- **Problem**: Logs don't forward after configuration.
- **Solution**: Double-check the diagnostic settings, and make sure that all parameters are correct.

- **Problem 2**: Automation scripts fail after the transition.
- **Solution 2**: Update scripts to align with the new diagnostic settings API.

### Verify existing Diagnostic Settings

Before you change any configuration, check whether the subscription already forwards activity logs through a diagnostic setting, and make sure that no legacy log profile is still configured. This check helps you find the cause of missing logs, avoid duplicate forwarding, and confirm that the subscription no longer depends on log profiles.

A subscription is correctly configured when both of the following conditions are true:

- At least one subscription-level diagnostic setting exists, the required activity log categories are enabled, and the setting sends data to the expected destination (Log Analytics workspace, storage account, event hub, or partner solution).
- No legacy log profile exists for the subscription.

> [!NOTE]
> You need at least the **Monitoring Reader** role on the subscription to view diagnostic settings and log profiles.

#### [Azure portal](#tab/portal)

1. In the [Azure portal](https://portal.azure.com), go to **Monitor** > **Activity log**.
1. Select **Export Activity Logs**.
1. In the **Subscription** list, select the subscription that you want to check.

    The **Diagnostic settings** page lists every diagnostic setting that's configured for the subscription, together with its destinations. If the list is empty, the subscription doesn't forward activity logs through diagnostic settings.

    :::image type="content" source="media/troubleshoot-activity-logs-forward/activity-log-diagnostic-settings-list.png" alt-text="Screenshot of the Diagnostic settings page for a subscription that lists an existing activity log diagnostic setting and its destinations." lightbox="media/troubleshoot-activity-logs-forward/activity-log-diagnostic-settings-list.png":::

1. Select **Edit setting** next to a diagnostic setting to review it. Verify that the required log categories (for example, **Administrative**, **Security**, **ServiceHealth**, **Alert**, **Recommendation**, **Policy**, **Autoscale**, and **ResourceHealth**) are selected, and that the destination details point to the expected resource.

    :::image type="content" source="media/troubleshoot-activity-logs-forward/activity-log-diagnostic-setting-details.png" alt-text="Screenshot of an activity log diagnostic setting that shows the selected log categories and the Log Analytics workspace destination." lightbox="media/troubleshoot-activity-logs-forward/activity-log-diagnostic-setting-details.png":::

1. The Azure portal doesn't provide a dedicated view to list legacy log profiles. To confirm that no log profile exists, use the commands in the **Azure CLI** or **PowerShell** tab.

#### [Azure CLI](#tab/azure-cli)

1. Sign in, and select the subscription that you want to check:

    ```azurecli
    az login
    az account set --subscription "<subscription-id>"
    ```

1. List the subscription-level diagnostic settings:

    ```azurecli
    az monitor diagnostic-settings subscription list --subscription "<subscription-id>" --output json
    ```

    If a diagnostic setting is configured, the output resembles the following example. Check the `logs` array to make sure that the required categories have `"enabled": true`, and check the `workspaceId`, `storageAccountId`, `eventHubAuthorizationRuleId`, or `marketplacePartnerId` values for the destination.

    ```output
    [
      {
        "eventHubAuthorizationRuleId": null,
        "eventHubName": null,
        "id": "/subscriptions/<subscription-id>/providers/microsoft.insights/diagnosticSettings/forward-activity-logs",
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
        "name": "forward-activity-logs",
        "storageAccountId": null,
        "workspaceId": "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.OperationalInsights/workspaces/<workspace-name>"
      }
    ]
    ```

    An empty result (`[]`) means that no diagnostic setting forwards activity logs for the subscription.

1. To view a single diagnostic setting, run the following command:

    ```azurecli
    az monitor diagnostic-settings subscription show --name "<setting-name>" --subscription "<subscription-id>"
    ```

1. Check for legacy log profiles:

    ```azurecli
    az monitor log-profiles list --output table
    ```

    If no log profile exists, the command returns no rows. If a log profile is returned, make sure that a diagnostic setting covers the same categories and destination, and then delete the log profile:

    ```azurecli
    az monitor log-profiles delete --name "<log-profile-name>"
    ```

#### [PowerShell](#tab/powershell)

1. Install or update the [Az PowerShell module](/powershell/azure/install-azure-powershell), sign in, and then select the subscription that you want to check:

    ```powershell
    Connect-AzAccount
    Set-AzContext -Subscription "<subscription-id>"
    ```

1. List the subscription-level diagnostic settings:

    ```powershell
    Get-AzSubscriptionDiagnosticSetting -SubscriptionId "<subscription-id>"
    ```

1. To review the enabled categories and the destination of each setting, run the following commands:

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
    Name              : forward-activity-logs
    WorkspaceId       : /subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.OperationalInsights/workspaces/<workspace-name>
    StorageAccountId  :
    EventHubRuleId    :
    EnabledCategories : Administrative, Security, ServiceHealth, Alert, Recommendation, Policy, Autoscale, ResourceHealth
    ```

    If the command returns nothing, no diagnostic setting forwards activity logs for the subscription.

1. Check for legacy log profiles:

    ```powershell
    Get-AzLogProfile
    ```

    If no log profile exists, the command returns nothing. If a log profile is returned, make sure that a diagnostic setting covers the same categories and destination, and then delete the log profile:

    ```powershell
    Remove-AzLogProfile -Name "<log-profile-name>"
    ```

---

If the subscription has a diagnostic setting that meets your requirements and no legacy log profile exists, but logs still don't arrive at the destination, continue with the steps in the next section.

### Resolve configuration problems

To resolve configuration problems, follow these steps.

1. **Identify legacy API usage**
    
    1. Run the `Get-AzLogProfile` command.
    1. Check for any existing log profiles in your Azure subscriptions. If you find a log profile that's named **default** that isn't enabled, the profile isn't in use. For more information, see [Verify existing Diagnostic Settings](#verify-existing-diagnostic-settings).

1. **Update automation scripts**

   1. Review any automation scripts or tools that interact with Azure activity logs.
   1. Make sure that the scripts or tools are updated to use the new diagnostic settings instead of legacy APIs.

1. **Configure diagnostic settings**
   
   1. In the [Azure portal](https://portal.azure.com), go to **Activity Logs**.
   1. Select **Diagnostic settings**, and configure the necessary parameters to forward logs as required.

1. **Verify configuration**

   1. After you update the settings, repeat the checks in [Verify existing Diagnostic Settings](#verify-existing-diagnostic-settings) to confirm that the diagnostic setting is present and no legacy log profile remains.
   1. Monitor the logs to make sure that they're forwarded correctly.
   1. Use Azure Monitor charts to visualize log data and verify successful configuration.

### References

- [Azure Monitor Documentation](/azure/azure-monitor/)
- [Azure Activity Logs Overview](/azure/azure-monitor/platform/activity-logs-overview)
- [Configure Diagnostic Settings](/azure/azure-monitor/platform/diagnostic-settings)
