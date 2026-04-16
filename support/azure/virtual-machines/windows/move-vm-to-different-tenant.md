---
title: Move Azure VM resources to a different tenant
description: Learn why moving Azure virtual machine resources to a subscription in a different tenant is not directly supported, and the available workarounds.
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

# Move Azure VM resources to a different tenant

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

Azure Resource Manager doesn't support moving Azure resources directly to a subscription in a different Microsoft Entra ID tenant. For a standard resource move to succeed, the source and destination subscriptions must be in the same tenant.

This article describes two workarounds for customers who need to move virtual machine (VM) resources across tenant boundaries.

## Why direct cross-tenant move isn't supported

The Azure Resource Manager move API validates that both the source and destination subscriptions belong to the same Microsoft Entra ID tenant. If they don't, the move validation fails. This limitation is a platform constraint, not a configuration issue.

## Workaround 1: Move the subscription to the destination tenant

If you want to move all resources in a subscription to a different tenant, you can transfer the subscription itself.

1. In the source tenant, create a new subscription (or use an existing empty one).
1. Move the resources to that new subscription by using the standard resource move operation (within the same tenant).
1. Transfer the subscription to the destination tenant. The Azure Subscription Management team manages this process.
1. After the subscription transfer completes, move the resources from the transferred subscription to the target subscription in the destination tenant if needed.

> [!NOTE]
> Transferring a subscription to a different tenant requires Azure Subscription Management team assistance. Open a support request with the support topic: **Azure / Subscription Management / Transfer ownership of my subscription / Change subscription Microsoft Entra ID**.

For more information, see [Transfer an Azure subscription to a different Microsoft Entra ID directory](/azure/role-based-access-control/transfer-subscription).

## Workaround 2: Copy VM disks by using Azure Storage Explorer (VMs only)

This workaround applies to VMs only. It involves copying the VM's managed disks to the destination tenant and recreating the VM there.

### Prerequisites

- Access to both the source and destination tenant accounts in Azure Storage Explorer.
- A destination resource group and virtual network already created in the destination tenant.

### Steps

1. Stop and deallocate the source VM in the [Azure portal](https://portal.azure.com).

2. Open Azure Storage Explorer and sign in with both the source and destination tenant accounts.

3. In the source tenant account, locate the managed OS disk and any data disks attached to the VM.

4. Copy each disk to the destination tenant.
    1. Right-click the disk and select **Copy**.
    1. Navigate to the destination tenant account and the destination resource group.
    1. Select **Paste** in the destination container.
    
5. Once all disk copies are complete, create a new VM from the copied OS disk in the destination tenant

**Azure PowerShell**

   ```azurepowershell
   # Get the copied disk
   $disk = Get-AzDisk -ResourceGroupName "<destination-rg>" -DiskName "<copied-os-disk-name>"

   # Create VM configuration
   $vmConfig = New-AzVMConfig -VMName "<new-vm-name>" -VMSize "<vm-size>"
   $vmConfig = Set-AzVMOSDisk -VM $vmConfig -ManagedDiskId $disk.Id -CreateOption Attach -Windows

   # Attach to an existing NIC
   $nic = Get-AzNetworkInterface -ResourceGroupName "<destination-rg>" -Name "<nic-name>"
   $vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id $nic.Id

   # Create the VM
   New-AzVM -ResourceGroupName "<destination-rg>" -Location "<location>" -VM $vmConfig
   ```

6. Verify the new VM starts and operates correctly in the destination tenant.

7. Once verified, delete the source VM and its resources in the source tenant if no longer needed.

> [!IMPORTANT]
> Any VM extensions, managed identities, or Entra ID-integrated services must be reconfigured in the destination tenant after recreation.

## Next steps

- [Transfer an Azure subscription to a different MicrosoftEntra ID directory](/azure/role-based-access-control/transfer-subscription)
- [Create a VM from a managed disk](/azure/virtual-machines/windows/create-vm-specialized)
- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Tenant not authorized to access linked subscription](move-resources-tenant-not-authorized.md)
