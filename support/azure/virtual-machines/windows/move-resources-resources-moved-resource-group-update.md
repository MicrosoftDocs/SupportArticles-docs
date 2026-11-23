---
title: Azure resource move fails with ResourcesBeingMoved messagebecause resource group is updating
description: Resolve ResourcesBeingMoved errors when Azure resource group updates block a move. Follow these steps to identify active operations, wait, and retry successfully.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/16/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure resource move fails with ResourcesBeingMoved message because resource group is updating

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs :heavy_check_mark: All resource types

## Summary    

This article explains how to troubleshoot a `ResourcesBeingMoved` error when another operation updates an Azure resource group and blocks a resource move. Use the steps to identify the blocking operation, wait for it to finish, and retry the move successfully.

## Symptoms

A move operation fails and returns the following error message:

```output
ResourcesBeingMoved: The resource group '<rg-name>' is being updated and cannot perform this operation.
```

This error message indicates that another operation is already modifying the resource group. Azure can't process the move request until the current operation finishes.

## Cause

This error occurs if an in-flight operation such as a deployment, another move, or a resource update locks the resource group. Azure Resource Manager (ARM) allows only one write operation at a time on a resource group.

### Quick fix

Follow these steps to quickly resolve the issue:

1. Stop submitting new move or deployment operations to the same resource group.
1. Wait until the resource group provisioning state is terminal (`Succeeded` or `Failed`).
1. Retry the operation one time.
1. If the retry fails again, wait by using an exponential backoff, and then retry.

### High-volume signature issues

The following table summarizes common high-volume error signatures related to resource group updates and move operations.

| Error signature | What it usually means | What to do first |
|---|---|---|
| `ResourcesBeingMoved` | In-flight update or move locks the resource group | Stop concurrent changes, and then wait for terminal state. |
| `RequestConflict` (related) | Concurrent modification of move collection | Use one writer. Serialize prepare, commit, and update operations. |

## Resolution

### Step 1: Check whether the resource group is still busy

Use the Azure portal, Azure PowerShell, or Azure CLI to query the resource group provisioning state to determine whether another operation is still running.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Resource groups** and select the resource group.
1. On the **Overview** page, check the **Provisioning state**. If it shows **Updating** or **Running**, wait until it reaches **Succeeded** or **Failed**.
1. Select **Deployments** in the left menu to see whether any deployments are still in progress.

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$rg = Get-AzResourceGroup -Name "<rg-name>"
$rg | Select-Object ResourceGroupName, ProvisioningState
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az group show --name "<rg-name>" --query "{Name:name, State:properties.provisioningState}"
```

---

### Step 2: Check active deployments and move operations

Use the Azure portal, Azure PowerShell, or Azure CLI to review the deployment history and activity log to identify which operation is blocking the move.

# [Azure portal](#tab/portal)

Follow these steps:

1. Go to **Resource groups** > your resource group > **Deployments**.
1. Look for any deployment with a status other than **Succeeded** or **Failed**.
1. Go to **Activity log** and filter by the last two hours. Look for operations that contain "move" in the operation name.

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
Get-AzResourceGroupDeployment -ResourceGroupName "<rg-name>" -ErrorAction SilentlyContinue |
  Where-Object { $_.ProvisioningState -notin @('Succeeded','Failed') } |
  Select-Object DeploymentName, ProvisioningState, Timestamp

Get-AzActivityLog -StartTime (Get-Date).AddHours(-2) |
  Where-Object {
    $_.ResourceGroupName -eq "<rg-name>" -and
    $_.OperationName.Value -like '*move*'
  } |
  Select-Object EventTimestamp, OperationName, ActivityStatus, CorrelationId
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
az deployment group list --resource-group "<rg-name>" \
  --query "[?properties.provisioningState!='Succeeded' && properties.provisioningState!='Failed'].{Name:name, State:properties.provisioningState, Time:properties.timestamp}"

az monitor activity-log list --resource-group "<rg-name>" \
  --start-time $(date -u -d '2 hours ago' '+%Y-%m-%dT%H:%M:%SZ') \
  --query "[?contains(operationName.value, 'move')].{Time:eventTimestamp, Op:operationName.value, Status:status.value}"
```

---

### Step 3: Retry by using backoff

Use the Azure portal, Azure PowerShell, or Azure CLI to implement exponential backoff between retry attempts. 

> [!NOTE]
> Don't submit rapid retries because they increase contention on the resource group.

#### [Azure portal](#tab/portal)

The Azure portal doesn't support automated retry with backoff. Wait 2-5 minutes between each manual retry and then follow these steps:

1. Go to **Resource groups** > source resource group.
1. Select the resources to move, and then select **Move**.
1. If the move fails with the same error, wait longer before you retry.

For more information, see [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$maxAttempts = 5
$delay = 20

for ($attempt = 1; $attempt -le $maxAttempts; $attempt++) {
  Write-Host "Attempt $attempt of $maxAttempts"
  try {
    Move-AzResource -DestinationResourceGroupName "<destination-rg>" `
      -DestinationSubscriptionId "<destination-sub-id>" `
      -ResourceId @("<resource-id>") -ErrorAction Stop

    Write-Host "Move request accepted."
    break
  }
  catch {
    Write-Host "Retryable conflict: $($_.Exception.Message)"
    if ($attempt -eq $maxAttempts) { throw }
    Start-Sleep -Seconds $delay
    $delay = [Math]::Min($delay * 2, 300)
  }
}
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
# Single retry attempt — repeat manually with increasing wait times
az resource move --destination-group "<destination-rg>" \
  --ids "<resource-id>"
```

> [!NOTE]
> Azure CLI doesn't have a built-in retry loop. Run the command manually, and wait 30-60 seconds between attempts. Double the wait time after each failure.

---

### Step 4: Reduce contention

To avoid resource group conflicts during moves, do the following:

- Run moves in a maintenance window.
- Pause Continuous Integration (CI)/Continuous Deployment (CD) pipelines that target the source and destination resource groups.
- Avoid running parallel move operations against the same resource group.

### Step 5: Add a pre-check gate before a move

Before you submit a move operation, use the Azure portal, Azure PowerShell, or Azure CLI to verify that no other move or update operations are active on the resource group.

# [Azure portal](#tab/portal)

Follow these steps:

1. Go to **Resource groups** > your resource group > **Activity log**.
1. Filter by the last 30 minutes.
1. Look for any operations with status **Started** or **In Progress** that contain **move** in the operation name.

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$busyOps = Get-AzActivityLog -StartTime (Get-Date).AddMinutes(-30) |
  Where-Object {
    $_.ResourceGroupName -eq "<rg-name>" -and
    $_.OperationName.Value -like '*move*' -and
    $_.ActivityStatus.Value -in @('Started','InProgress')
  }

if ($busyOps) {
  throw "Resource group has active move/update operations. Wait and retry later."
}
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
az monitor activity-log list --resource-group "<rg-name>" \
  --start-time $(date -u -d '30 minutes ago' '+%Y-%m-%dT%H:%M:%SZ') \
  --query "[?contains(operationName.value, 'move') && (status.value=='Started' || status.value=='InProgress')].{Op:operationName.value, Status:status.value}" \
  --output table
```

---

### Prevention

Ensure that you take the following preventative measures:

- Use one orchestrator per move batch.
- Avoid overlap between deployment jobs and move jobs.
- Use ARM for larger batches.

## References

- [Azure resource move fails after provider operations succeed with batch orchestration error](move-resources-batch-orchestration-failed.md)
- [Azure virtual machine move fails because resource group has active deployments](move-resources-deployment-active-blocks-move.md)
- [Azure resource move fails with RequestConflict because provisioning state is not terminal](move-resources-request-conflict-provisioning-state-not-terminal.md)
- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
