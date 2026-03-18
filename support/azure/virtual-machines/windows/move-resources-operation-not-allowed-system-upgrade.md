---
title: Azure resource move fails - OperationNotAllowed due to system upgrade
description: Troubleshoot the OperationNotAllowed error that occurs during a cross-subscription resource move when the source and target partitions are running different service versions.
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
# Azure resource move fails with OperationNotAllowed due to system upgrade

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

## Symptoms

When you try to move resources across subscriptions, the operation fails with the following error:

```output
{
  "code": "OperationNotAllowed",
  "target": "Microsoft.Compute/availabilitySets",
  "message": "The resource provider cannot perform this operation currently due to system upgrade. Please retry after some time."
}
```

## Cause

Azure Compute Resource Provider (CRP) is built on Service Fabric and organized into regional partitions. Each subscription is assigned to a specific partition in each region. During a cross-subscription move, both the source and destination subscriptions must be running the same CRP service version.

When a rolling upgrade is in progress, the source and destination subscription partitions may temporarily be at **different service versions**. During this window, cross-subscription move operations are blocked and return the `OperationNotAllowed` error.

This is an expected, transient condition — not a permanent failure.

## Resolution

**Retry the operation after a short wait.** Rolling upgrades in Azure CRP typically complete within minutes to a few hours. Once both the source and target subscription partitions are running the same version, the move operation will succeed.

Retry guidelines:
- Wait **15 to 30 minutes** and retry the move.
- If the error persists beyond 2 hours, open a support request with the **correlation ID** from the error, the **subscription IDs**, and the **region** where the move was attempted.

## More information

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Troubleshoot moving Azure resources](/azure/azure-resource-manager/management/troubleshoot-move)
