---
title: InsufficientSubnetSize error code
description: Learn how to fix an InsufficientSubnetSize error that occurs when you deploy an Azure Kubernetes Service (AKS) cluster that uses advanced networking.
ms.date: 11/29/2023
author: jotavar
ms.author: jotavar
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
ms.topic: troubleshooting-problem-resolution
#Customer intent: As an Azure Kubernetes user, I want avoid an insufficient subnet size error so that I can deploy an Azure Kubernetes Service (AKS) cluster that uses advanced networking.
---
# InsufficientSubnetSize error code

This article discusses how to resolve an `InsufficientSubnetSize` error that occurs when you try to deploy a Microsoft Azure Kubernetes Service (AKS) cluster that uses advanced networking. This article applies to both Kubernetes clusters and Azure Container Networking Interface (CNI) clusters.

## Symptoms

The `InsufficientSubnetSize` error occurs during any of the following operations. This error is also encountered in [AKS Diagnostics](/azure/aks/concepts-diagnostics), which proactively discovers issues such as an insufficient subnet size.

#### Operation 1: Scaling an AKS cluster or an AKS node pool

| Cluster type      | Symptom: <br/>The number of free IP addresses in the subnet is *less than*...                                                                              |
|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Kubenet           | The number of new nodes that are requested.                                                                                                                |
| Azure CNI         | The number of new nodes that are requested **times** the node pool value in the `--max-pod` parameter.                                                   |
| Azure CNI Overlay | The number of new nodes that are requested.<br/>(In the node pools that use the autoscaler, the number of nodes is the value in the `--max-count` parameter.) |

#### Operation 2: Upgrading an AKS cluster or an AKS node pool

| Cluster type      | Symptom: <br/>The number of free IP addresses in the subnet is *less than*...                                                                              |
|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Kubenet           | The number of buffer nodes that have to be upgraded.|
| Azure CNI         | The number of buffer nodes that have to be upgraded **times** the node pool value in the `--max-pod` parameter.                                        |
| Azure CNI Overlay | The number of buffer nodes that have to be upgraded.<br/>(In the node pools that use autoscaler, the number of nodes is the value in the `--max-count` parameter.) |

By default, an AKS cluster sets a maximum surge (upgrade buffer) value of one (1). However, you can customize this upgrade behavior by setting the maximum surge value of a node pool. This action increases the number of available IP addresses that are necessary to complete an upgrade.

#### Operation 3: Creating an AKS cluster or adding an AKS node pool

| Cluster type      | Symptom: <br/>The number of free IP addresses in the subnet is *less than*...                                                                              |
|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Kubenet           | The number of nodes that are requested.                                                                                                                    |
| Azure CNI         | The number of nodes that are requested **times** the node pool value in the `--max-pod` parameter.                                                   |
| Azure CNI Overlay | The number of nodes that are requested.<br/>(In the node pools that use the autoscaler, the number of nodes is the value in the `--max-count` parameter.) |

## Cause

A subnet that's in use for a cluster no longer has available IP addresses within its Classless Inter-Domain Routing (CIDR) address space for successful resource assignment.

| Cluster type      | Requirement                                                |
|-------------------|------------------------------------------------------------|
| Kubenet           | Sufficient IP space for each *node* in the cluster         |
| Azure CNI         | Sufficient IP space for each *node and pod* in the cluster |
| Azure CNI Overlay | Sufficient IP space for each *node* in the cluster         |

Read more about the [design of Azure CNI to assign IP addresses to pods](/azure/aks/configure-azure-cni#plan-ip-addressing-for-your-cluster).

## Solution

Trying to update a subnet's CIDR address space in an existing node pool isn't currently supported. To migrate your workloads to a new node pool in a larger subnet, follow these steps:

1. Create a subnet in the cluster virtual network that contains a larger CIDR address range than that of the existing subnet. For information about how to size the subnet adequately for your cluster, see [Plan IP addressing for your cluster](/azure/aks/azure-cni-overview#plan-ip-addressing-for-your-cluster).

2. Create a node pool on the new subnet by running the [az aks nodepool add](/cli/azure/aks/nodepool#az-aks-nodepool-add) command together with the `--vnet-subnet-id` parameter.

3. Migrate your workloads to the new node pool by draining the nodes in the old node pool. For information about how to drain AKS worker nodes safely, see [Safely Drain a Node](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node).

4. Delete the original node pool by running the [az aks nodepool delete](/cli/azure/aks/nodepool#az-aks-nodepool-delete) command.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
