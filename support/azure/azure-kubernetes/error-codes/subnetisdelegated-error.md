---
title: Troubleshoot the SubnetIsDelegated error code
description: Learn how to troubleshoot the SubnetIsDelegated error when you try to create a node pool.
ms.date: 08/07/2025
editor: v-jsitser
ms.reviewer: v-liuamson
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the SubnetIsDelegated error so that I can successfully create a node pool.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the SubnetIsDelegated error code

This article discusses how to identify and resolve the SubnetIsDelegated error that occurs when you try to create a node pool.

## Prerequisites

- Azure CLI (version 2.0.59 or a later version)

## Symptoms  

When you try to create a node pool in an AKS cluster, you receive the following error message:

> **Code:** **SubnetIsDelegated**
>
> **Message:** `AgentPoolProfile` subnet with id \<subnet-id\> cannot be used as it\'s a delegated subnet. Please check <https://aka.ms/adv-network-prerequest> for more details.

## Cause

If you try to create a node pool by using a subnet, and the subnet is delegation-enabled for a particular Azure service, the new node pool can't be integrated with the AKS service.

## Resolution

To resolve this issue, follow these steps:

1. Verify that the subnet is correctly delegated:

      ```bash
      az network vnet subnet show \
        --resource-group $RESOURCE_GROUP \
        --vnet-name $VNET_NAME \
        --name $SUBNET_NAME \
        --query delegations
      ```

1. Make sure that the output shows **Microsoft.ContainerService/managedClusters** as the delegated service or no delegated service. If the output shows any other Azure service delegation, remove it by running the following command:

   ```bash
   az network vnet subnet update \
     --resource-group $RESOURCE_GROUP \
     --vnet-name $VNET_NAME \
     --name $SUBNET_NAME \
     --remove delegations 0
   ```

1. Run the following command to add Managed Cluster delegation:

   ```bash
   az network vnet subnet update \
     --resource-group $RESOURCE_GROUP \
     --vnet-name $VNET_NAME \
     --name $SUBNET_NAME \
     --delegations Microsoft.ContainerService/managedClusters
   ```

1. After the subnet delegation is removed, try again to create the node pool by using the `az aks nodepool add` command.

## References

- [az aks node pool examples](/cli/azure/aks/nodepool?view=azure-cli-latest#az-aks-nodepool-add-examples&preserve-view=true)

[!INCLUDE [azure-help-support](../../../includes/azure-help-support.md)]
