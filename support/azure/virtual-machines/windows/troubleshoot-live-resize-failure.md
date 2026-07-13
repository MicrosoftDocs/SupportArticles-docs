---
title: Troubleshoot live resize failure for Azure VM managed disks
description: Learn how to resolve the LiveResizeStorageClientFailure error when you try to resize a managed disk on a running Azure VM.
ms.date: 07/10/2026
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, donajilugo, v-leedennis
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Windows (Guest OS)
ms.topic: troubleshooting
---

# Troubleshoot live resize failure for Azure VM managed disks

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article helps you resolve the `LiveResizeStorageClientFailure` error that occurs when you try to resize a managed disk on a running Azure virtual machine (VM). Azure Resource Manager (ARM) accepts the resize operation but the operation fails internally during the live resize process.

## Symptoms

When you try to resize a managed disk that's attached to a running VM, the operation fails with the following error:

```output
Failed to update disk '<DiskName>'. Error: Error resizing disk <DiskName> while it is attached
to running VM(s) /subscriptions/<SubscriptionId>/resourceGroups/<ResourceGroupName>/providers/
Microsoft.Compute/virtualMachines/<VMName>.
```

The error code in the activity log is `LiveResizeStorageClientFailure`.

## Causes

When you resize a managed disk on a running VM, Azure performs a live resize operation. This process involves multiple internal components:

1. Azure Resource Manager accepts the resize request.
1. The Disk Resource Provider (DiskRP) coordinates the resize through a pipeline.
1. The storage node performs the physical disk expansion and validates the disk metadata.

The `LiveResizeStorageClientFailure` error occurs when this internal process fails. The two most common causes are:

- **Timeout during storage operation** — The storage node didn't respond within the expected time frame. This pattern is more common when multiple disks are being resized simultaneously or when automation tools send rapid sequential requests.
- **Internal validation error** — The disk metadata validation failed during the resize operation. This error is an internal platform issue that doesn't indicate a problem with your configuration.

## Resolution

### Step 1: Retry the resize from the Azure portal

If a transient timeout causes the failure, retrying the operation usually succeeds:

1. In the [Azure portal](https://portal.azure.com), go to your disk resource.
1. Select **Size + performance**.
1. Select a new disk size and select **Resize**.

> [!NOTE]
> If you originally used an automation tool or custom script to resize the disk, retry from the Azure portal or an official SDK (Azure PowerShell, Azure CLI) instead. These tools include built-in retry and throttling logic.

If the retry succeeds, no further action is needed.

### Step 2: Detach the disk, resize, and reattach

If the retry doesn't work, detach the data disk from the VM, resize it offline, and then reattach it. The VM stays running during this process.

#### [Azure PowerShell](#tab/powershell)

```powershell
# Detach the data disk
$vm = Get-AzVM -ResourceGroupName "<ResourceGroupName>" -Name "<VMName>"
Remove-AzVMDataDisk -VM $vm -Name "<DiskName>"
Update-AzVM -ResourceGroupName "<ResourceGroupName>" -VM $vm

# Resize the disk (now unattached)
$disk = Get-AzDisk -ResourceGroupName "<ResourceGroupName>" -DiskName "<DiskName>"
$disk.DiskSizeGB = <NewSizeGB>
Update-AzDisk -ResourceGroupName "<ResourceGroupName>" -Disk $disk -DiskName $disk.Name

# Reattach the data disk
$disk = Get-AzDisk -ResourceGroupName "<ResourceGroupName>" -DiskName "<DiskName>"
Add-AzVMDataDisk -VM $vm -Name "<DiskName>" -ManagedDiskId $disk.Id -Lun <LUN> -CreateOption Attach
Update-AzVM -ResourceGroupName "<ResourceGroupName>" -VM $vm
```

#### [Azure CLI](#tab/cli)

```azurecli
# Detach the data disk
az vm disk detach --resource-group <ResourceGroupName> --vm-name <VMName> --name <DiskName>

# Resize the disk (now unattached)
az disk update --resource-group <ResourceGroupName> --name <DiskName> --size-gb <NewSizeGB>

# Reattach the data disk
az vm disk attach --resource-group <ResourceGroupName> --vm-name <VMName> --name <DiskName>
```

---

Verify that the disk shows the new size:

#### [Azure PowerShell](#tab/powershell-verify)

```powershell
Get-AzDisk -ResourceGroupName "<ResourceGroupName>" -DiskName "<DiskName>" |
    Select-Object Name, DiskSizeGB, DiskState
```

#### [Azure CLI](#tab/cli-verify)

```azurecli
az disk show --resource-group <ResourceGroupName> --name <DiskName> --query "{Name:name, SizeGB:diskSizeGb, State:diskState}" --output table
```

---

The output should show the new disk size and the disk state as `Attached`.

### Step 3: Deallocate the VM and resize offline

If you can't detach the disk (for example, it's an OS disk), deallocate the VM and resize it:

#### [Azure PowerShell](#tab/powershell-offline)

```powershell
# Deallocate the VM
Stop-AzVM -ResourceGroupName "<ResourceGroupName>" -Name "<VMName>" -Force

# Resize the disk
$disk = Get-AzDisk -ResourceGroupName "<ResourceGroupName>" -DiskName "<DiskName>"
$disk.DiskSizeGB = <NewSizeGB>
Update-AzDisk -ResourceGroupName "<ResourceGroupName>" -Disk $disk -DiskName $disk.Name

# Start the VM
Start-AzVM -ResourceGroupName "<ResourceGroupName>" -Name "<VMName>"
```

#### [Azure CLI](#tab/cli-offline)

```azurecli
# Deallocate the VM
az vm deallocate --resource-group <ResourceGroupName> --name <VMName>

# Resize the disk
az disk update --resource-group <ResourceGroupName> --name <DiskName> --size-gb <NewSizeGB>

# Start the VM
az vm start --resource-group <ResourceGroupName> --name <VMName>
```

If none of the preceding steps resolve the issue, [contact Azure Support](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade).

## References

- [Start here for troubleshooting Azure VM disk resize issues](troubleshoot-disk-resize-overview.md)
- [Expand virtual hard disks on a Windows VM](/azure/virtual-machines/windows/expand-os-disk)
- [Expand virtual hard disks on a Linux VM](/azure/virtual-machines/linux/expand-disks)
- [Troubleshoot Azure VM disk resize errors](troubleshoot-disk-resize-errors.md)
