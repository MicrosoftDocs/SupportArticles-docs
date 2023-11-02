---
title: Insufficient subnet size error while deploying an AKS cluster
description: Troubleshoot an insufficientSubnetSize error that occurs while you deploy an Azure Kubernetes Service (AKS) cluster with advanced networking.
ms.date: 05/17/2023
ms.reviewer: chiragpa, nickoman, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want avoid an insufficient subnet size error so that I can deploy an Azure Kubernetes Service (AKS) cluster with advanced networking.
---
# Insufficient subnet size error while deploying an AKS cluster with advanced networking

This article discusses how to resolve an `insufficientSubnetSize` error that occurs while you try to deploy a Microsoft Azure Kubernetes Service (AKS) cluster with advanced networking. It addresses this issue for Kubernetes clusters and for Azure Container Networking Interface (CNI) clusters.

## Symptoms

The `insufficientSubnetSize` error occurs during any of the following three operations. This error is also encountered in [AKS Diagnostics](/azure/aks/concepts-diagnostics), which proactively surfaces issues such as an insufficient subnet size.

### Operation 1: Scaling an AKS cluster or an AKS node pool

| Cluster type      | Symptom: <br/>The number of free IP addresses in the subnet is *less than*...                                                                              |
|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Kubenet           | The number of new nodes that are requested.                                                                                                                |
| Azure CNI         | The number of new nodes that are requested **times** the node pool's value in the `--max-pod` parameter.                                                   |
| Azure CNI Overlay | The number of new nodes that are requested.<br/>In the node pools that use the autoscaler, the number of nodes is the value in the `--max-count` parameter. |

### Operation 2: Upgrading an AKS cluster or an AKS node pool

| Cluster type      | Symptom: <br/>The number of free IP addresses in the subnet is *less than*...                                                                              |
|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Kubenet           | The number of buffer nodes that need to be upgraded.|
| Azure CNI         | The number of buffer nodes that need to be upgraded **times** the node pool's value in the `--max-pod` parameter.                                        |
| Azure CNI Overlay | The number of buffer nodes that need to be upgraded.<br/>In the node pools that use autoscaler, the number of nodes is the value in the `--max-count` parameter. |

By default, an AKS cluster sets a maximum surge (upgrade buffer) value of one (1). However, you can customize this upgrade behavior by setting the maximum surge value of a node pool. This action increases the number of available IP addresses that are needed to complete an upgrade.

### Operation 3: Creating an AKS cluster or adding an AKS node pool

| Cluster type      | Symptom: <br/>The number of free IP addresses in the subnet is *less than*...                                                                              |
|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Kubenet           | The number of nodes that are requested.                                                                                                                    |
| Azure CNI         | The number of nodes that are requested **times** the node pool's value in the `--max-pod` parameter.                                                   |
| Azure CNI Overlay | The number of nodes that are requested.<br/>In the node pools that use the autoscaler, the number of nodes is the value in the `--max-count` parameter. |

## Cause

A subnet that's in use for a cluster no longer has available IP addresses within its classless interdomain routing (CIDR) for successful resource assignment.

| Cluster type      | Requirement                                                |
|-------------------|------------------------------------------------------------|
| Kubenet           | Sufficient IP space for each *node* in the cluster         |
| Azure CNI         | Sufficient IP space for each *node and pod* in the cluster |
| Azure CNI Overlay | Sufficient IP space for each *node* in the cluster         |

Read more about the [design of Azure CNI to assign IP addresses to pods](/azure/aks/configure-azure-cni#plan-ip-addressing-for-your-cluster).

## Solution

Create new subnets. Because you can't update an existing subnet's CIDR range, you'll need to be granted the permission to create a new subnet.

Rebuild a new subnet with a larger CIDR range that's sufficient for operation goals by following these steps:

1. Create a new subnet with a larger, non-overlapping range.

1. Create a new node pool on the new subnet.

1. Drain the pods from the old node pool that resides in the old subnet.

1. Delete the old subnet and old node pool.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
