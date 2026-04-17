---
title: Convert unmanaged disks to managed disks for an Azure virtual machine
description: Learn how to convert unmanaged disks to Azure managed disks for a virtual machine by using the Azure portal, PowerShell, or Azure CLI.
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

# Convert unmanaged disks to managed disks for an Azure virtual machine

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article describes how to convert a virtual machine's unmanaged disks to Microsoft Azure-managed disks. Managed disks are required for many modern Azure virtual machine (VM) operations, including certain move and migration scenarios.

## Before you begin

Review the following important considerations before you convert:

- **The conversion isn't reversible:** After you convert disks to managed disks, you can't revert them to unmanaged.
- **Test before production:** Migrate a test VM before you convert a production workload.
- **The VM restarts:** The conversion process deallocates the VM. When the VM restarts, it gets a new IP address, unless you configure a static IP.
- **Agent version requirements:** Verify that the Azure VM agent is at the minimum supported version. For more information, see [Minimum version support for VM agents in Azure](/azure/virtual-machines/extensions/agent-windows).
- **Extensions must be in a succeeded state:** All VM extensions must be in the `Provisioning succeeded` state before conversion. Otherwise, the conversion fails and returns error code **409**.
- **Original virtual hard disks (VHDs) aren't deleted:** The original VHD blobs and the storage account that the VM used before migration aren't deleted automatically. You continue to incur charges until you manually delete these items after you verify the migration.
- **Virtual Machine Contributor role:** After conversion, users who have the Virtual Machine Contributor role must have the `Microsoft.Compute/disks/write` permission in order to change the VM size.

## Convert using the Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com).

1. Go to the VM that you want to convert.

1. Under **Settings**, select **Disks**.

1. At the top of the **Disks** pane, select **Migrate to managed disks**.

   > [!NOTE]
   > If your VM is in an **availability set**, a warning appears and indicates that you must migrate the availability set first. Select the link in the warning to migrate the availability set, and then return to migrate the individual VM.

1. On **Migrate to managed disks**, review the disks to convert, and then select **Migrate**. The VM is stopped and restarted after the migration finishes.

## Convert by using Azure PowerShell

Run the following commands:

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

## Convert by using Azure CLI

Run the following commands:

```azurecli
# Stop and deallocate the VM
az vm deallocate --resource-group <rg-name> --name <vm-name>

# Convert to managed disks
az vm convert --resource-group <rg-name> --name <vm-name>

# Start the VM
az vm start --resource-group <rg-name> --name <vm-name>
```

## Clean up original VHD blobs

To avoid ongoing storage charges, delete the original VHD blobs after you verify that the conversion is successful.

To find unattached unmanaged disks in your subscription, see [Find and delete unattached Azure managed and unmanaged disks](/azure/virtual-machines/windows/find-unattached-disks).

## Troubleshooting

| Error | Cause | Resolution |
|---|---|---|
| Extension `'<ext>'` isn't in a succeeded state. | A VM extension is in a failed or transitioning state. | Resolve the extension issue before you retry the conversion. |
| VM in availability set must be stopped. | The availability set isn't converted yet. | Convert the availability set first, then retry. |
| Storage account doesn't exist. | Boot diagnostics references a deleted storage account. | See [Move fails due to invalid storage account](move-resources-invalid-storage-account.md). The same resolution applies: Reconfigure the boot diagnostics. |

## Next steps

- [Convert unmanaged to managed disks — full documentation](/azure/virtual-machines/windows/convert-unmanaged-to-managed-disks)
- [Managed disks FAQ](/azure/virtual-machines/faq-for-disks)
- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
