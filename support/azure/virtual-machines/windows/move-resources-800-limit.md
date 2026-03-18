---
title: Azure resource move fails - 800 resource limit exceeded
description: Troubleshoot the error that occurs when a single move operation contains more than 800 resources in Azure Resource Manager.
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

## Symptoms

When you try to move a large number of Azure resources to a different resource group or subscription in a single operation, the move fails immediately with an error indicating too many resources were included, or the operation times out.

## Cause

Azure Resource Manager enforces a limit of **800 resources per move operation**. When a single move request contains more than 800 resources, Resource Manager returns an error immediately. Move operations with fewer than 800 resources may also fail if they time out.

This is a subscription-level platform limit. For more information, see [Subscription limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#subscription-limits).

## Resolution

Break the move into multiple smaller operations, each containing fewer than 800 resources. Consider the following approaches:

### Option 1: Move resources in batches

Divide your resources into groups of fewer than 800 and run separate move operations for each group. Ensure that dependent resources (such as a VM and its NIC) are included in the same batch.

### Option 2: Snapshot and recreate

If breaking the move into batches is not practical, take snapshots of the VM disks, move the snapshots to the destination subscription, and recreate the VMs.

> [!NOTE]
> Only **Full** snapshots can be moved between resource groups, subscriptions, or regions. **Incremental** snapshots are not supported for cross-subscription or cross-region moves. See [Move operation support for Microsoft.Compute resources](/azure/azure-resource-manager/management/move-support-resources#microsoftcompute).

**Take a snapshot**

See [Create a snapshot of a virtual hard disk](/azure/virtual-machines/snapshot-copy-managed-disk?tabs=portal).

**Move the snapshot**

See [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).

**Create a VM from the snapshot (PowerShell)**

See [Create a virtual machine from a snapshot with PowerShell](/azure/virtual-machines/scripts/virtual-machines-linux-powershell-sample-create-vm-from-snapshot).

**Create a VM from the snapshot (Azure CLI)**

See [Create a virtual machine from a snapshot with CLI](/azure/virtual-machines/scripts/create-vm-from-snapshot).

## More information

- [Move Azure resources to a new resource group or subscription — FAQ](/azure/azure-resource-manager/management/move-resource-group-and-subscription#frequently-asked-questions)
- [Subscription and service limits, quotas, and constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits#subscription-limits)
