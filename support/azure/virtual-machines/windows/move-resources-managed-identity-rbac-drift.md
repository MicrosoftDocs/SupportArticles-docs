---
title: Azure VM resource move fails because managed identity role assignments are missing at destination
description: Fix Azure VM resource move failures caused by missing managed identity role assignments at the destination. Follow these steps to restore workload access.
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

# Azure virtual machine resource move fails because managed identity role assignments are missing at destination

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to identify and resolve managed identity role assignment drift after an Azure VM resource move between subscriptions or resource groups, helping restore workload access.

Managed identity role assignments can drift when you move Azure VM resources between subscriptions or resource groups. This drift can cause authorization failures for workloads that rely on these identities.

## Symptoms

After a VM move, workloads that rely on managed identity can't access dependent services such as Azure Key Vault, Azure Storage, and AzureSQL. In some workflows, move validation fails because identity-related dependencies are incomplete.

The following are examples of error signatures related to managed identity role assignment drift.

```output
AuthorizationFailed
```

```output
Managed identity cannot access target resource.
```

## Cause

System-assigned and user-assigned managed identities keep their identity references. However, role assignments at destination scopes are frequently missing or incomplete after move operations.

## Managed identity role assignment error signatures

The following table summarizes common error signatures related to managed identity role assignment drift.

| Error signature | Typical meaning | First action |
|---|---|---|
| `AuthorizationFailed` | Identity exists but lacks role assignment on destination scope | Re-create the required role-based access control (RBAC) role assignments at the destination. |
| `ManagedIdentityInvalidTenantId` | Identity reference points to wrong tenant context | Verify the tenant-subscription alignment, and rebind the correct identity. |

## Resolution

### Step 1: Inventory the managed identity configuration

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to inventory the managed identity configuration for your VM.

# [Azure PowerShell](#tab/powershell)

Run this command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>"
$vm.Identity
```

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
az vm show --resource-group "<rg-name>" --name "<vm-name>" \
  --query "identity.{Type:type, PrincipalId:principalId, UserAssigned:userAssignedIdentities}"
```

#### [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Virtual machines**, and then select your VM.
1. In the menu, in **Security**, select **Identity**.
1. Review the **System assigned** and **User assigned** tabs to see which identities are configured.

For more information, see [Managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview).

---

If you use user-assigned identities, list them, and then capture the principal IDs.

### Step 2: Export current role assignments from source

Use Azure PowerShell, Azure CLI, or the Azure portal to export the current role assignments for the managed identity from the source scope.

# [Azure PowerShell](#tab/powershell)

Run this command.

```azurepowershell
Get-AzRoleAssignment -ObjectId "<principal-id>" |
  Select-Object RoleDefinitionName, Scope
```

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
az role assignment list --assignee "<principal-id>" \
  --query "[].{Role:roleDefinitionName, Scope:scope}" --output table
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to the source resource group or subscription.
1. In the menu, select **Access control (IAM)**.
1. Select **Role assignments**, and then filter by the managed identity's principal ID or name to see its current roles.

For more information, see [List Azure role assignments - Azure portal](/azure/role-based-access-control/role-assignments-list-portal).

---

### Step 3: Re-create required role assignments at destination

Use Azure PowerShell, Azure CLI, or the Azure portal to assign equivalent roles at the destination resource group, subscription, or resource scopes.

# [Azure PowerShell](#tab/powershell)

Run this command.

```azurepowershell
New-AzRoleAssignment -ObjectId "<principal-id>" -RoleDefinitionName "Reader" -Scope "/subscriptions/<sub-id>/resourceGroups/<destination-rg>"
```

# [Azure CLI](#tab/cli)

Run this command.

```azurecli
az role assignment create --assignee "<principal-id>" \
  --role "Reader" \
  --scope "/subscriptions/<sub-id>/resourceGroups/<destination-rg>"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to the destination resource group or subscription.
1. In the menu, select **Access control (IAM)** > **Add** > **Add role assignment**.
1. Select the required role, search for the managed identity by name or principal ID, and then select **Save**.

For more information, see [Assign Azure roles - Azure portal](/azure/role-based-access-control/role-assignments-portal).

---

### Step 4: Verify access from workload path

Re-run the workload operation that uses managed identity, and then verify successful authentication and authorization.

### Prevention

Include identity RBAC mapping in your pre-move checklist, and then stage destination role assignments before the cutover.

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Custom RBAC prerequisites for Azure Resource Mover](resource-mover-rbac-prerequisites.md)
- [Azure resource move fails with provider-specific validation error](move-resources-provider-validation-failed.md)
- [Managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
