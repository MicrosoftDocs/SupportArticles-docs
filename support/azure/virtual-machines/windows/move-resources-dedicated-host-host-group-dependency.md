---
title: Azure VM resource move fails because dedicated host or host group dependencies are present
description: Troubleshoot Azure VM resource move failures caused by dedicated host or host group dependencies. Follow the steps to complete a supported move.
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

# Azure virtual machine resource move fails because dedicated host or host group dependencies are present

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to troubleshoot Azure virtual machine (VM) resource move operations that fail because of dependencies on dedicated hosts or host groups. It provides guidance to identify host dependencies, verify destination host capabilities, and choose supported migration patterns to ensure successful move operations.

## Symptoms

Move validation fails for a VM that runs on a dedicated host or within a host group. The following error messages are examples of what you might see.

```output
InvalidResourceReference
```

```output
The virtual machine depends on a dedicated host or host group that isn't included or supported in the move path.
```

## Cause

Dedicated hosts and host groups create placement dependencies that standard move operations don't automatically reconcile. The destination scope must support equivalent host resources and placement.

## Resolution

### Step 1: Verify host dependency

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to check whether the VM is deployed on a dedicated host or within a host group.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>"
$vm.Host
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show --resource-group "<rg-name>" --name "<vm-name>" \
  --query "host.id"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Virtual machines**, and then select your VM.
1. On the **Overview** page, check the **Host group** field. If a value is displayed, the VM is deployed on a dedicated host.

---

For more information, see [Azure Dedicated Hosts](/azure/virtual-machines/dedicated-hosts).

### Step 2: Verify destination host strategy

Check whether the destination has:

- A compatible dedicated host SKU
- Available host capacity
- The required host group topology

### Step 3: Choose supported migration pattern

Use one of the following methods:

- Move only after an equivalent host infrastructure exists at the destination.
- Re-create the VM on a new dedicated host in the destination.
- Remove the host dependency if the workload policy allows it.

### Step 4: Verify placement and workload behavior

After the migration, verify host placement, licensing assumptions, and workload performance.

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move blocked by availability set and zone constraints](move-resources-availability-set-zonal-constraint.md)
- [Azure Dedicated Host overview](/azure/virtual-machines/dedicated-hosts)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
