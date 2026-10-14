---
title: Azure VM move fails because the virtual network and dependencies must move together
description: Troubleshoot Azure VM move validation failures caused by missing virtual network dependencies. Follow these steps to complete the move.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/21/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine move fails because the virtual network and dependencies must move together

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains why moving an Azure virtual machine (VM) without its required virtual network and related network dependencies fails validation. The article also provides guidance to include all necessary resources in the move.

## Symptoms

Move validation fails and generates dependency errors after you select a VM but exclude the required network objects.

The following error messages are commonly seen.

```output
MissingMoveDependentResources
```

```output
The virtual machine depends on network resources that aren't included in the move.
```

## Cause

A VM's network adapter, IP configurations, network security groups (NSGs), public IPs, and sometimes the virtual network (VNet) itself are part of the dependency graph. If the move scope excludes required network resources, validation fails.

## Resolution

### Step 1: Inventory the networking dependency set

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to inventory the networking dependency set for the VM.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the VM.
1. Select **Networking** to review the attached NICs, IP configurations, and NSGs.
1. Note all dependent network resources that you must include in the move.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<resource-group-name>" -Name "<vm-name>"
$vm.NetworkProfile.NetworkInterfaces | ForEach-Object {
  $nic = Get-AzNetworkInterface -ResourceId $_.Id
  [PSCustomObject]@{
    NIC      = $nic.Name
    Subnet   = ($nic.IpConfigurations[0].Subnet.Id -split '/')[-1]
    VNet     = ($nic.IpConfigurations[0].Subnet.Id -split '/')[-3]
    PublicIP  = $nic.IpConfigurations[0].PublicIpAddress.Id
    NSG      = $nic.NetworkSecurityGroup.Id
  }
} | Format-List
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
az vm nic list \
  --resource-group <resource-group-name> \
  --vm-name <vm-name> \
  --query "[].id" -o tsv | while read nicId; do
  az network nic show --ids "$nicId" \
    --query "{name:name, subnet:ipConfigurations[0].subnet.id, publicIp:ipConfigurations[0].publicIpAddress.id, nsg:networkSecurityGroup.id}" \
    -o table
done
```

---

### Step 2: Include all required resources in the move

Select the entire required dependency set in the move scope when supported.

### Step 3: Use staged re-creation for unsupported topologies

If you can't move the network topology directly, follow these steps:

- Move the VM and supported dependencies.
- Recreate unsupported network objects at the destination.
- Reattach the VM to the recreated network design.

## References

- [Move fails because load balancer dependencies are missing](move-resources-load-balancer-dependency-missing.md)
- [Move blocked by NIC IP configuration dependency conflicts](move-resources-network-interface-ip-config-conflict.md)
- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
