---
title: Azure resource move fails - VM is configured with Azure Backup
description: Troubleshoot the error that occurs when trying to move a virtual machine that has Azure Backup configured.
services: virtual-machines
author: scotro
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 03/18/2026
ms.author: scotro
ms.reviewer: jarrettr
ms.custom: sap:Cannot create a VM
---
# Azure resource move fails because the VM is configured with Azure Backup

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Symptoms

When you try to move a virtual machine or disk to a different resource group or subscription, the operation fails with an error similar to the following:

```output
The move resources request contains resources like /subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Compute/disks/<disk-name> that are being backed up as part of an Azure Backup job.
```

## Cause

Azure Backup creates **restore point collections** (instant recovery snapshots) that are associated with the VM. These restore point collections are stored in a separate resource group (by default named `AzureBackupRG_<region>_1`) and must be removed before the VM can be moved.

Additionally, if **soft delete** is enabled for the backup vault, you cannot move the VM while soft-deleted restore points exist.

## Resolution

### Step 1: Stop backup and delete restore point collections

**Azure portal**

1. In the Azure portal, go to the **Recovery Services vault** and temporarily stop the backup for the VM, selecting **Retain backup data**.
2. Find the resource group that contains the restore point collections. If you used the default naming, it follows the pattern `AzureBackupRG_<location>_1` (for example, `AzureBackupRG_westus2_1`). If you used a custom resource group, search for **Restore Point Collections** in the portal.
3. Find the restore point collection named `AzureBackup_<vm-name>_##########`.
4. Delete the restore point collection. This only removes the instant recovery points — it does not delete backed-up data in the vault.
5. After deletion completes, proceed with the move.

**Azure CLI**

```azurecli
# Find the restore point collection resource group
az resource list --resource-type Microsoft.Compute/restorePointCollections \
  --query "[?starts_with(name, 'AzureBackup_<vm-name>')].resourceGroup"

# Delete the restore point collection
RESTOREPOINTCOL=$(az resource list -g AzureBackupRG_<location>_1 \
  --resource-type Microsoft.Compute/restorePointCollections \
  --query "[?starts_with(name, 'AzureBackup_<vm-name>')].id" --output tsv)
az resource delete --ids $RESTOREPOINTCOL
```

**PowerShell**

```powershell
# Find the restore point collection resource group
(Get-AzResource -ResourceType Microsoft.Compute/restorePointCollections `
  -Name "AzureBackup_<vm-name>*").ResourceGroupName

# Delete the restore point collection
$restorePointCollection = Get-AzResource `
  -ResourceGroupName "AzureBackupRG_<location>_1" `
  -Name "AzureBackup_<vm-name>*" `
  -ResourceType Microsoft.Compute/restorePointCollections
Remove-AzResource -ResourceId $restorePointCollection.ResourceId -Force
```

### Step 2: Handle soft delete (if enabled)

If soft delete is enabled on the backup vault and restore points were recently deleted, you must either:

- **Disable soft delete** on the vault and wait for the points to be purged, OR
- **Wait 14 days** for soft-deleted restore points to expire automatically.

See [Soft delete for virtual machines in Azure Backup](/azure/backup/soft-delete-virtual-machines).

### Step 3: Move the VM

After the restore point collections are deleted (and soft delete is resolved), retry the move operation.

### Step 4: Re-enable backup

After the move completes, reconfigure Azure Backup for the VM in its new location.

## More information

- [Move a Recovery Services vault](/azure/backup/backup-azure-move-recovery-services-vault)
- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Soft delete for virtual machines in Azure Backup](/azure/backup/soft-delete-virtual-machines)
