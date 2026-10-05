---
title: Azure resource move fails with RequestConflict error because provisioning state isn't terminal
description: Resolve Azure resource move RequestConflict errors when move collections are still processing. Follow these steps to verify the state and retry successfully.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/14/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure resource move fails with RequestConflict error because provisioning state isn't terminal

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs :heavy_check_mark: Resource Mover collections

## Summary

This article explains how to resolve `RequestConflict` errors that occur when you try to move Azure resources while the provisioning state of a move collection isn't terminal. The article provides steps to inspect the move collection state, ensure that there's only one active writer, and retry operations safely.

## Symptoms

A move operation fails and returns the following error message.

```
RequestConflict: Cannot modify resource ... because the resource entity provisioning state is not terminal.
Please wait for the provisioning state to become terminal and then retry.
```

## Cause

This error occurs if an Azure Resource Mover move collection is still processing a previous operation. The collection provisioning state must reach a terminal state (`Succeeded` or `Failed`) before you can submit new operations. Common causes include the following reasons:

- Multiple scripts or users modify the same move collection at the same time.
- A previous prepare, commit, or update operation doesn't finish.
- A dependent resource is in a `Failed` or `Updating` state. This condition blocks the collection from reaching a terminal state.

## Resolution

### Resolution 1

Follow these steps to resolve the conflict:

1. Stop all concurrent updates to the same move collection.
1. Wait for the collection state to reach `Succeeded` or `Failed`.
1. Retry the operation one time.
1. If the conflict repeats, serialize the operations (one writer only).

## Common Azure resource move error signatures

The following table summarizes common error signatures, their usual meanings, and the recommended first steps to take.

| Error signature | What it usually means | What to do first |
|---|---|---|
| `RequestConflict` with message `provisioning state is not terminal` | Move collection is still processing another operation | Wait for a terminal state, and then retry one time. |
| `MoveResourcesHavePendingOperations` | Resource or provider has outstanding operations | Stop overlapping jobs, and let pending operations finish. |
| `MoveCannotProceedWithResourcesNotInSucceededState` | Dependency resource is `Failed` or `Updating` | Fix the dependency state, and then rerun the prepare or commit. |

### Resolution 2

#### Step 1: Inspect move collection state

Use Azure PowerShell or Azure CLI to check the current provisioning state of your move collections to determine whether a previous operation is still running.

# [Azure portal](#tab/portal)

You can't query move collection provisioning state programmatically in the [Azure portal](https://portal.azure.com). To check the current state, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run this command.

```azurepowershell
Get-AzResource -ResourceType "Microsoft.Migrate/moveCollections" |
  Select-Object Name, ResourceGroupName, ProvisioningState
```

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
az resource list --resource-type "Microsoft.Migrate/moveCollections" \
  --query "[].{Name:name, RG:resourceGroup, State:provisioningState}" --output table
```

---

#### Step 2: Make sure that there's only one active writer

Concurrent modifications to a move collection can cause conflicts. Verify that the following conditions are actively enforced:

- Stop parallel scripts that update the same collection.
- Disable duplicate automation jobs.
- Don't run prepare, commit, or update operations simultaneously.

#### Step 3: Retry with terminal-state guard

Use the Azure portal, Azure PowerShell, or Azure CLI to wait for the collection to reach a terminal state before you retry the operation.

# [Azure portal](#tab/portal)

The [Azure portal](https://portal.azure.com) doesn't support automated terminal-state polling. 

Follow these steps to manually check the move collection status:

1. In the Azure portal, go to **Azure Resource Mover**.
1. Select your move collection.
1. Check the **Status** field. Wait until it shows **Succeeded** or **Failed** before you retry.

For more information, see [Azure Resource Mover overview](/azure/resource-mover/overview).

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$collectionName = "<move-collection-name>"
$collectionRg = "<move-collection-rg>"

function Wait-ForTerminalState {
  param(
    [string]$Name,
    [string]$ResourceGroup,
    [int]$TimeoutSeconds = 900
  )

  $start = Get-Date
  while ((Get-Date) -lt $start.AddSeconds($TimeoutSeconds)) {
    $mc = Get-AzResource -ResourceGroupName $ResourceGroup `
      -ResourceType "Microsoft.Migrate/moveCollections" -Name $Name -ErrorAction SilentlyContinue

    if ($mc -and $mc.ProvisioningState -in @('Succeeded','Failed')) {
      return $mc.ProvisioningState
    }

    Start-Sleep -Seconds 15
  }

  throw "Timed out waiting for terminal provisioning state."
}

$state = Wait-ForTerminalState -Name $collectionName -ResourceGroup $collectionRg
Write-Host "Collection state: $state"

# Retry only after terminal state
Invoke-AzResourceMoverMoveCollectionPrepare -MoveCollectionName $collectionName -ResourceGroupName $collectionRg
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
# Check collection state
az resource show --resource-group "<move-collection-rg>" \
  --resource-type "Microsoft.Migrate/moveCollections" \
  --name "<move-collection-name>" \
  --query "properties.provisioningState"

# Wait until state is Succeeded or Failed, then retry
az resource-mover move-collection initiate-move \
  --move-collection-name "<move-collection-name>" \
  --resource-group "<move-collection-rg>"
```

---

#### Step 4: If conflicts continue

If conflicts continue after you serialize operations, try the following steps:

- Create a new move collection and add the resources again.
- Run prepare and commit in strict sequence.
- Use separate collections for separate batches.

#### Step 5: Identify dependencies that aren't in a `Succeeded` state

A dependency resource in a non-terminal state can block the entire move collection.

Use Azure PowerShell or Azure CLI to identify dependency resources that aren't in a `Succeeded` state.

# [Azure portal](#tab/portal)

The Azure portal doesn't support identifying dependency resources in a non-terminal provisioning state across a move collection. To check dependency states, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzResource -ResourceGroupName "<source-rg>" |
  Select-Object Name, ResourceType, ProvisioningState |
  Where-Object { $_.ProvisioningState -ne "Succeeded" }
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource list --resource-group "<source-rg>" \
  --query "[?provisioningState!='Succeeded'].{Name:name, Type:type, State:provisioningState}" --output table
```

---

If any dependency isn't in the `Succeeded` state, fix that resource first. Retry move operations only after all dependencies reach a terminal state.

### Prevention

Ensure the following preventative steps are taken:

- Use one move collection per batch owner.
- Enforce pipeline locking so that only a single job runs at a time.
- Add a precheck that blocks execution if the collection state isn't terminal.

## References

- [Azure resource move fails with ResourcesBeingMoved because resource group is updating](move-resources-resources-moved-resource-group-update.md)
- [Azure resource move fails after provider operations succeed with batch orchestration error](move-resources-batch-orchestration-failed.md)
- [Troubleshoot batch operation failures](/azure/azure-resource-manager/troubleshooting)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
