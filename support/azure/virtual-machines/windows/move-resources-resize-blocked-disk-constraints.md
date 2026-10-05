---
title: Move fails because the VM size is not available at the destination
description: Troubleshoot Azure VM move failures when the destination doesn't support the required VM size or disk constraints block startup. Follow these steps to fix and retry.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/15/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted

---

# Move fails because the required virtual machine size isn't available at the destination

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to troubleshoot Azure virtual machine (VM) move failures that occur when the required VM size isn't available at the destination, or when disk type constraints prevent the VM from starting after the move. It provides steps to verify size availability, check disk compatibility, and ensure a successful move.

## Symptoms

When you move a VM to another region or resource group, the move might fail and generate one of the following error messages:

```output
The requested VM size '<vm-size>' is currently not available in location '<destination-region>'.
```

```output
Operation 'startTenantUpdate' is not allowed on VM '<vm-name>' since the VM is being deallocated.
Please try again later.
```

In other cases, the move finishes, but the VM doesn't start at the destination.

## Cause

Most size-related move failures have one of the following causes.

### Cause 1: VM size isn't available at the destination

The destination region doesn't support the source VM size.

### Cause 2: Disk type incompatibility after resize

The target size is incompatible with the current disk layout. This issue is common when you switch between families that differ in local temporary disk support.

## Resolution

### Resolution 1: Verify size availability at the destination

Before the move, use Azure PowerShell or Azure CLI to check whether the target size exists in the destination region.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzVMSize -Location "<destination-region>" | Where-Object { $_.Name -eq "<vm-size>" }
```

To find regions where a specific size is available, run the following command.

```azurepowershell
Get-AzComputeResourceSku | Where-Object {
  $_.ResourceType -eq "virtualMachines" -and $_.Name -eq "<vm-size>"
} | Select-Object -ExpandProperty Locations
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm list-skus --location "<destination-region>" --size "<vm-size>" \
  --query "[].{Name:name, Zones:locationInfo[].zones}" --output table
```

# [Azure portal](#tab/portal)

You can't query VM size availability by region in the [Azure portal](https://portal.azure.com). To check whether a specific size is supported at the destination, use Azure PowerShell or Azure CLI.

---

If the command returns no output, the size isn't available in that region.

To resolve this issue, use one of the following methods:

- Select a different destination region.
- Resize the VM before the move to a size that's available in both regions.

### Resolution 2: Avoid incompatible disk type changes

Before you resize after a move, verify that the current and target sizes are in compatible families.

#### Check the current disk family

Resource-disk sizes include a local temporary disk (`D:` on Windows or `/dev/sdb` on Linux). Non-resource-disk sizes don't include a local temporary disk.

Resource-disk family examples include the following: `Dsv3`, `Dv3`, `Esv3`, `Ev3`, `Fsv2`.

Non-resource-disk family examples include the following: `Dsv5`, `Dv5`, `Dasv5`, `Dav4`.

Switching families after a move often requires changes to the operating system configuration.

If you must switch disk families, complete these steps before you move:

1. Record any application data that's stored on the temporary disk.
1. Update the application or operating system configuration so that it no longer writes to `D:\Temp` (Windows) or `/mnt` (Linux).
1. Complete the move.
1. Resize to the target size.

> [!NOTE]
> You lose data on the local temporary disk when you stop-deallocate or move a VM. To maintain persistent data, use managed data disks.

### Verify that the VM size supports the disk configuration

After you choose a destination size, use Azure PowerShell or Azure CLI to verify that it supports the attached disks.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$size = Get-AzVMSize -Location "<destination-region>" | Where-Object { $_.Name -eq "<vm-size>" }
$size | Select-Object Name, NumberOfCores, MemoryInMB, MaxDataDiskCount, OSDiskSizeInMB
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm list-sizes --location "<destination-region>" \
  --query "[?name=='<vm-size>'].{Name:name, Cores:numberOfCores, Memory:memoryInMb, MaxDisks:maxDataDiskCount}" --output table
```

# [Azure portal](#tab/portal)

You can't query VM size disk capabilities like maximum data disk count in the Azure portal. To verify disk compatibility, use Azure PowerShell or Azure CLI.

---

Verify that `MaxDataDiskCount` is greater than or equal to the number of data disks that are attached to the VM.

### Checklist

Before you retry the move, verify the following conditions are met:

- The destination region supports the target VM size.
- The target size is compatible with your current disk family.
- Application data isn't stored on the temporary disk.
- `MaxDataDiskCount` supports your attached data disks.

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Azure VM sizes without a local temporary disk](/azure/virtual-machines/azure-vms-no-temp-disk)
- [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
