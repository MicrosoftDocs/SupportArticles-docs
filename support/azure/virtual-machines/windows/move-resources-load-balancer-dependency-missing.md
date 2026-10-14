---
title: Azure VM resource move fails because load balancer dependencies are missing
description: Fix Azure VM resource move validation errors by including network adapter, public IP, and load balancer dependencies. Use these steps to move successfully.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/10/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine resource move fails because load balancer dependencies are missing

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

Azure virtual machine (VM) resource move operations can fail if the move scope doesn't include all dependent resources, like load balancers and associated network configurations. This article explains how to identify missing dependencies and resolve move validation errors.

## Symptoms

Move validation fails and generates dependency errors if a VM network adapter is attached to a load balancer backend pool, and you exclude related resources from the move request.

The following are examples of dependency errors.

```output
MissingMoveDependentResources
```

```output
Cannot move resource because dependent resources are not included.
```

## Cause

A VM that participates in load balancing has network dependencies that you must move together. If the move scope excludes linked resources, Azure Resource Manager (ARM) blocks the operation.

Typical missing dependencies include the following resources:

- Load balancer
- Backend pool configuration
- Health probe and load-balancing rules
- Public IP (for public load balancer)
- Associated network adapter/IP configuration objects

## Resolution

### Step 1: Map current network dependencies

Use the Azure portal, Azure PowerShell, or Azure CLI to map the current network dependencies.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the VM > **Networking**.
1. Open the attached network adapter.
1. Check **IP configurations** and the linked load balancer backend address pools.

For more information, see [Manage a load balancer using the Azure portal](/azure/load-balancer/manage).

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$nic = Get-AzNetworkInterface -ResourceGroupName "<rg-name>" -Name "<nic-name>"
$nic.IpConfigurations | Select-Object Name, PrivateIpAddress, LoadBalancerBackendAddressPools
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az network nic show --resource-group "<rg-name>" --name "<nic-name>" \
  --query "ipConfigurations[].{Name:name, IP:privateIpAddress, LBPools:loadBalancerBackendAddressPools[].id}" --output table
```

---

### Step 2: Include all required resources in move scope

When you move the VM, include the following resources:

- VM and disks
- Network adapters
- Load balancer and public IP resources
- NSG and route table dependencies

### Step 3: If full dependency move isn't supported, detach and reattach

For complex topologies, use the following sequence of steps:

1. Remove the network adapter from the back-end pool (or remove the VM from the load balancer set).
1. Complete the VM resource move.
1. Re-create or reattach the load balancer configuration at the destination.

### Step 4: Verify application connectivity

After the move, verify:

- Health probe status
- Inbound rule behavior
- Back-end pool membership

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move blocked by unavailable virtual machine size at destination](move-resources-resize-blocked-disk-constraints.md)
- [Azure Load Balancer troubleshooting](/azure/load-balancer/load-balancer-troubleshoot)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
