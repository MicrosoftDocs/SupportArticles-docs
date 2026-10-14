---
title: Azure VM resource move fails because network interface IP configuration dependencies conflict
description: Fix Azure VM resource move validation errors caused by network adapter IP configuration dependencies, static IP conflicts, and subnet mismatches.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/11/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine resource move fails because of network interface IP configuration dependencies conflict

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article helps you troubleshoot and resolve Azure virtual machine (VM) resource move failures that are caused by network adapter IP configuration dependencies, static IP assumptions, or subnet mismatches at the destination.


## Symptoms

A move validation fails or post-move network connectivity fails because of network adapter and IP configuration mismatches.

The following error messages indicate network interface IP configuration conflicts.

```output
InvalidResourceReference
```

```output
Subnet not found or IP configuration conflict detected.
```

## Cause

VM network interfaces are tightly bound to subnet, IP configuration, network security group (NSG), and route dependencies. Moves can fail if destination topology doesn't provide equivalent network constructs.

## Resolution

### Step 1: Capture network adapter and IP configuration state

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to capture the current network adapter and IP configuration state.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzNetworkInterface -ResourceGroupName "<rg-name>" -Name "<nic-name>" |
  Select-Object Name,IpConfigurations,NetworkSecurityGroup
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az network nic show --resource-group "<rg-name>" --name "<nic-name>" \
  --query "{Name:name, IpConfigs:ipConfigurations[].{Subnet:subnet.id, PrivateIP:privateIpAddress}, NSG:networkSecurityGroup.id}"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the network interface resource.
1. In the menu, in **Settings**, select **IP configurations**.
1. Review the subnet, private IP address, and any associated NSG for each IP configuration.

For more information, see [Virtual network interface addresses](/azure/virtual-network/ip-services/virtual-network-network-interface-addresses).

---

### Step 2: Verify destination VNet and subnet readiness

Verify that required virtual networks (VNets) and subnets exist and permit equivalent configuration.

### Step 3: Resolve static IP and configuration conflicts

If static private IP assignments conflict with destination subnet ranges, take the following steps:

- Reallocate to available private IP addresses.
- Update dependent NSG and route rules.

### Step 4: Retry the move and run connectivity checks

After remediation, rerun the move validation and verify the following items:

- Network adapter attachment
- Domain Name System (DNS) resolution
- Application reachability

## References

- [Preflight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move fails because load balancer dependencies are missing](move-resources-load-balancer-dependency-missing.md)
- [Create, change, or delete a network interface](/azure/virtual-network/virtual-network-network-interface)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
