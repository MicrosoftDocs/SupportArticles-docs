---
title: Azure VM resource move fails because private endpoint dependencies are present
description: Fix Azure VM move failures caused by private endpoint and private DNS zone dependencies. Follow these steps to validate dependencies and complete your move.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/14/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine resource move fails because private endpoint dependencies are present

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary 

Private endpoint and private Domain Name System (DNS) zone dependencies can block the move of Azure virtual machine (VM) resources. This article explains the symptoms, causes, and resolution steps for move failures that these dependencies cause.

## Symptoms

Move validation fails if resources in the move scope have private endpoint or private DNS zone links, and the links block the move.

The following error messages indicate that private endpoint or private DNS zone dependencies block the move.

```output
MoveNotSupportedForResourceType
```

```output
Cannot move resource due to linked private endpoint/private DNS dependencies.
```

## Cause

Private endpoint topology often includes dependencies that are tightly bound to a virtual network, subnet policy, and DNS zone links. Move validation fails if you don't include these dependencies or if the selected path doesn't support moving them.

Common blockers include the following items:

- Private endpoint resources that are linked to moved network adapters and virtual network (VNet) paths
- Private DNS zone virtual network links that aren't aligned with destination scope
- Service-specific move limitations for private endpoint-connected resources

## Resolution

### Step 1: Inventory private endpoint and DNS dependencies

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to inventory private endpoint and DNS dependencies.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
Get-AzPrivateEndpoint -ResourceGroupName "<rg-name>" |
  Select-Object Name, Location, Subnet

Get-AzPrivateDnsVirtualNetworkLink -ResourceGroupName "<dns-rg>" -ZoneName "<private-zone-name>" |
  Select-Object Name, VirtualNetworkId, RegistrationEnabled
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
az network private-endpoint list --resource-group "<rg-name>" \
  --query "[].{Name:name, Location:location, Subnet:subnet.id}" --output table

az network private-dns link vnet list --resource-group "<dns-rg>" --zone-name "<private-zone-name>" \
  --query "[].{Name:name, VNet:virtualNetwork.id, Registration:registrationEnabled}" --output table
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Resource groups** and then select the resource group.
1. Filter the resource list by **Type** = **Private endpoint** to see all private endpoints in the group.
1. For each private endpoint, select it to view its **Private link resource**, **Subnet**, and **DNS configuration**.
1. To view DNS zone links, search for **Private DNS zones** in the portal and then select the relevant zone to check its **Virtual network links**.

For more information, see [Manage private endpoint connections](/azure/private-link/manage-private-endpoint).

---

### Step 2: Verify move support for each dependent type

Check the support for the selected move path (resource group, subscription, or region or resource mover). If a dependent resource type isn't supported, plan to re-create that dependency at destination.

### Step 3: Use staged migration for unsupported dependencies

A common staged sequence includes the following steps:

1. Remove or disconnect private endpoint dependencies (as approved).
1. Move VM core resources.
1. Re-create private endpoints and private DNS links at destination.
1. Verify name resolution and connectivity.

### Step 4: Verify private connectivity after move

Verify the following items from the VM:

- The DNS resolves to a private IP.
- Service endpoint reachability is restored.
- Network security group (NSG) and user-defined route (UDR) rules allow expected traffic.

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move virtual machine resources across tenants](move-vm-cross-tenant-migration-guide.md)
- [Azure Private Endpoint DNS configuration](/azure/private-link/private-endpoint-dns)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
