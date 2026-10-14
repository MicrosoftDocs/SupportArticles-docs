---
title: Azure region relocation fails because private endpoint re-creation order is wrong
description: Fix Azure region relocation failures caused by incorrect private endpoint re-creation order. Learn the right sequence for DNS and service re-creation.
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

# Azure region relocation fails because of private endpoint re-creation order

**Applies to:** :heavy_check_mark: Windows VMs :heavy_check_mark: Linux VMs

## Summary

During an Azure region relocation, the order in which you re-create private endpoints and related Domain Name System (DNS) resources is critical. An incorrect private endpoint re-creation order can cause the relocation to fail or make workloads unreachable after cutover. This article explains the correct resource sequence to help you avoid these issues.

## Symptoms

A region relocation fails or the workload remains unreachable after a cutover because private endpoints and private DNS resources were re-created in the wrong order.

## Cause

Private connectivity dependencies are order-sensitive. If you re-create virtual networks (VNets), DNS links, private endpoints, and target services in the wrong sequence, resolution and connectivity fail.

## Resolution

The following is the recommended order:

1. Re-create the destination network foundation.
1. Re-create private DNS zones and vNet links.
1. Re-create or reconnect private endpoints.
1. Verify DNS resolution from the virtual machine (VM).
1. Verify application connectivity.

## References

- [Move blocked by private endpoint dependencies](move-resources-private-endpoint-dependency-block.md)
- [Region move isn't the same as a resource group or subscription move](move-resources-region-move-vs-resource-group-subscription-move.md)
- [Azure Private Endpoint DNS configuration](/azure/private-link/private-endpoint-dns)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
