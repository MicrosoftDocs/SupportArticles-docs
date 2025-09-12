---
title: Troubleshoot a SubnetIsFull error code that occurs during an AKS cluster upgrade
description: Learn how to troubleshoot the SubnetIsFull error when you try to upgrade an Azure Kubernetes Service (AKS) cluster.
ms.date: 10/10/2024
editor: v-jsitser
ms.reviewer: chiragpa, albarqaw, v-leedennis
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot an Azure Kubernetes Service cluster upgrade that failed because of a SubnetIsFull error so that I can upgrade the cluster successfully.
---

# Troubleshoot the "SubnetIsFull" error code during an AKS cluster upgrade

This article discusses how to identify and resolve the "SubnetIsFull" error that occurs when you try to upgrade an Azure Kubernetes Service (AKS) cluster.

Here's an example of the error message:

>Failed to scale node pool \<AGENT POOL NAME>\' in Kubernetes service '\<NAME>\'. Error: VMSSAgentPoolReconciler retry failed: Code='SubnetIsFull' Message='\<SUBNET NAME>\ with address prefix \<PREFIX>\ doesn't have enough capacity for IP addresses.' Details=[]

## Prerequisites

This article requires Azure CLI version 2.0.65 or a later version. To find the version number, run `az --version`. If you have to install or upgrade Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

For more detailed information about the upgrade process, see the "Upgrade an AKS cluster" section in [Upgrade an Azure Kubernetes Service (AKS) cluster](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

## Symptoms

An AKS cluster upgrade fails, and you receive a "SubnetIsFull" error message.

## Cause

This error occurs if your cluster doesn't have enough IP addresses to create a new node.

When you plan to do an upgrade or scaling operation, consider the number of required IP addresses. If the IP address range that you configured in the cluster supports only a fixed number of nodes, the upgrade or scaling operation will fail. For more information, see [IP address planning for your Azure Kubernetes Service (AKS) clusters](/azure/aks/concepts-network-ip-address-planning).

## Solution

Reduce the cluster nodes to reserve IP addresses for the upgrade.

If scaling down isn't an option, and your virtual network CIDR has enough IP addresses, try to add a node pool that has a [unique subnet](/azure/aks/use-multiple-node-pools#add-a-node-pool-with-a-unique-subnet-preview):

1. Add a new user node pool in the virtual network on a larger subnet.
1. Switch the original node pool to a system node pool type.
1. Scale up the user node pool.
1. Scale down the original node pool.

## More information

- [InsufficientSubnetSize error code](../connectivity/insufficientsubnetsize-error-advanced-networking.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
