---
title: Troubleshoot traffic still going through load balancer after removal of VMs from the backend pool
description: Learn why Azure Load Balancer traffic can continue after backend VM removal and use network tracing to confirm infrastructure traffic and resolve issues.
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

# Troubleshoot traffic still going through load balancer after removal of virtual machines from the backend pool

## Summary

After removing virtual machines (VMs) from the backend pool of an Azure Load Balancer, you might notice that a small amount of traffic continues to be routed to those VMs. This article explains why this traffic occurs and how to verify that it's related to Azure infrastructure services such as storage or DNS rather than the load balancer itself.

## Cause

VMs removed from a load balancer's backend pool no longer receive traffic from the load balancer. The small amount of network traffic you see might be related to storage, DNS, and other functions within Azure.

### Solution

To check whether the traffic comes from Azure infrastructure services rather than the load balancer, conduct a network trace. The properties of each storage account list the fully qualified domain name (FQDN) for your blob storage account. From a VM within your Azure subscription, you can perform `nslookup` to determine the Azure IP assigned to that storage account.