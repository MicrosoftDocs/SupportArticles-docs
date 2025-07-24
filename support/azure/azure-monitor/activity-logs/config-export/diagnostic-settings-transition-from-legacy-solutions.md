---
title: Diagnostic Settings Transition from Legacy Solutions
description: Provides step-by-step guidance on diagnostic settings transition from legacy solutions.
ms.date: 07/16/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Diagnostic settings transition from legacy solutions

## Resolve Transition Issues from Legacy Azure Activity Log Solutions

This article addresses the transition from legacy solutions for forwarding Azure activity logs to new diagnostic settings. The legacy solution will be retired on September 30, 2026, and this change will occur automatically without disrupting your workflow. However, if you have automation using the legacy API, you will need to update it.

### Step-by-Step Instructions to Resolve Transition Issues

1. **Verify Current Configuration**
   - Navigate to **Azure Portal**.
   - Go to **Monitor** > **Activity Log** > **Export Activity Log**.
   - Select your subscription from the dropdown and ensure a diagnostic setting is configured.

2. **Update Automation Scripts**
   - If you have scripts using the legacy API, update them to use the **diagnostic settings API** by September 30, 2026.
   - Refer to the [Azure Diagnostic Settings API Documentation](/azure/azure-monitor/essentials/activity-log?tabs=powershell#legacy-collection-methods) for guidance.

3. **Check Log Analytics Workspace**
   - Ensure the destination Log Analytics Workspace is active.
   - If the workspace is inactive, change the destination to an active subscription.

4. **Run PowerShell Script to List Diagnostic Settings**
   - Open **Azure Cloud Shell** or any PowerShell connected to your tenant.
   - Run the following script to list all diagnostic settings across your subscriptions:
  
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

- [Azure Diagnostic Settings Documentation](/azure/azure-monitor/essentials/activity-log?tabs=powershell#legacy-collection-methods)
- [Azure Monitor Overview](/azure-monitor/overview)

If the issue persists after following the solution steps, please open a support case for further assistance.
