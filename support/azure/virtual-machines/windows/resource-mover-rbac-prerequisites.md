---
title: Custom RBAC prerequisites for Azure Resource Mover
description: Learn which built-in and custom RBAC roles Azure Resource Mover requires, and how to assign them to avoid AuthorizationFailed errors. Start your move today.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/22/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Custom role-based access control (RBAC) prerequisites for Azure Resource Mover

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article describes the custom RBAC prerequisites for Azure Resource Mover, which requires specific role assignments on both the source and destination subscriptions. Without these assignments, move operations fail and generate `AuthorizationFailed` errors. This article describes the built-in role option and a custom role definition for least-privilege scenarios.

### Verify your current role assignments

Before you start a move, use Azure PowerShell or Azure CLI to verify that your account has the required permissions.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzRoleAssignment -SignInName "<your-upn>" | Select-Object RoleDefinitionName, Scope | Format-Table -AutoSize
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az role assignment list --assignee "<your-upn>" \
  --query "[].{Role:roleDefinitionName, Scope:scope}" --output table
```

# [Azure portal](#tab/portal)

This operation isn't available in the [Azure portal](https://portal.azure.com). Use Azure PowerShell or Azure CLI.

---

If you don't see **Resource Mover Contributor** or **Contributor** scoped to the relevant subscriptions, apply one of the assignment options in the following section.

### Option 1: Use the Resource Mover Contributor built-in role

The Resource Mover Contributor built-in role grants the minimum permissions to move resources across subscriptions and resource groups by using Azure Resource Mover.

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to assign this role at the **subscription** scope for both the source and destination subscriptions.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Subscriptions**, and select the source subscription.
1. Select **Access control (IAM)** > **Add** > **Add role assignment**.
1. On the **Role** tab, search for **Resource Mover Contributor**, and then select it.
1. On the **Members** tab, select **+ Select members**, and then add your account or service principal.
1. Select **Review + assign**.

Repeat these steps for the destination subscription.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
# Assign Resource Mover Contributor on the source subscription
New-AzRoleAssignment `
  -SignInName "<your-upn>" `
  -RoleDefinitionName "Resource Mover Contributor" `
  -Scope "/subscriptions/<source-subscription-id>"

# Assign Resource Mover Contributor on the destination subscription
New-AzRoleAssignment `
  -SignInName "<your-upn>" `
  -RoleDefinitionName "Resource Mover Contributor" `
  -Scope "/subscriptions/<destination-subscription-id>"
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
# Assign on source subscription
az role assignment create --assignee "<your-upn>" \
  --role "Resource Mover Contributor" \
  --scope "/subscriptions/<source-subscription-id>"

# Assign on destination subscription
az role assignment create --assignee "<your-upn>" \
  --role "Resource Mover Contributor" \
  --scope "/subscriptions/<destination-subscription-id>"
```

---

### Option 2: Create a custom role for least-privilege access

If your organization requires least-privilege access, create a custom role that grants only the permissions that Resource Mover requires.

#### Step 1: Create the custom role definition

Save the following JSON script to a file named `resource-mover-custom-role.json`. In this script, replace `<source-subscription-id>` and `<destination-subscription-id>` with your subscription IDs.

Run the following script.

```json
{
  "Name": "Resource Mover Operator",
  "Description": "Least-privilege role for Azure Resource Mover operations.",
  "IsCustom": true,
  "Actions": [
    "Microsoft.Resources/subscriptions/resourceGroups/read",
    "Microsoft.Resources/subscriptions/resourceGroups/moveResources/action",
    "Microsoft.Resources/subscriptions/resourceGroups/write",
    "Microsoft.MigrationHub/moveCollections/read",
    "Microsoft.MigrationHub/moveCollections/write",
    "Microsoft.MigrationHub/moveCollections/delete",
    "Microsoft.MigrationHub/moveCollections/moveResources/read",
    "Microsoft.MigrationHub/moveCollections/moveResources/write",
    "Microsoft.MigrationHub/moveCollections/moveResources/delete",
    "Microsoft.MigrationHub/moveCollections/prepare/action",
    "Microsoft.MigrationHub/moveCollections/initiateMove/action",
    "Microsoft.MigrationHub/moveCollections/commit/action",
    "Microsoft.MigrationHub/moveCollections/discard/action",
    "Microsoft.MigrationHub/moveCollections/resolveDependencies/action",
    "Microsoft.Compute/virtualMachines/read",
    "Microsoft.Compute/disks/read",
    "Microsoft.Network/networkInterfaces/read",
    "Microsoft.Network/publicIPAddresses/read",
    "Microsoft.Network/virtualNetworks/read"
  ],
  "NotActions": [],
  "DataActions": [],
  "NotDataActions": [],
  "AssignableScopes": [
    "/subscriptions/<source-subscription-id>",
    "/subscriptions/<destination-subscription-id>"
  ]
}
```

#### Step 2: Deploy the custom role

Use Azure PowerShell or Azure CLI to deploy the custom role.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
New-AzRoleDefinition -InputFile ".\resource-mover-custom-role.json"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az role definition create --role-definition @resource-mover-custom-role.json
```

# [Azure portal](#tab/portal)

This operation isn't available in the Azure portal. Use Azure PowerShell or Azure CLI.

---

#### Step 3: Assign the custom role

Use Azure PowerShell or Azure CLI to assign the custom role to the appropriate subscriptions.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
# Assign on source subscription
New-AzRoleAssignment `
  -SignInName "<your-upn>" `
  -RoleDefinitionName "Resource Mover Operator" `
  -Scope "/subscriptions/<source-subscription-id>"

# Assign on destination subscription
New-AzRoleAssignment `
  -SignInName "<your-upn>" `
  -RoleDefinitionName "Resource Mover Operator" `
  -Scope "/subscriptions/<destination-subscription-id>"
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
az role assignment create --assignee "<your-upn>" \
  --role "Resource Mover Operator" \
  --scope "/subscriptions/<source-subscription-id>"

az role assignment create --assignee "<your-upn>" \
  --role "Resource Mover Operator" \
  --scope "/subscriptions/<destination-subscription-id>"
```

# [Azure portal](#tab/portal)

This operation isn't available in the Azure portal. Use Azure PowerShell or Azure CLI.

---

### Required permissions reference

The following table describes what each permission category enables during a move operation.

| Permission category | What it enables |
|---|---|
| `Microsoft.Resources/subscriptions/resourceGroups/moveResources/action` | Submit the move request on the source resource group. |
| `Microsoft.Resources/subscriptions/resourceGroups/write` | Create resources in the destination resource group. |
| `Microsoft.MigrationHub/moveCollections/*` | Create and manage Resource Mover move collections. |
| `Microsoft.Compute/*/read`, `Microsoft.Network/*/read` | Read source resources to build the dependency graph. |

### Troubleshoot AuthorizationFailed errors

If the move fails and returns an `AuthorizationFailed` error message, the message identifies the specific missing permission. 

#### Common missing permissions and their resolutions

The following table lists common missing permissions and how to resolve them.

| Error detail | Resolution |
|---|---|
| `does not have authorization to perform action 'Microsoft.Resources/subscriptions/resourceGroups/moveResources/action'` | Assign **Resource Mover Contributor** or the custom role on the source subscription. |
| `does not have authorization to perform action 'Microsoft.MigrationHub/moveCollections/write'` | The custom role is missing `MigrationHub` permissions. Update the role definition. |
| `The client does not have permission to perform action on scope '/subscriptions/<id>/resourceGroups/<rg>'` | The role assignment scope doesn't match the target resource group. Verify the scope. |

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move Azure virtual machine resources to a different subscription (Azure portal)](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [What is Azure Resource Mover?](/azure/resource-mover/overview)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
