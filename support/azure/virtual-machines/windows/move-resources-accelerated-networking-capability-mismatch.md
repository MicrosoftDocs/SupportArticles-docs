---
title: Azure VM resource move causes accelerated networking capability mismatch
description: Troubleshoot an accelerated networking mismatch after an Azure VM resource move. Verify destination VM support and restore network performance.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/03/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine resource move causes accelerated networking capability mismatch

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article describes how to troubleshoot move failures or post-move network degradation that's caused by accelerated networking capability mismatches between the source and destination virtual machines (VMs).

## Symptoms

After a move, the workload shows reduced throughput, higher latency, or network adapter configuration issues. In some cases, validation fails because the destination VM size doesn't support the existing network assumptions.

## Cause

Accelerated networking support depends on VM size, image support, guest configuration, and destination capabilities. A move plan that preserves the VM but changes those assumptions can introduce network problems.

## Resolution

### Step 1: Verify that accelerated networking is enabled

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to check whether accelerated networking is enabled on the source VM's network interface.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the network interface resource that's associated with the VM.
1. On **Overview**, check the **Accelerated networking** field to see whether it's enabled.

For more information, see [Azure accelerated networking](/azure/virtual-network/accelerated-networking-overview).

# [Azure PowerShell](#tab/powershell)

Run this command.

```azurepowershell
Get-AzNetworkInterface -ResourceGroupName "<rg-name>" -Name "<nic-name>" |
  Select-Object Name, EnableAcceleratedNetworking
```

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
az network nic show --resource-group "<rg-name>" --name "<nic-name>" \
  --query "{Name:name, AcceleratedNetworking:enableAcceleratedNetworking}"
```

---

### Step 2: Verify destination VM size support

Use Azure PowerShell or Azure CLI to check whether the destination VM size supports accelerated networking.

# [Azure portal](#tab/portal)

This operation isn't directly available in the Azure portal. Use Azure PowerShell or Azure CLI to query VM size capabilities programmatically.

# [Azure PowerShell](#tab/powershell)

Run this command.

```azurepowershell
Get-AzComputeResourceSku -Location "<destination-region>" |
  Where-Object { $_.Name -eq "<vm-size>" } |
  Select-Object Name, @{N='AcceleratedNetworking';E={($_.Capabilities | Where-Object { $_.Name -eq 'AcceleratedNetworkingEnabled' }).Value}}
```

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
az vm list-skus --location "<destination-region>" --size "<vm-size>" \
  --query "[].{Name:name, AccNet:capabilities[?name=='AcceleratedNetworkingEnabled'].value | [0]}" --output table
```

---

### Step 3: Update deployment assumptions if necessary

If support isn't available, see the following options:

- Choose a compatible size.
- Disable accelerated networking if this action is supported and acceptable.
- Rebuild by using a supported image or driver baseline.

### Step 4: Verify workload networking after move

Verify throughput, latency, and connectivity from the application path.

## References

- [Move blocked by unavailable virtual machine size at destination](move-resources-resize-blocked-disk-constraints.md)
- [Move blocked by network adapter IP configuration dependency conflicts](move-resources-network-interface-ip-config-conflict.md)
- [Accelerated networking overview](/azure/virtual-network/accelerated-networking-overview)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
