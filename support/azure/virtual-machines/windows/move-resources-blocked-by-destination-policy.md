---
title: Azure resource move is blocked by Azure Policy deny rules
description: Troubleshoot Azure resource move failures caused by Azure Policy deny rules. Use this guide to identify blockers and complete the move successfully.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/04/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure Policy deny rules block resource move

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs :heavy_check_mark: All resource types

## Summary

This article explains how to troubleshoot Azure resource move operations that Azure Policy assignments with `Deny` effects block at the destination scope.

## Symptoms

A move operation fails and returns an error message that resembles the following example:

```
ResourceMovePolicyValidationFailed: Resource move policy validation failed.
Please see details. Diagnostic information: subscription id '<id>',
tracking id '<tracking-id>'
```

The move is blocked even though the resources are valid and the destination infrastructure exists.

## Cause

Azure Policy assignments at the destination subscription or resource group scope have `Deny` effects that prevent the following actions:

- Creating resources of a specific type
- Creating resources that have certain tags or properties
- Moving resources into a resource group
- Using specific resource SKUs or sizes

Common policies that block moves include the following:

- `Deny` policies on VM creation
- Tag-based `Deny` policies (missing required tags)
- SKU restrictions (for example, blocking Standard SKU resources)
- Location restrictions (for example, allowing only certain regions)
- Resource type restrictions

## Resolution

### Step 1: Identify the blocking policy

Check which policies are assigned to the destination scope.

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to review the policy assignments at the destination subscription or resource group.

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
# Check subscription-level policies
Get-AzPolicyAssignment -Scope "/subscriptions/<destination-sub-id>" |
  Where-Object { $_.Properties.PolicyDefinitionId -match "Deny" }

# Check resource group-level policies
Get-AzPolicyAssignment -Scope "/subscriptions/<destination-sub-id>/resourceGroups/<destination-rg>" |
  Where-Object { $_.Properties.PolicyDefinitionId -match "Deny" }

# Review policy details
$policy = Get-AzPolicyAssignment -Name "<policy-name>"
$policyDef = Get-AzPolicyDefinition -Id $policy.Properties.PolicyDefinitionId
$policyDef.Properties.policyRule | ConvertTo-Json -Depth 5
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
# Check subscription-level policies
az policy assignment list --scope "/subscriptions/<destination-sub-id>" \
  --query "[?contains(policyDefinitionId, 'Deny')].{Name:name, Policy:policyDefinitionId}" --output table

# Check resource group-level policies
az policy assignment list --resource-group "<destination-rg>" \
  --query "[].{Name:name, Policy:policyDefinitionId, Enforcement:enforcementMode}" --output table

# Review policy rule details
az policy definition show --name "<policy-definition-name>" --query "policyRule"
```

# [Azure portal](#tab/portal)

Follow these steps.

1. In the [Azure portal](https://portal.azure.com), go to **Policy** > **Compliance**.
1. Set the scope to the destination subscription or resource group.
1. Review any policies that show **Non-compliant** to identify which policy is blocking the move.

Alternatively, go to the resource group, select **Activity log**, and filter by the failed move operation to see the policy denial details.

---

For more information, see [What is Azure Policy?](/azure/governance/policy/overview).

### Step 2: Review the policy rule

Check which condition the policy rule violates.

Use Azure PowerShell, Azure CLI, or the Azure portal to review the policy definition and understand which conditions trigger the `Deny` effect.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$policyDef | Select-Object -ExpandProperty Properties |
  Select-Object -ExpandProperty displayName, description, policyRule
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az policy definition show --name "<policy-definition-name>" \
  --query "{Name:displayName, Description:description, Rule:policyRule}"
```

# [Azure portal](#tab/portal)

Follow these steps.

1. In the [Azure portal](https://portal.azure.com), go to **Policy** > **Definitions**.
1. Search for the policy by name, and then select it.
1. Review the **Policy rule** tab to understand which conditions trigger the deny effect.

---

For more information, see [What is Azure Policy?](/azure/governance/policy/overview).

Common blocking conditions include the following:

- `type` field - Policy denies specific resource types (for example, `Microsoft.Compute/virtualMachines`).
- `tags` - Resources are missing required tags.
- `sku.name` - Resource SKU doesn't match approved list.
- `location` - Resource location isn't in allowed regions.

### Step 3: Choose remediation path

**Option A: Exempt the move operation**

Create a temporary policy exemption.

Use Azure PowerShell, Azure CLI, or the Azure portal to create a temporary exemption for the move operation. 

# [Azure PowerShell](#tab/powershell)

Run the following commands.

```azurepowershell
$exemption = @{
  Name = "move-operation-temporary"
  ResourceGroupName = "<destination-rg>"
  PolicyAssignmentId = $policy.ResourceId
  ExemptionCategory = "Mitigated"
  DisplayName = "Temporary exemption for resource move"
  Description = "Exempts the move operation from blocking policy"
}

New-AzPolicyExemption @exemption
```

After the move finishes, remove the exemption.

```azurepowershell
Remove-AzPolicyExemption -Name "move-operation-temporary" -ResourceGroupName "<destination-rg>"
```

# [Azure CLI](#tab/cli)

Run the following commands.

```azurecli
# Create temporary exemption
az policy exemption create \
  --name "move-operation-temporary" \
  --resource-group "<destination-rg>" \
  --policy-assignment "<policy-assignment-id>" \
  --exemption-category "Mitigated" \
  --display-name "Temporary exemption for resource move"

# After the move, remove the exemption
az policy exemption delete \
  --name "move-operation-temporary" \
  --resource-group "<destination-rg>"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Policy** > **Exemptions**.
1. Select **Add exemption**, select the blocking policy assignment, and then set the category to **Mitigated**.
1. After the move finishes, delete the exemption.

---

For more information, see [What is Azure Policy?](/azure/governance/policy/overview).

Retry the move.

**Option B: Modify resources to comply**

If the policy can be satisfied, update the resources.

Use Azure PowerShell, Azure CLI, or the Azure portal to add required tags or properties to the resources before moving them.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
# Example: Add required tags before move
$vm = Get-AzVM -ResourceGroupName "<source-rg>" -Name "<vm-name>"
$vm.Tags["CostCenter"] = "Finance"
$vm.Tags["Environment"] = "Production"
Update-AzTag -ResourceId $vm.Id -Tag $vm.Tags
```

#### [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az tag update --resource-id "<vm-resource-id>" \
  --operation merge \
  --tags CostCenter=Finance Environment=Production
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the resource (for example, the VM).
1. In the menu, select **Tags**.
1. Add the required tags and values, and then select **Apply**.

---

For more information, see [What is Azure Policy?](/azure/governance/policy/overview).

**Option C: Adjust the policy assignment**

If the destination policy is unnecessarily restrictive, adjust it.

Use Azure PowerShell, Azure CLI, or the Azure portal to temporarily exclude the destination resource group from the policy assignment.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
$assignment = Get-AzPolicyAssignment -Name "<policy-name>"
Set-AzPolicyAssignment -Id $assignment.ResourceId -Scope "/subscriptions/<destination-sub-id>" -NotScopes @("/subscriptions/<destination-sub-id>/resourceGroups/<destination-rg>")
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az policy assignment update --name "<policy-name>" \
  --scope "/subscriptions/<destination-sub-id>" \
  --not-scopes "/subscriptions/<destination-sub-id>/resourceGroups/<destination-rg>"
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Policy** > **Assignments**.
1. Select the blocking policy assignment, and then select **Edit assignment**.
1. Under **Exclusions**, add the destination resource group to exclude it temporarily from the policy scope.
1. After the move finishes, remove the exclusion.

---

For more information, see [What is Azure Policy?](/azure/governance/policy/overview).

Retry the move and restore the policy.

**Option D: Move to a different destination**

If the destination subscription policies are fundamentally incompatible with your resources, move to a different subscription that doesn't have conflicting policies.

Use Azure PowerShell or Azure CLI to specify an alternate destination subscription and resource group.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Move-AzResource -DestinationSubscriptionId "<alternate-sub-id>" `
  -DestinationResourceGroupName "<alternate-destination-rg>" `
  -ResourceId "/subscriptions/<source-sub-id>/resourceGroups/<source-rg>/providers/<resource-type>/<resource-name>"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource move \
  --destination-group "<alternate-destination-rg>" \
  --destination-subscription-id "<alternate-sub-id>" \
  --ids "/subscriptions/<source-sub-id>/resourceGroups/<source-rg>/providers/<resource-type>/<resource-name>"
```

# [Azure portal](#tab/portal)

Moving resources to an alternate destination subscription isn't available in the Azure portal move wizard. To specify a different destination subscription, use Azure PowerShell or Azure CLI.

---

### Prevention

Ensure that you take the following preventative measures:

- Review destination policies before you plan a move.
- Coordinate with the security team to understand compliance requirements in the destination.
- For sensitive operations, use policy exemptions instead of disabling policies.
- Verify resource compliance before you initiate large-scale moves.

## References

- [Move blocked by destination Azure Policy deny rules](move-resources-destination-policy-deny.md)
- [Azure Policy overview](/azure/governance/policy/overview)
- [Use policy exemptions](/azure/governance/policy/concepts/exemption-structure)
- [Troubleshoot Azure Policy](/azure/governance/policy/troubleshoot/general)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
