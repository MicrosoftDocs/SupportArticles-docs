---
title: Troubleshoot no outbound connectivity from Standard internal load balancers
description: Learn why a Standard internal load balancer has no outbound connectivity and configure Azure NAT Gateway to restore internet access. Fix it now.
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

# Troubleshoot no outbound connectivity from Standard internal load balancers

## Summary

This article helps you troubleshoot scenarios where virtual machines (VMs) behind a Standard internal load balancer (ILB) can't reach the internet. Unlike Basic ILBs, Standard ILBs don't provide default outbound access, so VMs in the backend pool need explicit outbound connectivity configuration, such as a NAT Gateway, to reach external endpoints.

## Cause

Standard ILBs have default security features. Basic ILBs allow connecting to the internet through a hidden public IP address called the *default outbound access IP*. Don't use the default outbound access IP for production workloads, because the IP address isn't static or locked down through network security groups that you own.

### Solution

If you recently moved from a Basic ILB to a Standard ILB and need outbound connectivity to the internet from your VMs, configure [Azure NAT Gateway](/azure/virtual-network/nat-gateway/nat-overview) on your subnet. Use NAT Gateway for all outbound access in production scenarios.
