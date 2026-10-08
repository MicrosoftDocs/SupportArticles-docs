---
title: Preflight checklist for moving Azure VM resources
description: Follow this preflight checklist to avoid failures when you move Azure VM resources across resource groups or subscriptions.
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

# Preflight checklist for moving Azure virtual machine resources

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

Use this checklist to experience fewer failures when you move Azure virtual machine (VM) resources. Each check addresses a common Azure resource move issue so that you can verify the requirements before you initiate the move.

## Quick check: Go - no-go determination

Before you open the **Move** wizard in the [Azure portal](https://portal.azure.com), verify these two conditions:

- The source VM is in a **Succeeded** provisioning state.
- No active backup jobs or maintenance operations are running on the VM.

If either condition isn't met, wait for the operation to finish before you proceed.

## Checklist

### Check 1: Include all dependent resources

A move request must include every resource that the target VM depends on. For example, the `MissingMoveDependentResources` error occurs if you omit dependent resources.

Include the following resources in the same move request:

- The VM
- All attached managed disks (OS disk and data disks)
- Network adapters that are attached to the VM
- Public IP addresses that are associated with the network adapters
- Network security groups (NSGs) that are attached to the network adapters or subnets
- A virtual network (required when moving to a different resource group)

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to list all resources in the source resource group.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzResource -ResourceGroupName "<source-rg>" | Select-Object Name, ResourceType | Sort-Object ResourceType
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource list --resource-group "<source-rg>" \
  --query "[].{Name:name, Type:type}" --output table
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Resource groups**, and then select the source resource group.
1. On the **Overview** page, review the **Resources** tab. You should see all dependent resources, like VMs, disks, network interface cards (NICs), public IPs, NSGs, and virtual networks (VNets).

For more information, see [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).

---

### Check 2: Remove Azure Backup restore point collections

If Azure Backup is active on the VM, the move fails and generates a backup lock error. Stop the backup, and delete the restore point collections before you move the VM.

Use Azure PowerShell or Azure CLI to identify restore point collections that are associated with the VM.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzResource -ResourceType "Microsoft.Compute/restorePointCollections" |
  Where-Object { $_.Name -match "<vm-name>" }
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource list --resource-type "Microsoft.Compute/restorePointCollections" \
  --query "[?contains(name, '<vm-name>')].{Name:name, Id:id}" --output table
```

# [Azure portal](#tab/portal)

Restore point collections are hidden resources that you can't see in the Azure portal resource browser. To list and check these resources, use  Azure PowerShell or Azure CLI.

---

### Check 3: Verify role-based access control (RBAC) permissions on source and destination

The following table lists the permissions that the account running the move needs.

| Scope | Required permission |
|---|---|
| Source resource group | `Microsoft.Resources/subscriptions/resourceGroups/moveResources/action` |
| Destination resource group | `Microsoft.Resources/subscriptions/resourceGroups/write` |

Use Azure PowerShell, Azure CLI, or the Azure portal to check the role assignments for your account.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzRoleAssignment -SignInName "<your-upn>" | Select-Object RoleDefinitionName, Scope
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az role assignment list --assignee "<your-upn>" \
  --query "[].{Role:roleDefinitionName, Scope:scope}" --output table
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to the source or destination resource group.
1. On the **Overview** page, review the **Access control (IAM)** tab to check your role assignments.
1. In the menu, select **Access control (IAM)**.
1. Select **View my access** to check your role assignments. Verify that you have at least **Contributor** or a custom role with the `moveResources/action` permission.

For more information, see [List Azure role assignments - Azure portal](/azure/role-based-access-control/role-assignments-list-portal).

---

> [!NOTE]
> If you don't have the required permissions, assign the **Resource Mover Contributor** built-in role at the subscription scope. For custom role requirements, see [Custom RBAC prerequisites for Azure Resource Mover](resource-mover-rbac-prerequisites.md).

### Check 4: Resolve VM extensions in a failed state

Extensions that are in a **Failed** or **Transitioning** provisioning state block the move. 

Use Azure PowerShell, Azure CLI, or the Azure portal to check the extension states before you submit the move.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzVMExtension -ResourceGroupName "<rg-name>" -VMName "<vm-name>" |
  Select-Object Name, ProvisioningState
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm extension list --resource-group "<rg-name>" --vm-name "<vm-name>" \
  --query "[].{Name:name, State:provisioningState}" --output table
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to **Virtual machines**, and then select the VM.
1. In the menu, in **Settings**, select **Extensions + applications**.
1. Check the **Status** column for each extension. All extensions should show **Provisioning succeeded**.

For more information, see [View available extensions](/azure/virtual-machines/extensions/overview#view-available-extensions).

---

For any extension that's not in the `Succeeded` state, follow these steps:

1. Try to update or reinstall the extension from the Azure portal: **Virtual machines** > **Extensions + applications** > select the extension > **Update** or **Uninstall**.
1. If the extension doesn't recover, uninstall it, complete the move, and then reinstall the extension at the destination.

### Check 5: Verify sufficient quota at the destination

Azure subscriptions enforce limits on resource counts. Verify that the destination subscription has a sufficient quota before you move resources.

In the Azure portal, go to **Subscriptions**, select the destination subscription, and then go to **Usage + quotas**. Check the following resource types:

- VMs (default: 25,000 per region)
- Managed disks (default: 50,000 per subscription)
- Public IP addresses (default: 1,000 per region)
- Network adapters (default: 65,536 per region)

If any resource type is at or near the limit, request a quota increase before you initiate the move.

### Check 6: Verify that the VM size is available at the destination 

If you move a VM to a different region, use Azure PowerShell, Azure CLI, or the Azure portal to verify that the VM size exists in the destination region.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzVMSize -Location "<destination-region>" | Where-Object { $_.Name -eq "<vm-size>" }
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm list-skus --location "<destination-region>" --size "<vm-size>" \
  --query "[].{Name:name, Zones:locationInfo[].zones}" --output table
```

# [Azure portal](#tab/portal)

In the Azure portal, you can check VM size availability by going to **Virtual machines** > **Create** and selecting the destination region. The **Size** dropdown shows available sizes. However, to verify a specific size programmatically, use Azure PowerShell or Azure CLI.

For more information, see [Resize a VM](/azure/virtual-machines/resize-vm).

---

If the command returns no results, the required size option isn't available. Either resize the VM to a supported size before you move it, or select a different destination region.

For resize constraints that involve disk types, see [Move fails because the required VM size isn't available at the destination](move-resources-resize-blocked-disk-constraints.md).

### Check 7: Verify Marketplace plan compatibility

VMs that you deploy from Azure Marketplace images and use a purchase plan require the same plan to be available in the destination subscription.

Use Azure PowerShell or Azure CLI to verify Marketplace plan compatibility for the VM.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<rg-name>" -Name "<vm-name>"
$vm.Plan
```

If the output shows a plan (publisher, product, and name fields), verify that the destination subscription has accepted the Marketplace terms.

```azurepowershell
Get-AzMarketplaceTerms -Publisher "<publisher>" -Product "<product>" -Name "<sku>"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az vm show --resource-group "<rg-name>" --name "<vm-name>" --query "plan"
```

If the output shows a plan, verify the terms.

```azurecli
az vm image terms show --publisher "<publisher>" --offer "<product>" --plan "<sku>"
```

# [Azure portal](#tab/portal)

Querying VM Marketplace plan metadata and verifying plan compatibility isn't available in the Azure portal. To check plan details, use Azure PowerShell or Azure CLI.

---

### Error reference table

The following table summarizes common error codes, their causes, and recommended resolutions.

| Error code | Cause | Resolution |
|---|---|---|
| `MissingMoveDependentResources` | One or more dependent resources are missing from the move scope. | [Check 1](#check-1-include-all-dependent-resources) |
| `ResourceMoveFailed` | General move failure. Review the Azure activity log for details. | Azure portal > Activity log |
| `IncompleteRequest` | Hidden resources (restore points, private endpoints) block the move. | [Check 2](#check-2-remove-azure-backup-restore-point-collections) |
| `AuthorizationFailed` | The account lacks required RBAC permissions. | [Check 3: Verify role-based access control (RBAC) permissions on source and destination](#check-3-verify-role-based-access-control-rbac-permissions-on-source-and-destination) |
| `ExtensionProvisioningFailed` | A VM extension is in a failed state. | [Check 4](#check-4-resolve-vm-extensions-in-a-failed-state) |
| `QuotaExceeded` | The destination subscription doesn't have a sufficient quota. | [Check 5](#check-5-verify-sufficient-quota-at-the-destination) |

## Next steps

After you complete all checks, follow these steps to initiate the move:

1. In the Azure portal, go to **Resource groups**, and select the source resource group.
1. Select the resources to move, and then select **Move** > **Move to another subscription** or **Move to another resource group**.
1. Select the destination, and then select **Next**.
1. Review the validation results, and then resolve any errors.
1. To submit the request, select **Move**.

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
