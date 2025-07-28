---
title: Diagnostic Settings Transition from Legacy Solutions
description: Provides guidance to make diagnostic settings to transition from legacy solutions.
ms.date: 07/28/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Manage diagnostic settings to transition from legacy solutions

## Resolve transition issues from legacy Azure Activity Log solutions

This article discusses the transition from legacy solutions to new diagnostic settings that you can make to forward Azure activity logs. The legacy solution will be retired on September 30, 2026. This change occurs automatically without disrupting your workflow. However, if you have automation that uses the legacy API, you must update it.

### Instructions to resolve transition issues

1. Verify the current configuration:
   1. Navigate to the Azure portal.
   1. Go to **Monitor** > **Activity Log** > **Export Activity Log**.
   1. Select your subscription from the list, and make sure that a diagnostic setting is configured.

2. Update Automation Scripts
   1. If you have scripts using the legacy API, update them to use the **diagnostic settings API** by September 30, 2026.
   1. Refer to the [Azure Diagnostic Settings API Documentation](/azure/azure-monitor/essentials/activity-log?tabs=powershell#legacy-collection-methods) for guidance.

3. Check the Log Analytics workspace:
   1. Make sure that the destination Log Analytics workspace is active.
   1. If the workspace is inactive, change the destination to an active subscription.

4. Run a PowerShell script to list diagnostic settings:
   1. Open **Azure Cloud Shell** or any PowerShell that's connected to your tenant.
   1. To list all diagnostic settings across your subscriptions, run the following script:
  
   ```powershell
        # Install and login with Connect-AzAccount
        If ($null -eq (Get-Command -Name Get-CloudDrive -ErrorAction SilentlyContinue)) {
            If ($null -eq (Get-Module Az -ListAvailable -ErrorAction SilentlyContinue)){
                Write-Host Installing Az module from default repository
                Install-Module -Name Az -AllowClobber
            }
            Write-Host Importing Az
            Import-Module -Name Az
            Write-Host Connecting to Az
            Connect-AzAccount
        }
        # Get all Azure Subscriptions
        $Subs = Get-AzSubscription
        # Set array
        $DiagResults = @()
        # Loop through all Azure Subscriptions
        foreach ($Sub in $Subs) {
            Set-AzContext $Sub.id | Out-Null
            Write-Host Processing Subscription: ($Sub).name
            # Get all Azure resources for current subscription
            $Resources = Get-AZResource
            # Get all Azure resources which have Diagnostic settings enabled and configured
            foreach ($res in $Resources) {
                $resId = $res.ResourceId
                $DiagSettings = Get-AzDiagnosticSetting -ResourceId $resId -WarningAction SilentlyContinue -ErrorAction SilentlyContinue | Where-Object { $_.Id -ne $null }
                foreach ($diag in $DiagSettings) {
                    # Store all results for resource in PS Object
                    $item = [PSCustomObject]@{
                        ResourceName = $res.name
                        DiagnosticSettingsName = $diag.name
                        StorageAccountName = $diag.StorageAccountId
                        EventHubName = $diag.EventHubAuthorizationRuleId
                        WorkspaceName = $diag.WorkspaceId
                        Subscription = $Sub.Name
                        ResourceId = $resId
                        DiagnosticSettingsId = $diag.Id
                     }
                    Write-Host $item
                    # Add PS Object to array
                    $DiagResults += $item
                }
            }
        }
        # Save Diagnostic settings to CSV as tabular data
        $DiagResults | Export-Csv -Force -Path .\AzureResourceDiagnosticSettings-$(get-date -f yyyy-MM-dd-HHmm).csv
   ```

## References

- [Azure diagnostic settings documentation](/azure/azure-monitor/essentials/activity-log?tabs=powershell#legacy-collection-methods)
- [Azure Monitor overview](/azure/azure-monitor/overview)

If the issue persists after you follow these steps, open a support case for further assistance.

