---
title: Azure resource move fails - hidden resources not included in move request
description: Troubleshoot the IncompleteRequest error when moving Azure VM resources that have hidden dependent resources not included in the move.
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
# Azure resource move fails because hidden resources are not included in the move

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Symptoms

When you try to move a virtual machine and its associated resources to a different resource group or subscription, the operation fails with an error similar to the following:

```output
{
  "code": "IncompleteRequest",
  "message": "Move with hidden resources has a hidden resource /subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Compute/disks/<disk-name> that is not being moved"
}
```

## Cause

Two conditions can trigger this error:

**Cause 1: Hidden resources not selected**

Some Azure resources, such as managed disks attached to a VM, are marked as *hidden* in the portal by default. If you select resources to move without enabling the **Show hidden types** option, hidden dependent resources are excluded from the selection. Azure requires that all dependent resources be moved together and blocks the operation if any are missing.

**Cause 2: Insufficient RBAC permissions**

If the account performing the move uses a custom role, it may lack the permissions needed to discover hidden resources. When Azure validates the move request, it can't enumerate the hidden resources and treats the request as incomplete.

The minimum required permissions are:
- **Source resource group:** `Microsoft.Resources/subscriptions/resourceGroups/moveResources/action`
- **Destination resource group:** `Microsoft.Resources/subscriptions/resourceGroups/write`

## Resolution

### Step 1: Include hidden resources in your selection (Azure portal)

1. In the Azure portal, navigate to the source resource group.
2. Select **Manage view** > **Show hidden types** to reveal hidden resources such as managed disks.
3. Re-select all resources you want to move, including the hidden ones listed in the error message.
4. Retry the move operation.

### Step 2: Verify RBAC permissions

Confirm that the account performing the move has the correct role assignments:

1. In the Azure portal, navigate to the source resource group.
2. Select **Access control (IAM)** > **View my access**.
3. Review the listed role assignments and verify the required permissions are present.
4. If permissions are missing, select **Add role assignment** and assign a role that includes `Microsoft.Resources/subscriptions/resourceGroups/moveResources/action`.

> [!NOTE]
> Granting permissions at the resource group level is recommended. The account also needs read permissions (`Microsoft.Resources/subscriptions/providers/read`) at the subscription level to fully enumerate all dependent resources during validation.

### Step 3: Retry the move

After including all hidden resources and confirming permissions, retry the move operation.

## More information

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Required permissions to move Azure resources](/azure/azure-resource-manager/management/move-resource-group-and-subscription#permissions-required-to-move-resources)
- [Move operation support for resources](/azure/azure-resource-manager/management/move-support-resources)
- [Troubleshoot moving Azure resources](/azure/azure-resource-manager/management/troubleshoot-move)
