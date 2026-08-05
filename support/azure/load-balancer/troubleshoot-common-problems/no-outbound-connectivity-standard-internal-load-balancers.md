---
title: Troubleshoot no outbound connectivity from Standard internal load balancers
description: Learn why a Standard internal load balancer has no outbound connectivity and configure Azure NAT Gateway to restore internet access. Fix it now.
services: load-balancer
ms.service: azure-load-balancer
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
ms.topic: troubleshooting
ms.date: 08/04/2026
ms.custom: sap:Configuration and Setup
# Customer intent: "As a network administrator, I want to troubleshoot connectivity issues with Azure Load Balancer, so that I can ensure reliable traffic distribution and maintain service availability for my virtual machine resources."
---

# Troubleshoot no outbound connectivity from Standard internal load balancers

## Summary

This article helps you troubleshoot scenarios where virtual machines (VMs) behind a Standard internal load balancer (ILB) can't reach the internet. Unlike Basic ILBs, Standard ILBs don't provide default outbound access, so VMs in the backend pool need an explicit outbound connectivity method, such as [Azure NAT Gateway](/azure/virtual-network/nat-gateway/nat-overview), a public IP address on the network interface, or outbound rules on a Standard public load balancer, to reach external endpoints.

## Cause

Standard ILBs have default security features. Basic ILBs allow connecting to the internet through a hidden public IP address called the *default outbound access IP*. Don't use the default outbound access IP for production workloads, because the IP address isn't static or locked down through network security groups that you own. For more information, including which methods count as explicit outbound connectivity, see [Default outbound access in Azure](/azure/virtual-network/ip-services/default-outbound-access).

### Solution

If you recently moved from a Basic ILB to a Standard ILB and need outbound connectivity to the internet from your VMs, configure an explicit outbound connectivity method on the subnet or VMs. [Azure NAT Gateway](/azure/virtual-network/nat-gateway/nat-overview) is the Azure-recommended option for most production scenarios, because it avoids the SNAT port exhaustion limits of load balancer outbound rules. For step-by-step configuration, see [Tutorial: Integrate a NAT gateway with an internal load balancer](/azure/nat-gateway/tutorial-nat-gateway-load-balancer-internal-portal).

Alternatively, you can assign a public IP address directly to each VM's network interface, or place the VMs in the backend pool of a separate Standard public load balancer that has outbound rules configured. For the load balancer approach, see [Outbound-only load balancer configuration](/azure/load-balancer/egress-only).

To compare outbound options in more depth and diagnose SNAT port exhaustion, see [Troubleshoot Azure Load Balancer outbound connectivity issues](../troubleshoot-outbound-connection.md).
