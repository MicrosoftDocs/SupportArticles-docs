---
title: Azure VM resource move fails because resource locks are present
description: Learn how to fix Azure VM resource move failures caused by CanNotDelete or ReadOnly locks, retry the move, and restore governance locks.
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

# Azure VM resource move fails because resource locks are present

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to troubleshoot Azure virtual machine (VM) move failures that resource locks cause. It provides steps to identify and remove blocking locks, retry the move, and reapply locks after the move finishes.

## Symptoms 

A move validation fails and generates lock-related errors. When the error occurs, you receive error messages that indicate that the operation is blocked by a lock.

The following error message is an example of a lock-related error message.

```output
The scope '<resource-id>' cannot perform write operation because the following scope(s) are locked.
```

## Cause

Azure resource locks that are enacted at the subscription, resource group, or resource scope can block move operations.

The most common lock types are the following locks:

- `CanNotDelete`
- `ReadOnly`

> [!IMPORTANT]
> Not all lock types and scopes block moves equally. In practice, **ReadOnly** locks at the **resource group** or **subscription** scope are the primary cause of `ScopeLocked` errors during move operations. `CanNotDelete` locks and resource-level `ReadOnly` locks typically don't block resource moves. However, you should still remove or temporarily disable all locks on resources in the move request to prevent unexpected behavior during the operation.

Locks on any dependency (VM, network adapter, disks, network security group (NSG), or public IP) can block the entire move transaction.

## Resolution

### Step 1: Enumerate locks in the source scope

Use Azure PowerShell, Azure CLI, or the Azure portal to enumerate locks in the source scope.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzResourceLock -ResourceGroupName "<source-rg>" |
  Select-Object LockName, LockLevel, ResourceName, ResourceType
```

To inspect locks recursively at the subscription scope, run the following command.

```azurepowershell
Get-AzResourceLock | Select-Object LockName, LockLevel, Scope
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az lock list --resource-group "<source-rg>" \
  --query "[].{Name:name, Level:level, Resource:resourceName, Type:resourceType}" --output table
```

To inspect subscription-level locks, run the following command.

```azurecli
az lock list --query "[].{Name:name, Level:level, Scope:id}" --output table
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the resource group that contains the resources you want to move.
1. In the menu, in **Settings**, select **Locks**.
1. Review all locks that are listed. Note the lock name, level (**CanNotDelete** or **ReadOnly**), and the scope at which each lock is applied.

To check locks on individual resources, go to the resource, and in the menu, in **Settings**, select **Locks**.

For more information, see [Configure locks - Azure portal](/azure/azure-resource-manager/management/lock-resources?tabs=json#azure-portal).

---

### Step 2: Remove or temporarily disable blocking locks

If your change process approves, use Azure PowerShell, Azure CLI, or the Azure portal to remove locks that block move execution.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Remove-AzResourceLock -LockName "<lock-name>" -ResourceGroupName "<source-rg>" -Force
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az lock delete --name "<lock-name>" --resource-group "<source-rg>"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the resource or resource group that has the blocking lock.
1. In the menu, in **Settings**, select **Locks**.
1. Find the lock that blocks the move, and then select **Delete**.
1. After the move finishes, re-create the lock by selecting **Add** and specifying the lock name and level.

For more information, see [Configure locks - Azure portal](/azure/azure-resource-manager/management/lock-resources?tabs=json#azure-portal).

---

> [!IMPORTANT]
> Reapply required governance locks after the move finishes.

### Step 3: Retry move validation and move

After lock removal, rerun move validation and complete the move.

### Step 4: Reapply locks at destination

After a successful move, reapply `CanNotDelete` or `ReadOnly` locks on the destination scope as required by your governance baseline.

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move blocked by failed virtual machine extension](move-resources-extension-failed-state.md)
- [Lock resources to prevent unexpected changes](/azure/azure-resource-manager/management/lock-resources)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
