---
title: Convert unmanaged disks to managed disks for an Azure VM
description: How to convert a virtual machine's unmanaged disks to Azure managed disks using the Azure portal, PowerShell, or Azure CLI.
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

# Convert unmanaged disks to managed disks for an Azure VM

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

This article describes how to convert a virtual machine's unmanaged disks to Azure managed disks. Managed disks are required for many modern Azure VM operations including certain move and migration scenarios.

## Before you begin

Review the following important considerations before converting:

- **The conversion isn't reversible.** Once disks are converted to managed disks, they can't be converted back to unmanaged.
- **Test before production.** Migrate a test virtual machine before converting production workloads.
- **The VM will restart.** The VM is deallocated during the conversion and receives a new IP address when restarted (unless a static IP is configured).
- **Agent version requirements.** Verify that the Azure VM agent is at the minimum supported version. See [Minimum version support for VM agents in Azure](/azure/virtual-machines/extensions/agent-windows).
- **Extensions must be in a succeeded state.** All VM extensions must be in the `Provisioning succeeded` state before conversion, or the conversion fails with error code 409.
- **Original VHDs aren't deleted.** The original VHD blobs and the storage account used by the VM before migration aren't deleted automatically. They continue to incur charges until you manually delete them after verifying the migration.
- **Virtual Machine Contributor role.** After conversion, users with the Virtual Machine Contributor role require the `Microsoft.Compute/disks/write` permission to change the VM size, which they may not have had before.

## Convert using the Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com).

2. Navigate to the virtual machine you want to convert.

3. Under **Settings**, select **Disks**.

4. At the top of the **Disks** pane, select **Migrate to managed disks**.

   > [!NOTE]
   > If your VM is in an **availability set**, a warning appears indicating that you must migrate the availability set first. Select the link in the warning to migrate the availability set, then return to migrate the individual VM.

5. On the **Migrate to managed disks** pane, review the disks to be converted and select **Migrate**.

6. The VM is stopped and restarted after the migration completes.

## Convert using Azure PowerShell

```powershell
# Stop and deallocate the VM
Stop-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>" -Force

# Convert to managed disks
ConvertTo-AzVMManagedDisk -ResourceGroupName "<rg-name>" -VMName "<vm-name>"
```

For VMs in an availability set, convert the availability set first:

```powershell
# Convert all VMs in an availability set
$avSet = Get-AzAvailabilitySet -ResourceGroupName "<rg-name>" -Name "<avset-name>"
foreach ($vmRef in $avSet.VirtualMachinesReferences) {
    $vmId = $vmRef.Id
    $vmName = $vmId.Split('/')[-1]
    Stop-AzVM -ResourceGroupName "<rg-name>" -Name $vmName -Force
    ConvertTo-AzVMManagedDisk -ResourceGroupName "<rg-name>" -VMName $vmName
}
```

## Convert using Azure CLI

```azurecli
# Stop and deallocate the VM
az vm deallocate --resource-group <rg-name> --name <vm-name>

# Convert to managed disks
az vm convert --resource-group <rg-name> --name <vm-name>

# Start the VM
az vm start --resource-group <rg-name> --name <vm-name>
```

## Clean up original VHD blobs

After verifying the conversion is successful, delete the original VHD blobs to avoid ongoing storage charges.

To find unattached unmanaged disks in your subscription, see [Find and delete unattached Azure managed and unmanaged disks](/azure/virtual-machines/windows/find-unattached-disks).

## Troubleshooting

| Error | Cause | Resolution |
|---|---|---|
| Extension `'<ext>'` is not in a succeeded state | A VM extension is in a failed or transitioning state | Resolve the extension issue before retrying the conversion |
| VM in availability set must be stopped | The availability set has not been converted | Convert the availability set first, then retry |
| Storage account does not exist | Boot diagnostics references a deleted storage account | See [Move fails due to invalid storage account](move-resources-invalid-storage-account.md) — same resolution applies: reconfigure boot diagnostics |

## Next steps

- [Convert unmanaged to managed disks — full documentation](/azure/virtual-machines/windows/convert-unmanaged-to-managed-disks)
- [Managed disks FAQ](/azure/virtual-machines/faq-for-disks)
- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
