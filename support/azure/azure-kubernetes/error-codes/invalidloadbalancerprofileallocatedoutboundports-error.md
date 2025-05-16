---
title: InvalidLoadBalancerProfileAllocatedOutboundPorts error code
description: Learn how to fix the InvalidLoadBalancerProfileAllocatedOutboundPorts error when you try to create or update an Azure Kubernetes Service (AKS) cluster.
ms.date: 05/06/2024
ms.reviewer: jotavar, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to fix the InvalidLoadBalancerProfileAllocatedOutboundPorts error so that I can create or update an AKS cluster successfully.
---

# "InvalidLoadBalancerProfileAllocatedOutboundPorts" error when creating or updating an AKS cluster

This article discusses how to identify and resolve the "InvalidLoadBalancerProfileAllocatedOutboundPorts" error code that occurs when you try to create or update a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

[Azure CLI](/cli/azure/install-azure-cli), version 2.53.0 or a later version. To find your installed version, run the `az --version` command.

## Symptoms

An AKS cluster create or update operation fails and returns the following error message:

> Code: InvalidLoadBalancerProfileAllocatedOutboundPorts  
> Message: Load balancer profile allocated ports 8000 is not in an allowable range given the number of nodes and IPs provisioned. Total node count 9 requires 72000 ports but only 64000 ports are available given 1 outbound public IPs. Refer to `https://aka.ms/aks/slb-ports` for more details.

## Cause

In clusters with outbound type `LoadBalancer`, the traffic originating from cluster nodes (including traffic from applications running in pods) egresses via the AKS-managed load balancer, which relies on Source Network Address Translation (SNAT) ports to establish these outbound connections.

By default, each cluster is assigned one outbound frontend IP address that allows for a total of 64,000 SNAT ports, and each worker node in the cluster is allocated a share of these ports. For example, if a cluster has 50 nodes or fewer, each worker node is allocated 1,024 ports. In some scenarios where applications running in a cluster require establishing large numbers of outbound connections, the default number of available SNAT ports may be insufficient, which leads to SNAT port exhaustion.

To solve the SNAT port exhaustion issue, use one or both of the following methods:

- Change the number of outbound frontend IP addresses. Each IP address provides an additional 64,000 SNAT ports.
- Change the number of SNAT ports assigned to each worker node.

The "InvalidLoadBalancerProfileAllocatedOutboundPorts" error occurs when the specified node count, the number of outbound frontend IP addresses, and the number of allocated ports per node don't constitute a feasible configuration.

## Solution

To resolve the "InvalidLoadBalancerProfileAllocatedOutboundPorts" error, follow these steps:

1. Use the following formula to check if the desired configuration is feasible:

    ```code
    64,000 ports per IP / <outbound ports per node> * <number of outbound IPs> = <maximum number of nodes in the cluster>
    ```

    > [!NOTE]
    > When performing this check, make sure you consider node surges that happen during cluster upgrades and other operations. AKS defaults to one buffer node for upgrade operations, but this number can be modified using the [maxSurge](/azure/aks/upgrade-aks-cluster#customize-node-surge-upgrade) parameter.

2. Change the cluster's node count, the number of outbound frontend IP addresses, or the number of SNAT ports per node.

    For more information about how to configure the allocated outbound ports and examples and calculations of the number of ports you might need, see [Configure the allocated outbound ports](/azure/aks/load-balancer-standard#configure-the-allocated-outbound-ports).

## Reference

[Use Source Network Address Translation (SNAT) for outbound connections](/azure/load-balancer/load-balancer-outbound-connections)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
