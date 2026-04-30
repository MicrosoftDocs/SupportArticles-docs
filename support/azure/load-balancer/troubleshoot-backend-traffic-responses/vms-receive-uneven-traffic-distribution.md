---
title: Virtual machines receive uneven distribution of traffic 
description: Troubleshoot uneven traffic distribution across Azure Load Balancer VMs. Learn to identify configuration issues and verify traffic is balanced evenly across backend pool members.
services: load-balancer
ms.service: azure-load-balancer
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.topic: troubleshooting
ms.date: 04/30/2026
ms.custom: engagement-fy23
# Customer intent: "As a network administrator, I want to troubleshoot connectivity issues with Azure Load Balancer, so that I can ensure reliable traffic distribution and maintain service availability for my virtual machine resources."
---

# Virtual machines behind a load balancer receive uneven traffic distribution

## Summary

This article explains why virtual machines (VMs) in the backend pool of an Azure Load Balancer might not receive traffic evenly. It provides guidance on how to identify configuration problems that can affect load-balancing behavior and steps to verify that traffic is distributed as expected across the backend VMs.

Azure Load Balancer distributes traffic based on connections. Check traffic distribution per connection and not per packet. Verify distribution by using the **Flow Distribution** tab in your preconfigured [Load Balancer Insights dashboard](/azure/load-balancer/load-balancer-insights#flow-distribution).

Azure Load Balancer doesn't support true round robin load balancing but supports a hash based [distribution mode](/azure/load-balancer/distribution-mode-concepts). 

If you suspect backend pool members aren't receiving traffic evenly, it could be due to the following causes.  

### Cause 1: You configured session persistence

Using source persistence distribution mode can cause an uneven distribution of traffic. If this distribution isn't desired, update session persistence to be **None** so traffic is distributed across all healthy instances in the backend pool. For more information, see [distribution modes for Azure Load Balancer](/azure/load-balancer/distribution-mode-concepts).

### Cause 2: You configured a proxy

Clients that run behind proxies might appear as one unique client application from the load balancer's point of view.