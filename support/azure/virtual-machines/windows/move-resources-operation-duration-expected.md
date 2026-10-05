---
title: Azure VM resource move is taking longer than expected
description: Troubleshoot long-running Azure VM move operations, verify when delays are expected, and open a support case if move progress stalls.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/11/2026
ms.reviewer: scotro, jdickson
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine resource move takes longer than expected

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article helps you troubleshoot and understand why an Azure virtual machine (VM) resource move operation might take longer than expected, and when to investigate further.

## Symptoms

A move operation takes much longer than you expect.

Common questions include the following items:

- Is the move operation stuck?
- Should I cancel and retry the move operation?
- Why are the resource groups still locked?

## Cause

Move duration varies based on the following factors:

- The number of dependent resources
- Validation complexity
- Resource group lock duration
- Platform-side dependency orchestration

A long-running move operation isn't automatically a failure.

## Resolution

### Step 1: Review the Azure activity log

Use the [Azure portal](https://portal.azure.com), Azure PowerShell, or Azure CLI to review the activity log for the move operation.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to the source or destination resource group.
1. Select **Activity log**.
1. Filter by the **Move** operation to check whether the move is still progressing or failed.

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

### Step 2: Count dependent resources

Large dependency graphs increase the move time. Use the Azure portal, Azure PowerShell, or Azure CLI to review VM-related network adapters, disks, public IPs, network security groups (NSGs), virtual networks (VNets), and attached service dependencies.

# [Azure portal](#tab/portal)

Follow these steps:

1. In the Azure portal, go to the resource group.
1. Review the resource list and note the total count and types of resources.

# [Azure PowerShell](#tab/powershell)

Run the following command.

```azurepowershell
Get-AzResource -ResourceGroupName "<resource-group-name>" |
  Group-Object ResourceType |
  Format-Table Count, Name
```

# [Azure CLI](#tab/cli)

Run the following command.

```azurecli
az resource list \
  --resource-group <resource-group-name> \
  --query "[].type" -o tsv | sort | uniq -c | sort -rn
```

---

### Step 3: Don't interrupt an active, healthy move

If the move is still active, and no failure appears in the activity log, avoid retrying or making concurrent changes.

### When to investigate further

Investigate the issue further if the following conditions are true:

- The activity log shows repeated failures.
- The duration exceeds expected operational windows.
- Resource groups remain locked and show no visible move progress.

### What to collect for escalation

Before you open a support case, gather the following items:

- The subscription ID
- The source and destination resource groups
- The Correlation ID from the failed or long-running operation
- The timestamp from when the move started

## References

- [Azure resource groups are locked during a virtual machine move operation](move-resources-resource-group-lock-duration.md)
- [Pre-flight checklist for moving Azure VM resources](move-resources-preflight-checklist.md)
- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
