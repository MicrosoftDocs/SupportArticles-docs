---
title: Remove old product connectors from Operations Manager
description: Describes how to remove an old product connector from System Center - Operations Manager by using a PowerShell script.
ms.date: 04/15/2024
ms.reviewer: msadoff, jarrettr
---
# How to remove old product connectors from Operations Manager

## Summary

This article describes how to remove an old product connector from Microsoft System Center - Operations Manager by using the OperationsManager PowerShell module and the sample script in this article.

_Original product version:_ &nbsp; System Center Operations Manager  
_Original KB number:_ &nbsp; 2626670

## When to use this procedure

Use this procedure only when a product connector is no longer required in the management group and must be removed from the environment. Because connector removal affects connector-related configuration and data associations, this procedure should be treated as a maintenance operation.

## What this procedure does

The script identifies the specified connector, removes any connector subscriptions that reference it, clears connector associations from related alerts when applicable, uninitializes the connector if required, and then removes the connector from the management group.

## Prerequisites

Before running this procedure:

- Verify that the specified connector isn't an internal Operations Manager connector.
- Back up both the operational and data warehouse databases before making any changes.
- Run the procedure only from a management server or PowerShell session that has the required Operations Manager components available.
- Verify the exact connector name before removal. If possible, first validate the target connector in a non-production or low-risk scenario before running the deletion in production.
- Don't modify or improvise the script to work around startup or runtime errors. Use only the published, validated version of the script.

## PowerShell script

Use the following PowerShell script to remove the specified product connector only after completing the prerequisites.

> [!IMPORTANT]
> Don't attempt to work around errors in earlier versions of this script by manually removing invalid startup references or changing individual lines without validating the full procedure. In terms of testing, an ad hoc workaround can leave the environment in an inconsistent state and may require database restoration to recover.

```powershell
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
param(
    [Parameter(Mandatory = $true)]
    [string]$ConnectorName,

[string]$ManagementServerName = 'localhost',

    [switch]$AllowWildcard
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-MatchingConnector {
    param(
        [Parameter(Mandatory = $true)]
        [object[]]$Connectors,

        [Parameter(Mandatory = $true)]
        [string]$Name,

        [switch]$Wildcard
    )

    if ($Wildcard) {
        @($Connectors | Where-Object { $_.Name -like $Name })

    else {
        @($Connectors | Where-Object { $_.Name -eq $Name })
}

}

function Remove-ConnectorSubscriptions {
    param(
        [Parameter(Mandatory = $true)]
        $Admin,

        [Parameter(Mandatory = $true)]
        [object[]]$Connectors
    )

    $connectorIds = @($Connectors | ForEach-Object { $_.Id })

    $subscriptions = @(
        $Admin.GetConnectorSubscriptions() |
        Where-Object { $connectorIds -contains $_.MonitoringConnectorId }
    )

    foreach ($subscription in $subscriptions) {
        $target = "{0} [{1}]" -f $subscription.DisplayName, $subscription.Id
        if ($PSCmdlet.ShouldProcess($target, 'Delete connector subscription')) {
            Write-Host "Deleting subscription: $($subscription.DisplayName)"
            $subObj = $Admin.GetConnectorSubscription($subscription.Id)
            $Admin.DeleteConnectorSubscription($subObj)
        }

}

function Remove-ConnectorObjects {
    param(
        [Parameter(Mandatory = $true)]
        $Admin,

        [Parameter(Mandatory = $true)]
        [object[]]$Connectors
    )

    foreach ($connector in @($Connectors)) {
        Write-Host "Processing connector: $($connector.Name) [$($connector.Id)]"

        if ($connector.Initialized) {
            $alerts = @($connector.GetMonitoringAlerts())

            if (@($alerts).Count -gt 0) {
                Write-Host "  Disconnecting $($alerts.Count) alert(s) from connector..."
            }

            foreach ($alert in @($alerts)) {
                $alertTarget = "{0} [{1}]" -f $alert.Name, $alert.Id
                if ($PSCmdlet.ShouldProcess($alertTarget, "Clear ConnectorId for '$($connector.Name)'")) {
                    $alert.ConnectorId = $null
                    $alert.Update("Delete Connector")
                }
            }

            if ($PSCmdlet.ShouldProcess($connector.Name, 'Uninitialize connector')) {
                Write-Host "  Uninitializing connector..."
                $connector.Uninitialize()
            }
        }

        if ($PSCmdlet.ShouldProcess($connector.Name, 'Delete connector')) {
            Write-Host "  Deleting connector..."
            [void]$Admin.Cleanup($connector)
        }
    }
}

New-DefaultManagementGroupConnection -ManagementServerName $ManagementServerName | Out-Null
$mg = Get-SCOMManagementGroup -ComputerName $ManagementServerName -ErrorAction Stop
$admin = $mg.GetConnectorFrameworkAdministration()

$allConnectors = @($admin.GetMonitoringConnectors())
$connectorsToDelete = @(Get-MatchingConnector -Connectors $allConnectors -Name $ConnectorName -Wildcard:$AllowWildcard)

if (@($connectorsToDelete).Count -eq 0) {
    throw "No connector found matching '$ConnectorName'."
 }

Write-Host "Matched connector(s):"
$connectorsToDelete | Select-Object Name, Id, Initialized | Format-Table -AutoSize
Write-Host ""

Remove-ConnectorSubscriptions -Admin $admin -Connectors $connectorsToDelete
Remove-ConnectorObjects -Admin $admin -Connectors $connectorsToDelete

Write-Host ""
Write-Host "Completed."
```

## Run the script

Use the following syntax to run the script:

`DeleteConnector.ps1 -ConnectorName <String> [-ManagementServerName <String>] [-AllowWildcard] [-WhatIf] [-Confirm]`

### Parameters

- `ConnectorName`  
  Specifies the connector name to remove. This parameter is required.

- `ManagementServerName`  
  Specifies the management server to connect to. This parameter is optional. The default value is `localhost`.

- `AllowWildcard`  
  Enables wildcard matching for the connector name. Use this parameter only when you intentionally want to match more than one connector.

### Examples

Preview the operation without making changes:

```powershell
.\DeleteConnector.ps1 -ConnectorName 'Old Connector Name' -ManagementServerName 'SCOMMS01' -WhatIf
```

Remove a connector by exact name:

```powershell
.\DeleteConnector.ps1 -ConnectorName 'Old Connector Name' -ManagementServerName 'SCOMMS01'
```

Preview wildcard matching:

```powershell
.\DeleteConnector.ps1 -ConnectorName 'OldConnector*' -ManagementServerName 'SCOMMS01' -AllowWildcard -WhatIf
```

## Validate the result

After the script completes, verify the following:

- The connector no longer appears in the connector list.
- Any connector subscriptions associated with the connector have been removed.
- No alerts remain associated with the removed connector.
- The Operations Manager console opens the connector view normally after the change.

## Troubleshooting

- If no connector is found, verify that the connector name is correct and rerun the script by using the exact connector name.

- If you use wildcard matching, always run the script first with `-WhatIf` to confirm that only the intended connector is matched.

- Don't use this procedure to remove internal Operations Manager connectors.

- If a previous version of the script was used or modified ad hoc and the environment shows inconsistent behavior afterward, restore the OperationsManager databases from backup before retrying the procedure with the validated script version.
