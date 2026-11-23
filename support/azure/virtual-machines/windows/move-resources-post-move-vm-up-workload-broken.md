---
title: Azure VM move succeeds but the workload is still broken
description: Learn how to troubleshoot networking, identity, and extension issues after an Azure VM move that succeeds but leaves your workload still broken.
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

# Azure virtual machine move succeeds but the workload is still broken

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

After a virtual machine (VM) move, the VM starts successfully, but the workload running on the VM doesn't function correctly. This article helps you troubleshoot scenarios in which the VM is up, but the application or service is still broken.

## Symptoms

After a move, a VM starts successfully, but the application or service doesn't recover fully.

The following list describes common symptoms:

- VM boots but the app is unreachable.
- Extensions report an unhealthy state.
- Identity-based calls fail.
- Domain Name System (DNS) or front-end traffic still points to the old footprint.

## Cause

A successful infrastructure move doesn't guarantee that all workload dependencies are re-created or validated.

## Resolution

Use this post-move checklist to verify the VM and its workload.

### Step 1: Verify network adapter, IP, DNS, and load balancer behavior

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to verify the network adapter, IP configuration, DNS settings, and load balancer behavior.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the VM in the destination resource group.
1. Select **Networking** to verify the network interface card (NIC), IP configuration, and network security group (NSG) associations.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<resource-group-name>" -Name "<vm-name>"
$vm.NetworkProfile.NetworkInterfaces | ForEach-Object {
  Get-AzNetworkInterface -ResourceId $_.Id |
    Select-Object Name, @{N='PrivateIP';E={$_.IpConfigurations[0].PrivateIpAddress}},
      @{N='PublicIP';E={$_.IpConfigurations[0].PublicIpAddress.Id}}
} | Format-List
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm nic list \
  --resource-group <resource-group-name> \
  --vm-name <vm-name> -o table
```

---

### Step 2: Verify VM extensions and agent state

Use the Azure portal, Azure PowerShell, or Azure CLI to verify the VM extensions and agent state.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to the VM.
1. Select **Extensions + applications** to review installed extensions and their status.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzVMExtension -ResourceGroupName "<resource-group-name>" -VMName "<vm-name>" |
  Format-Table Name, Publisher, ExtensionType, ProvisioningState
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm extension list \
  --resource-group <resource-group-name> \
  --vm-name <vm-name> \
  --query "[].{name:name, publisher:publisher, type:typePropertiesType, status:provisioningState}" \
  --output table
```

---

### Step 3: Verify role-based access control and managed identity paths

Use the Azure portal, Azure PowerShell, or Azure CLI to verify role-based access control (RBAC) and managed identity paths.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to the VM.
1. Select **Identity** to verify the managed identity status.
1. Check downstream resource **Access control (IAM)** for correct role assignments.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$principalId = (Get-AzVM -ResourceGroupName "<resource-group-name>" -Name "<vm-name>").Identity.PrincipalId
Get-AzRoleAssignment -ObjectId $principalId |
  Format-Table RoleDefinitionName, Scope
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
principalId=$(az vm identity show --resource-group <resource-group-name> --name <vm-name> --query "principalId" -o tsv)
az role assignment list --assignee "$principalId" --all -o table
```

---

### Step 4: Verify application configuration

Review application configuration that references old resource IDs, IPs, or DNS names and update them to the destination values.

## References

- [Move causes accelerated networking capability mismatch](move-resources-accelerated-networking-capability-mismatch.md)
- [Move fails because managed identity role assignments drift at destination](move-resources-managed-identity-rbac-drift.md)
- [Move fails because load balancer dependencies are missing](move-resources-load-balancer-dependency-missing.md)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
