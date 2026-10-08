---
title: Azure resource move fails because private endpoint not in Succeeded state
description: Troubleshoot resource move failures when a private endpoint is in a Failed provisioning state. Learn how to remediate and retry your move operation.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/14/2026
ms.custom: sap:Cannot create a VM
ai-usage: ai-assisted
---
# Azure resource move fails because a private endpoint isn't in a Succeeded state

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Summary

When an Azure resource move fails, a private endpoint that isn't in the `Succeeded` provisioning state might be the cause. This article helps you identify and remediate the endpoint so you can successfully retry the resource group or subscription move.

## Symptoms

When you try to move Azure resources to a different resource group or subscription, the move or validation operation fails and returns an error message that resembles the following message.

```output
{
  "code": "MoveCannotProceedWithResourcesNotInSucceededState",
  "message": "One of the resources being migrated or its dependency is not in Succeeded state.",
  "details": [{
    "code": "ResourceNotProvisioned",
    "message": "Cannot proceed with operation because resource /subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Network/privateEndpoints/<endpoint-name> either directly involved in the move or referenced by one of the resources involved in the move is not in Succeeded state."
  }]
}
```

## Cause

A private endpoint in the source or destination resource group isn't in the `Succeeded` provisioning state. The affected endpoint is either directly included in the move or referenced as a dependency. Azure blocks the move until all resources and their dependencies are in a healthy state.

Common reasons a private endpoint enters a `Failed` state include the following items:

- A prior deployment or update operation failed partway through.
- One or more of the private endpoint's dependent objects (like the private endpoint network interface) is in a `Failed` state.
- The private endpoint was partially created or deleted.

## Resolution

### Step 1: Identify the failed private endpoint

The error message names the private endpoint that isn't in the `Succeeded` state. Note the resource group and endpoint name for the next steps.

### Step 2: Check the private endpoint provisioning status

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to identify the failed private endpoint and check its provisioning status.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for **Private endpoints**.
1. Locate the endpoint that's named in the error message.
1. Review the **Properties** settings, and then verify that the provisioning state is **Failed**.
1. In **DNS configuration** or dependent objects, note any subresources that are also in a `Failed` state.

For more information, see [Manage a private endpoint](/azure/private-link/manage-private-endpoint).

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzPrivateEndpoint -ResourceGroupName "<resource-group-name>" -Name "<endpoint-name>"
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az network private-endpoint show --resource-group "<resource-group-name>" --name "<endpoint-name>" \
  --query "{Name:name, State:provisioningState, Connections:privateLinkServiceConnections[].privateLinkServiceConnectionState}"
```

---

### Step 3: Remediate the private endpoint

If only the private endpoint itself is in a `Failed` state (that is, its dependent network interface is healthy), use Azure PowerShell or Azure CLI to trigger a reapplication that can restore the endpoint to a `Succeeded` state.

# [Azure portal](#tab/portal)

Reapplying a private endpoint configuration to restore it from a failed state isn't available in the Azure portal. To trigger a reapplication programmatically, use Azure PowerShell or Azure CLI.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzPrivateEndpoint -ResourceGroupName "<resource-group-name>" -Name "<endpoint-name>" | Set-AzPrivateEndpoint
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az network private-endpoint update --resource-group "<resource-group-name>" --name "<endpoint-name>"
```

---

After you run this command, verify that the provisioning state returns to `Succeeded` before you retry the move.

> [!NOTE]
> If more than one dependent resource of the private endpoint is in a `Failed` state, this command might not resolve the issue. In this case, engage the Azure Networking support team for assistance to perform the private endpoint remediation.

### Step 4: Retry the move

After the private endpoint shows a provisioning state of `Succeeded`, retry the move operation.

## Alternative: Remove the private endpoint from the move scope

If the private endpoint isn't essential to the resources that you're moving and you don't want to wait for remediation, remove the endpoint from the set of resources that you select for the move. Complete the move, and then re-create the private endpoint in the destination resource group.

> [!IMPORTANT]
> Before you remove a private endpoint from the move scope, verify that none of the resources that you're moving have a hard dependency on it during the move process.

## References

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [What is Azure Private Endpoint?](/azure/private-link/private-endpoint-overview)
- [Manage private endpoints](/azure/private-link/manage-private-endpoint)
- [Troubleshoot moving Azure resources](/azure/azure-resource-manager/management/troubleshoot-move)
