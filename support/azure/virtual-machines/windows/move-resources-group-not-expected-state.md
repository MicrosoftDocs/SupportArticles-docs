---
title: Azure resource move fails because resource group is not in expected state
description: Learn how to fix Azure resource move failures when a resource group isn't in the expected state. Then, retry the move successfully by using step-by-step checks.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/09/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure resource move fails because resource group isn't in expected state

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs :heavy_check_mark: All resource types

## Summary

This article helps you troubleshoot and resolve Azure resource move failures that are caused by a resource group that isn't in the expected state. It provides steps to check the resource group status, identify incomplete deployments, verify resource locks, and ensure that all resources are in a consistent state before you retry the move.

## Symptoms

A move operation fails and returns an error message that resembles the following example.

```
ResourceGroupNotInExpectedState: The resource group 'my-rg' isn't in the expected state.
```

The resource group appears healthy in the portal, but the move operation can't proceed.

## Cause

The resource group is in a transitional or inconsistent state for one or more of the following reasons:

- A previous operation (deployment, move, delete) left the resource group in an incomplete state.
- The resource group metadata didn't replicate across Azure regions (especially after recent operations).
- A lock or policy changed the resource group state.
- The resource group was recently updated and is still synchronizing.

## Resolution

### Step 1: Check resource group status

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to query the resource group for state information.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$rg = Get-AzResourceGroup -Name "<resource-group-name>"

Write-Host "Name: $($rg.ResourceGroupName)"
Write-Host "Location: $($rg.Location)"
Write-Host "ProvisioningState: $($rg.ProvisioningState)"
Write-Host "ManagedBy: $($rg.ManagedBy)"
Write-Host "Tags: $($rg.Tags)"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az group show --name "<resource-group-name>" \
  --query "{Name:name, Location:location, State:properties.provisioningState, ManagedBy:managedBy, Tags:tags}"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Resource groups**, and then select the resource group.
1. On the **Overview** page, check the **Status** field. The provisioning state should show **Succeeded**.

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

---

### Step 2: Check for incomplete deployments

Use Azure PowerShell, Azure CLI, or the Azure portal to verify that no incomplete deployments are affecting the resource group state.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$deployments = Get-AzResourceGroupDeployment -ResourceGroupName "<resource-group-name>"

$deployments | ForEach-Object {
  Write-Host "Deployment: $($_.DeploymentName)"
  Write-Host "  State: $($_.ProvisioningState)"
  Write-Host "  Timestamp: $($_.Timestamp)"
}

# Cancel any stuck deployments
$stuck = $deployments | Where-Object { $_.ProvisioningState -notin @("Succeeded", "Failed") }
if ($stuck) {
  foreach ($deploy in $stuck) {
    Write-Host "Canceling stuck deployment: $($deploy.DeploymentName)"
    Stop-AzResourceGroupDeployment -ResourceGroupName "<resource-group-name>" -DeploymentName $deploy.DeploymentName -ErrorAction SilentlyContinue
  }
}
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
# List deployments and their states
az deployment group list --resource-group "<resource-group-name>" \
  --query "[].{Name:name, State:properties.provisioningState, Time:properties.timestamp}" --output table

# Cancel any stuck deployments
az deployment group cancel --resource-group "<resource-group-name>" --name "<deployment-name>"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to **Resource groups**, and then select the resource group.
1. In the menu, in **Settings**, select **Deployments**.
1. Review the list for any deployment that shows a status other than **Succeeded** or **Failed**. Cancel or wait for stuck deployments before you retry the move.

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

---

### Step 3: Check for resource locks

Use Azure PowerShell, Azure CLI, or the Azure portal to verify that locks aren't preventing state transitions.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzManagementLock -ResourceGroupName "<resource-group-name>" |
  Select-Object Name, LockLevel, ResourceId
```

If locks exist and aren't necessary for the move, temporarily remove them.

```azurepowershell
Get-AzManagementLock -ResourceGroupName "<resource-group-name>" |
  ForEach-Object { Remove-AzManagementLock -LockId $_.LockId -Force }

# Re-apply locks after the move
New-AzManagementLock -ResourceGroupName "<resource-group-name>" -LockLevel "CanNotDelete" -LockName "prevent-delete"
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
# List locks
az lock list --resource-group "<resource-group-name>" \
  --query "[].{Name:name, Level:level}" --output table

# Remove a lock
az lock delete --name "<lock-name>" --resource-group "<resource-group-name>"

# Re-apply after move
az lock create --name "prevent-delete" --resource-group "<resource-group-name>" --lock-type CanNotDelete
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to the resource group.
1. In the menu, in **Settings**, select **Locks**.
1. Review all locks that are listed. If any locks are unnecessary for the move, select the lock, and then select **Delete**.
1. After the move finishes, re-create the lock by selecting **Add**.

For more information, see [Configure locks - Azure portal](/azure/azure-resource-manager/management/lock-resources?tabs=json#azure-portal).

---

### Step 4: Wait for state synchronization

If you recently modified the resource group, use Azure PowerShell or Azure CLI to monitor state changes programmatically and then wait for state synchronization.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
# Monitor RG state
for ($i = 0; $i -lt 12; $i++) {
  $rg = Get-AzResourceGroup -Name "<resource-group-name>"
  Write-Host "[$i] $(Get-Date -Format 'HH:mm:ss') - State: $($rg.ProvisioningState)"
  
  if ($rg.ProvisioningState -eq "Succeeded") {
    Write-Host "RG is ready"
    break
  }
  
  Start-Sleep -Seconds 5
}
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
# Check RG state (repeat until Succeeded)
az group show --name "<resource-group-name>" --query "properties.provisioningState" --output tsv
```

# [Azure portal](#tab/portal)

The Azure portal doesn't support polling a resource group's provisioning state in a loop for state synchronization. To monitor state changes programmatically, use Azure PowerShell or Azure CLI.

---

### Step 5: Verify that all resources are in a good state

Use Azure PowerShell, Azure CLI, or the Azure portal to ensure that resources within the resource group are consistent.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$resources = Get-AzResource -ResourceGroupName "<resource-group-name>"

$resources | ForEach-Object {
  $state = (Get-AzResource -ResourceId $_.ResourceId).Properties.provisioningState
  if ($state -notin @("Succeeded", $null)) {
    Write-Host "WARNING: $($_.Name) is in state: $state"
  }
}
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource list --resource-group "<resource-group-name>" \
  --query "[?provisioningState!='Succeeded'].{Name:name, Type:type, State:provisioningState}" --output table
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to **Resource groups**, and then select the resource group.
1. In the menu, select **Resources** (or **Overview** > **Resources** tab).
1. Review the list and check the **Status** column. All resources should show **Succeeded**. Investigate any resource that shows a different state.

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

---

### Step 6: Check for quota or subscription limits

If the resource group recently reached a quota limit, that limit can cause state problems. Use Azure PowerShell, Azure CLI, or the Azure portal to check the current usage and limits for your resources.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$usage = Get-AzVMUsage -Location "<region>"
$usage | Where-Object { $_.CurrentValue -gt ($_.Limit * 0.9) } |
  Select-Object Name, CurrentValue, Limit
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm list-usage --location "<region>" \
  --query "[?currentValue > limit * `0.9`].{Name:name.value, Current:currentValue, Limit:limit}" --output table
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to **Subscriptions**, and then select the subscription.
1. In the menu, select **Usage + quotas**.
1. Filter by resource type and region to check whether any resource type is at or near its limit.

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

---

### Step 7: Retry by using a fresh context

A fresh Azure context can help resolve state visibility problems. Use Azure PowerShell or Azure CLI to reset your session and retry the move.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
Clear-AzContext -Force
Connect-AzAccount
Set-AzContext -SubscriptionId "<subscription-id>"

Move-AzResource -DestinationResourceGroupName "<destination-rg>" `
  -ResourceId "/subscriptions/<sub-id>/resourceGroups/<source-rg>/providers/<resource-type>/<resource-name>"
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
az logout
az login
az account set --subscription "<subscription-id>"

az resource move --destination-group "<destination-rg>" \
  --ids "/subscriptions/<sub-id>/resourceGroups/<source-rg>/providers/<resource-type>/<resource-name>"
```

# [Azure portal](#tab/portal)

The Azure portal doesn't provide an option to clear and re-establish your Azure session context to resolve cached state issues. To reset your context and retry the move, use Azure PowerShell or Azure CLI.

---

### Prevention

Ensure that you take the following preventative measures:

- **Avoid parallel operations** - Don't modify the resource group while a move is in progress.
- **Wait between operations** - Wait 30 seconds after making major changes before you initiate a move.
- **Use Resource Mover** - For complex moves, Azure Resource Mover handles state transitions more reliably.
- **Monitor deployments** - Verify that all deployments are complete before you initiate a move.

## References

- [Use Resource Mover for complex VMs moves](/azure/resource-mover/tutorial-move-region-virtual-machines)
- [Troubleshoot Azure deployments](/azure/azure-resource-manager/templates/common-deployment-errors)
- [Manage resource groups](/azure/azure-resource-manager/management/manage-resource-groups-portal)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
