---
title: Move Azure VM resources to a different subscription in a different tenant
description: Learn how to move Azure VM resources to a subscription in a different tenant. Compare supported migration paths, and choose the best option.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/21/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Move Azure virtual machine resources to a subscription in a different tenant

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

The Azure Resource Manager (ARM) move API doesn't support moving virtual machine (VM) resources to a subscription in a different Microsoft Entra ID tenant. If the source and destination subscriptions belong to different tenants, the move validation fails immediately. This limitation is a platform constraint, not a configuration issue.

This article describes the supported migration paths for customers who have to move VMs across tenant boundaries.

### Check whether the source and destination tenants differ

To check whether the source and destination subscriptions are in different tenants, use Azure PowerShell or Azure CLI to run the following commands.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
# Source subscription tenant
(Get-AzSubscription -SubscriptionId "<source-subscription-id>").TenantId

# Destination subscription tenant  
(Get-AzSubscription -SubscriptionId "<destination-subscription-id>").TenantId
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az account show --subscription "<source-subscription-id>" --query "tenantId"
az account show --subscription "<destination-subscription-id>" --query "tenantId"
```

# [Azure portal](#tab/portal)

This operation isn't available in the Azure portal. Use Azure PowerShell or Azure CLI.

---

If the two tenant IDs differ, use one of the supported paths described in the following section. If the IDs match, you can use a standard resource move.

### Supported migration paths

#### Path 1: Transfer the source subscription to the destination tenant

If you want to move all resources in the source subscription to the destination tenant, transfer the subscription itself.

This path works well if the following conditions are met:

- You want to move all resources in the subscription to the destination tenant.
- You can tolerate a transfer process that might take several hours.

Follow these steps:

1. Move the VM and its dependent resources to a dedicated resource group within the source subscription. This step isolates the resources from any resources that you want to retain in the source tenant.
1. Remove role assignments that reference users or service principals in the source tenant. These assignments become invalid after the subscription transfers.
1. Submit a subscription transfer request by opening a support case that has the following topic: **Azure / Subscription Management / Transfer ownership of my subscription / Change subscription Entra ID**.
1. After the transfer finishes, re-create role assignments by using identities in the destination tenant.

For more detailed steps, see [Transfer an Azure subscription to a different Entra ID directory](/azure/role-based-access-control/transfer-subscription).

> [!IMPORTANT]
> A subscription transfer removes all Azure RBAC role assignments. All management access disappears at the time of transfer. Plan access recovery before you start.

#### Path 2: Replicate the VM by using Azure Migrate

Azure Migrate supports cross-tenant VM migration by replicating disk data to the destination tenant. The source VM continues to run during replication, and is cut over at a scheduled time.

This path works well if the following conditions are met:

- You move only specific VMs to the destination tenant.
- You have to minimize downtime during the migration.
- You want to retain the source copy until the migration validates successfully.

Ensure you meet the following prerequisites:

- An Azure Migrate project is in the destination subscription.
- The **Azure Migrate: Server Migration** tool is added to the project.
- A Recovery Services vault replication appliance or agentless replication is configured.

Follow these steps:

1. In the destination tenant, create an Azure Migrate project: **Azure Migrate** > **Create project**.
2. Add the **Azure Migrate: Server Migration** tool to the project.
3. Set up the replication appliance in the source environment, or enable agentless replication if the source VMs run on VMware or are Azure VMs.
4. Discover and add the source VMs to the migration project.
5. Start replication. Azure Migrate copies the disk data to a staging storage account in the destination subscription.
6. Run a **Test migration** operation to verify that the VM starts correctly in the destination tenant.
7. Run the **Migrate** operation to complete the cutover. This operation stops the source VM and transfers all remaining data.
8. Decommission the source VM after you verify that the destination VM functions correctly.

For full service guidance, see [What is Azure Migrate?](/azure/migrate/migrate-services-overview).

#### Path 3: Copy managed disks by using Azure Storage and re-create the VM

This path works well for a small number of VMs if Azure Migrate isn't available and you need direct control over each disk copy.

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), stop and deallocate the source VM.
2. For each managed disk, use Azure PowerShell or Azure CLI to create a shared access signature (SAS) URL:

   # [Azure PowerShell](#tab/powershell)
   
   Run the following command.

   ```azurepowershell
   $sas = Grant-AzDiskAccess `
     -ResourceGroupName "<source-rg>" `
     -DiskName "<disk-name>" `
     -Access Read `
     -DurationInSecond 3600
   $sas.AccessSAS
   ```

   # [Azure CLI](#tab/cli)

   Run the following command.

   ```azurecli
   az disk grant-access --resource-group "<source-rg>" --name "<disk-name>" \
     --access-level Read --duration-in-seconds 3600 --query "accessSas" -o tsv
   ```

   # [Azure portal](#tab/portal)

   This operation isn't available in the Azure portal. Use Azure PowerShell or Azure CLI.

   ---

1. In the destination subscription, use a command-line interface tool to create a destination storage account, and copy the disk by using AzCopy.

  Run the following command.

   ```bash
   azcopy copy "<source-sas-url>" "https://<destination-storage>.blob.core.windows.net/<container>/<disk-name>.vhd"
   ```

1. Use Azure PowerShell or Azure CLI to create a managed disk in the destination subscription from the copied virtual hard disk (VHD).

   # [Azure PowerShell](#tab/powershell)

   Run the following commands.

   ```azurepowershell
   $diskConfig = New-AzDiskConfig `
     -Location "<destination-region>" `
     -CreateOption Import `
     -StorageAccountId "<storage-account-id>" `
     -SourceUri "https://<destination-storage>.blob.core.windows.net/<container>/<disk-name>.vhd"

   New-AzDisk -ResourceGroupName "<destination-rg>" -DiskName "<new-disk-name>" -Disk $diskConfig
   ```

   # [Azure CLI](#tab/cli)

   Run the following command.

   ```azurecli
   az disk create --resource-group "<destination-rg>" --name "<new-disk-name>" \
     --location "<destination-region>" \
     --source "https://<destination-storage>.blob.core.windows.net/<container>/<disk-name>.vhd" \
     --storage-account-id "<storage-account-id>"
   ```

   # [Azure portal](#tab/portal)

   This operation isn't available in the Azure portal. Use Azure PowerShell or Azure CLI.

   ---

1. Use Azure PowerShell or Azure CLI to re-create the VM in the destination tenant by attaching the new OS disk.

   # [Azure PowerShell](#tab/powershell)

   Run the following commands.

   ```azurepowershell
   $disk = Get-AzDisk -ResourceGroupName "<destination-rg>" -DiskName "<new-disk-name>"
   $vmConfig = New-AzVMConfig -VMName "<new-vm-name>" -VMSize "<vm-size>"
   $vmConfig = Set-AzVMOSDisk -VM $vmConfig -ManagedDiskId $disk.Id -CreateOption Attach -Windows
   $nic = Get-AzNetworkInterface -ResourceGroupName "<destination-rg>" -Name "<nic-name>"
   $vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id $nic.Id
   New-AzVM -ResourceGroupName "<destination-rg>" -Location "<destination-region>" -VM $vmConfig
   ```

   # [Azure CLI](#tab/cli)

   Run the following command.

   ```azurecli
   az vm create --resource-group "<destination-rg>" --name "<new-vm-name>" \
     --attach-os-disk "<new-disk-name>" --os-type Windows \
     --size "<vm-size>" --location "<destination-region>" \
     --nics "<nic-name>"
   ```

   # [Azure portal](#tab/portal)

   This operation isn't available in the Azure portal. Use Azure PowerShell or Azure CLI.

   ---

1. Use Azure PowerShell or Azure CLI to revoke the SAS access after the copy finishes.

  # [Azure PowerShell](#tab/powershell)

   Run the following command.

   ```azurepowershell
   Revoke-AzDiskAccess -ResourceGroupName "<source-rg>" -DiskName "<disk-name>"
   ```

  # [Azure CLI](#tab/cli)

   Run the following command.

   ```azurecli
   az disk revoke-access --resource-group "<source-rg>" --name "<disk-name>"
   ```

  # [Azure portal](#tab/portal)

   This operation isn't available in the Azure portal. Use Azure PowerShell or Azure CLI.

---

### Comparison of migration paths

The following table compares the different migration paths for Azure VMs.

| Path | Best for | Downtime | Requires support request |
|---|---|---|---|
| Subscription transfer | All resources move together | Moderate (transfer time) | Yes |
| Azure Migrate replication | Specific VMs, minimal downtime | Minimal (cutover only) | No |
| Disk copy and VM re-creation | Small number of VMs, no Azure Migrate | Full (VM stopped during copy) | No |

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [What is Azure Migrate?](/azure/migrate/migrate-services-overview)
- [Transfer an Azure subscription to a different Azure AD directory](/azure/role-based-access-control/transfer-subscription)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
