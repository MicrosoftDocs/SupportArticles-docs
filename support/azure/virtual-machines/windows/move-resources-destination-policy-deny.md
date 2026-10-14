---
title: Azure VM resource move is blocked by destination Azure Policy
description: Troubleshoot an Azure VM resource move blocked by destination Azure Policy deny assignments. Fix compliance issues and retry the move successfully.
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

# Azure virtual machine resource move is blocked by destination Azure Policy

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains how to troubleshoot an Azure VM resource move that fails because Azure Policy assignments at the destination subscription or resource group have deny effects. It shows how to identify the blocking policy, compare its requirements with the resources, fix noncompliance, and retry the move successfully.

## Symptoms

A move validation or move operation fails and generates policy errors that resemble the following examples.

```output
RequestDisallowedByPolicy
```

```output
The resource action is disallowed by one or more policies.
```

## Cause

The destination scope has Azure Policy assignments that have `Deny` effects. These effects conflict with one or more moved resources. Common conflicts include the following:

- Missing required tags
- Disallowed locations or SKUs
- Restricted public IP or network adapter settings
- Enforced diagnostic settings or naming patterns

## Resolution

### Step 1: Identify the blocking policy assignment

Use Azure PowerShell, Azure CLI, or the [Azure portal](https://portal.azure.com) to run the failed move and capture the operation details from the **Activity log**. Note the policy assignment name and definition.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzPolicyAssignment -Scope "/subscriptions/<destination-subscription-id>/resourceGroups/<destination-rg>" |
  Select-Object DisplayName, PolicyDefinitionId, Scope
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az policy assignment list --resource-group "<destination-rg>" \
  --query "[].{Name:displayName, Policy:policyDefinitionId, Scope:scope}" --output table
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Policy** > **Compliance**.
1. Set the scope to the destination subscription or resource group.
1. Review any policies that show **Non-compliant** to identify which policy is blocking the move.

Alternatively, go to the resource group, select **Activity log**, and filter by the failed move operation to see the policy denial details.

---

For more information, see [What is Azure Policy?](/azure/governance/policy/overview).

### Step 2: Compare policy requirements with moved resources

Use Azure PowerShell, Azure CLI, or the Azure portal to check whether resources satisfy required tags and allowed settings.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzResource -ResourceGroupName "<source-rg>" |
  Select-Object Name, ResourceType, Location, Tags
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource list --resource-group "<source-rg>" \
  --query "[].{Name:name, Type:type, Location:location, Tags:tags}" --output table
```

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to **Resource groups**, and then select the source resource group.
1. On the **Overview** page, review the **Resources** tab. Check the **Location** and **Tags** columns for each resource.

---

For more information, see [Manage resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal).

### Step 3: Fix resource metadata or request temporary exemption

Use one of the following methods:

- Add required tags before the move
- Align resource settings to policy requirements
- Create a temporary policy exemption (if approved by governance)

> [!NOTE]
> Avoid permanently relaxing the security policies unless this change is approved by your governance team.

### Step 4: Re-run move validation

After remediation, rerun the validation, and complete the move.

### Prevention

Before you move production workloads, run a policy precheck at the destination scope, and fix noncompliant resources.

## References

- [Preflight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Custom RBAC prerequisites for Azure Resource Mover](resource-mover-rbac-prerequisites.md)
- [Azure Policy overview](/azure/governance/policy/overview)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
