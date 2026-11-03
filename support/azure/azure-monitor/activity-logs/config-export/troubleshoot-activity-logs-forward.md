---
title: Troubleshoot forwarding Azure activity logs to diagnostic settings
description: Learn why Azure activity logs stop forwarding and scripts fail after you move to diagnostic settings. Follow these steps to fix the problem.
ms.date: 11/02/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: neghuman, vikamala, tcsougan
ms.service: azure-monitor
ms.custom: I can't configure export of Activity Logs
ai-usage: ai-assisted
---

# Troubleshoot forwarding Azure activity logs to diagnostic settings

## Summary

This article helps you troubleshoot Azure activity log forwarding problems after you move from legacy solutions to diagnostic settings. You might encounter problems when you configure these settings, especially if automation relies on outdated APIs. Use the steps in this article to identify and resolve these problems.

## Common problems and solutions

The following are common problems you might encounter when forwarding Azure activity logs to diagnostic settings, along with their solutions:

- **Problem** - Logs don't forward after configuration.
- **Solution** - Double-check the diagnostic settings, and ensure that all parameters are correct.

- **Problem** - Automation scripts fail after the transition.
- **Solution** - Update scripts to align with the new diagnostic settings API.

## Resolve activity log forwarding configuration problems

To resolve configuration problems, follow these steps.

1. **Identify legacy API usage**
    
    1. Run the `Get-AzLogProfile` command.
    1. Check for any existing log profiles in your Azure subscriptions. If you find a log profile named **default** that isn't enabled, the profile isn't in use.

1. **Update automation scripts**

   1. Review any automation scripts or tools that interact with Azure activity logs.
   1. Make sure that the scripts or tools are updated to use the new diagnostic settings instead of legacy APIs.

1. **Configure diagnostic settings**
   
   1. In the [Azure portal](https://portal.azure.com), go to **Activity Logs**.
   1. Select **Diagnostic settings**, and configure the necessary parameters to forward logs as required.

1. **Verify configuration**

   1. After you update the settings, monitor the logs to make sure that they're forwarded correctly.
   1. Use Azure Monitor charts to visualize log data and verify successful configuration.
   1. Confirm that the diagnostic settings exist and that no legacy log profiles remain. For more information, see [Verify existing diagnostic settings](#verify-existing-diagnostic-settings).

## Verify existing diagnostic settings

Before you create or change any configuration, verify whether activity log diagnostic settings are already configured for the subscription and whether legacy log profiles still exist. A subscription can have up to five diagnostic settings. Activity log export should rely on diagnostic settings only, not on legacy log profiles.

### Use the Azure portal

Follow these steps to verify existing diagnostic settings in the Azure portal:

1. In the [Azure portal](https://portal.azure.com), search for and select **Activity log**.
1. Select **Export Activity Logs** to open the **Diagnostic settings** page.
1. In the **Subscription** list, select the subscription that you want to check.
1. Review the **Diagnostic settings** list. Each existing setting shows its name and its destinations (storage account, event hub, Log Analytics workspace, or partner solution).

   :::image type="content" source="media/troubleshoot-activity-logs-forward/activity-log-diagnostic-settings-list.png" alt-text="Screenshot of the Diagnostic settings page showing an activity log diagnostic setting that sends logs to a Log Analytics workspace." lightbox="media/troubleshoot-activity-logs-forward/activity-log-diagnostic-settings-list.png" border="true":::

1. Select **Edit setting** for a setting to confirm which log categories are selected and which destination receives them.

   :::image type="content" source="media/troubleshoot-activity-logs-forward/activity-log-diagnostic-setting-details.png" alt-text="Screenshot of an activity log diagnostic setting showing selected log categories and the Log Analytics workspace destination." lightbox="media/troubleshoot-activity-logs-forward/activity-log-diagnostic-setting-details.png" border="true":::

> [!NOTE]
> The Azure portal doesn't show legacy log profiles. To check for log profiles, use Azure CLI or Azure PowerShell.

### Use Azure CLI

Follow these steps to verify existing diagnostic settings by using Azure CLI:

1. List the activity log diagnostic settings for the subscription.

   ```azurecli
   az monitor diagnostic-settings subscription list --subscription <subscription-id> --output table
   ```

1. To view the categories and destinations of a specific setting, run the following command.

   ```azurecli
   az monitor diagnostic-settings subscription show --name <setting-name> --subscription <subscription-id>
   ```

   In the output, check that the required categories have `"enabled": true` and that `workspaceId`, `storageAccountId`, `eventHubAuthorizationRuleId`, or `marketplacePartnerId` points to the expected destination.

1. Check for legacy log profiles.

   ```azurecli
   az monitor log-profiles list --output table
   ```

   An empty result means that no legacy log profiles exist. If a log profile is returned (typically named `default`), remove it after you confirm that a diagnostic setting covers the same destinations.

   ```azurecli
   az monitor log-profiles delete --name default
   ```

### Use Azure PowerShell

Follow these steps to verify existing diagnostic settings by using Azure PowerShell:

1. Select the subscription to check.

   ```powershell
   Set-AzContext -Subscription "<subscription-id>"
   ```

1. List the activity log diagnostic settings for the subscription.

   ```powershell
   Get-AzSubscriptionDiagnosticSetting | Select-Object Name, WorkspaceId, StorageAccountId, EventHubAuthorizationRuleId
   ```

1. To view the categories of a specific setting, run the following command.

   ```powershell
   (Get-AzSubscriptionDiagnosticSetting -Name "<setting-name>").Log | Select-Object Category, Enabled
   ```

1. Check for legacy log profiles.

   ```powershell
   Get-AzLogProfile
   ```

   If the command returns nothing, no legacy log profiles exist. If a log profile is returned, remove it after you confirm that a diagnostic setting covers the same destinations.

   ```powershell
   Remove-AzLogProfile -Name "default"
   ```

> [!IMPORTANT]
> If both a legacy log profile and a diagnostic setting send activity logs to the same destination, you might see duplicate data. Remove the log profile after the diagnostic setting is in place.

### References

- [Azure Monitor documentation](/azure/azure-monitor/)
- [Azure activity logs overview](/azure/azure-monitor/platform/activity-logs-overview)
- [Configure diagnostic settings](/azure/azure-monitor/platform/diagnostic-settings)
