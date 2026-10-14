---
title: Azure VM move isn't supported for Virtual Machine Scale Sets that use standard load balancer or standard public IP
description: Troubleshoot unsupported move attempts for Virtual Machine Scale Sets that use a standard load balancer or standard public IP. Learn alternatives.
services: virtual-machines
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.date: 09/21/2026
ms.custom: sap:VM Move and Migration
ai-usage: ai-assisted
---

# Azure virtual machine move isn't supported for Azure Virtual Machine Scale Sets that use standard load balancer or standard public IP

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

This article explains why moving an Azure Virtual Machine Scale Set that uses a standard load balancer or standard public IP isn't supported. The article also provides guidance for alternative migration approaches.

## Symptoms

A move attempt fails for a Virtual Machine Scale Set that depends on standard SKU load balancing or standard public IP resources.

## Cause

Some Virtual Machine Scale Set topologies aren't supported by standard move workflows because the scale set orchestration and networking resources can't be preserved by that motion.

## Resolution

Use a redeploy or rebuild path for the scale set instead of an instance-by-instance move. Re-create the scale set and its networking dependencies in the destination. Then, cut the traffic over.

## References

- [Move path isn't supported for VM Scale Set instance resources](move-resources-vmss-instance-scope-not-supported.md)
- [Move fails because load balancer dependencies are missing](move-resources-load-balancer-dependency-missing.md)
- [Move fails because resource group has active deployments](move-resources-deployment-active-blocks-move.md)
- [Special cases to move Azure VMs to new subscription or resource group](/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
