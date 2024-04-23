---
title: InvalidLoadBalancerProfileAllocatedOutboundPorts error code
description: Learn how to fix the InvalidLoadBalancerProfileAllocatedOutboundPorts error that occurs when you try to create or update an Azure Kubernetes Service (AKS) cluster.
ms.date: 04/23/2024
author: jotavar
ms.author: jotavar
editor:
ms.reviewer:
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to fix a InvalidLoadBalancerProfileAllocatedOutboundPorts error so that I can create or update an AKS cluster successfully.
---

# Troubleshoot the "InvalidLoadBalancerProfileAllocatedOutboundPorts" error code

This article discusses how to identify and resolve the "InvalidLoadBalancerProfileAllocatedOutboundPorts" error code that occurs when you try to create or update a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli), version 2.53.0 or a later version. To find your installed version, run `az --version`.

## Symptoms

An AKS cluster create or update operation fails and returns the following error message:

> Code: InvalidLoadBalancerProfileAllocatedOutboundPorts
> Message: Load balancer profile allocated ports 8000 is not in an allowable range given the number of nodes and IPs provisioned. Total node count 9 requires 72000 ports but only 64000 ports are available given 1 outbound public IPs. Refer to https://aka.ms/aks/slb-ports for more details.

## Cause

In clusters with outbound type Load-Balancer the traffic originating from cluster nodes (including traffic from applications running in pods) will egress via the AKS managed Load-Balancer, which relies on Source Network Address Translation (SNAT) ports for establishing these outbound connections.

By default each cluster is assigned 1 outbound frontend IP address which allows for a total of 64,000 SNAT ports, and each worker node in the cluster will be allocated a share of these ports - by default, if a cluster has 50 or fewer nodes, 1024 ports are allocated to each worker node. In some scenarios where the applications running in the cluster require establishing large numbers of outbound connections, the default number of available SNAT ports may not be enough, which leads to SNAT port exhaustion.

In order to solve this problem you can change the number of outbound frontend IP addresses - each IP provides an additional 64,000 SNAT ports - and/or change the number of SNAT ports assigned to each worker node.

The InvalidLoadBalancerProfileAllocatedOutboundPorts error occurs whenever the specified node count, number of outbound frontend IP addresses and number of allocated ports per node do not add up to a viable configuration.

## Solution

Before running an operation which changes a cluster's node count, the number of outbound frontend IP addresses or the number of SNAT ports per node, use the following formula to confirm if the desired configuration is viable:

```
64,000 ports per IP / <outbound ports per node> * <number of outbound IPs> = <maximum number of nodes in the cluster>
```

> [!NOTE]
> When performing this check make sure you account for node surges which happen during cluster upgrades and other operations. AKS defaults to 1 buffer node for upgrade operations but this number may be modified using the maxSurge  parameter.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
