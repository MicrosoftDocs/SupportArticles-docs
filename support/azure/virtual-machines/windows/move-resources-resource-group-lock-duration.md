---
title: Azure resource groups are locked during a virtual machine move operation
description: Learn why Azure resource groups are locked during a virtual machine move, which operations are blocked, and what to check next to troubleshoot faster.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/15/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure resource groups are locked during a virtual machine move operation

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains why Azure resource groups are locked during a virtual machine (VM) move operation, and which operations are blocked while the move is in progress. The article also provides guidance to monitor the move, and explains what to do if the move takes longer than expected.

## Symptoms

After a move starts, you can't update, delete, or create resources in the source or destination resource group.

Typical questions include the following concerns:

- Why is the move taking so long?
- Is the move stuck?
- Why can't I resize or update the VM while the move runs?

## Cause

During a move, Azure Resource Manager (ARM) locks both the source and destination resource groups to prevent conflicting writes while it updates resource IDs and dependencies.

This platform behavior is by design.

## Resolution

### Step 1: Check move operation state

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to check the state of the move operation.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the source or destination resource group.
1. Select **Activity log**.
1. Filter by the **Move** operation to check whether the move is still running or failed.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzActivityLog -ResourceGroupName "<resource-group-name>" `
  -StartTime (Get-Date).AddHours(-4) |
  Where-Object { $_.OperationName.Value -like "*move*" } |
  Format-Table EventTimestamp, OperationName, Status
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az monitor activity-log list \
  --resource-group <resource-group-name> \
  --offset 4h \
  --query "[?contains(operationName.value, 'move')].{time:eventTimestamp, operation:operationName.value, status:status.value}" \
  --output table
```

---

### Step 2: Avoid conflicting operations

Don't try the following operations because they can conflict with the ongoing move operation.

- Resizing
- VM extension updates
- Network security group (NSG) rule changes
- Resource creation in the same source or destination group

### Step 3: Escalate only after the expected window

If the move operation takes longer than expected, and the activity log shows no progress, gather the correlation ID, and open a support case.

## More information

### What is affected

While the move is running, the following restrictions apply:

- You can't create, delete, or update resources in the source resource group.
- You can't create, delete, or update resources in the destination resource group.
- Existing workloads usually keep running, but management operations are restricted.

### How long does the lock last?

The lock can remain in place for up to four hours, although many moves finish sooner.

If the move is still active, don't start overlapping change operations against either resource group.

## References

- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Move Azure resources across resource groups, subscriptions, or regions](/azure/azure-resource-manager/management/move-resources-overview)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
