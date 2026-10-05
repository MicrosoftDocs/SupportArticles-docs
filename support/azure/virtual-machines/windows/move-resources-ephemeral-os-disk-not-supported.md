---
title: Azure VM resource move is not supported for ephemeral OS disk deployments
description: Troubleshoot Azure VM resource move failures for ephemeral OS disk deployments and choose a supported migration strategy to redeploy your workload.
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

# Azure virtual machine resource move doesn't support ephemeral OS disk deployments

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains why Azure virtual machine (VM) resource move operations don't support ephemeral OS disk deployments. It also provides guidance for alternative migration strategies.

Ephemeral OS disks are temporary disks that the Azure VM host stores on the local host cache or temporary storage. Because ephemeral OS disks aren't standard managed disks, you can't move them by using the standard Azure resource move operations. 

## Symptoms

A move attempt fails or the move plan is rejected for a VM that uses an ephemeral OS disk. The operation generates policy errors that resemble the following examples.

```output
MoveNotSupportedForResourceType
```

```output
The selected virtual machine configuration uses an ephemeral OS disk and can't be moved by this operation.
```

## Cause

Ephemeral OS disks are stored on the local host cache or temporary storage instead of remote managed storage. Because the OS disk isn't a standard managed disk resource, a normal move workflow can't preserve the OS state.

## Resolution

### Step 1: Verify that the VM uses an ephemeral OS disk

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to check whether the VM uses an ephemeral OS disk.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>"
$vm.StorageProfile.OsDisk.DiffDiskSettings
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show --resource-group "<rg-name>" --name "<vm-name>" \
  --query "storageProfile.osDisk.diffDiskSettings"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Virtual machines**, and then select your VM.
1. In the menu, in **Settings**, select **Disks**.
1. Check the **OS disk** section. If the disk type shows **Ephemeral OS disk**, the VM uses an ephemeral disk and can't be moved.

---

For more information, see [Ephemeral OS disks for Azure VMs](/azure/virtual-machines/ephemeral-os-disks).

If the output shows `Local`, the VM uses an ephemeral OS disk.

### Step 2: Choose a rebuild-based migration path

Use one of the following supported methods:

- Re-create the VM from source configuration in the destination scope.
- Use image-based redeployment for stateless workloads.
- Export application configuration, and rehydrate the workload after deployment.

### Step 3: Preserve application state separately

Before you run the redeployment, capture:

- Application configuration
- Data disks
- Network configuration
- Identity and access settings

### Step 4: Re-create and verify the workload

Deploy a new VM in the destination and verify startup, workload startup, and network access.

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move blocked by unavailable virtual machine size at destination](move-resources-resize-blocked-disk-constraints.md)
- [Ephemeral OS disks for Azure VMs](/azure/virtual-machines/ephemeral-os-disks)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
