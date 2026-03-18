---
title: Azure resource move fails - private endpoint is not in Succeeded state
description: Troubleshoot a resource move or validation failure caused by a private endpoint that is in a Failed provisioning state.
services: virtual-machines
author: scotro
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 03/18/2026
ms.author: scotro
ms.reviewer: jarrettr
ms.custom: sap:Cannot create a VM
---
# Azure resource move fails because a private endpoint is not in Succeeded state

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Symptoms

When you try to move Azure resources to a different resource group or subscription, the move or validation operation fails with an error similar to the following:

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

A private endpoint in the source or destination resource group — either directly included in the move, or referenced as a dependency — is not in `Succeeded` provisioning state. Azure blocks the move until all resources and their dependencies are in a healthy state.

Common reasons a private endpoint enters a `Failed` state:
- A prior deployment or update operation failed partway through.
- One or more of the private endpoint's dependent objects (such as the private endpoint network interface) is in a `Failed` state.
- The private endpoint was partially created or deleted.

## Resolution

### Step 1: Identify the private endpoint

The error message names the private endpoint that is not in `Succeeded` state. Note the resource group and endpoint name for the next steps.

### Step 2: Check the private endpoint status

**Azure portal**

1. In the Azure portal, search for **Private endpoints**.
2. Locate the endpoint named in the error message.
3. Review **Properties** and confirm that the provisioning state is **Failed**.
4. Under **DNS configuration** or dependent objects, note any sub-resources that are also in a `Failed` state.

**PowerShell**

```powershell
Get-AzPrivateEndpoint -ResourceGroupName "<resource-group-name>" -Name "<endpoint-name>"
```

### Step 3: Remediate the private endpoint

If only the private endpoint itself is in `Failed` state (its dependent network interface is healthy), use the following PowerShell command to trigger a re-apply that can restore it to `Succeeded` state:

```powershell
Get-AzPrivateEndpoint -ResourceGroupName "<resource-group-name>" -Name "<endpoint-name>" | Set-AzPrivateEndpoint
```

After running this command, verify that the provisioning state has returned to `Succeeded` before retrying the move.

> [!NOTE]
> If more than one dependent resource of the private endpoint is in a `Failed` state, the above command may not resolve the issue. In that case, engage the Azure Networking support team for assistance with the private endpoint remediation.

### Step 4: Retry the move

Once the private endpoint shows a provisioning state of `Succeeded`, retry the move operation.

## Alternative: Remove the private endpoint from the move scope

If the private endpoint is not essential to the resources being moved and you do not want to wait for remediation, you can remove it from the set of resources selected for the move, complete the move, and then recreate the private endpoint in the destination resource group afterward.

> [!IMPORTANT]
> Before removing a private endpoint from the move scope, verify that none of the resources you are moving have a hard dependency on it during the move process.

## More information

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [What is Azure Private Endpoint?](/azure/private-link/private-endpoint-overview)
- [Manage private endpoints](/azure/private-link/manage-private-endpoint)
- [Troubleshoot moving Azure resources](/azure/azure-resource-manager/management/troubleshoot-move)
