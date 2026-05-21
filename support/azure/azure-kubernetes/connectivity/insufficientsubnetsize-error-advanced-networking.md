---
title: InsufficientSubnetSize error code
description: Fix the InsufficientSubnetSize error in AKS advanced networking. Learn how to restore subnet IP capacity and deploy your cluster successfully today.
ms.date: 02/20/2025
author: jotavar
ms.author: jotavar
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want avoid an insufficient subnet size error so that I can deploy an Azure Kubernetes Service (AKS) cluster that uses advanced networking.
ms.custom: sap:Connectivity
---
# InsufficientSubnetSize error code

## Summary

Use this article to fix the `InsufficientSubnetSize` error when deploying an Azure Kubernetes Service (AKS) cluster with advanced networking. You learn why it happens and how to restore enough subnet IP capacity for successful cluster and node pool operations across Kubenet, Azure CNI, and Azure CNI Overlay.

## Symptoms

The `InsufficientSubnetSize` error occurs during any of the following operations. You also encounter this error in [AKS Diagnostics](/azure/aks/concepts-diagnostics), which proactively discovers issues such as an insufficient subnet size.

#### Operation 1: Scaling an AKS cluster or an AKS node pool

| Cluster type      | Symptom: <br/>The number of free IP addresses in the subnet is *less than*...                                                                              |
|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Kubenet           | The number of new nodes that you request.                                                                                                                |
| Azure CNI         | The number of new nodes that you request **times** the node pool value in the `--max-pod` parameter.                                                   |
| Azure CNI Overlay | The number of new nodes that you request.<br/>(In the node pools that use the autoscaler, the number of nodes is the value in the `--max-count` parameter.) |

#### Operation 2: Upgrading an AKS cluster or an AKS node pool

| Cluster type      | Symptom: <br/>The number of free IP addresses in the subnet is *less than*...                                                                              |
|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Kubenet           | The number of buffer nodes that you need to upgrade.|
| Azure CNI         | The number of buffer nodes that you need to upgrade **times** the node pool value in the `--max-pod` parameter.                                        |
| Azure CNI Overlay | The number of buffer nodes that you need to upgrade.<br/>(In the node pools that use autoscaler, the number of nodes is the value in the `--max-count` parameter.) |

By default, an AKS cluster sets a maximum surge (upgrade buffer) value of one (1). However, you can customize this upgrade behavior by setting the maximum surge value of a node pool. This action increases the number of available IP addresses that are necessary to complete an upgrade.

#### Operation 3: Creating an AKS cluster or adding an AKS node pool

| Cluster type      | Symptom: <br/>The number of free IP addresses in the subnet is *less than*...                                                                              |
|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Kubenet           | The number of nodes that you request.                                                                                                                    |
| Azure CNI         | The number of nodes that you request **times** the node pool value in the `--max-pod` parameter.                                                   |
| Azure CNI Overlay | The number of nodes that you request.<br/>(In the node pools that use the autoscaler, the number of nodes is the value in the `--max-count` parameter.) |

## Cause

A subnet that's in use for a cluster no longer has available IP addresses within its Classless Inter-Domain Routing (CIDR) address space for successful resource assignment.

| Cluster type      | Requirement                                                |
|-------------------|------------------------------------------------------------|
| Kubenet           | Sufficient IP space for each *node* in the cluster         |
| Azure CNI         | Sufficient IP space for each *node and pod* in the cluster |
| Azure CNI Overlay | Sufficient IP space for each *node* in the cluster         |

Read more about the [design of Azure CNI to assign IP addresses to pods](/azure/aks/configure-azure-cni#plan-ip-addressing-for-your-cluster).

AKS considers all node pools in the cluster and their respective subnet. If you upgrade a node pool, AKS  considers the IP requirements of all node pools in the cluster. For example, if you upgrade node pool "pool-A" in subnet "subnet-A", and there's another subnet "subnet-B" linked to another node pool "pool-B" facing IP exhaustion, then the following error might happen:

`Code: InsufficientSubnetSize; Message: Pre-allocated IPs <number> exceeds IPs available <number> in Subnet Cidr <CIDR>, Subnet Name <subnet-name>. If Autoscaler is enabled, the max-count from each nodepool is counted towards this total, which means that pre-allocated IPs count represents a theoretical max value, not the actual number of IPs requested. See http://aka.ms/aks/insufficientsubnetsize for troubleshooting steps. Surge nodes would also consume the subnet IP space, consider use smaller maxSurge or use maxUnavailable (aka.ms/aks/maxUnavailable).`

## Solution

You can't currently update a subnet's CIDR address space in an existing node pool. To migrate your workloads to a new node pool in a larger subnet, follow these steps:

1. Create a subnet in the cluster virtual network that contains a larger CIDR address range than the existing subnet. For information about how to size the subnet adequately for your cluster, see [Plan IP addressing for your cluster](/azure/aks/azure-cni-overview#plan-ip-addressing-for-your-cluster).

1. Create a node pool on the new subnet by running the [az aks nodepool add](/cli/azure/aks/nodepool#az-aks-nodepool-add) command together with the `--vnet-subnet-id` parameter.

1. Migrate your workloads to the new node pool by draining the nodes in the old node pool. For information about how to drain AKS worker nodes safely, see [Safely Drain a Node](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node).

1. Delete the original node pool by running the [az aks nodepool delete](/cli/azure/aks/nodepool#az-aks-nodepool-delete) command.

Alternatively, if you have some node pools with Cluster Autoscaler enabled, you can temporarily decrease the `MaxCount` of nodes in these pools (whenever possible) so that AKS counts fewer IPs against the total available. After the scale, upgrade, or add operation finishes, you can increase the `MaxCount` back to its original value.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]

 
