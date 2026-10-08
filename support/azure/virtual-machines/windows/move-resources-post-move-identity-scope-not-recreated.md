---
title: Azure VM move succeeds but downstream identity access still fails because resource scopes arent re-created
description: Troubleshoot downstream identity access failures after an Azure VM move when resource scopes aren't re-created. Follow these steps to restore access.
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

# Azure virtual machine move succeeds but downstream identity access fails because resource scopes aren't re-created

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article helps you troubleshoot downstream identity access failures after an Azure virtual machine (VM) move when service scopes aren't remapped or re-created, even though the move succeeds.

## Symptoms

Consider the following scenarios:

- An Azure VM move succeeds.
- The VM has the expected managed identity.
- Local role-based access control (RBAC) looks correct.

In this scenario, the workload can't reach downstream services, such as Azure Key Vault, Azure Storage, Azure SQL, or messaging endpoints.

## Cause

The VM-side identity object survives the move, but downstream resource scopes, role assignments, access policies, or service-side trust references still point to the old context.

## Resolution

Use this post-move checklist to verify the VM move.

### Step 1: Verify the managed identity principal

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to verify the managed identity principal.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the VM in the destination resource group.
1. Select **Identity** to verify the system-assigned or user-assigned managed identity.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzVM -ResourceGroupName "<resource-group-name>" -Name "<vm-name>" |
  Select-Object -ExpandProperty Identity
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm identity show \
  --resource-group <resource-group-name> \
  --name <vm-name>
```

---

### Step 2: Enumerate downstream role assignments and access policies

Use the Azure portal, Azure PowerShell, or Azure CLI to enumerate downstream role assignments and access policies.

# [Azure portal](#tab/portal)

Follow these steps:

1. Go to each downstream resource (for example, Key Vault, Azure Storage, or Azure SQL).
1. Select **Access control (IAM)**, and then verify the managed identity has the required role assignments.

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
az role assignment list \
  --assignee "$principalId" \
  --all \
  --output table
```

---

### Step 3: Re-create the missing downstream scope grants

If role assignments are missing, re-create them on the downstream resources.

### Step 4: Re-test the workload path end to end

Verify that the managed identity has the required role assignments on all downstream resources and that the workload functions as expected.

## References

- [Move fails because managed identity role assignments drift at destination](move-resources-managed-identity-rbac-drift.md)
- [Azure virtual machine move succeeded but the VM is up and the workload is still broken](move-resources-post-move-vm-up-workload-broken.md)
- [Managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
