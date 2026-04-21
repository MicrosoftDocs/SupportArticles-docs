---
title: Azure resource move fails - hidden resources not included in move request
description: Resolve Azure resource move failures and "IncompleteRequest" errors when hidden dependencies are missed. Follow these steps to include all resources and retry successfully.
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
# Azure resource move fails because hidden resources aren't included in the move

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Summary

This article helps you fix cases in which a Microsoft Azure resource move fails and geberates an `IncompleteRequest` error because hidden dependent resources weren't included in the move request.

## Symptoms

When you try to move a virtual machine (VM) and its associated resources to a different resource group or subscription, the operation fails and returns an error message that resembles the following message:

```output
{
  "code": "IncompleteRequest",
  "message": "Move with hidden resources has a hidden resource /subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Compute/disks/<disk-name> that is not being moved"
}
```

## Cause

Two conditions can trigger this error.

**Cause 1: Hidden resources not selected**

Some Azure resources, like managed disks that are attached to a VM, are marked as **hidden** in the [Azure portal](https://portal.azure.com) by default. If you select resources to move without enabling **Show hidden types**, hidden dependent resources are excluded from the selection. Azure requires that all dependent resources be moved together. Azure blocks the operation if any required resources are missing.

**Cause 2: Insufficient role-based access control (RBAC) permissions**

If the account that performs the move uses a custom role, it might lack the required permissions to discover hidden resources. When Azure validates the move request, it can't enumerate the hidden resources. Therefore, it treats the request as incomplete.

The minimum required permissions are:

- **Source resource group:** `Microsoft.Resources/subscriptions/resourceGroups/moveResources/action`
- **Destination resource group:** `Microsoft.Resources/subscriptions/resourceGroups/write`

## Resolution

### Step 1: Include hidden resources in your selection (Azure portal)

1. In the Azure portal, go to the source resource group.
1. To reveal hidden resources, such as managed disks, select **Manage view** > **Show hidden types**.
1. Reselect all the resources that you want to move, including the hidden ones listed in the error message.
1. Retry the move operation.

### Step 2: Verify RBAC permissions

Verify that the account that performs the move has the correct role assignments:

1. In the Azure portal, go to the source resource group.
1. Select **Access control (IAM)** > **View my access**.
1. Review the listed role assignments, and verify that the required permissions are present.
1. If permissions are missing, select **Add role assignment**, and assign a role that includes `Microsoft.Resources/subscriptions/resourceGroups/moveResources/action`.

> [!NOTE]
> Grant permissions at the resource group level. The account also needs read permissions (`Microsoft.Resources/subscriptions/providers/read`) at the subscription level to fully enumerate all dependent resources during validation.

### Step 3: Retry the move

After you include all hidden resources and verify the permissions, retry the move operation.

## References

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Required permissions to move Azure resources](/azure/azure-resource-manager/management/move-resource-group-and-subscription#permissions-required-to-move-resources)
- [Move operation support for resources](/azure/azure-resource-manager/management/move-support-resources)
- [Troubleshoot moving Azure resources](/azure/azure-resource-manager/management/troubleshoot-move)
