---
title: Azure VM move fails because hidden restore point or snapshot artifacts still exist
description: Resolve Azure VM move failures caused by hidden restore points or snapshots that remain. Follow these steps to identify and remove blockers, and to retry validation.
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

# Azure virtual machine move fails because hidden restore point or snapshot artifacts still exist

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

If an Azure virtual machine (VM) move fails after backup changes, hidden restore point collections or snapshots might still block validation. Use this article to identify and remove the blocking artifacts.

## Symptoms

Move validation still fails after a backup is stopped or after an earlier move blocker is supposedly removed.

The following are some example messages you might encounter.

```output
IncompleteRequest
```

```output
Move validation failed because restore point or snapshot dependencies still exist.
```

## Cause

Hidden restore point collections, snapshots, or previous backup artifacts can remain in the dependency graph even after the operator believes that the cleanup process is complete.

## Resolution

### Step 1: Enumerate restore point collections and snapshots

Use Azure PowerShell or Azure CLI to enumerate restore point collections and snapshots.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
Get-AzResource -ResourceType "Microsoft.Compute/restorePointCollections" |
  Select-Object Name, ResourceGroupName, ResourceId

Get-AzSnapshot -ResourceGroupName "<rg-name>" |
  Select-Object Name, ProvisioningState, SourceResourceId
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
az resource list --resource-type "Microsoft.Compute/restorePointCollections" \
  --query "[].{Name:name, RG:resourceGroup, Id:id}" --output table

az snapshot list --resource-group "<rg-name>" \
  --query "[].{Name:name, State:provisioningState, Source:creationData.sourceResourceId}" --output table
```

# [Azure portal](#tab/portal)

Restore point collections are hidden resources that you can't see in the Azure portal resource browser. To list and discover these resources, use Azure PowerShell or Azure CLI.

---

### Step 2: Match the artifacts to the affected VM

Use Azure PowerShell or Azure CLI to look for names or source resource IDs that are associated with the VM you're moving.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzResource -ResourceType "Microsoft.Compute/restorePointCollections" |
  Where-Object { $_.Name -match "<vm-name>" }
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource list --resource-type "Microsoft.Compute/restorePointCollections" \
  --query "[?contains(name, '<vm-name>')].{Name:name, Id:id}" --output table
```

# [Azure portal](#tab/portal)

Restore point collections are hidden resources that you can't see in the Azure portal resource browser. To filter and match these resources to a specific VM, use Azure PowerShell or Azure CLI.

---

### Step 3: Remove the blocking artifacts if the retention policy allows it

Use Azure PowerShell or Azure CLI to delete the restore point or snapshot residue, and then retry validation.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzResource -ResourceType "Microsoft.Compute/restorePointCollections" |
  Where-Object { $_.Name -match "<vm-name>" } |
  ForEach-Object { Remove-AzResource -ResourceId $_.ResourceId -Force }
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource delete --ids "<restore-point-collection-resource-id>"
```

# [Azure portal](#tab/portal)

Restore point collections are hidden resources that you can't see in the Azure portal resource browser. To delete these resources programmatically, use  Azure PowerShell or Azure CLI.

---

## References

- [Move fails because Azure Backup dependencies block the move](move-resources-backup-lock-recovery-services-vault.md)
- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Special cases to move Azure VMs to new subscription or resource group](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
