---
title: Troubleshoot Azure VM disk resize errors
description: Resolve Azure VM disk resize errors for live resize and running VM scenarios. Use these steps to fix failures quickly and restore operations.
ms.date: 07/10/2026
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, donajilugo, v-leedennis
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Windows (Guest OS)
ms.topic: troubleshooting
---

# Troubleshoot Azure VM disk resize errors

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article helps you troubleshoot Azure VM disk resize errors when you try to resize a managed disk on an Azure virtual machine (VM). These errors appear in the Azure portal, Azure CLI, or Azure PowerShell when the platform blocks the resize operation. The most common causes are that the VM size (SKU) doesn't support live disk resize, the disk is a shared disk, or the VM must be deallocated first.

## Symptoms

When you try to resize a managed disk that's attached to a running VM, you receive one of the following error messages.

### Error: ChangeDiskSizeWhileAttachedNotAllowed

```output
{
  "innererror": {
    "internalErrorCode": "ChangeDiskSizeWhileAttachedNotAllowed"
  },
  "code": "OperationNotAllowed",
  "message": "Cannot resize disk <DiskName> while it is attached to running VM <VMResourceId>. Resizing a disk of an Azure Virtual Machine requires the virtual machine to be deallocated. Please stop your VM and retry the operation."
}
```

### Error: LiveDiskPropertyChangeOfVMOfSizeNotSupported

```output
{
  "innererror": {
    "internalErrorCode": "LiveDiskPropertyChangeOfVMOfSizeNotSupported"
  },
  "code": "OperationNotAllowed",
  "message": "Change in disk property of VM of size <VMSize> is not supported."
}
```

### Error: LiveResizeSharedDiskNotAllowed

```output
{
  "innererror": {
    "internalErrorCode": "LiveResizeSharedDiskNotAllowed"
  },
  "code": "OperationNotAllowed",
  "message": "Cannot resize shared disk <DiskName> while it is attached to running VM(s)."
}
```

> [!NOTE]
> When you use the Azure CLI to resize a shared disk, the error message might not include the word "shared." Instead, the message reads: "Cannot resize disk \<DiskName\> while it is attached to running VM ... Resizing a disk of an Azure Virtual Machine requires the virtual machine to be deallocated." The underlying error code is the same.

## Causes

Azure supports resizing managed disks without deallocating the VM (live resize), but only under specific conditions:

- **VM SKU must support live resize.** Not all VM sizes support expanding disks while the VM is running. VMs that support live resize include those with Premium Storage capability, ephemeral OS disk support, or Hyper-V Generation 2 capability.
- **OS disk live resize has additional requirements.** Unlike data disks, OS disk live resize requires the VM to be running a supported SKU **and** the disk to use a supported storage type. If the VM SKU or disk configuration doesn't meet these requirements, you must deallocate the VM first. For detailed requirements, see [Expand without downtime](/azure/virtual-machines/windows/expand-os-disk#expand-without-downtime).
- **Shared disks can't be live-resized.** If the disk has `maxShares` set to a value greater than 1, the disk can't be resized while it's attached to any running VM. You must deallocate all VMs that the disk is attached to (or detach the disk from all VMs) before you resize it.
- **Disk type restrictions apply.** Ultra Disks and Premium SSD v2 disks have specific live resize rules that differ from Standard and Premium SSD disks.

> [!NOTE]
> The error messages shown in this article reflect the raw Azure Resource Manager (ARM) REST API response format, which includes `innererror.internalErrorCode`. When you use the Azure CLI or Azure PowerShell, the output might show a simplified error message without the `innererror` block. The error code and resolution are the same regardless of the tool you use.

## Resolution

### Step 1: Verify whether your VM SKU supports live resize

Run the following Azure PowerShell script to list VM SKUs in your region that support live data disk resize:

```powershell
Connect-AzAccount
$subscriptionId = "<your-subscription-id>"
$location = "<your-region>"
Set-AzContext -Subscription $subscriptionId

$vmSizes = Get-AzComputeResourceSku -Location $location |
    Where-Object { $_.ResourceType -eq "virtualMachines" }

foreach ($vmSize in $vmSizes) {
    foreach ($capability in $vmSize.Capabilities) {
        if (($capability.Name -eq "EphemeralOSDiskSupported" -and $capability.Value -eq "True") -or
            ($capability.Name -eq "PremiumIO" -and $capability.Value -eq "True") -or
            ($capability.Name -eq "HyperVGenerations" -and $capability.Value -match "V2")) {
            $vmSize.Name
            break
        }
    }
}
```

If your VM SKU doesn't appear in the output, live data disk resize isn't supported. Proceed to Step 2.

### Step 2: Deallocate the VM and resize

If live resize isn't supported for your VM SKU, or if you're resizing an OS disk, deallocate the VM first:

#### [Azure PowerShell](#tab/powershell)

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

#### [Azure CLI](#tab/cli)

```azurecli
# Deallocate the VM
az vm deallocate --resource-group <ResourceGroupName> --name <VMName>

# Resize the disk
az disk update --resource-group <ResourceGroupName> --name <DiskName> --size-gb <NewSizeGB>

# Start the VM
az vm start --resource-group <ResourceGroupName> --name <VMName>
```

---

### Step 3: Resize a shared disk

If you receive the `LiveResizeSharedDiskNotAllowed` error, you must detach the disk from all VMs before you resize it:

1. Detach the shared disk from every VM that it's attached to.
1. Resize the disk by using the Azure portal, Azure PowerShell, or Azure CLI.
1. Reattach the disk to the VMs.

> [!NOTE]
> Detaching a shared disk might interrupt workloads that use the disk, such as Windows Server Failover Clustering (WSFC) or shared data scenarios. Plan for a maintenance window.

### Step 4: Resize by detaching (VM stays running)

If you don't want to deallocate the VM, you can detach the data disk, resize it offline, and reattach it:

#### [Azure PowerShell](#tab/powershell-detach)

```powershell
# Detach the data disk
$vm = Get-AzVM -ResourceGroupName "<ResourceGroupName>" -Name "<VMName>"
Remove-AzVMDataDisk -VM $vm -Name "<DiskName>"
Update-AzVM -ResourceGroupName "<ResourceGroupName>" -VM $vm

# Resize the disk
$disk = Get-AzDisk -ResourceGroupName "<ResourceGroupName>" -DiskName "<DiskName>"
$disk.DiskSizeGB = <NewSizeGB>
Update-AzDisk -ResourceGroupName "<ResourceGroupName>" -Disk $disk -DiskName $disk.Name

# Reattach the data disk
$disk = Get-AzDisk -ResourceGroupName "<ResourceGroupName>" -DiskName "<DiskName>"
Add-AzVMDataDisk -VM $vm -Name "<DiskName>" -ManagedDiskId $disk.Id -Lun <LUN> -CreateOption Attach
Update-AzVM -ResourceGroupName "<ResourceGroupName>" -VM $vm
```

#### [Azure CLI](#tab/cli-detach)

```azurecli
# Detach the data disk
az vm disk detach --resource-group <ResourceGroupName> --vm-name <VMName> --name <DiskName>

# Resize the disk
az disk update --resource-group <ResourceGroupName> --name <DiskName> --size-gb <NewSizeGB>

# Reattach the data disk
az vm disk attach --resource-group <ResourceGroupName> --vm-name <VMName> --name <DiskName>
```

---

> [!IMPORTANT]
> This approach works only for data disks. You can't detach an OS disk from a running VM.

If none of the preceding steps resolve the issue, [contact Azure Support](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade).

## References

- [Start here for troubleshooting Azure VM disk resize issues](troubleshoot-disk-resize-overview.md)
- [Expand virtual hard disks on a Windows VM](/azure/virtual-machines/windows/expand-os-disk)
- [Expand virtual hard disks on a Linux VM](/azure/virtual-machines/linux/expand-disks)
- [Azure managed disk types](/azure/virtual-machines/disks-types)
- [Troubleshoot live resize failure](troubleshoot-live-resize-failure.md)
