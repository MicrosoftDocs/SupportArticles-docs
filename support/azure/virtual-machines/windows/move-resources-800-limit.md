---
title: Azure resource move fails - 800 resource limit exceeded
description: Resolve Azure resource move failures caused by the 800-resource limit in Azure Resource Manager by using proven batching and recovery steps.
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
# Azure resource move fails because the 800-resource limit is exceeded

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Summary

When you try to move more than 800 resources in a single operation, the move fails because of the platform limit. To successfully move a large number of resources, break the move into smaller batches.

## Symptoms

When you try to move a large number of Azure resources to a different resource group or subscription in a single operation, the move fails immediately. Additionally, you receive an error message that states that too many resources were included, or the operation times out.

## Cause

Azure Resource Manager enforces a limit of 800 resources per move operation. If a single move request contains more than 800 resources, Resource Manager generates an error immediately. Move operations that have 800 or fewer resources can also fail if they time out.

This limit applies at the subscription level. For more information, see [Subscription limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#subscription-limits).

## Resolution

Break the move into multiple smaller operations, each containing fewer than 800 resources. Consider the following methods.

### Option 1: Move resources in batches

Divide your resources into groups of fewer than 800, and run separate move operations for each group. Make sure that dependent resources (like a virtual machine (VM) and its network adapter are included in the same batch.

### Option 2: Tka e a snapshot and re-create

If breaking the move into batches isn't practical, take snapshots of the VM disks, move the snapshots to the destination subscription, and re-create the VMs.

> [!NOTE]
> You can move only *full* snapshots between resource groups, subscriptions, or regions. *Incremental* snapshots aren't supported for cross-subscription or cross-region moves. See [Move operation support for Microsoft.Compute resources](/azure/azure-resource-manager/management/move-support-resources#microsoftcompute).

1. Take a snapshot. For more information, see [Create a snapshot of a virtual hard disk](/azure/virtual-machines/snapshot-copy-managed-disk?tabs=portal).

1. Move the snapshot. For more information, see [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).

1. Create a VM from the snapshot (PowerShell). For more information, see [Create a virtual machine from a snapshot with PowerShell](/azure/virtual-machines/scripts/virtual-machines-linux-powershell-sample-create-vm-from-snapshot).

1. Create a VM from the snapshot (Azure CLI). For more information, see [Create a virtual machine from a snapshot with CLI](/azure/virtual-machines/scripts/create-vm-from-snapshot).

## References

- [Move Azure resources to a new resource group or subscription — FAQ](/azure/azure-resource-manager/management/move-resource-group-and-subscription#frequently-asked-questions)
- [Subscription and service limits, quotas, and constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits#subscription-limits)
