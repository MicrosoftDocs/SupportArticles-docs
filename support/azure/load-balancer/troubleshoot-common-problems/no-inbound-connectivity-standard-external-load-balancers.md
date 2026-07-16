---
title: Troubleshoot no inbound connectivity to Standard external load balancers
description: Resolve no inbound connectivity on a Standard external load balancer by checking NSG rules, load-balancing rules, and health probes. Start troubleshooting now.
services: load-balancer
ms.service: azure-load-balancer
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
ms.topic: troubleshooting
ms.date: 04/06/2026
ms.custom: sap:Configuration and Setup
# Customer intent: "As a network administrator, I want to troubleshoot connectivity issues with Azure Load Balancer, so that I can ensure reliable traffic distribution and maintain service availability for my virtual machine resources."
---

# Troubleshoot no inbound connectivity to Standard external load balancers

## Summary

This article helps you troubleshoot why a Standard external load balancer isn't allowing inbound traffic to reach the backend virtual machines. Common causes include network security group (NSG) rules that block traffic, misconfigured load-balancing rules, or health probe failures that prevent the load balancer from routing traffic to the backend pool.

## Cause

Standard load balancers and standard public IP addresses are closed to inbound connections unless network security groups open them. You use NSGs to explicitly permit allowed traffic. You must configure your NSGs to explicitly permit allowed traffic. If you don't have an NSG on a subnet or network interface card (NIC) of your virtual machine resource, traffic isn't allowed to reach the resource.

### Solution

To allow ingress traffic, [add a network security group](/azure/virtual-network/manage-network-security-group) to the subnet or interface for your virtual resource.
