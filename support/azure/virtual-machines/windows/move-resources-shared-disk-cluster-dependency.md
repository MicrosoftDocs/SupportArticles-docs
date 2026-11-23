---
title: Azure VM resource move fails because shared disk cluster dependencies are present
description: Troubleshoot Azure VM resource move failures caused by shared managed disk cluster dependencies, and use these steps to complete your move.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/17/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine resource move fails because shared disk cluster dependencies are present

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to troubleshoot Azure virtual machine (VM) move failures that shared disk cluster dependencies cause. The article provides steps to identify the dependencies, plan a coordinated move, and validate the cluster after migration.

## Symptoms

Move validation fails for VMs that participate in a cluster and share managed disks, or the application becomes unavailable after a partial move.

The following examples illustrate the error messages you might encounter.

```output
MissingMoveDependentResources
```

```output
The selected resource depends on shared disk attachments used by multiple virtual machines.
```

## Cause

Shared disks create coordinated dependencies across multiple VMs. A partial move of one VM or one disk can break cluster quorum, attachment state, or failover configuration.

## Resolution

### Step 1: Inventory clustered VM and disk relationships

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to inventory the clustered VM and disk relationships.

# [Azure portal](#tab/portal)

1. In the [Azure portal](https://portal.azure.com), go to the resource group.
1. Filter by **Disks** and look for disks with **Max shares** greater than 1.
1. Note which VMs are attached to each shared disk.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzDisk -ResourceGroupName "<resource-group-name>" |
  Where-Object { $_.MaxShares -gt 1 } |
  Format-Table Name, MaxShares, ManagedBy, @{N='SharedWith';E={$_.ManagedByExtended -join ', '}}
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az disk list \
  --resource-group <resource-group-name> \
  --query "[?maxShares > \`1\`].{name:name, maxShares:maxShares, managedBy:managedBy}" \
  --output table
```

---

### Step 2: Freeze cluster state and plan coordinated move

Before the move, determine the following items:

- Verify cluster health.
- Decide whether to stop cluster services.
- Include all related VMs and shared disks in the migration plan, where supported.

### Step 3: Use staged rebuild if a direct move isn't supported

If the move path can't preserve shared disk topology, rebuild the cluster in the destination, and migrate the application state separately.

### Step 4: Verify cluster health after migration

Check quorum, disk ownership, and application failover.

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move blocked by missing load balancer dependencies](move-resources-load-balancer-dependency-missing.md)
- [Shared disks on Azure managed disks](/azure/virtual-machines/disks-shared)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
