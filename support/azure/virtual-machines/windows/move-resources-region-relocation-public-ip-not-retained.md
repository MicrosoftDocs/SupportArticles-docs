---
title: Azure VM region relocation changes public IP behavior and the original public IP isnt retained
description: Troubleshoot Azure VM region relocation public IP address changes, update affected references, and restore inbound connectivity.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/14/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine region relocation changes public IP behavior and the original public IP isn't retained

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

During an Azure VM region relocation, the associated public IP address might change because public IP resources are regional. This article explains how to identify the new public IP, update affected references, and restore inbound connectivity.

## Symptoms

After a region relocation, inbound connectivity fails because the expected public IP address isn't preserved.

## Cause

Public IP resources are regional. Region relocation workflows often re-create public-facing resources in the target region instead of preserving the original IP identity.

## Resolution

### Step 1: Verify the target public IP address

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to verify the target public IP address.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the destination resource group.
1. Select the public IP resource and review the IP address and allocation method.
1. Verify the load balancer front-end settings are updated to use the new public IP.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzPublicIpAddress -ResourceGroupName "<destination-resource-group>" |
  Format-Table Name, IpAddress, PublicIpAllocationMethod, Location
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az network public-ip list \
  --resource-group <destination-resource-group> \
  --query "[].{name:name, ip:ipAddress, allocation:publicIpAllocationMethod, location:location}" \
  --output table
```

---

### Step 2: Update all references to the new public IP

Update the following information:

- Domain Name System (DNS) records
- Firewall allow lists
- Monitoring endpoints
- External integrations

## References

- [Region move isn't the same as a resource group or subscription move](move-resources-region-move-vs-resource-group-subscription-move.md)
- [Move fails because load balancer dependencies are missing](move-resources-load-balancer-dependency-missing.md)
- [Move Azure resources across resource groups, subscriptions, or regions](/azure/azure-resource-manager/management/move-resources-overview)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
