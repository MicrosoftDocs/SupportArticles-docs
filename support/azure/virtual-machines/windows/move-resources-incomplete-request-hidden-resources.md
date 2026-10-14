---
title: Azure resource move fails - hidden resources not included in move request
description: An Azure resource move fails with an IncompleteRequest error when hidden dependencies are excluded. Follow these steps to include all resources and retry.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/09/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:Cannot create a VM
ai-usage: ai-assisted
---
# Azure resource move fails because hidden resources aren't included in the move

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Summary

This article helps you fix cases in which an Azure resource move fails and generates an `IncompleteRequest` error because hidden dependent resources weren't included in the move request.

## Symptoms

When you try to move a virtual machine (VM) and its associated resources to a different resource group or subscription, the operation fails and returns an error message that resembles the following message.

```output
{
  "code": "IncompleteRequest",
  "message": "Move with hidden resources has a hidden resource /subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Compute/disks/<disk-name> that is not being moved"
}
```

## Cause

Two conditions can trigger this error.

**Cause 1: Hidden resources not selected**

Some Azure resources, like managed disks that are attached to a VM, are marked as **hidden** in the [Azure portal](https://portal.azure.com) by default. If you select resources to move without enabling **Show hidden types**, you exclude hidden dependent resources from the selection. Azure requires that you move all dependent resources together. Azure blocks the operation if any required resources are missing.

**Cause 2: Insufficient role-based access control (RBAC) permissions**

If the account that performs the move uses a custom role, it might lack the required permissions to discover hidden resources. When Azure validates the move request, it can't enumerate the hidden resources. Therefore, it treats the request as incomplete.

The minimum required permissions are:

- **Source resource group:** `Microsoft.Resources/subscriptions/resourceGroups/moveResources/action`
- **Destination resource group:** `Microsoft.Resources/subscriptions/resourceGroups/write`

## Resolution

### Step 1: Include hidden resources in your move request

Use the Azure portal, Azure PowerShell, or Azure CLI to include hidden resources in your move request.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the source resource group.
1. To reveal hidden resources, like managed disks, select **Manage view** > **Show hidden types**.
1. Reselect all the resources that you want to move, including the hidden resources listed in the error message.
1. Retry the move operation.

# [Azure PowerShell](#tab/powershell)

Hidden resources are always visible in Azure PowerShell. Run the following command to list all resources in the resource group to identify any that were excluded from the move.

```azurepowershell
Get-AzResource -ResourceGroupName "<resource-group-name>" |
  Format-Table Name, ResourceType, ResourceId
```

Include all dependent resources when you run the move operation.

```azurepowershell
$resources = Get-AzResource -ResourceGroupName "<source-resource-group>"
Move-AzResource -DestinationResourceGroupName "<destination-resource-group>" `
  -ResourceId $resources.ResourceId
```

# [Azure CLI](#tab/cli)

Hidden resources are always visible in Azure CLI. Run the following command to list all resources in the resource group to identify any resources that the move operation excludes.

```azurecli
az resource list \
  --resource-group <resource-group-name> \
  --query "[].{name:name, type:type}" \
  --output table
```

Include all dependent resources when you run the move operation.

```azurecli
ids=$(az resource list --resource-group <source-resource-group> --query "[].id" -o tsv)
az resource move \
  --destination-group <destination-resource-group> \
  --ids $ids
```

---

### Step 2: Verify RBAC permissions

Use the Azure portal, Azure PowerShell, or Azure CLI to verify that you have the required RBAC permissions for the move operation.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to the source resource group.
1. Select **Access control (IAM)** > **View my access**.
1. Review the listed role assignments, and verify that the required permissions are present.
1. If permissions are missing, select **Add role assignment**, and assign a role that includes `Microsoft.Resources/subscriptions/resourceGroups/moveResources/action`.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzRoleAssignment -ResourceGroupName "<resource-group-name>" `
  -SignInName "<user-upn>" |
  Format-Table RoleDefinitionName, Scope
```

If the required permissions are missing, assign a contributor role.

```azurepowershell
New-AzRoleAssignment -SignInName "<user-upn>" `
  -RoleDefinitionName "Contributor" `
  -ResourceGroupName "<resource-group-name>"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az role assignment list \
  --resource-group <resource-group-name> \
  --assignee <user-upn> \
  --output table
```

If the required permissions are missing, assign a contributor role.

```azurecli
az role assignment create \
  --assignee <user-upn> \
  --role "Contributor" \
  --resource-group <resource-group-name>
```

---

> [!NOTE]
> Grant permissions at the resource group level. The account also needs read permissions (`Microsoft.Resources/subscriptions/providers/read`) at the subscription level to fully enumerate all dependent resources during validation.

### Step 3: Retry the move

After you include all hidden resources and verify the permissions, retry the move operation.

## References

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Required permissions to move Azure resources](/azure/azure-resource-manager/management/move-resource-group-and-subscription#permissions-required-to-move-resources)
- [Move operation support for resources](/azure/azure-resource-manager/management/move-support-resources)
- [Troubleshoot moving Azure resources](/azure/azure-resource-manager/management/troubleshoot-move)
