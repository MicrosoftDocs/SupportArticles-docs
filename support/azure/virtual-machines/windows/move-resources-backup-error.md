---
title: Azure resource move fails - VM is configured with Azure Backup
description: Learn how to fix the Azure resource move fails error when a VM uses Azure Backup by removing restore point collections and soft delete blockers. 
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

## Summary

Azure resource move fails when you try to move a virtual machine (VM) that has Azure Backup configured. This issue occurs because restore point collections exist. To resolve this issue, stop the backup, and delete the restore point collections before you move the VM. If soft delete is enabled on the backup vault, wait for soft-deleted restore points to expire, or disable soft delete.

## Symptoms

When you try to move a VM or disk to a different resource group or subscription, the operation fails and returns an error message that resembles the following message:

```output
The move resources request contains resources like /subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Compute/disks/<disk-name> that are being backed up as part of an Azure Backup job.
```

## Cause

Azure Backup creates restore point collections (instant recovery snapshots) that are associated with the VM. These restore point collections are stored in a separate resource group. By default, the group is named `AzureBackupRG_<region>_1`. It must be removed before the VM can be moved.

Additionally, if **soft delete** is enabled for the backup vault, you can't move the VM while soft-deleted restore points exist.

## Resolution

### Step 1: Stop backup and delete restore point collections

**Azure portal**

1. In the [Azure portal](https://portal.azure.com), go to **Recovery Services vault**, and temporarily stop the backup for the VM. Select **Retain backup data**.
1. Find the resource group that contains the restore point collections. If you used the default naming, it follows the pattern, `AzureBackupRG_<location>_1` (for example, `AzureBackupRG_westus2_1`). If you used a custom resource group, search for **Restore Point Collections** in the portal.
1. Find the restore point collection that's named `AzureBackup_<vm-name>_##########`.
1. Delete the restore point collection. This action removes only the instant recovery points. It doesn't delete backed-up data in the vault.
1. After deletion finishes, retry the move operation.

**Azure CLI**

Run the following commands:

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

**Azure PowerShell**

Run the following commands:

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

If soft delete is enabled on the backup vault, and you recently deleted restore points, you must either:

- **Disable soft delete** on the vault, and wait for the points to be purged.
- **Wait 14 days** for soft-deleted restore points to expire automatically.

For more information, see [Soft delete for virtual machines in Azure Backup](/azure/backup/soft-delete-virtual-machines).

### Step 3: Move the VM

After you delete the restore point collections and resolve soft delete, retry the move operation.

### Step 4: Re-enable backup

After the move finishes, reconfigure Azure Backup for the VM in its new location.

## More information

- [Move a Recovery Services vault](/azure/backup/backup-azure-move-recovery-services-vault)
- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Soft delete for virtual machines in Azure Backup](/azure/backup/soft-delete-virtual-machines)
