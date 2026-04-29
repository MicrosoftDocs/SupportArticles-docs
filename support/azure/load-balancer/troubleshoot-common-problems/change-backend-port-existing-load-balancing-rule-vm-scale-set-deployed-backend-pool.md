---
title: Troubleshoot changing the backend port for an existing load-balancing rule of a load balancer that has a virtual machine scale set deployed in the backend pool
description: Learn how to troubleshoot changing the backend port for an existing load-balancing rule of a load balancer that has a virtual machine scale set deployed in the backend pool, including the steps to remove the health probe, update the port, and reconfigure the health probe.
services: load-balancer
ms.service: azure-load-balancer
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.topic: troubleshooting
ms.date: 04/29/2026
ms.custom: engagement-fy23
# Customer intent: "As a network administrator, I want to troubleshoot connectivity issues with Azure Load Balancer, so that I can ensure reliable traffic distribution and maintain service availability for my virtual machine resources."
---

# Troubleshoot changing the backend port for an existing load-balancing rule of a load balancer that has a virtual machine scale set deployed in the backend pool

## Summary

When a load balancer is configured with a virtual machine (VM) scale set in the backend pool, you can't directly modify the backend port of an existing load-balancing rule while it's associated with a health probe. This article explains how to remove the health probe, update the backend port, and then reconfigure the health probe to allow the change to take effect.

## Cause

When a load balancer is configured with a VM scale set, you can't modify the backend port of a load-balancing rule while it's associated with a health probe.

### Solution

To change the port, you can remove the health probe. Update the VM scale set, update the port, and then configure the health probe again.