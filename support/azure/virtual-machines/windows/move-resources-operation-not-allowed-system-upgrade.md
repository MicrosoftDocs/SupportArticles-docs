---
title: Azure resource move fails - OperationNotAllowed due to system upgrade
description: Troubleshoot the OperationNotAllowed error during cross-subscription resource moves. Learn why this error occurs and how to resolve it with simple retry steps.
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

## Summary

This article helps you troubleshoot the `OperationNotAllowed` error that occurs when moving Azure resources across subscriptions during a rolling upgrade of the Azure Compute Resource Provider. The error indicates that the source and target subscription partitions temporarily run different service versions. To resolve this issue, wait for the upgrade to complete and retry the move operation.

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

Compute Resource Provider is built on Azure Service Fabric and organized into regional partitions. Each subscription is assigned to a specific partition in each region. During a cross-subscription move, both the source and destination subscriptions must run the same Compute Resource Provider service version.

When a rolling upgrade is in progress, the source and destination subscription partitions might temporarily run **different service versions**. During this window, cross-subscription move operations are blocked and return the `OperationNotAllowed` error.

This condition is expected and transient - not a permanent failure.

## Resolution

**Retry the operation after a short wait.** Rolling upgrades in Compute Resource Provider typically complete within minutes to a few hours. Once both the source and target subscription partitions run the same version, the move operation succeeds.

### Retry steps

- Wait 15 to 30 minutes and retry the move.
- If the error persists beyond two hours, open a support request by using the **correlation ID** from the error, the **subscription IDs**, and the **region** where the move was attempted.

## More information

- [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Troubleshoot moving Azure resources](/azure/azure-resource-manager/management/troubleshoot-move)
