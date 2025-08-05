---
title: Troubleshoot the SubnetIsDelegated error code
description: Learn how to troubleshoot the SubnetIsDelegated error code when you try to create a new node pool.
ms.date: 08/05/2025
editor: v-jsitser
ms.reviewer: v-liuamson
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the SubnetIsDelegated error code so that I can successfully try to create a new node pool.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the SubnetIsDelegated error code

This article discusses how to identify and resolve the SubnetIsDelegated
error that occurs when you try to create a new node pool.

## Prerequisites

Azure CLI (version 2.0.59 or a later version)

## Symptoms  

When you try to create a nodepool in AKS cluster, you receive the
following error message:

**Code:** **SubnetIsDelegated**

**Message:** `AgentPoolProfile` subnet with id \<subnet-id\> cannot be used as
it\'s a delegated subnet. Please check
<https://aka.ms/adv-network-prerequest> for more details.

## Cause

 When you try to create a new nodepool using a subnet and if the subnet
is delegation enabled for a particular Azure service, it cannot be
integrated with AKS service.

## Solution

Confirm that the subnet is correctly delegated:

az network vnet subnet show \\  \--resource-group \$RESOURCE_GROUP
\--vnet-name \$VNET_NAME  \--name \$SUBNET_NAME  \--query delegations

Ensure that the output shows
**Microsoft.ContainerService/managedClusters** as the delegated service
or no delegated service.

If the output shows any Azure service delegation, you will need to
remove it using the following command:

az network vnet subnet update  \--resource-group \$RESOURCE_GROUP
\--vnet-name \$VNET_NAME  \--name \$SUBNET_NAME \--remove delegations 0

Add Managed Cluster delegation:

az network vnet subnet update  \--resource-group \$RESOURCE_GROUP
\--vnet-name \$VNET_NAME  \--name \$SUBNET_NAME \--delegations
Microsoft.ContainerService/managedClusters

Once the subnet delegation is removed, you may try to create the
nodepool again using the az aks nodepool add command.

You may refer to this article for some more examples:

- [az aks nodepool examples](/cli/azure/aks/nodepool?view=azure-cli-latest#az-aks-nodepool-add-examples).

[!INCLUDE [azure-help-support](../../../includes/azure-help-support.md)]
