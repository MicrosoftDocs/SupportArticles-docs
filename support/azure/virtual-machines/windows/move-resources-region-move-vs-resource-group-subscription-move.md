---
title: Azure VM region move isnt the same as a resource group or subscription move
description: Learn how an Azure VM region move differs from a resource group or subscription move, and choose Azure Resource Mover or manual redeployment for your scenario.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/14/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine region move isn't the same as a resource group or subscription move

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

An Azure VM region move requires a relocation workflow; moving a VM across resource groups or subscriptions doesn't change its region. This article explains the difference and helps you choose the right method for your scenario.

## Symptoms

Operators try to use a standard resource move for a scenario that actually requires a region relocation path.

The following list includes questions you might have:

- Why can't I use the standard move workflow to change regions?
- Why does the move keep validating but not solve the relocation scenario?
- Should I use Azure Resource Mover instead?

## Cause

A standard Resource Manager move changes the resource group or subscription association of a resource. It doesn't change the region of the resource.

## Resolution

If you need to change regions, use a region relocation pattern instead. For example, use one of the following options for your scenario:

- Resource Mover
- Manual redeployment
- Service-specific relocation guidance

### How to choose the right path

Use the following rules to help guide your decision:

- Same region, different resource group or subscription: Standard move
- Different region: Relocation workflow, not a standard move

### Recommended paths for moving VMs

Use one of the following paths.

#### Path 1: Resource group or subscription move

If the source and destination remain in the same region, use the standard move workflow.

#### Path 2: Region move

If the region changes, use one of the following methods:

- Resource Mover
- Azure Migrate
- Manual rebuild or redeployment for unsupported resources

## References

- [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)
- [Move Azure resources across resource groups, subscriptions, or regions](/azure/azure-resource-manager/management/move-resources-overview)
- [Move Azure virtual machine resources to a subscription in a different tenant](move-vm-cross-tenant-migration-guide.md)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
