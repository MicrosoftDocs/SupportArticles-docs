---
title: Azure VM resource move fails because Azure Backup is enabled
description: Learn how to fix Azure VM resource move failures caused by Azure Backup. Resolve restore point collections and vault dependencies that block your move.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/04/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine resource move fails because Azure Backup is enabled

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to resolve an Azure virtual machine (VM) resource move that fails because Azure Backup is enabled. Learn how to remove blocking restore point collections and Azure Backup Recovery Services vault dependencies so that you can complete the move.

## Symptoms

A move operation fails validation and generates error messages that reference backup-protected resources, restore point collections, or Recovery Services vault dependencies.

The following are example error patterns.

```output
Move cannot proceed because one or more resources are protected by Azure Backup.
```

```output
Resource move validation failed due to restorePointCollections dependency.
```

## Cause

When Azure Backup is enabled for a VM, move operations can be blocked by dependencies such as the following examples:

- Active backup protection state
- Restore point collections
- Recovery Services vault associations

To move VM resources, you must clean up or move these dependencies in a supported sequence.

## Resolution

### Step 1: Verify backup protection state

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to check whether the VM is protected by Azure Backup.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Recovery Services vaults**, and then select your vault.
1. In the menu, in **Protected items**, select **Backup items** > **Azure Virtual Machine**.
1. Check whether the VM is listed and review its backup status.

For more information, see [Manage Azure VM backups](/azure/backup/backup-azure-manage-vms).

# [Azure PowerShell](#tab/powershell)

Run this command.

```azurepowershell
Get-AzResource -ResourceType "Microsoft.Compute/restorePointCollections" |
  Where-Object { $_.Name -match "<vm-name>" }
```

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
az resource list --resource-type "Microsoft.Compute/restorePointCollections" \
  --query "[?contains(name, '<vm-name>')].{Name:name, RG:resourceGroup}" --output table
```

---

### Step 2: Stop protection and retain data (if necessary)

If you need to keep restore data, stop backup protection before the move.

Use the Azure portal, Azure PowerShell, or Azure CLI to stop backup protection for the VM.

# [Azure portal](#tab/portal)

Follow these steps:

1. Go to **Recovery Services vaults** > your vault > **Backup items** > **Azure Virtual Machine**.
1. Select the VM.
1. Select **Stop backup**.
1. Choose **Retain Backup Data** or **Delete Backup Data** according to your recovery policy.
1. Select **Stop backup**.

For more information, see [Manage Azure VM backups](/azure/backup/backup-azure-manage-vms).

# [Azure PowerShell](#tab/powershell)

Run these commands.

```azurepowershell
$vault = Get-AzRecoveryServicesVault -Name "<vault-name>" -ResourceGroupName "<rg-name>"
Set-AzRecoveryServicesVaultContext -Vault $vault

$backupItem = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureVM -WorkloadType AzureVM -Name "<vm-name>"

# Stop protection and retain data
Disable-AzRecoveryServicesBackupProtection -Item $backupItem -Force
```

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
az backup protection disable \
  --resource-group "<rg-name>" \
  --vault-name "<vault-name>" \
  --container-name "<vm-resource-id>" \
  --item-name "<vm-name>" \
  --backup-management-type AzureIaasVM \
  --delete-backup-data false
```

---

For more information, see [Stop protection for a VM](/azure/backup/backup-azure-manage-vms#stop-protecting-a-vm).

> [!IMPORTANT]
> Verify retention and legal requirements before you delete any backup data.

### Step 3: Remove blocking restore point collections

If restore point collections exist for the VM, remove them before you retry the move.

Use Azure PowerShell or Azure CLI to list and remove restore point collections.

# [Azure portal](#tab/portal)

Restore point collections are hidden resources that you can't see in the Azure portal resource browser. To list and remove these resources, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run this command.

```azurepowershell
Get-AzResource -ResourceType "Microsoft.Compute/restorePointCollections" |
  Where-Object { $_.Name -match "<vm-name>" } |
  ForEach-Object {
    Remove-AzResource -ResourceId $_.ResourceId -Force
  }
```

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
# Find the restore point collection ID
rpcId=$(az resource list --resource-type "Microsoft.Compute/restorePointCollections" \
  --query "[?contains(name, '<vm-name>')].id" --output tsv)

# Delete it
az resource delete --ids $rpcId
```

---

### Step 4: Retry move validation

Retry the move operation from the source resource group. If validation succeeds, proceed with the move.

### Step 5: Re-enable backup at destination

After the move finishes, re-enable backup protection for the VM in the destination resource group.

Use the Azure portal, Azure PowerShell, or Azure CLI to re-enable backup protection for the VM.

# [Azure portal](#tab/portal)

Follow these steps:

1. Go to **Recovery Services vaults** > your vault > **Backup**.
1. Select **Azure Virtual Machine**, and then select **Backup**.
1. Select the moved VM and configure the backup policy.
1. Select **Enable backup**.
1. Run an on-demand backup to verify that restore points are generated.

For more information, see [Manage Azure VM backups](/azure/backup/backup-azure-manage-vms).

# [Azure PowerShell](#tab/powershell)

Run these commands.

```azurepowershell
$vault = Get-AzRecoveryServicesVault -Name "<vault-name>" -ResourceGroupName "<destination-rg>"
Set-AzRecoveryServicesVaultContext -Vault $vault

$policy = Get-AzRecoveryServicesBackupProtectionPolicy -Name "<policy-name>"

Enable-AzRecoveryServicesBackupProtection `
  -ResourceGroupName "<destination-rg>" `
  -Name "<vm-name>" `
  -Policy $policy

# Run an on-demand backup to verify
$backupItem = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureVM -WorkloadType AzureVM -Name "<vm-name>"
Backup-AzRecoveryServicesBackupItem -Item $backupItem
```

# [Azure CLI](#tab/cli)

Run these commands.

```azurecli
az backup protection enable-for-vm \
  --resource-group "<destination-rg>" \
  --vault-name "<vault-name>" \
  --vm "<vm-name>" \
  --policy-name "<policy-name>"

# Run an on-demand backup to verify
az backup protection backup-now \
  --resource-group "<destination-rg>" \
  --vault-name "<vault-name>" \
  --container-name "<vm-resource-id>" \
  --item-name "<vm-name>" \
  --backup-management-type AzureIaasVM
```

---

For more information, see [Back up an Azure VM](/azure/backup/quick-backup-vm-powershell).

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move blocked by failed virtual machine extension](move-resources-extension-failed-state.md)
- [Support matrix for backup and restore of Azure VMs](/azure/backup/backup-support-matrix-iaas)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
