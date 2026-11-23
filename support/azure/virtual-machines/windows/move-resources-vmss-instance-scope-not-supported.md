---
title: Azure VM move path isn't supported for Virtual Machine Scale Set instance resources
description: Learn why an Azure VM move isn't supported for individual Virtual Machine Scale Set instances, and explore supported migration paths to redeploy successfully.
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

# Azure virtual machine move path isn't supported for Azure Virtual Machine Scale Set instance resources

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

You can't move individual Azure Virtual Machine Scale Set instances. Virtual Machine Scale Set instances are part of a larger scale set that you can't move independently without disrupting the orchestration and management of the scale set.

## Symptoms

An operator tries to move a Virtual Machine Scale Set instance as if it were a standalone virtual machine (VM) resource. This action generates unsupported resource or dependency errors like the following messages.

```output
MoveNotSupportedForResourceType
```

```output
The selected virtual machine scale set instance can't be moved independently.
```

## Cause

Virtual Machine Scale Set instances are managed as part of the parent scale set model. Moving an instance independently doesn't preserve orchestration, networking, and instance model relationships.

## Resolution

### Step 1: Verify that the resource is a Virtual Machine Scale Set instance

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to verify that the resource is a Virtual Machine Scale Set instance.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the resource.
1. Check the **Resource type** field to confirm it belongs to `Microsoft.Compute/virtualMachineScaleSets`.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzResource -ResourceId "<resource-id>" |
  Select-Object Name, ResourceType, ResourceGroupName
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource show \
  --ids <resource-id> \
  --query "{name:name, type:type, resourceGroup:resourceGroup}" \
  --output table
```

---

### Step 2: Use a supported migration path

Use one of the following methods to move or redeploy the Virtual Machine Scale Set:

- Re-create the scale set in the destination.
- Use image-based redeployment.
- Migrate workload state externally, then redeploy the scale set.

### Step 3: Verify scale set dependencies

Verify the supporting resources are in place, including the following resources:

- Load balancers
- Autoscale configuration
- Managed identities
- Extensions

## References

- [Move blocked by missing load balancer dependencies](move-resources-load-balancer-dependency-missing.md)
- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Virtual Machine Scale Sets overview](/azure/virtual-machine-scale-sets/overview)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
