---
title: Troubleshoot the SubnetIsFull error code
description: Introduces how to troubleshoot the SubnetIsFull error when you try to scale an Azure Kubernetes Service (AKS) cluster.
ms.date: 02/28/2025
author: jotavar
ms.author: jotavar
editor: v-jsitser
ms.reviewer: rissing, chiragpa, addobres
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the SubnetIsFull error code so that I can successfully scale an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the SubnetIsFull error code

This article discusses how to identify and resolve the `SubnetIsFull` error that occurs when you try to scale a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli) (version 2.0.59 or a later version)

## Symptoms

When you try to scale an AKS cluster, you receive the following error message:

> **"code": "SubnetIsFull"**
>
> "message": "Subnet \<subnet-name> with address prefix \<subnet-prefix> does not have enough capacity for \<new-ip-count> IP addresses."

## Cause

To add nodes to an AKS cluster (scaling out), you have to use more IP addresses from the subnet in which the node pool is deployed. The exact number of new IP addresses that are required to successfully complete a cluster scale operation varies according to the networking plug-in that the cluster uses. For information about how IP addresses are allocated under each of these networking models, see [Network concepts for applications in AKS](/azure/aks/concepts-network).

> [!NOTE]
> Azure reserves five IP addresses per subnet. The first address in the subnet is for the network ID, followed by three addresses that are used internally by Azure. The last address in the subnet is reserved for broadcast packets. For more information, see [Are there any restrictions on using IP addresses within these subnets?](/azure/virtual-network/virtual-networks-faq#are-there-any-restrictions-on-using-ip-addresses-within-these-subnets)

## Solution

Trying to update a subnet's Classless Inter-Domain Routing (CIDR) address space in an existing node pool isn't currently supported. To migrate your workloads to a new node pool in a larger subnet, follow these steps:

1. Create a subnet in the cluster virtual network that contains a larger CIDR address range than the existing subnet. For information about how to adequately size the subnet for your cluster, see [Plan IP addressing for your cluster](/azure/aks/azure-cni-overview#plan-ip-addressing-for-your-cluster).

2. Create a node pool on the new subnet by running the [az aks nodepool add](/cli/azure/aks/nodepool#az-aks-nodepool-add) command together with the `--vnet-subnet-id` parameter.

3. Migrate your workloads to the new node pool by draining the nodes in the old node pool. For information about how to safely drain AKS worker nodes, see [Safely Drain a Node](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node).

4. Delete the original node pool by running the [az aks nodepool delete](/cli/azure/aks/nodepool#az-aks-nodepool-delete) command.


## Best practices

To avoid `SubnetIsFull` issues in Azure Kubernetes Service (AKS), follow best practices that are related to subnet sizing, IP address management, and node pool strategies. Here are some key recommendations: 

- Plan for Future Growth: When you create subnets, make sure that they're large enough to accommodate future growth. We recommend that you reserve more IP addresses than you currently need to avoid running out of space as the cluster scales. 
- Use Larger Subnet CIDR: If possible, use a larger subnet CIDR to provide more IP addresses. This strategy helps to accommodate more nodes and pods without running into IP exhaustion issues.
- Monitor IP Usage: To identify potential issues before they become critical, regularly monitor the IP address usage within your subnets. Tools such as Azure Monitor can help track IP address consumption.
- Optimize IP Allocation: Make sure that IP addresses are allocated efficiently. Avoid reserving IP addresses unnecessarily. To free up space, release any unused IP addresses.
- Use multiple node pools: Consider using node pools that have different subnets to distribute the IP address load. This strategy can help mitigate the risk of running out of IP addresses in a single subnet.   

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
